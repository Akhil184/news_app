// lib/utils/time_utils.dart

import 'package:intl/intl.dart';

String formatTimeAgo(String? publishedAt) {
  if (publishedAt == null) return 'Unknown time';

  DateTime publishedDateTime = DateTime.parse(publishedAt);
  Duration difference = DateTime.now().difference(publishedDateTime);

  if (difference.inDays > 0) {
    return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
  } else if (difference.inHours > 0) {
    return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
  } else if (difference.inMinutes > 0) {
    return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
  } else {
    return 'Just now';
  }
}
