import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../components/record_empresa_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FavoritosWidget extends StatefulWidget {
  FavoritosWidget({Key key}) : super(key: key);

  @override
  _FavoritosWidgetState createState() => _FavoritosWidgetState();
}

class _FavoritosWidgetState extends State<FavoritosWidget> {
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
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: StreamBuilder<List<FavoritesRecord>>(
                stream: queryFavoritesRecord(
                  queryBuilder: (favoritesRecord) => favoritesRecord
                      .where('idUser', isEqualTo: currentUserReference),
                ),
                builder: (context, snapshot) {
                  // Customize what your widget looks like when it's loading.
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }
                  List<FavoritesRecord> listViewFavoritesRecordList =
                      snapshot.data;
                  // Customize what your widget looks like with no query results.
                  if (listViewFavoritesRecordList.isEmpty) {
                    return Center(
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://image.flaticon.com/icons/png/512/3064/3064836.png',
                        width: 200,
                        height: 200,
                        fit: BoxFit.contain,
                      ),
                    );
                  }
                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    itemCount: listViewFavoritesRecordList.length,
                    itemBuilder: (context, listViewIndex) {
                      final listViewFavoritesRecord =
                          listViewFavoritesRecordList[listViewIndex];
                      return StreamBuilder<EmpresasRecord>(
                        stream: EmpresasRecord.getDocument(
                            listViewFavoritesRecord.idEmpresa),
                        builder: (context, snapshot) {
                          // Customize what your widget looks like when it's loading.
                          if (!snapshot.hasData) {
                            return Center(child: CircularProgressIndicator());
                          }
                          final recordEmpresaEmpresasRecord = snapshot.data;
                          return RecordEmpresaWidget(
                            name: recordEmpresaEmpresasRecord.name,
                            address: recordEmpresaEmpresasRecord.address,
                            rating: recordEmpresaEmpresasRecord.rating,
                            image: recordEmpresaEmpresasRecord.logo,
                            idEmpresa: recordEmpresaEmpresasRecord.reference,
                          );
                        },
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
