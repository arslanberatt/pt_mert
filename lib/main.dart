import 'package:appointment_repository/appointment_repository.dart';
import 'package:customer_repository/customer_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pt_mert/app.dart';
import 'package:pt_mert/firebase_options.dart';
import 'package:pt_mert/simple_bloc_observer.dart';
import 'package:transaction_repository/transaction_repository.dart';
import 'package:user_repository/user_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Bloc.observer = SimpleBlocObserver();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    MainApp(
      FirebaseUserRepository(),
      FirebaseAppointmentRepository(),
      FirebaseCustomerRepository(),
      FirebaseTransactionRepository(),
    ),
  );
}
