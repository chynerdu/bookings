import 'package:bookings/components/user-item-component.dart';
import 'package:bookings/services/mainService.dart';
import 'package:flutter/material.dart';

class UserListComponent extends StatelessWidget {
  final MainAppProvider provider;
  final ScrollController scrollController;
  final String filter;
  UserListComponent(this.provider, this.scrollController, this.filter);

  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height - 200,
        padding: EdgeInsets.only(top: 10),
        // margin: EdgeInsets.only(bottom: 10),
        child: ListView.builder(
            shrinkWrap: true,
            controller: scrollController,
            itemCount: provider.userList.length,
            itemBuilder: (context, index) {
              final user = provider.userList[index];
              return filter == null || filter == ""
                  ? UserItemComponent(user)
                  : user.firstName
                              .toLowerCase()
                              .contains(filter.toLowerCase()) ||
                          user.lastName
                              .toLowerCase()
                              .contains(filter.toLowerCase())
                      ? UserItemComponent(user)
                      // return empty container if it does not contain filter
                      : new Container();
            }));
  }
}
