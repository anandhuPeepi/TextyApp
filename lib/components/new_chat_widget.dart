import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'new_chat_model.dart';
export 'new_chat_model.dart';

class NewChatWidget extends StatefulWidget {
  const NewChatWidget({super.key});

  @override
  State<NewChatWidget> createState() => _NewChatWidgetState();
}

class _NewChatWidgetState extends State<NewChatWidget> {
  late NewChatModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NewChatModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const AlignmentDirectional(0.0, 1.0),
      child: Container(
        width: 430.0,
        height: 550.0,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              FlutterFlowTheme.of(context).secondary,
              FlutterFlowTheme.of(context).accent2
            ],
            stops: const [0.0, 1.0],
            begin: const AlignmentDirectional(0.87, -1.0),
            end: const AlignmentDirectional(-0.87, 1.0),
          ),
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(0.0),
            bottomRight: Radius.circular(0.0),
            topLeft: Radius.circular(35.0),
            topRight: Radius.circular(35.0),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(
              width: 150.0,
              child: Divider(
                thickness: 5.0,
                color: Color(0xCC807E7E),
              ),
            ),
            Text(
              'Start chat',
              style: FlutterFlowTheme.of(context).labelMedium.override(
                    fontFamily: 'Readex Pro',
                    fontSize: 25.0,
                    letterSpacing: 0.0,
                  ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                child: StreamBuilder<List<UserRecord>>(
                  stream: queryUserRecord(),
                  builder: (context, snapshot) {
                    // Customize what your widget looks like when it's loading.
                    if (!snapshot.hasData) {
                      return Center(
                        child: SizedBox(
                          width: 50.0,
                          height: 50.0,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              FlutterFlowTheme.of(context).primary,
                            ),
                          ),
                        ),
                      );
                    }
                    List<UserRecord> gridViewUserRecordList = snapshot.data!;
                    return GridView.builder(
                      padding: EdgeInsets.zero,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                        childAspectRatio: 1.0,
                      ),
                      scrollDirection: Axis.vertical,
                      itemCount: gridViewUserRecordList.length,
                      itemBuilder: (context, gridViewIndex) {
                        final gridViewUserRecord =
                            gridViewUserRecordList[gridViewIndex];
                        return InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            var chatRecordReference =
                                ChatRecord.collection.doc();
                            await chatRecordReference.set(createChatRecordData(
                              userAuth: currentUserReference,
                              userOpposite: gridViewUserRecord.reference,
                              lastMsg: '',
                              messageTime: getCurrentTimestamp,
                              user: currentUserReference,
                            ));
                            _model.chatRef = ChatRecord.getDocumentFromData(
                                createChatRecordData(
                                  userAuth: currentUserReference,
                                  userOpposite: gridViewUserRecord.reference,
                                  lastMsg: '',
                                  messageTime: getCurrentTimestamp,
                                  user: currentUserReference,
                                ),
                                chatRecordReference);

                            context.pushNamed(
                              'personPage',
                              queryParameters: {
                                'chatDocsCollection': serializeParam(
                                  _model.chatRef,
                                  ParamType.Document,
                                ),
                              }.withoutNulls,
                              extra: <String, dynamic>{
                                'chatDocsCollection': _model.chatRef,
                                kTransitionInfoKey: const TransitionInfo(
                                  hasTransition: true,
                                  transitionType:
                                      PageTransitionType.bottomToTop,
                                ),
                              },
                            );

                            setState(() {});
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              StreamBuilder<List<UserRecord>>(
                                stream: queryUserRecord(),
                                builder: (context, snapshot) {
                                  // Customize what your widget looks like when it's loading.
                                  if (!snapshot.hasData) {
                                    return Center(
                                      child: SizedBox(
                                        width: 50.0,
                                        height: 50.0,
                                        child: CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                            FlutterFlowTheme.of(context)
                                                .primary,
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                  List<UserRecord> containerUserRecordList =
                                      snapshot.data!;
                                  return Container(
                                    width: 90.0,
                                    height: 90.0,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: Image.network(
                                          gridViewUserRecord.photoUrl,
                                        ).image,
                                      ),
                                      boxShadow: const [
                                        BoxShadow(
                                          blurRadius: 4.0,
                                          color: Color(0x33DFDFDF),
                                          offset: Offset(
                                            0.0,
                                            2.0,
                                          ),
                                          spreadRadius: 4.0,
                                        )
                                      ],
                                      shape: BoxShape.circle,
                                    ),
                                  );
                                },
                              ),
                              Text(
                                gridViewUserRecord.displayName,
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      color: const Color(0xFFBABABA),
                                      letterSpacing: 0.0,
                                    ),
                              ),
                            ].divide(const SizedBox(height: 5.0)),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
