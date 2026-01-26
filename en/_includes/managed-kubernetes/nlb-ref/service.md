# Service resource fields and annotations

The `Service` resource defines a [{{ k8s }} service](../../../managed-kubernetes/concepts/index.md#service). In {{ network-load-balancer-name }} for {{ managed-k8s-name }}, services are load balancers for incoming traffic.

`Service` is a standard {{ k8s }} resource. This reference describes the resource fields and annotations supported by {{ network-load-balancer-name }} for {{ managed-k8s-name }}. For a complete reference for the resource, see [this {{ k8s }} guide](https://kubernetes.io/docs/reference/kubernetes-api/service-resources/service-v1/).

## Service {#service}

```yaml
apiVersion: v1
kind: Service
metadata: <ObjectMeta>
spec: <ServiceSpec>
```

#|
|| **Field**     | **Value / Type**   | **Description**                   ||
|| `apiVersion` | `v1` | **This is a required field**.
                                           Kubernetes API version.          ||
|| `kind`       | `Service`              | Resource type.                    ||
|| `metadata`   | `ObjectMeta`           | **This is a required field**.
                                          [Resource metadata](#metadata). ||
|| `spec`       | `ServiceSpec`          | **This is a required field**.
                                          [Resource specification](#servicespec).   ||
|#

{% cut "Example" %}

```yaml
apiVersion: v1
kind: Service
metadata:
  name: nlb-demo-1
spec:
  selector:
    app: app-demo-1
  type: LoadBalancer
  ports:
    - port: 80
      name: plaintext
      targetPort: 8080
```

{% endcut %}

## ObjectMeta {#metadata}

```yaml
name: <string>
annotations:
  yandex.cloud/load-balancer-type: <string>
  yandex.cloud/subnet-id: <string>
  yandex.cloud/load-balancer-healthcheck-healthy-threshold: <string>
  yandex.cloud/load-balancer-healthcheck-interval: <string>
  yandex.cloud/load-balancer-healthcheck-timeout: <string>
  yandex.cloud/load-balancer-healthcheck-unhealthy-threshold: <string>
```

#|
|| **Field**      | **Value / Type** | **Description** ||
|| `name`        | `string`             | **This is a required field**.
[Resource name](https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names).

It does not match the load balancer name in {{ network-load-balancer-name }}. ||
|| `annotations` | `map[string]string`  | [Resource annotations](#annotations). ||
|#

### Metadata.annotations {#annotations}

Annotations are collections of `key:value` pairs for assigning metadata to objects. Annotation values have the `string` data type. For more information on annotations, see [this Kubernetes guide](https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/).

You can add the following annotations to `ObjectMeta`:

* **yandex.cloud/load-balancer-type**

  [Load balancer type](../../../network-load-balancer/concepts/nlb-types.md) (by default, with an external IP address).

  For a load balancer with an internal IP address, the value is `internal`.
* **yandex.cloud/subnet-id**

  ID of the subnet the internal load balancer will get its IP address.
* **yandex.cloud/load-balancer-healthcheck-healthy-threshold**

  Number of consecutive successful [checks](../../../network-load-balancer/concepts/health-check.md) to consider a node healthy.

  It can range from `2` to `10`.
* **yandex.cloud/load-balancer-healthcheck-interval**

  [Health check](../../../network-load-balancer/concepts/health-check.md) interval in seconds.

  It can range from `2s` to `300s`.
* **yandex.cloud/load-balancer-healthcheck-timeout**

  [Health check](../../../network-load-balancer/concepts/health-check.md) timeout in seconds. If a node fails to respond within this time, it is considered unhealthy.

  It can range from `1s` to `60s`.
* **yandex.cloud/load-balancer-healthcheck-unhealthy-threshold**

  Number of consecutive failed [checks](../../../network-load-balancer/concepts/health-check.md) to consider a node unhealthy.

  It can range from `2` to `10`.

## ServiceSpec {#servicespec}

```yaml
type: LoadBalancer
ports:
  - <ServicePort>
  - ...
loadBalancerIP: <string>
externalTrafficPolicy: <string>
```

#|
|| **Field** | **Value / Type** | **Description** ||
|| `type`   | `LoadBalancer` | **This is a required field**.
Service type.

{% note warning %}

{{ k8s }} services used as network load balancers must be of the `LoadBalancer` type. For more information about this type, see [this {{ k8s }} guide](https://kubernetes.io/docs/concepts/services-networking/service/#loadbalancer).

{% endnote %}
||

|| `ports`    | `[]ServicePort`      | **This is a required field**.
[List of ports the service is available on](#ports).
||

|| `loadBalancerIP` | `string` | When using an [external load balancer](../../../network-load-balancer/concepts/nlb-types.md), you may specify a static [public IP address](../../../vpc/concepts/address.md#public-addresses) in this field. You need to [reserve such an address in advance](../../../vpc/operations/get-static-ip.md). When reserving a public IP address, you can enable [DDoS protection](../../../vpc/ddos-protection/index.md). If you do not specify a static public IP address, the network load balancer will get a dynamic public IP address.

When using an [internal load balancer](../../../network-load-balancer/concepts/nlb-types.md), you can specify an [internal IP address](../../../vpc/concepts/address.md#internal-addresses). Make sure the specified internal IP address is not assigned to some other resource in the same cloud network.

{% note warning %}

Once removed from the specification, the internal IP address may be automatically assigned to a different resource in the same cloud network. We recommend selecting the address closer to the upper bound of your subnet's IP address range.

{% endnote %}

||

|| `externalTrafficPolicy` | `string` | [Traffic management policy]({{ k8s-api-link }}#servicespec-v1-core):

* `Cluster`: Traffic can reach any of the {{ k8s }} cluster nodes. If the target pods are not on that node, [kube-proxy](https://kubernetes.io/docs/reference/command-line-tools-reference/kube-proxy) redirects traffic to another node. This is a default value.
* `Local`: Traffic goes directly to the nodes where the application containers are running. In this case, the following applies:

  * User request IP address remains unchanged.
  * Inter-VM traffic is reduced.
||
|#

### ServicePort {#ports}

```yaml
name: <string>
port: <int32>
targetPort: <int32>
nodePort: <int32>
```

#|
|| **Field** | **Value / Type** | **Description** ||
|| `name` | `string` | Service port name.
||
|| `port`    | `int32`      | **This is a required field**.
Port to process incoming user requests to the service.

This port will also be assigned to the load balancer [listener](../../../network-load-balancer/concepts/listener.md) as the incoming traffic port.
||
|| `targetPort`    | `int32`      | Container port on which the application will be available.

If you skip this field, the `targetPort` value will match the `port` value.

||
|| `nodePort`      | `int32`      | Port to process incoming user requests to the service from outside the cluster.

This port will also be assigned to the load balancer listener as the target incoming traffic port for targets in the target group.

Typically, this field is skipped and its value is automatically selected from the specified range.

However, you can specify a port explicitly. This port must not be used by other {{ k8s }} objects.

Its range of values is `{{ port-range-k8s-nodeport }}`.
||
|#
