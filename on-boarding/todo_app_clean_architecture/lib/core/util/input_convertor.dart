import 'package:dartz/dartz.dart';

import '../error/failures.dart';

class InputConverter {
  String dateTimeToString(DateTime datetime) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];

    return '${months[datetime.month - 1]} ${datetime.day}, ${datetime.year}';
  }

  Either<InputValidationFailure, DateTime> stringToDateTime(String str,
      {bool future = false}) {
    try {
      final date = DateTime.parse(str);

      if (future && date.isBefore(DateTime.now())) {
        return const Left(InputValidationFailure(message: "Invalid Date"));
      }

      return Right(date);
    } on FormatException {
      return const Left(InputValidationFailure(message: "Invalid Date Format"));
    }
  }
}
