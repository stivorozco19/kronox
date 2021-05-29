import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BannerHomeWidget extends StatefulWidget {
  BannerHomeWidget({Key key}) : super(key: key);

  @override
  _BannerHomeWidgetState createState() => _BannerHomeWidgetState();
}

class _BannerHomeWidgetState extends State<BannerHomeWidget> {
  final pageViewController = PageController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: StreamBuilder<List<FeaturedRecord>>(
        stream: queryFeaturedRecord(
          queryBuilder: (featuredRecord) =>
              featuredRecord.where('isActive', isEqualTo: true),
        ),
        builder: (context, snapshot) {
          // Customize what your widget looks like when it's loading.
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          List<FeaturedRecord> pageViewFeaturedRecordList = snapshot.data;
          // Customize what your widget looks like with no query results.
          if (snapshot.data.isEmpty) {
            // return Container();
            // For now, we'll just include some dummy data.
            pageViewFeaturedRecordList = createDummyFeaturedRecord(count: 4);
          }
          return Container(
            width: double.infinity,
            height: double.infinity,
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 1),
                  child: PageView.builder(
                    controller: pageViewController,
                    scrollDirection: Axis.horizontal,
                    itemCount: pageViewFeaturedRecordList.length,
                    itemBuilder: (context, pageViewIndex) {
                      final pageViewFeaturedRecord =
                          pageViewFeaturedRecordList[pageViewIndex];
                      return StreamBuilder<EmpresasRecord>(
                        stream: EmpresasRecord.getDocument(
                            pageViewFeaturedRecord.idEmpresa),
                        builder: (context, snapshot) {
                          // Customize what your widget looks like when it's loading.
                          if (!snapshot.hasData) {
                            return Center(child: CircularProgressIndicator());
                          }
                          final stackEmpresasRecord = snapshot.data;
                          return Stack(
                            children: [
                              Image.network(
                                'https://images.unsplash.com/photo-1598887142487-3c854d51eabb?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80',
                                width: double.infinity,
                                height: 200,
                                fit: BoxFit.fitWidth,
                              ),
                              Align(
                                alignment: Alignment(0, 1),
                                child: Container(
                                  width: double.infinity,
                                  height: 60,
                                  constraints: BoxConstraints(
                                    maxWidth: double.infinity,
                                    maxHeight: double.infinity,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Color(0x40F7F7F7),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          stackEmpresasRecord.name,
                                          style: FlutterFlowTheme.bodyText1
                                              .override(
                                            fontFamily: 'Poppins',
                                            color:
                                                FlutterFlowTheme.tertiaryColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        StreamBuilder<CategoriesRecord>(
                                          stream: CategoriesRecord.getDocument(
                                              stackEmpresasRecord.category),
                                          builder: (context, snapshot) {
                                            // Customize what your widget looks like when it's loading.
                                            if (!snapshot.hasData) {
                                              return Center(
                                                  child:
                                                      CircularProgressIndicator());
                                            }
                                            final textCategoriesRecord =
                                                snapshot.data;
                                            return Text(
                                              textCategoriesRecord.name,
                                              style: FlutterFlowTheme.bodyText1
                                                  .override(
                                                fontFamily: 'Poppins',
                                                color: FlutterFlowTheme
                                                    .tertiaryColor,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            );
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),
                Align(
                  alignment: Alignment(0, 1),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: SmoothPageIndicator(
                      controller: pageViewController,
                      count: pageViewFeaturedRecordList.length,
                      axisDirection: Axis.horizontal,
                      onDotClicked: (i) {
                        pageViewController.animateToPage(
                          i,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.ease,
                        );
                      },
                      effect: ExpandingDotsEffect(
                        expansionFactor: 2,
                        spacing: 8,
                        radius: 16,
                        dotWidth: 8,
                        dotHeight: 8,
                        dotColor: Color(0xFF9E9E9E),
                        activeDotColor: FlutterFlowTheme.primaryColor,
                        paintStyle: PaintingStyle.fill,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
