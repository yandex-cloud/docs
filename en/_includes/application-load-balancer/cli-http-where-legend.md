Where:
* `--name`: The name of the existing backend you want to update or the name of the new backend you want to add.
* `--panic-threshold`: Panic mode threshold.
* `--http-healthcheck`: Resource health check parameters:
  * `port`: Port.
  * `healthy-threshold`: Healthy threshold.
  * `unhealthy-threshold`: Unhealthy threshold.
  * `expected-statuses`: HTTP status code that will be considered correct when running the backend health check. To add multiple values, specify them separated by commas: `expected-statuses=201,expected-statuses=205,expected-statuses=302`. Code values can range from `100` to `599`. If the parameter is not set, the response code will be the same: `200`.
  * `timeout`: Maximum period for which a connection can be established.
  * `interval`: Interval.
  * `host`: Host address.
  * `path`: Path.
