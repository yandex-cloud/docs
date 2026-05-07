# Fields and annotations of the Service resource for the Gateway API

The `Service` resource represents a [{{ k8s }} service](../../../managed-kubernetes/concepts/index.md#service). For the [Gateway API]({{ gateway-local-link }}/index.md), services are backends across which incoming traffic is distributed within a {{ managed-k8s-name }} cluster. Services operating as {{ alb-name }} backends are specified in the [HTTPRoute]({{ configuration-local-link }}/http-route.md) resource.

{% include [Gwin-with-preset](../../application-load-balancer/ingress-to-gwin-tip-with-preset.md) %}

`Service` is a standard {{ k8s }} resource. Below, we describe its fields and annotations used by the {{ alb-name }} tools for {{ managed-k8s-name }}. For resource configuration details, see [this {{ k8s }} guide](https://kubernetes.io/docs/reference/kubernetes-api/service-resources/service-v1/).

## Service {#service}

{% include notitle [service-core](../../../_includes/managed-kubernetes/alb-ref/service-core-for-gateway.md) %}

## ServiceSpec {#servicespec}

{% include notitle [service-spec](../../../_includes/managed-kubernetes/alb-ref/service-spec.md) %}

## ServicePort {#ports}

{% include notitle [service-port](../../../_includes/managed-kubernetes/alb-ref/service-port.md) %}