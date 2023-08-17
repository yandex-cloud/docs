# API methods

[{{ yandex-cloud }} APIs](https://github.com/yandex-cloud/cloudapi) use a set of methods for resource management. Each gRPC call is mapped to a certain HTTP method. For example, the `List` call is mapped to the `GET` method and the `Create` call is mapped to the `POST` method. Mapping to HTTP requests is specified in a method's description in [google.api.http](https://github.com/googleapis/googleapis/blob/master/google/api/http.proto) annotation.

There are two sets of methods in APIs:

{% include [method-sets](../_includes/method-sets.md) %}
