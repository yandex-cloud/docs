Where:
* `--name`: The name of the backend you want to add or update.
* `--panic-threshold`: Panic mode threshold.
* `--http-healthcheck`: Health check settings:
  * `port`: Port.
  * `healthy-threshold`: Healthy threshold.
  * `unhealthy-threshold`: Unhealthy threshold.
  * `expected-statuses`: HTTP status code deemed valid during a backend health check. You can add multiple values separated by a comma: `expected-statuses=201,expected-statuses=205,expected-statuses=302`. You can use HTTP codes in the range between `100` and `599`. If this setting is not specified, the response code will be `200`.
  * `timeout`: Maximum connection time.
  * `interval`: Interval.
  * `host`: Host address.
  * `path`: Path.
