import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

Future<void> openLink(String urlString) async {
  if (!urlString.startsWith("mailto") || !urlString.startsWith("tel")) {
    if (!urlString.startsWith("http") && urlString.contains("www")) {
      urlString = "https://$urlString";
    }
  }
  final Uri url = Uri.parse(urlString);
  try {
    // if (await canLaunchUrl(url)) {
    await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    );
    // } else {
    //   throw ('Error: Could not launch');
    // }
  } catch (e) {
    //
    rethrow;
  }
}

Future<void> openWhatsappLink(String number) async {
  final url = Uri.parse("https://api.whatsapp.com/send/?phone=$number");
  try {
    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );
    } else {
      throw ('Error: Could not launch');
    }
  } catch (e) {
    //
    rethrow;
  }
}

openCall(String number) async {
  final url = "tel:$number";
  try {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(
        url,
        mode: LaunchMode.externalApplication,
      );
    } else {
      throw Exception('Could not launch url');
    }
  } catch (e) {
    //
  }
}

final List<dynamic> passwordValidationValues = [
  {"title": "Minimum 8 characters", "regexp": RegExp(r'^.{8,}$')},
  {"title": "At least 1 letter", "regexp": RegExp(r'^(?=.*[a-zA-Z]).+$')},
  {"title": "At least 1 capital letter", "regexp": RegExp(r'^(?=.*[A-Z]).+$')},
  {"title": "At least 1 number", "regexp": RegExp(r'^(?=.*\d).+$')},
  {"title": "At least 1 special character", "regexp": RegExp(r'^(?=.*[!@#$&*~()\[\]{}]).+$')},
  {"title": "Maximum 40 characters", "regexp": RegExp(r'^.{0,40}$')}
];

String priceFormatter(double price, {bool addCurrency = false}) {
  final priceString = price.toString();
  if (addCurrency) {
    return "Rs $priceString";
  }
  return priceString;
}

int getIntervalForLineChart(double minValue, double maxValue) {
  final interval = maxValue - minValue;
  if (interval < 100) {
    return 20;
  }
  if (interval < 500) {
    return 80;
  }
  if (interval < 1000) {
    return 100;
  }
  if (interval < 5000) {
    return 500;
  }
  if (interval < 10000) {
    return 1000;
  }
  return 5000;
}

double calculateMaxY(double maxValue, double interval) {
  return (maxValue / interval).ceil() * interval;
}

String formatDuration(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');

  String days = duration.inDays.toString();
  String hours = twoDigits(duration.inHours.remainder(24));
  String minutes = twoDigits(duration.inMinutes.remainder(60));
  String seconds = twoDigits(duration.inSeconds.remainder(60));

  return '$days / $hours:$minutes:$seconds';
}
