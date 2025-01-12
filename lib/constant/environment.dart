enum Environment {
  development,
  staging,
  production,
}

String getBaseURL() {
  String baseURL;
  Environment env = Environment.production;

  switch (env) {
    case Environment.production:
      baseURL = '';
      break;

    case Environment.staging:
      baseURL = '';
      break;

    case Environment.development:
      baseURL = '';
      break;

    default:
      baseURL = '';
  }

  return baseURL;
}
