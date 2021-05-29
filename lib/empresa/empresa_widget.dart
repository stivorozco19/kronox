import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_toggle_icon.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class EmpresaWidget extends StatefulWidget {
  EmpresaWidget({
    Key key,
    this.idEmpresa,
  }) : super(key: key);

  final DocumentReference idEmpresa;

  @override
  _EmpresaWidgetState createState() => _EmpresaWidgetState();
}

class _EmpresaWidgetState extends State<EmpresaWidget> {
  bool checkboxListTileValue;
  final pageViewController = PageController();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<EmpresasRecord>(
      stream: EmpresasRecord.getDocument(widget.idEmpresa),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        final empresaEmpresasRecord = snapshot.data;
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            backgroundColor: Colors.white,
            automaticallyImplyLeading: true,
            title: Text(
              empresaEmpresasRecord.name,
              style: FlutterFlowTheme.bodyText1.override(
                fontFamily: 'Poppins',
              ),
            ),
            actions: [
              Align(
                alignment: Alignment(0, 0),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                  child: Stack(
                    alignment: Alignment(0, 0),
                    children: [
                      Align(
                        alignment: Alignment(0, 0),
                        child: StreamBuilder<List<FavoritesRecord>>(
                          stream: queryFavoritesRecord(
                            queryBuilder: (favoritesRecord) =>
                                favoritesRecord.where('idUser',
                                    isEqualTo: currentUserReference),
                            singleRecord: true,
                          ),
                          builder: (context, snapshot) {
                            // Customize what your widget looks like when it's loading.
                            if (!snapshot.hasData) {
                              return Center(child: CircularProgressIndicator());
                            }
                            List<FavoritesRecord>
                                toggleIconFavoritesRecordList = snapshot.data;
                            // Customize what your widget looks like with no query results.
                            if (snapshot.data.isEmpty) {
                              // return Container();
                              // For now, we'll just include some dummy data.
                              toggleIconFavoritesRecordList =
                                  createDummyFavoritesRecord(count: 1);
                            }
                            final toggleIconFavoritesRecord =
                                toggleIconFavoritesRecordList.first;
                            return ToggleIcon(
                              onPressed: () async {
                                final isActive =
                                    !toggleIconFavoritesRecord.isActive;

                                final favoritesRecordData =
                                    createFavoritesRecordData(
                                  isActive: isActive,
                                );

                                await toggleIconFavoritesRecord.reference
                                    .update(favoritesRecordData);
                              },
                              value: toggleIconFavoritesRecord.isActive,
                              onIcon: Icon(
                                Icons.favorite,
                                color: Color(0xFFFF0000),
                                size: 20,
                              ),
                              offIcon: Icon(
                                Icons.favorite_border,
                                color: Colors.black,
                                size: 20,
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
            centerTitle: true,
            elevation: 4,
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              primary: false,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 1000,
                    child: Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 200,
                          decoration: BoxDecoration(
                            color: Color(0xFFEEEEEE),
                          ),
                          child: StreamBuilder<List<ImagesEmpresasRecord>>(
                            stream: queryImagesEmpresasRecord(
                              queryBuilder: (imagesEmpresasRecord) =>
                                  imagesEmpresasRecord.where('idEmpresa',
                                      isEqualTo: widget.idEmpresa),
                            ),
                            builder: (context, snapshot) {
                              // Customize what your widget looks like when it's loading.
                              if (!snapshot.hasData) {
                                return Center(
                                    child: CircularProgressIndicator());
                              }
                              List<ImagesEmpresasRecord>
                                  pageViewImagesEmpresasRecordList =
                                  snapshot.data;
                              // Customize what your widget looks like with no query results.
                              if (snapshot.data.isEmpty) {
                                // return Container();
                                // For now, we'll just include some dummy data.
                                pageViewImagesEmpresasRecordList =
                                    createDummyImagesEmpresasRecord(count: 4);
                              }
                              return Container(
                                width: double.infinity,
                                height: 200,
                                child: PageView.builder(
                                  controller: pageViewController,
                                  scrollDirection: Axis.horizontal,
                                  itemCount:
                                      pageViewImagesEmpresasRecordList.length,
                                  itemBuilder: (context, pageViewIndex) {
                                    final pageViewImagesEmpresasRecord =
                                        pageViewImagesEmpresasRecordList[
                                            pageViewIndex];
                                    return Image.network(
                                      'https://images.unsplash.com/photo-1598887142487-3c854d51eabb?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80',
                                      width: double.infinity,
                                      height: 200,
                                      fit: BoxFit.cover,
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                        Align(
                          alignment: Alignment(0, -0.3),
                          child: Container(
                            width: double.infinity,
                            height: 500,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.tertiaryColor,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(10, 10, 0, 0),
                                        child: Container(
                                          width: 80,
                                          height: 80,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                'https://cdn2.vectorstock.com/i/1000x1000/61/01/barbershop-logo-with-barber-pole-in-vintage-style-vector-24216101.jpg',
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 90,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.tertiaryColor,
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(10, 0, 0, 0),
                                        child: Text(
                                          empresaEmpresasRecord.name,
                                          textAlign: TextAlign.start,
                                          style: FlutterFlowTheme.subtitle1
                                              .override(
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(10, 10, 0, 0),
                                        child: Text(
                                          empresaEmpresasRecord.description,
                                          style: FlutterFlowTheme.bodyText1
                                              .override(
                                            fontFamily: 'Roboto',
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 500,
                                  constraints: BoxConstraints(
                                    maxHeight:
                                        MediaQuery.of(context).size.height * 1,
                                  ),
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.tertiaryColor,
                                  ),
                                  child: DefaultTabController(
                                    length: 3,
                                    initialIndex: 0,
                                    child: Column(
                                      children: [
                                        TabBar(
                                          isScrollable: true,
                                          labelColor: Color(0xFF313131),
                                          indicatorColor:
                                              FlutterFlowTheme.primaryColor,
                                          tabs: [
                                            Tab(
                                              text: 'SERVICIOS',
                                            ),
                                            Tab(
                                              text: 'VITRINA',
                                            ),
                                            Tab(
                                              text: 'ACERCA DE',
                                            )
                                          ],
                                        ),
                                        Expanded(
                                          child: TabBarView(
                                            children: [
                                              Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Expanded(
                                                    child: StreamBuilder<
                                                        List<
                                                            ServiciosEmpresaRecord>>(
                                                      stream:
                                                          queryServiciosEmpresaRecord(
                                                        queryBuilder: (serviciosEmpresaRecord) =>
                                                            serviciosEmpresaRecord
                                                                .where(
                                                                    'idEmpresa',
                                                                    isEqualTo:
                                                                        widget
                                                                            .idEmpresa)
                                                                .where(
                                                                    'isActive',
                                                                    isEqualTo:
                                                                        true),
                                                      ),
                                                      builder:
                                                          (context, snapshot) {
                                                        // Customize what your widget looks like when it's loading.
                                                        if (!snapshot.hasData) {
                                                          return Center(
                                                              child:
                                                                  CircularProgressIndicator());
                                                        }
                                                        List<ServiciosEmpresaRecord>
                                                            listViewServiciosEmpresaRecordList =
                                                            snapshot.data;
                                                        // Customize what your widget looks like with no query results.
                                                        if (snapshot
                                                            .data.isEmpty) {
                                                          // return Container();
                                                          // For now, we'll just include some dummy data.
                                                          listViewServiciosEmpresaRecordList =
                                                              createDummyServiciosEmpresaRecord(
                                                                  count: 4);
                                                        }
                                                        return ListView.builder(
                                                          padding:
                                                              EdgeInsets.zero,
                                                          scrollDirection:
                                                              Axis.vertical,
                                                          itemCount:
                                                              listViewServiciosEmpresaRecordList
                                                                  .length,
                                                          itemBuilder: (context,
                                                              listViewIndex) {
                                                            final listViewServiciosEmpresaRecord =
                                                                listViewServiciosEmpresaRecordList[
                                                                    listViewIndex];
                                                            return CheckboxListTile(
                                                              value:
                                                                  checkboxListTileValue ??
                                                                      false,
                                                              onChanged: (newValue) =>
                                                                  setState(() =>
                                                                      checkboxListTileValue =
                                                                          newValue),
                                                              title: Text(
                                                                listViewServiciosEmpresaRecord
                                                                    .name,
                                                                style:
                                                                    FlutterFlowTheme
                                                                        .title3
                                                                        .override(
                                                                  fontFamily:
                                                                      'Roboto',
                                                                ),
                                                              ),
                                                              subtitle: Text(
                                                                listViewServiciosEmpresaRecord
                                                                    .price
                                                                    .toString(),
                                                                style: FlutterFlowTheme
                                                                    .subtitle2
                                                                    .override(
                                                                  fontFamily:
                                                                      'Poppins',
                                                                ),
                                                              ),
                                                              tileColor: Color(
                                                                  0xFFF5F5F5),
                                                              dense: false,
                                                              controlAffinity:
                                                                  ListTileControlAffinity
                                                                      .trailing,
                                                            );
                                                          },
                                                        );
                                                      },
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Expanded(
                                                    child: StreamBuilder<
                                                        List<ProductsRecord>>(
                                                      stream:
                                                          queryProductsRecord(
                                                        queryBuilder: (productsRecord) =>
                                                            productsRecord
                                                                .where(
                                                                    'idEmpresa',
                                                                    isEqualTo:
                                                                        widget
                                                                            .idEmpresa)
                                                                .where(
                                                                    'isActive',
                                                                    isEqualTo:
                                                                        true),
                                                      ),
                                                      builder:
                                                          (context, snapshot) {
                                                        // Customize what your widget looks like when it's loading.
                                                        if (!snapshot.hasData) {
                                                          return Center(
                                                              child:
                                                                  CircularProgressIndicator());
                                                        }
                                                        List<ProductsRecord>
                                                            gridViewProductsRecordList =
                                                            snapshot.data;
                                                        // Customize what your widget looks like with no query results.
                                                        if (gridViewProductsRecordList
                                                            .isEmpty) {
                                                          return Center(
                                                            child:
                                                                CachedNetworkImage(
                                                              imageUrl:
                                                                  'https://image.flaticon.com/icons/png/512/751/751621.png',
                                                              width: 150,
                                                              height: 100,
                                                              fit: BoxFit
                                                                  .contain,
                                                            ),
                                                          );
                                                        }
                                                        return GridView.builder(
                                                          padding:
                                                              EdgeInsets.zero,
                                                          gridDelegate:
                                                              SliverGridDelegateWithFixedCrossAxisCount(
                                                            crossAxisCount: 3,
                                                            crossAxisSpacing:
                                                                10,
                                                            mainAxisSpacing: 60,
                                                            childAspectRatio: 1,
                                                          ),
                                                          scrollDirection:
                                                              Axis.vertical,
                                                          itemCount:
                                                              gridViewProductsRecordList
                                                                  .length,
                                                          itemBuilder: (context,
                                                              gridViewIndex) {
                                                            final gridViewProductsRecord =
                                                                gridViewProductsRecordList[
                                                                    gridViewIndex];
                                                            return Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .fromLTRB(
                                                                          5,
                                                                          5,
                                                                          5,
                                                                          5),
                                                              child: Container(
                                                                width: 100,
                                                                height: 100,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Color(
                                                                      0xFFEEEEEE),
                                                                ),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10),
                                                                      child: Image
                                                                          .network(
                                                                        gridViewProductsRecord
                                                                            .image,
                                                                        width:
                                                                            100,
                                                                        height:
                                                                            100,
                                                                        fit: BoxFit
                                                                            .contain,
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      gridViewProductsRecord
                                                                          .name,
                                                                      style: FlutterFlowTheme
                                                                          .subtitle1
                                                                          .override(
                                                                        fontFamily:
                                                                            'Roboto',
                                                                        fontSize:
                                                                            16,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      gridViewProductsRecord
                                                                          .price
                                                                          .toString(),
                                                                      style: FlutterFlowTheme
                                                                          .bodyText1
                                                                          .override(
                                                                        fontFamily:
                                                                            'Poppins',
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        );
                                                      },
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Container(
                                                width: 100,
                                                height: double.infinity,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme
                                                      .tertiaryColor,
                                                ),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              20, 10, 0, 0),
                                                      child: Text(
                                                        'Infromación',
                                                        style: FlutterFlowTheme
                                                            .bodyText1
                                                            .override(
                                                          fontFamily: 'Poppins',
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              0, 10, 0, 0),
                                                      child: ListTile(
                                                        leading: Icon(
                                                          Icons.location_on,
                                                          color:
                                                              FlutterFlowTheme
                                                                  .primaryColor,
                                                          size: 30,
                                                        ),
                                                        title: Text(
                                                          empresaEmpresasRecord
                                                              .address,
                                                          textAlign:
                                                              TextAlign.start,
                                                          style:
                                                              FlutterFlowTheme
                                                                  .subtitle1
                                                                  .override(
                                                            fontFamily:
                                                                'Roboto',
                                                          ),
                                                        ),
                                                        trailing: Icon(
                                                          Icons
                                                              .arrow_forward_ios,
                                                          color:
                                                              Color(0xFF303030),
                                                          size: 20,
                                                        ),
                                                        tileColor:
                                                            FlutterFlowTheme
                                                                .tertiaryColor,
                                                        dense: false,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              0, 10, 0, 0),
                                                      child: ListTile(
                                                        leading: Icon(
                                                          Icons.phone,
                                                          color:
                                                              FlutterFlowTheme
                                                                  .primaryColor,
                                                          size: 30,
                                                        ),
                                                        title: Text(
                                                          empresaEmpresasRecord
                                                              .phone,
                                                          textAlign:
                                                              TextAlign.start,
                                                          style:
                                                              FlutterFlowTheme
                                                                  .subtitle1
                                                                  .override(
                                                            fontFamily:
                                                                'Roboto',
                                                          ),
                                                        ),
                                                        trailing: Icon(
                                                          Icons
                                                              .arrow_forward_ios,
                                                          color:
                                                              Color(0xFF303030),
                                                          size: 20,
                                                        ),
                                                        tileColor:
                                                            FlutterFlowTheme
                                                                .tertiaryColor,
                                                        dense: false,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              0, 10, 0, 0),
                                                      child: ListTile(
                                                        leading: Icon(
                                                          Icons.alternate_email,
                                                          color:
                                                              FlutterFlowTheme
                                                                  .primaryColor,
                                                          size: 30,
                                                        ),
                                                        title: Text(
                                                          empresaEmpresasRecord
                                                              .address,
                                                          textAlign:
                                                              TextAlign.start,
                                                          style:
                                                              FlutterFlowTheme
                                                                  .subtitle1
                                                                  .override(
                                                            fontFamily:
                                                                'Roboto',
                                                          ),
                                                        ),
                                                        trailing: Icon(
                                                          Icons
                                                              .arrow_forward_ios,
                                                          color:
                                                              Color(0xFF303030),
                                                          size: 20,
                                                        ),
                                                        tileColor:
                                                            FlutterFlowTheme
                                                                .tertiaryColor,
                                                        dense: false,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              20, 20, 0, 0),
                                                      child: Text(
                                                        'Reseñas',
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: FlutterFlowTheme
                                                            .bodyText1
                                                            .override(
                                                          fontFamily: 'Poppins',
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              10, 20, 10, 20),
                                                      child: FFButtonWidget(
                                                        onPressed: () {
                                                          print(
                                                              'Button pressed ...');
                                                        },
                                                        text:
                                                            'Escribe tú reseña',
                                                        icon: FaIcon(
                                                          FontAwesomeIcons.edit,
                                                          color:
                                                              FlutterFlowTheme
                                                                  .primaryColor,
                                                        ),
                                                        options:
                                                            FFButtonOptions(
                                                          width:
                                                              double.infinity,
                                                          height: 50,
                                                          color:
                                                              Color(0x00FF9052),
                                                          textStyle:
                                                              FlutterFlowTheme
                                                                  .subtitle2
                                                                  .override(
                                                            fontFamily:
                                                                'Poppins',
                                                            color:
                                                                FlutterFlowTheme
                                                                    .primaryColor,
                                                          ),
                                                          borderSide:
                                                              BorderSide(
                                                            color: Colors
                                                                .transparent,
                                                            width: 1,
                                                          ),
                                                          borderRadius: 12,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: double.infinity,
                                                      height: 700,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0xFFEEEEEE),
                                                      ),
                                                      child: StreamBuilder<
                                                          List<ReviewsRecord>>(
                                                        stream:
                                                            queryReviewsRecord(
                                                          queryBuilder: (reviewsRecord) =>
                                                              reviewsRecord.where(
                                                                  'idEmpresa',
                                                                  isEqualTo: widget
                                                                      .idEmpresa),
                                                        ),
                                                        builder: (context,
                                                            snapshot) {
                                                          // Customize what your widget looks like when it's loading.
                                                          if (!snapshot
                                                              .hasData) {
                                                            return Center(
                                                                child:
                                                                    CircularProgressIndicator());
                                                          }
                                                          List<ReviewsRecord>
                                                              listViewReviewsRecordList =
                                                              snapshot.data;
                                                          // Customize what your widget looks like with no query results.
                                                          if (listViewReviewsRecordList
                                                              .isEmpty) {
                                                            return Center(
                                                              child:
                                                                  CachedNetworkImage(
                                                                imageUrl:
                                                                    'https://image.flaticon.com/icons/png/512/2285/2285551.png',
                                                                width: 100,
                                                                height: 100,
                                                                fit: BoxFit
                                                                    .contain,
                                                              ),
                                                            );
                                                          }
                                                          return ListView
                                                              .builder(
                                                            padding:
                                                                EdgeInsets.zero,
                                                            shrinkWrap: true,
                                                            scrollDirection:
                                                                Axis.vertical,
                                                            itemCount:
                                                                listViewReviewsRecordList
                                                                    .length,
                                                            itemBuilder: (context,
                                                                listViewIndex) {
                                                              final listViewReviewsRecord =
                                                                  listViewReviewsRecordList[
                                                                      listViewIndex];
                                                              return StreamBuilder<
                                                                  UsersRecord>(
                                                                stream: UsersRecord
                                                                    .getDocument(
                                                                        listViewReviewsRecord
                                                                            .idUser),
                                                                builder: (context,
                                                                    snapshot) {
                                                                  // Customize what your widget looks like when it's loading.
                                                                  if (!snapshot
                                                                      .hasData) {
                                                                    return Center(
                                                                        child:
                                                                            CircularProgressIndicator());
                                                                  }
                                                                  final rowUsersRecord =
                                                                      snapshot
                                                                          .data;
                                                                  return Padding(
                                                                    padding: EdgeInsets
                                                                        .fromLTRB(
                                                                            0,
                                                                            10,
                                                                            0,
                                                                            0),
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      children: [
                                                                        Padding(
                                                                          padding: EdgeInsets.fromLTRB(
                                                                              0,
                                                                              0,
                                                                              15,
                                                                              0),
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                75,
                                                                            height:
                                                                                75,
                                                                            clipBehavior:
                                                                                Clip.antiAlias,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              shape: BoxShape.circle,
                                                                            ),
                                                                            child:
                                                                                CachedNetworkImage(
                                                                              imageUrl: rowUsersRecord.photoUrl,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Container(
                                                                          width:
                                                                              200,
                                                                          height:
                                                                              100,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                Color(0xFFEEEEEE),
                                                                          ),
                                                                          child:
                                                                              Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Text(
                                                                                rowUsersRecord.displayName,
                                                                                style: FlutterFlowTheme.subtitle1.override(
                                                                                  fontFamily: 'Roboto',
                                                                                  fontSize: 16,
                                                                                ),
                                                                              ),
                                                                              Text(
                                                                                listViewReviewsRecord.review,
                                                                                style: FlutterFlowTheme.bodyText1.override(
                                                                                  fontFamily: 'Poppins',
                                                                                ),
                                                                              )
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        Container(
                                                                          width:
                                                                              100,
                                                                          height:
                                                                              100,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                Color(0xFFEEEEEE),
                                                                          ),
                                                                          child:
                                                                              Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Padding(
                                                                                padding: EdgeInsets.fromLTRB(0, 0, 3, 0),
                                                                                child: Text(
                                                                                  listViewReviewsRecord.rating.toString(),
                                                                                  textAlign: TextAlign.start,
                                                                                  style: FlutterFlowTheme.bodyText1.override(
                                                                                    fontFamily: 'Poppins',
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Icon(
                                                                                Icons.star,
                                                                                color: Color(0xFFFDD10D),
                                                                                size: 20,
                                                                              )
                                                                            ],
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
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
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
