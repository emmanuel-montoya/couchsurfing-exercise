import 'dart:convert';

import 'package:couchsurfing_social/utils/app_color.dart';
import 'package:couchsurfing_social/utils/constants/app_translation_constants.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:timeago/timeago.dart' as timeago;

class AppUtilities {

  static final logger = Logger(
    printer: PrettyPrinter(
      methodCount: 5,
      errorMethodCount: 5,
      lineLength: 50,
      colors: true,
      printEmojis: true,
      printTime: false,
    )
  );

  static void showAlert(BuildContext context, {String title = '',  String message = ''}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColor.getMain(),
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text(AppTranslationConstants.close.tr,
                style: const TextStyle(color: AppColor.white)
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  static String secondsToMinutes(int seconds, {bool clockView = true}) {
    // Calculate the number of minutes and remaining seconds
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;

    // Format the minutes and seconds as two-digit strings
    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = remainingSeconds.toString().padLeft(2, '0');

    // Create the formatted string
    String formattedTime = '';

    if(clockView) {
      formattedTime = '$minutesStr:$secondsStr';
    } else {
      formattedTime = '$minutesStr ${AppTranslationConstants.minutes.tr} - $secondsStr ${AppTranslationConstants.seconds.tr}';
    }


    return formattedTime;
  }

  static String getTimeAgo(int createdTime, {showShort = true}) {

    Locale? locale;

    if(!showShort) locale = Get.locale;

    return timeago.format(
        DateTime.fromMillisecondsSinceEpoch(createdTime),
        locale: locale?.languageCode ?? 'en_short'
    );
  }

  static Position jsonToPosition(positionSnapshot){
    Position position = Position(
        longitude: 0, latitude: 0,
        timestamp: DateTime.now(),
        accuracy: 0, altitude: 0,
        heading: 0, speed: 0, speedAccuracy: 0,
        altitudeAccuracy: 1, headingAccuracy: 1
    );
    try {
      if(positionSnapshot != null && positionSnapshot != "null") {
        dynamic positionJSON = jsonDecode(positionSnapshot);
        double longitude = positionJSON['longitude'];
        double latitude = positionJSON['latitude'];
        DateTime timestamp = DateTime.now();
        double accuracy = positionJSON['accuracy'];
        double altitude = positionJSON['altitude'];
        double heading = positionJSON['heading'];
        double speed = positionJSON['speed'];
        double speedAccuracy = positionJSON['speed_accuracy'];
        bool isMocked = positionJSON['is_mocked'];

        position = Position(longitude: longitude,
            latitude: latitude,
            timestamp: timestamp,
            accuracy: accuracy,
            altitude: altitude,
            heading: heading,
            speed: speed,
            speedAccuracy: speedAccuracy,
            isMocked: isMocked,
            altitudeAccuracy: 1,
            headingAccuracy: 1
        );
      }
    } catch (e) {
      AppUtilities.logger.e(e.toString());
    }

    return position;
  }

  static int distanceBetweenPositionsRounded(Position mainUserPos, Position refUserPos){

    int distanceKm = 0;
    try {
      double mainLatitude = mainUserPos.latitude;
      double mainLongitude = mainUserPos.longitude;
      double refLatitude = refUserPos.latitude;
      double refLongitude = refUserPos.longitude;

      int distanceInMeters = Geolocator.distanceBetween(mainLatitude, mainLongitude, refLatitude, refLongitude).round();
      logger.t("Distance between positions $distanceInMeters");

      distanceKm = (distanceInMeters / 1000).round();
    } catch (e) {
      logger.e(e.toString());
    }

    return distanceKm;
  }


}
