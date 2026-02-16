Where:
* `--panic-threshold`: Panic mode threshold.
* `--grpc-healthcheck`: Resource health check settings:
  * `port`: Port.
  * `healthy-threshold`: Healthy threshold.
  * `unhealthy-threshold`: Unhealthy threshold.
  * `timeout`: Maximum connection time.
  * `interval`: Interval.
  * `service-name`: Name of the gRPC service you want to check. If no service is specified, the system will check the backend overall health.