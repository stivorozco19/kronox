import '../backend/backend.dart';
import '../components/banner_home_widget.dart';
import '../components/record_empresa_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeWidget extends StatefulWidget {
  HomeWidget({Key key}) : super(key: key);

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.tertiaryColor,
        automaticallyImplyLeading: false,
        title: Image.asset(
          'assets/images/LogoKronox_Tomato.png',
          width: 100,
          fit: BoxFit.fitWidth,
        ),
        actions: [
          Icon(
            Icons.search,
            color: Color(0xFF757575),
            size: 24,
          ),
          Icon(
            Icons.more_vert,
            color: Color(0xFF757575),
            size: 24,
          )
        ],
        centerTitle: false,
        elevation: 4,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Container(
                  width: double.infinity,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Color(0x00FFFFFF),
                  ),
                  child: StreamBuilder<List<CategoriesRecord>>(
                    stream: queryCategoriesRecord(
                      queryBuilder: (categoriesRecord) =>
                          categoriesRecord.where('isActive', isEqualTo: true),
                    ),
                    builder: (context, snapshot) {
                      // Customize what your widget looks like when it's loading.
                      if (!snapshot.hasData) {
                        return Center(child: CircularProgressIndicator());
                      }
                      List<CategoriesRecord> listViewCategoriesRecordList =
                          snapshot.data;
                      // Customize what your widget looks like with no query results.
                      if (snapshot.data.isEmpty) {
                        // return Container();
                        // For now, we'll just include some dummy data.
                        listViewCategoriesRecordList =
                            createDummyCategoriesRecord(count: 4);
                      }
                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.horizontal,
                        itemCount: listViewCategoriesRecordList.length,
                        itemBuilder: (context, listViewIndex) {
                          final listViewCategoriesRecord =
                              listViewCategoriesRecordList[listViewIndex];
                          return Padding(
                            padding: EdgeInsets.fromLTRB(20, 5, 5, 5),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl: listViewCategoriesRecord.image,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                AutoSizeText(
                                  listViewCategoriesRecord.name,
                                  style: FlutterFlowTheme.bodyText1.override(
                                    fontFamily: 'Poppins',
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 35),
                    child: BannerHomeWidget(),
                  )
                ],
              ),
              StreamBuilder<List<EmpresasRecord>>(
                stream: queryEmpresasRecord(),
                builder: (context, snapshot) {
                  // Customize what your widget looks like when it's loading.
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }
                  List<EmpresasRecord> columnEmpresasRecordList = snapshot.data;
                  // Customize what your widget looks like with no query results.
                  if (snapshot.data.isEmpty) {
                    // return Container();
                    // For now, we'll just include some dummy data.
                    columnEmpresasRecordList =
                        createDummyEmpresasRecord(count: 4);
                  }
                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(columnEmpresasRecordList.length,
                        (columnIndex) {
                      final columnEmpresasRecord =
                          columnEmpresasRecordList[columnIndex];
                      return RecordEmpresaWidget(
                        name: columnEmpresasRecord.name,
                        address: columnEmpresasRecord.address,
                        rating: columnEmpresasRecord.rating,
                        image: columnEmpresasRecord.logo,
                        idEmpresa: columnEmpresasRecord.reference,
                      );
                    }),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
