interface class AppEnvironment {
  final String baseUrl;
  final String domainUrl;
  final String firestoreChatReference;
  AppEnvironment(this.domainUrl, this.baseUrl, this.firestoreChatReference);
}

interface class ProductionEnvironment extends AppEnvironment {
  ProductionEnvironment() : super("https://api.unonepal.com/", "https://api.unonepal.com/api/", "uno-chats");
}

interface class DevelopmentEnvironment extends AppEnvironment {
  DevelopmentEnvironment() : super("http://57.181.16.86:8011/", "http://57.181.16.86:8011/api/", "uno-chats");
}

// ignore: non_constant_identifier_names
AppEnvironment _appEnvironment = ProductionEnvironment();

setEnvironment<T extends AppEnvironment>(T obj) {
  _appEnvironment = obj;
}

AppEnvironment get getEnvironment => _appEnvironment;
