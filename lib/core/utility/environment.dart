interface class AppEnvironment {
  final String baseUrl;
  final String domainUrl;
  AppEnvironment(
    this.domainUrl,
    this.baseUrl,
  );
}

interface class ProductionEnvironment extends AppEnvironment {
  ProductionEnvironment() : super("http://192.168.1.67:8081/", "http://192.168.1.67:8081/api/");
}

interface class DevelopmentEnvironment extends AppEnvironment {
  DevelopmentEnvironment() : super("http://192.168.1.67:8081/", "http://192.168.1.67:8081/api/");
}

// ignore: non_constant_identifier_names
AppEnvironment _appEnvironment = ProductionEnvironment();

setEnvironment<T extends AppEnvironment>(T obj) {
  _appEnvironment = obj;
}

AppEnvironment get getEnvironment => _appEnvironment;
