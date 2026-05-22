# Service

Each pod in the {{ k8s }} cluster is assigned an internal IP address. Since pods are created and deleted and their IP addresses change, it makes no sense to use IP addresses for pods directly. Use _services_ to get permanent access to pods and stop using their internal IP addresses.

A _service_ is a [{{ k8s }} API object](https://kubernetes.io/docs/reference/kubernetes-api/service-resources/service-v1) that provides access to an application running as a set of pods in a {{ k8s }} cluster.

If you use a service, you get a permanent IP address that exists throughout the service lifecycle, even if pods change their IP addresses. It also provides load balancing. Clients send requests to a single IP address, and their requests are balanced between the pods belonging to the service.

The set of pods belonging to the service is defined by a selector. The selector is configured by the user when creating the pod and allows filtering the list of resources based on labels, i.e., key-value pairs attached to the resource. The pod belongs to the service if it has all the {{ k8s }} labels specified in the selector.

Depending on your task, you can use [different types](#type) of services.

## Service types {#type}

You can use various types of services in your {{ k8s }} clusters, including:
* `ClusterIP`
  * You can access the service only within the {{ k8s }} cluster network using an internal IP address.
  * It requires no additional cloud resources.
* `NodePort`: `ClusterIP` type extension.
  * It provides access to the service via internal or public {{ k8s }} cluster node IP addresses.
  * It requires no additional cloud resources.
* `LoadBalancer`: `NodePort` type extension.
  * It provides access to the service via a cloud network load balancer you create.
  * It requires additional cloud resources: a network load balancer.

To [publish your application](../operations/create-load-balancer.md), use a `LoadBalancer` service based on a [network load balancer](../../network-load-balancer/concepts/index.md) with a public or internal IP address.

If [DDoS protection](../../vpc/ddos-protection/index.md) is required, [reserve](../../vpc/operations/enable-ddos-protection.md) a public IP address with protection enabled and [specify](../operations/create-load-balancer.md#advanced) it using the `loadBalancerIP` option.

Learn more about service types in [this {{ k8s }} guide](https://kubernetes.io/docs/concepts/services-networking/service/#publishing-services-service-types).

#### See also {#see-also}

* [{#T}](../operations/create-load-balancer.md)
