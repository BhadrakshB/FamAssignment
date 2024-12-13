import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import '../api/models/screen_card.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: "https://polyjuice.kong.fampay.co")
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET("/mock/famapp/feed/home_section")
  Future<List<ScreenCard>> getContextualCards();
}

// Provide a Dio instance
Dio dio = Dio()
  ..options = BaseOptions(
    connectTimeout: Duration(seconds: 5000),
    receiveTimeout: Duration(seconds: 3000),
  );
ApiClient apiClient = ApiClient(dio, baseUrl: "https://polyjuice.kong.fampay.co");

  // The  ApiClient  class is an abstract class that defines the API endpoints. The  @RestApi  annotation is used to define the base URL for the API. The  getContextualCards  method is an abstract method that returns a list of  CardGroup  objects.
  // The  ApiClient  class is implemented by the  _ApiClient  class, which is generated by the Retrofit package. The  _ApiClient  class is responsible for making HTTP requests to the API.
  // The  dio  instance is a  Dio  object that is used to make HTTP requests. The  apiClient  instance is an instance of the  ApiClient  class that is used to make API requests.
  // Making API Requests
  // To make an API request, you can call the  getContextualCards  method on the  apiClient  instance. The method returns a  Future  that resolves to a list of  CardGroup  objects.