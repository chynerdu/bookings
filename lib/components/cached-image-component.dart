import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CachedImageComponent extends StatelessWidget {
  final dynamic user;
  CachedImageComponent(this.user);

  Widget build(BuildContext context) {
    try {
      return CachedNetworkImage(
        imageUrl: "https://source.unsplash.com/collection/${user.id}",
        imageBuilder: (context, imageProvider) => Container(
            width: MediaQuery.of(context).size.width,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
                colorFilter: new ColorFilter.mode(
                    Colors.black.withOpacity(0.9), BlendMode.softLight),
              ),
            ),
            child: Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // ratings
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Wrap(
                          alignment: WrapAlignment.start,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Text('5.0',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600)),
                            Padding(
                                padding: EdgeInsets.only(left: 3),
                                child: Icon(Icons.star,
                                    size: 18, color: Colors.yellow[200]))
                          ],
                        )
                      ],
                    ),
                    // profile
                    Container(
                        child: Row(
                      children: [
                        ClipOval(
                          child: Image.network(
                            '${user.avatar}',
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${user.firstName} ${user.lastName}',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600)),
                                Text('${user.email}',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600))
                              ],
                            ))
                      ],
                    ))
                  ],
                ))),
        placeholder: (context, url) => SizedBox(
            height: 120,
            child: ProfileShimmer(
                // hasBottomBox: true,
                )
            // SpinKitPulse(color: Color(0xffE58A2E), size: 20)
            ),
        errorWidget: (context, url, error) => Icon(Icons.error),
      );
    } catch (error) {
      return Icon(Icons.error);
    }
  }
}
