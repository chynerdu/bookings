import 'package:bookings/components/cached-image-component.dart';
import 'package:bookings/components/user-list-component.dart';
import 'package:bookings/services/mainService.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomeScreen extends StatefulWidget {
  final MainAppProvider provider;
  HomeScreen(this.provider);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  TextEditingController searchController = new TextEditingController();
  ScrollController _scrollcontroller = ScrollController();

  String filter;
  bool search = false;

  void initState() {
    searchController.addListener(() {
      setState(() {
        filter = searchController.text;
      });
    });
    WidgetsBinding.instance.addPostFrameCallback((_) => getUsers());

    super.initState();
  }

  @override
  void dispose() {
    widget.provider.resetCurrentPage();
    super.dispose();
  }

  getUsers() async {
    await widget.provider.getUsers(loadMore: false);
    _scrollcontroller.addListener(() {
      double maxScroll = _scrollcontroller.position.maxScrollExtent;
      double currentScroll = _scrollcontroller.position.pixels;
      double loadMorePosition = 200;

      // call loadmore when
      // when current page in app state is less than or equal to total page
      // not compulsory though, but an extra check
      // prevent loadmore from being call when its currently fetching users.

      if (maxScroll - currentScroll <= loadMorePosition &&
          widget.provider.currentPage <= widget.provider.totalPages &&
          !widget.provider.fetchingUsers) {
        widget.provider.getUsers(loadMore: true);
      }
    });
  }

  sideDrawer() {
    return Drawer(child: Center(child: Text('Drawer here')));
  }

  buildSearchFormField() {
    return Container(
        height: 45,
        child: TextField(
            controller: searchController,
            style: TextStyle(
              color: Colors.black,
            ),
            decoration: new InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(30.0),
                  ),
                  borderSide: BorderSide(color: Colors.black54, width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(30.0),
                  ),
                  borderSide: BorderSide(color: Colors.black38, width: 1.0),
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  size: 20,
                  color: Colors.black54,
                ),
                hintText: 'Cinematographer',
                hintStyle: TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                    fontWeight: FontWeight.w600))));
  }

  Widget buildAllUserList() {
    return UserListComponent(widget.provider, _scrollcontroller, filter);
  }

  showLoader() {
    return Center(child: SpinKitFadingFour(color: Color(0xffE58A2E), size: 40));
  }

  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Color(0xfff9f9fb),
            key: _scaffoldKey,
            endDrawer: sideDrawer(),
            body: widget.provider.fetchingUsers &&
                    widget.provider.userList.length == 0
                ? showLoader()
                : Container(
                    padding: EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 10,
                    ),
                    child: SingleChildScrollView(
                        child: Column(
                      children: [
                        Container(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                              "assets/logo-image.png",
                              width: 94,
                              height: 26,
                            ),
                            IconButton(
                              // alignment: Alignment.topLeft,
                              padding: EdgeInsets.only(left: 0, right: 0),
                              icon: Icon(Icons.menu,
                                  color: Colors.black, size: 28),
                              onPressed: () {
                                print('tapped');
                                _scaffoldKey.currentState.openEndDrawer();
                              },
                            ),
                          ],
                        )),
                        SizedBox(height: 20),
                        // serach field
                        buildSearchFormField(),

                        // users
                        buildAllUserList(),
                        SizedBox(height: 20),
                        widget.provider.fetchingUsers
                            ? SpinKitThreeBounce(
                                color: Color(0xffE58A2E), size: 20)
                            : Container(),
                        SizedBox(height: 40),
                      ],
                    )))));
  }
}
