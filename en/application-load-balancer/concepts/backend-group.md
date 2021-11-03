# Backend groups

A backend group defines the settings based on which the L7 load balancer sends traffic to the backend endpoints:

* The protocol for connecting to the application instances.
* Settings for the endpoint health checks.
* Rules for traffic distribution between endpoints.

The backend group includes a list of backends. Each backend, depending on its [type](#types), points to resources that act as application endpoints: VMs in target groups or a bucket with files. You can assign a relative weight to each backend. Traffic between backends is distributed proportionally to these weights. Protocols, health checks, and traffic distribution are configured separately for each backend. By using a group of multiple backends, you can split traffic between different application versions when running updates or experiments.

## Backend types {#types}

Backends in a group can be of two types:

* One or more [_target groups_](target-group.md): Sets of IP addresses of {{ compute-name }} VM instances that your network applications are running on. Traffic between all VMs in target groups belonging to the same backend is distributed evenly based on the [backend settings](#settings) and results of [health checks](#health-checks).

* _{{ objstorage-name }} bucket_: A set of files (objects) and settings related to their storage. For more information, see the [{#T}](../../storage/concepts/bucket.md) section in the {{ objstorage-name }} documentation.

  {% include [bucket-availability-note](../_includes_service/bucket-availability-note.md) %}

## Session affinity {#session-affinity}

If you want requests from one user session to be processed by the same application endpoint, enable session affinity for a backend group.

{% note info %}

Session affinity currently only works if one backend is active (has a positive weight) in a backend group, it consists of one or more target groups, and [balancing mode](#balancing-mode) by hash table (`MAGLEV_HASH`) is selected for it.

{% endnote %}

Session affinity mode determines how incoming requests are grouped into one session:

* **By IP address**: Requests received from a single IP address are combined into a session.

* **By HTTP header**: Requests with the same value of the specified HTTP header, such as with user authentication data, are combined into a session.

* **By cookie**: Requests with the same cookie value and the specified file name are combined into a session. For each session, the load balancer generates a cookie with a unique value and sends it in the response to the first request.

  You can specify the lifetime of all generated cookies. If not specified, session cookies are used, which are stored in the client's memory, such as in the browser, and are reset when it's restarted.

## Protocol and load balancing settings {#settings}

For backends consisting of target groups, you can configure:

* A protocol for communicating with the load balancer.
* Traffic balancing between endpoints.

### Protocol {#protocol}

The load balancer and target group VMs can exchange data over HTTP/1.1 or HTTP/2. You can send requests both as plain text or via TLS (in HTTPS backends). When using TLS, the load balancer doesn't validate certificates returned by backends. However, you can specify certificates from Certificate Authorities that the load balancer will trust when establishing a secure connection with backend endpoints.

### Balancing mode {#balancing-mode}

In the backend settings, you can specify the mode for distributing traffic between backend endpoints (target group VMs).

The following modes are available by default:

* **In a circle** (`ROUND_ROBIN`): All endpoints will receive requests in turn. After all the endpoints receive one request each, it's the turn of the first endpoint again, and so on.
* **Random** (`RANDOM`): A random endpoint is selected to process a request. If no health checks are configured for the backend, random distribution helps avoid increased workloads on the endpoint, which, under round-robin distribution, would be in the queue after a non-working endpoint.
* **By workload** (`LEAST_REQUEST`): Requests are distributed according to the power of two random choices algorithm. Two backend endpoints are randomly selected and the request is received by the one with fewer connections. The algorithm reduces the load on the most loaded backend endpoint. For more information about the performance and efficiency of the algorithm, see [The Power of Two Random Choices: A Survey of Techniques and Results](https://www.eecs.harvard.edu/~michaelm/postscripts/handbook2001.pdf) (Mitzenmacher et al.).

If [session affinity](#session-affinity) is enabled for a backend group, there should be one active backend (with a positive weight) in the group with the following balancing mode:

* **By hash table** (`MAGLEV_HASH`): Requests are distributed according to the Maglev hashing algorithm.
  1. For each endpoint, the hash function value is calculated in the range from `0` to `65536`.
  1. Based on the resulting values, a hash table of 65537 rows is fully populated so that each endpoint corresponds to the same number of rows.
  1. For each incoming request, the load balancer calculates the value of the same hash function and finds a row with the corresponding number in the hash table. This row indicates the endpoint that will process the request. Depending on session affinity mode, the function is calculated using the client's IP address, HTTP header, or cookie value.

  For more information about the performance and efficiency of the Maglev hashing algorithm, see [Maglev: A Fast and Reliable Software Network Load Balancer](https://static.googleusercontent.com/media/research.google.com/en//pubs/archive/44824.pdf) (Eisenbud et al.; chapter 3.4).

If there are several active backends in the group or session affinity is disabled, the backends with the **By hash table** balancing mode selected will distribute traffic randomly, and the other backends will do that depending on the selected modes.

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

