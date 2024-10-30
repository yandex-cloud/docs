Where:
* `--panic-threshold`: Panic mode threshold.
* `--grpc-healthcheck`: Resource health check parameters:
  * `port`: Port.
  * `healthy-threshold`: Healthy threshold.
  * `unhealthy-threshold`: Unhealthy threshold.
  * `timeout`: Timeout.
  * `interval`: Interval.
  * `service-name`: Name of the gRPC service to check. If no service is specified, the backend general health is checked.