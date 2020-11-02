import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_online_painter/painter/painter.dart';
import 'package:flutter_online_painter/painter_state/painter_state.dart';
import 'package:flutter_online_painter/painter_tools/pointer_tools.dart';
import 'package:rxdart/rxdart.dart';

class PaintApp extends StatefulWidget {
  @override
  _PaintAppState createState() => _PaintAppState();
}

class _PaintAppState extends State<PaintApp> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  BehaviorSubject<PainterState> state = BehaviorSubject<PainterState>();
  BehaviorSubject<Tool> tool = BehaviorSubject<Tool>();

  @override
  void initState() {
    super.initState();
    firestore.collection('trash_store').doc('test').get().then((value) {
      if (value.exists) {
        state.add(PainterState.fromJson(value.data()));
      } else {
        var painterState = PainterState(id: 'test');
        firestore
            .collection('trash_store')
            .doc('test')
            .set(painterState.toJson())
            .then((value) async {
          state.add(painterState);
        });
      }
    });

    firestore.collection('trash_store').doc('test').snapshots().listen((event) {
      state.add(PainterState.fromJson(event.data()).canvasTranslate(state.value?.canvasOffset));
    });

    state.bufferTime(Duration(milliseconds: 500)).doOnData((event) {
      if (event.isNotEmpty) {
        firestore
            .collection('trash_store')
            .doc('test')
            .set(event.last.toJson());
      }
    }).listen(null);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Stack(
        children: [
          Positioned.fill(
            child: Container(
              color: Colors.white,
            ),
          ),
          Positioned.fill(
            child: GestureDetector(
              onTapDown: (details) {
                if (tool.hasValue) {
                  state.add((tool.value..state = state.value)
                      .onTapDown(details.globalPosition));
                }
              },
              onPanStart: (details) {
                if (tool.hasValue) {
                  state.add((tool.value..state = state.value)
                      .onPanStart(details.globalPosition));
                }
              },
              onPanUpdate: (details) {
                if (tool.hasValue) {
                  state.add((tool.value..state = state.value)
                      .onPanUpdate(details.globalPosition));
                }
              },
              onPanEnd: (details) {
                if (tool.hasValue) {
                  state.add((tool.value..state = state.value).onPanEnd());
                }
              },
              child: StreamBuilder<PainterState>(
                stream: state,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return CustomPaint(
                    painter: CanvasPainter(snapshot.data),
                  );
                },
              ),
            ),
          ),
          Material(
            child: SizedBox(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.circle),
                    onPressed: () {
                      tool.add(PointTool(state.value));
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.timeline),
                    onPressed: () {
                      tool.add(LineTool(state.value));
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.pan_tool_outlined),
                    onPressed: () {
                      tool.add(HandTool(state.value));
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    state.close();
    tool.close();
  }
}
