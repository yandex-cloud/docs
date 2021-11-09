# API methods

APIs use a set of methods for resource management. Each gRPC method is mapped to a certain HTTP method (verb). For example, the `List` method is mapped to the verb `GET`, while the `Create` method is mapped to the verb `POST`. Mapping to HTTP requests is specified in a method's description in [google.api.http](https://github.com/googleapis/googleapis/blob/master/google/api/http.proto) annotation.

There are two sets of methods in APIs:

{% include [method-sets](../_includes/method-sets.md) %}
