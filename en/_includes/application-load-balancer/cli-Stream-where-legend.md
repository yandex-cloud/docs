Where:
* `--panic-threshold`: Panic mode threshold.
* `--enable-proxy-protocol`: With this option enabled, the load balancer will send its client connection metadata, e.g. its IP address, to the backend via [HAProxy](https://www.haproxy.org/download/1.9/doc/proxy-protocol.txt) protocol. If you do not set specific values for this option, the load balancer will only send its IP address to the backend.
* `--keep-connections-on-host-health-failure`: Keeps the connection alive even if the health check fails.
* `--stream-healthcheck`: Health check settings:
  * `port`: Port.
  * `healthy-threshold`: Healthy threshold.
  * `unhealthy-threshold`: Unhealthy threshold.
  * `timeout`: Maximum connection time.
  * `interval`: Interval.
  * `send-text`: Data sent to the endpoint for a health check.
  * `receive-text`: Data the endpoint must return to pass the health check.