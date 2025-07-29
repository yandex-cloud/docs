When sending HTTP requests, use the following headers:

* {% include [x-client-request-id](x-client-request-id.md) %}
* `x-data-logging-enabled`: Flag that allows saving the data provided by the user in the request.

    By default, the service does not save the data you send over the API. If you provide the `true` value in this header, your data will be saved. This, along with the request ID, will help the support team to solve your problem.