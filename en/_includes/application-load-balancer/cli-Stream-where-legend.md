Where:
* `--panic-threshold`: Panic mode threshold.
* `--enable-proxy-protocol`: If this option is enabled, the load balancer will send metadata about its connection to the client, including its IP, to the backend over the [PROXY protocol from HAProxy](https://www.haproxy.org/download/1.9/doc/proxy-protocol.txt). If this option is not specified, only the load balancer's IP address will be provided to the backend.
* `--stream-healthcheck`: Resource health check parameters:
  * `port`: Port.
  * `healthy-threshold`: Healthy threshold.
  * `unhealthy-threshold`: Unhealthy threshold.
  * `timeout`: Timeout.
  * `interval`: Interval.
  * `send-text`: Data to send to the endpoint for a health check.
  * `receive-text`: Data to receive from the endpoint for it to pass the health check.