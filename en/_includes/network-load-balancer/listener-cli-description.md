* `--listener`: Listener settings:
    * `name`: Listener name.
    * `port`: Port on which the load balancer will listen to incoming traffic. The possible values range from `1` to `32767`.
    * `target-port`: Port to which the load balancer will redirect traffic. The possible values range from `1` to `32767`.
    * `protocol`: Protocol the listener will use, `tcp` or `udp`.
    * `external-address`: External IP address of the listener.
    * `external-ip-version`: External IP address version, `ipv4` or `ipv6`.
