* `listener`: Listener parameters:
   * `name`: Name of the listener.
   * `port`: Port where the load balancer will accept incoming traffic. The acceptable values are from `1` to `32767`.
   * `target-port`: Port to which the load balancer will redirect traffic. The acceptable values are from `1` to `32767`.
   * `protocol`: Protocol the listener will use (`TCP` or `UDP`).
   * `external-address`: External IP address of the listener.
   * `external-ip-version`: Version of the external IP address (`ipv4` or `ipv6`).
