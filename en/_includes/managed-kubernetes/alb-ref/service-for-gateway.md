# Fields and annotations of the Service resource for the Gateway API


The `Service` resource corresponds to the [{{ k8s }} service](../../../managed-kubernetes/concepts/index.md#service). For the [Gateway API](../../../application-load-balancer/tools/k8s-gateway-api/index.md), services are backends between which the incoming traffic is distributed within a {{ managed-k8s-name }} cluster. Services representing {{ alb-name }} backends are specified in the [HTTPRoute](../../../managed-kubernetes/alb-ref/http-route.md) resource.

`Service` is a standard {{ k8s }} resource. Below, you can find the descriptions of the resource fields and annotations the {{ alb-name }} tools for {{ managed-k8s-name }} interface with. For a full description of the resource configuration, see the [{{ k8s }} documentation](https://kubernetes.io/docs/reference/kubernetes-api/service-resources/service-v1/).

## Service {#service}

{% include notitle [service-core](../../../_includes/managed-kubernetes/alb-ref/service-core-for-gateway.md) %}

## ServiceSpec {#servicespec}

{% include notitle [service-spec](../../../_includes/managed-kubernetes/alb-ref/service-spec.md) %}

## ServicePort {#ports}

{% include notitle [service-port](../../../_includes/managed-kubernetes/alb-ref/service-port.md) %}