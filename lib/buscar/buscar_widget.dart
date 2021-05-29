import '../backend/backend.dart';
import '../components/record_empresa_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BuscarWidget extends StatefulWidget {
  BuscarWidget({Key key}) : super(key: key);

  @override
  _BuscarWidgetState createState() => _BuscarWidgetState();
}

class _BuscarWidgetState extends State<BuscarWidget> {
  TextEditingController termSearchController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    termSearchController = TextEditingController();
  }

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
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(1, 0, 0, 0),
                    child: TextFormField(
                      controller: termSearchController,
                      obscureText: false,
                      decoration: InputDecoration(
                        hintText: 'Buscar empresa o servicios',
                        hintStyle: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Poppins',
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(4.0),
                            topRight: Radius.circular(4.0),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(4.0),
                            topRight: Radius.circular(4.0),
                          ),
                        ),
                        filled: true,
                      ),
                      style: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                )
              ],
            ),
            Expanded(
              child: StreamBuilder<List<EmpresasRecord>>(
                stream: queryEmpresasRecord(
                  queryBuilder: (empresasRecord) => empresasRecord.where('name',
                      isEqualTo: termSearchController.text),
                ),
                builder: (context, snapshot) {
                  // Customize what your widget looks like when it's loading.
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }
                  List<EmpresasRecord> listViewEmpresasRecordList =
                      snapshot.data;
                  // Customize what your widget looks like with no query results.
                  if (listViewEmpresasRecordList.isEmpty) {
                    return Image.network(
                      'https://image.flaticon.com/icons/png/512/3388/3388466.png',
                      width: 200,
                      height: 200,
                    );
                  }
                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    itemCount: listViewEmpresasRecordList.length,
                    itemBuilder: (context, listViewIndex) {
                      final listViewEmpresasRecord =
                          listViewEmpresasRecordList[listViewIndex];
                      return RecordEmpresaWidget(
                        name: listViewEmpresasRecord.name,
                        address: listViewEmpresasRecord.address,
                        rating: listViewEmpresasRecord.rating,
                        image: listViewEmpresasRecord.logo,
                        idEmpresa: listViewEmpresasRecord.reference,
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
