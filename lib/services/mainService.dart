import 'package:bookings/services/connection.dart';
import 'package:bookings/services/users/users.dart';
import 'package:flutter/material.dart';

class MainAppProvider with ChangeNotifier, ConnectionProvider, Users {}
