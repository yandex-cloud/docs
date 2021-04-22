# Backend group

A backend group defines the settings based on which the L7 load balancer sends traffic to the endpoints of the [target groups](target-group.md): the protocol for connecting to the application instances, settings for the endpoint health checks, and rules for traffic distribution between them.

The backend group includes a list of backends. Each backend specifies a set of target groups containing application endpoints. You can assign a relative weight to each backend. Traffic between backends is distributed proportionally to these weights. Within a backend, traffic between endpoints of target groups is distributed uniformly based on the results of [health checks](#health-checks) and [locality aware routing](#locality). Protocols, health checks, and traffic distribution are configured separately for each backend. By using multiple backends in the same group, you can more easily split traffic between different application versions when running updates or experiments.

## Protocol settings inside backend groups {#protocol-settings}

Backends running HTTP/1 and HTTP/2 are supported. You can send requests both as plain text or via TLS (in HTTPS backends). When using TLS, the load balancer doesn't validate certificates returned by backends. However, you can specify certificates from Certificate Authorities that the load balancer will trust when establishing a secure connection with backend endpoints.

### Panic mode {#panic-mode}

Panic mode safeguards you against failure of all app instances in case the data load increases drastically.
In this mode, the load balancer will distribute requests across all endpoints, ignoring health check results. You can set the percentage of healthy endpoints that triggers panic mode.

If you don't use panic mode, failure of some backends will further increase the load on backends that are still running. If an application is running at its maximum capacity, all backends will fail, making your service completely unavailable. If you enable panic mode, traffic is again distributed across all your endpoints. Although some requests might fail, the service stays operable. This provides time to increase the application's computing resources [automatically](../../compute/concepts/instance-groups/scale.md#auto-scale) or manually.

### Locality aware routing {#locality}

By default, the load balancer evenly distributes traffic between all endpoints of the backend's target groups. If the application is running in multiple availability zones, you can configure the L7 load balancer to send requests to endpoints in the availability zone where the load balancer accepted the request. If no backends are running in this availability zone, the load balancer will send the request to another zone.

If strict locality is enabled, the load balancer will respond with an error (503 Service Unavailable) if no application backends are running in the availability zone that accepted the request.

## Health checks {#health-checks}

The load balancer will send health check requests to the specified endpoints at certain intervals and wait for a response during a given timeout.

HTTP and TCP health checks are supported. The following health check settings are supported:

* Timeout: Response waiting time.
* Interval: Amount of time between health check requests.
* Resource health indicators: The threshold amount of successful or failed results. If a threshold is exceeded, it indicates that the check was passed or failed, respectively.
* HTTP health check settings:
* Host name for the `host` header.
* Path of the endpoint checked.
* HTTP/2 flag.
* TCP health check settings:
* Request body.
* Substring in the response that indicates that the health check was successful. If the request body or response body is not specified, a successful connection to the backend is checked.

Note that if the backend is configured to use TLS with the target group endpoints, health checks also use TLS. For example, HTTP health checks run via HTTPS. For TCP health checks, a TLS connection is established and health check results are returned over TLS.

