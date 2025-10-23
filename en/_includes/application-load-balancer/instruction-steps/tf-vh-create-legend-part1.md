* `name`: Virtual host name. Follow these naming requirements:

    {% include [name-format](../../name-format.md) %}

* `http_router_id`: HTTP router ID.
* `rate_limit`: Request rate limit for the entire virtual host (optional).
    * `all_requests`: Limit on all requests per second or per minute (optional):
        * `per_second`: Maximum number of incoming requests to the virtual host per second.
        * `per_minute`: Maximum number of incoming requests to the virtual host per minute.

        The `per_second`, and `per_minute` parameters are mutually exclusive: you can use only one of them.
    * `requests_per_ip`: Additionally limits requests for each IP address per second or per minute (optional):
        * `per_second`: Maximum number of incoming requests from a single IP address to the virtual host per second.
        * `per_minute`: Maximum number of incoming requests from a single IP address to the virtual host per minute.

        The `per_second`, and `per_minute` parameters are mutually exclusive: you can use only one of them.