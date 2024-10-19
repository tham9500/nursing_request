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
      baseURL = 'https://api-v2.terminusfleet.com/api/';
      break;

    case Environment.staging:
      baseURL = 'https://api-v2-staging.terminusfleet.com/api/';
      break;

    case Environment.development:
      baseURL = 'https://test-v2-api.terminusfleet.com/api/';
      break;

    default:
      baseURL = 'https://api-v2.terminusfleet.com/api/';
  }

  return baseURL;
}
