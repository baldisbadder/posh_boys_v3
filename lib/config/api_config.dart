class APIConfig {
  // Posh Boys Custom PLugin API links
  static const String pbAPIbaseUrl = 'https://poshboysbar.co.uk/wp-json/poshboys/v1/';
  static const String eventsEndpoint = '${pbAPIbaseUrl}events';
  static const String offersEndpoint = '${pbAPIbaseUrl}app-offers-all';
  static const String beersEndpoint = '${pbAPIbaseUrl}beers';

  // Wordpress standard API links
  static const String wpAPIbaseUrl = 'https://poshboysbar.co.uk/wp-json/wp/v2/';
  static const String openingTimesEndpoint = '${wpAPIbaseUrl}posts/1123';
}
