import 'package:timeago/timeago.dart' as time_ago;
import 'package:youtube_app/utils/custom_dayago.dart';

extension StringX on String {
  String transformViews() {
    // this ở đây chính là instance của class (hay là cái mà ta truyền vào, cái mà ta muốn convert)
    int num = int.parse(this);
    if (num > 1000000000) {
      return '${(num / 1000000000).toStringAsFixed(1)}B';
    } else if (num > 1000000) {
      return '${(num / 1000000).toStringAsFixed(1)}M';
    } else if (num > 1000) {
      return '${(num / 1000).toStringAsFixed(1)}K';
    }
    return this;
  }

  String transformDate() {
    var time = DateTime.parse(this);
    final dayAgo = DateTime.now().subtract(Duration(minutes: time.minute));
    time_ago.setLocaleMessages('en', CustomDayAgo());
    return time_ago.format(dayAgo);
  }
}
