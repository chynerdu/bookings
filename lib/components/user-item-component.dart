import 'package:bookings/components/cached-image-component.dart';
import 'package:flutter/material.dart';

class UserItemComponent extends StatelessWidget {
  final dynamic user;
  UserItemComponent(this.user);

  Widget build(BuildContext context) {
    return Container(
        child: Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(top: 30),
          child: Container(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedImageComponent(user),
              Container(
                  decoration: BoxDecoration(
                      color: Color(0xfff2f2f2),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      )),
                  child: Wrap(
                    children: [
                      Container(
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${user.email}',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black54)),
                              SizedBox(height: 10),
                              Text('${user.id}',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 6,
                                  style: TextStyle(
                                      fontSize: 15,
                                      height: 1.4,
                                      color: Color(0xff38BA64),
                                      fontWeight: FontWeight.w800)),
                            ],
                          )),
                      SizedBox(height: 5),
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(color: Colors.black12, width: 1.0),
                          ),
                        ),
                        padding: EdgeInsets.all(10.0),
                        child: Align(
                            alignment: Alignment.center,
                            child: Text('View Profile',
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500))),
                      ),
                    ],
                  ))
            ],
          )),
        ),
      ],
    ));
  }
}
