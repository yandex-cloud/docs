# Service

Each pod in the {{ k8s }} cluster is assigned an internal IP address. Since pods are created and deleted and their IP addresses change, it doesn't make sense to use IP addresses for pods directly. Use a _service_ to get permanent access to the pods and stop using internal IP addresses.

_A service_ is a [{{ k8s }} API object (Service)](https://kubernetes.io/docs/reference/kubernetes-api/service-resources/service-v1) designed to provide access to an app running as a set of pods in a {{ k8s }} cluster.

If you use a service, you get a permanent IP address that exists throughout the service lifecycle, even if pods change their IP addresses. It also provides load balancing. Clients send requests to a single IP address, and their requests are balanced between the pods belonging to the service.

The set of pods belonging to the service is defined by a selector. The selector is defined by the user when creating the pod and allows them to filter the list of resources based on labels (key-value pairs assigned to the resource). The pod belongs to the service if it has all the labels specified in the selector.

Depending on your task, you can use [different types](#type) of services.

## Service types {#type}

You can use various types of services in your {{ k8s }} clusters, including:
* `ClusterIP`
  * The service is accessible only within the {{ k8s }} cluster network via an internal IP address.
  * It doesn't require any additional cloud resources.
* `NodePort` is a `ClusterIP` extensions.
  * It provides access to the service via internal or public {{ k8s }} cluster node IP addresses.
  * It doesn't require any additional cloud resources.
* `LoadBalancer` is a `NodePort` extension.
  * It provides access to the service through the created cloud network load balancer.
  * It requires an additional cloud resource (network load balancer).

To [publish your app](../operations/create-load-balancer.md), use a `LoadBalancer` service based on a [network load balancer](../../network-load-balancer/concepts/index.md) with a public or internal IP address.

{% if product == "yandex-cloud" %}

If you need [DDoS protection](../../vpc/ddos-protection/index.md), [reserve](../../vpc/operations/enable-ddos-protection.md) a static IP address with protection enabled and [specify](../operations/create-load-balancer.md#advanced) it using the `loadBalancerIP` option.

{% endif %}

Learn more about service types in the [{{ k8s }} documentation](https://kubernetes.io/docs/concepts/services-networking/service/#publishing-services-service-types).

#### See also {#see-also}

* [{#T}](../operations/create-load-balancer.md).