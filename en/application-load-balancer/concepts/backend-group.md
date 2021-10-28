# Backend groups

A backend group defines the settings based on which the L7 load balancer sends traffic to the backend endpoints:

* The protocol for connecting to the application instances.
* Settings for the endpoint health checks.
* Rules for traffic distribution between endpoints.

The backend group includes a list of backends. Each backend, depending on its [type](#types), points to resources that act as application endpoints: VMs in target groups or a bucket with files. You can assign a relative weight to each backend. Traffic between backends is distributed proportionally to these weights. Protocols, health checks, and traffic distribution are configured separately for each backend. By using a group of multiple backends, you can split traffic between different application versions when running updates or experiments.

## Backend types {#types}

Backends in a group can be of two types:

* One or more [_target groups_](target-group.md): sets of IP addresses of {{ compute-name }} VM instances that your network applications are running on. Traffic between all VMs in target groups belonging to the same backend is distributed evenly based on the [backend settings](#settings) and results of [health checks](#health-checks).

* _{{ objstorage-name }} bucket_: a set of files (objects) and settings related to their storage. For more information, see the [{#T}](../../storage/concepts/bucket.md) section in the {{ objstorage-name }} documentation.

  {% include [bucket-availability-note](../_includes_service/bucket-availability-note.md) %}

## Protocol and load balancing settings {#settings}

For backends with target groups, you can configure a protocol for communication with the load balancer and balancing traffic between endpoints.

### Protocol {#protocol}

The load balancer and target group VMs can exchange data over HTTP/1.1 or HTTP/2. You can send requests both as plain text or via TLS (in HTTPS backends). When using TLS, the load balancer doesn't validate certificates returned by backends. However, you can specify certificates from Certificate Authorities that the load balancer will trust when establishing a secure connection with backend endpoints.

### Panic mode {#panic-mode}

Panic mode safeguards you against failure of all app instances in case the data load increases drastically.
In this mode, the load balancer will distribute requests across all endpoints, ignoring health check results. You can set the percentage of healthy endpoints that triggers panic mode.

If you don't use panic mode, failure of some backends will further increase the load on backends that are still running. If an application is running at its maximum capacity, all backends will fail, making your service completely unavailable. If you enable panic mode, traffic is again distributed across all your endpoints. Although some requests might fail, the service stays operable. This provides time to increase the application's computing resources [automatically](../../compute/concepts/instance-groups/scale.md#auto-scale) or manually.

### Locality aware routing {#locality}

By default, the load balancer evenly distributes traffic between all endpoints of the backend's target groups. If the application is running in multiple availability zones, you can configure the L7 load balancer to send requests to endpoints in the availability zone where the load balancer accepted the request. If no backends are running in this availability zone, the load balancer will send the request to another zone.

If strict locality is enabled, the load balancer will respond with an error (503 Service Unavailable) if no application backends are running in the availability zone that accepted the request.

## Health checks {#health-checks}

You can enable _health checks_ for backends consisting of target groups. The load balancer will send health check requests to the endpoints at certain intervals and wait for a response during a given timeout.

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

