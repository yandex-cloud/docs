`rate_limit`: Limits the number of requests per unit of time (optional):

* `all_requests`: Limits all incoming requests (optional):

    * `per_second`: Maximum number of incoming requests to a route per second.
    * `per_minute`: Maximum number of incoming requests to a route per minute.

    The `per_second`, and `per_minute` parameters are mutually exclusive: you can use only one of them.
* `requests_per_ip`: Limits incoming requests from a single IP address (optional):

    * `per_second`: Maximum number of incoming requests to a route from a single IP address per second.
    * `per_minute`: Maximum number of incoming requests to a route from a single IP address per minute.

    The `per_second`, and `per_minute` parameters are mutually exclusive: you can use only one of them.