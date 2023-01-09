# Backend groups

A backend group defines the settings based on which the L7 load balancer sends traffic to the backend endpoints:

* The protocol for connecting to the application instances.
* Settings for the endpoint health checks.
* Rules for traffic distribution between endpoints.

The backend group includes a list of backends. Each backend, depending on its [type](#types), points to resources that act as application endpoints: VMs in target groups or a bucket with files. You can assign a relative weight to each backend. Traffic between backends is distributed proportionally to these weights. Protocols, health checks, and traffic distribution are configured separately for each backend. By using a group of multiple backends, you can split traffic between different application versions when running updates or experiments.

## Backend group types {#group-types}

The type of a backend group determines what traffic the load balancer will send to it:

* **HTTP**: HTTP or HTTPS traffic.
* **gRPC**: HTTP or HTTPS traffic with a [gRPC](https://{{ lang }}.wikipedia.org/wiki/GRPC) call.
* **Stream**: Unencrypted TCP traffic or TCP traffic with TLS encryption support.

Groups of the **HTTP** and **gRPC** types connect to [listeners](application-load-balancer.md#listener) of the **HTTP** type via [HTTP routers](http-router.md). Groups of the **Stream** type connect to **Stream** listeners directly.

{% note alert %}

You can only select a backend group's type when creating it. You can't change the type of an existing group.

{% endnote %}

## Backend types {#types}

Backends in a group of the **HTTP** type can be of two types:

* One or more [_target groups_](target-group.md): Sets of IP addresses of {{ compute-name }} VM instances that your network applications are running on. Traffic between all VMs in target groups belonging to the same backend is distributed evenly based on the [backend settings](#settings) and results of [health checks](#health-checks).
* {{ objstorage-name }} _bucket_: A set of files (objects) and settings related to their storage. For more information, see [{#T}](../../storage/concepts/bucket.md) in the {{ objstorage-name }} documentation.

   {% include [bucket-availability-note](../_includes_service/bucket-availability-note.md) %}

In groups of the **gRPC** and **Stream** types, only target groups and their sets can act as backends.

## Session affinity {#session-affinity}

If you want requests from one user session to be processed by the same application endpoint, enable session affinity for a backend group.

{% include [session-affinity-prereqs](../../_includes/application-load-balancer/session-affinity-prereqs.md) %}

Session affinity mode determines how incoming requests are grouped into one session: **HTTP** and **gRPC** backend groups support the following modes:

* **By IP address**: Requests received from a single IP address are combined into a session.
* **By HTTP header**: Requests with the same value of the specified HTTP header, such as with user authentication data, are combined into a session.
* **By cookie**: Requests with the same cookie value and the specified file name are combined into a session.

   * If session affinity settings include cookie lifetime, the load balancer generates a cookie with a unique value and sends it in its response to a user's first request. To use session cookies that are stored on a client, such as a browser, and reset when it restarts, specify a lifetime of `0`.
   * If a lifetime is not specified, the load balancer does not generate cookies. Instead, it only uses cookie values from incoming requests to bind sessions.

**Stream** backend groups only support session affinity by client IP address.

## Protocol and load balancing settings {#settings}

For backends consisting of target groups, you can configure:

* A protocol for communicating with the load balancer.
* Traffic balancing between endpoints.

### Protocol {#protocol}

The load balancer can establish unencrypted backend connections and backend connections with TLS encryption. When using TLS, the load balancer doesn't validate certificates returned by backends. However, you can specify certificates from Certificate Authorities that the load balancer will trust when establishing a secure connection with backend endpoints.

If the type of a backend group is **HTTP**, you can use HTTP 1.1 or HTTP 2 for exchanging data between the load balancer and backend endpoints. Backend groups of the **gRPC** type only support HTTP/2 connections.

### Balancing mode {#balancing-mode}

In the backend settings, you can specify the mode for distributing traffic between backend endpoints (target group VMs):

* `ROUND_ROBIN`: All endpoints will receive requests in turn. After all the endpoints receive one request each, it's the turn of the first endpoint again, and so on.
* `RANDOM`: A random endpoint is selected to process a request. If no health checks are configured for the backend, random distribution helps avoid increased workloads on the endpoint, which, under round-robin distribution, would be in the queue after a non-working endpoint.
* `LEAST_REQUEST`: Requests are distributed based on endpoint load using the power of two random choices algorithm. Two backend endpoints are randomly selected and the request is received by the one with fewer connections. The algorithm reduces the load on the most loaded backend endpoint. For more information about the performance and efficiency of the algorithm, see [The Power of Two Random Choices: A Survey of Techniques and Results](https://www.eecs.harvard.edu/~michaelm/postscripts/handbook2001.pdf) (Mitzenmacher et al.).
* `MAGLEV_HASH`: Requests are distributed using the Maglev hashing algorithm.

   1. For each endpoint, the hash function value is calculated in the range from `0` to `65536`.
   1. Based on the resulting values, a hash table of 65537 rows is fully populated so that each endpoint corresponds to the same number of rows.
   1. For each incoming request, the load balancer calculates the value of the same hash function and finds a row with the corresponding number in the hash table. This row indicates the endpoint that will process the request. If [session affinity](#session-affinity) is enabled for a group of backends, a hash function is evaluated based on the client's IP address, the HTTP header value, or the cookie file depending on the affinity mode.

   For more information about the performance and efficiency of the Maglev hashing algorithm, see [Maglev: A Fast and Reliable Software Network Load Balancer](https://static.googleusercontent.com/media/research.google.com/en//pubs/archive/44824.pdf) (Eisenbud et al.; chapter 3.4).

   {% note info %}

   If a group with session affinity enabled consists of several active backends, the backends with the `MAGLEV_HASH` mode selected will distribute traffic randomly whereas the remaining backends will operate in their selected modes.

   {% endnote %}

### Panic mode {#panic-mode}

Panic mode safeguards you against failure of all app instances in case the data load increases drastically.

In this mode, the load balancer will distribute requests across all endpoints, ignoring health check results. You can set the percentage of healthy endpoints that triggers panic mode.

If you don't use panic mode, failure of some backends will further increase the load on backends that are still running. If an application is running at its maximum capacity, all backends will fail, making your service completely unavailable. If you enable panic mode, traffic is again distributed across all your endpoints. Although some requests might fail, the service stays operable. This provides time to increase the application's computing resources [automatically](../../compute/concepts/instance-groups/scale.md#auto-scale) or manually.

### Locality aware routing {#locality}

By default, the load balancer evenly distributes traffic between all endpoints of the backend's target groups. If the application is running in multiple availability zones, you can configure the L7 load balancer to send requests to endpoints in the availability zone where the load balancer accepted the request. If no backends are running in this availability zone, the load balancer will send the request to another zone.

If strict locality is enabled, the load balancer will respond with an error (503 Service Unavailable) if no application backends are running in the availability zone that accepted the request.

## Health checks {#health-checks}

You can enable _health checks_ for backends consisting of target groups. The load balancer will send health check requests to the endpoints at certain intervals and wait for a response during a given timeout.

Health checks of the **HTTP**, **gRPC**, and **Stream** types are supported. They match the backend group types. However, the type of a health check doesn't have to be the same as the group type.

The following health check settings are supported:

* Timeout: Response waiting time.
* Interval: Amount of time between health check requests.
* Resource health indicators: The threshold amount of successful or failed results. If a threshold is exceeded, it indicates that the check passed or failed, respectively.
* HTTP health check settings:

   * Domain name for the `Host` header (HTTP/1.1) or the `:authority` pseudo-header (HTTP/2).
   * Path in the URI of a request to the endpoint.
   * HTTP/2 flag.

* Settings of gRPC health checks:

   * Name of the service being checked.

* Settings of Stream health checks (TCP):

   * Request body.
   * Substring in the response that indicates that the health check was successful. If the request body or response body is not specified, a successful connection to the backend is checked.

Note that if the backend is configured to use TLS with the target group endpoints, health checks also use TLS. For example:

* If the type of a health check is HTTP, it will be made over HTTPS.
* For Stream health checks, a TLS connection will be established and the check results will be returned through this connection.


