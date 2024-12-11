# Fields and annotations of the Service resource for the Ingress controller


The `Service` resource represents the [{{ k8s }} service](../../../managed-kubernetes/concepts/index.md#service). For the [Ingress controller](../../../application-load-balancer/tools/k8s-ingress-controller/index.md), {{ alb-name }} services are backends between which the incoming traffic is distributed within a {{ managed-k8s-name }} cluster. Services representing {{ alb-name }} backends may be specified in the [Ingress](../../../managed-kubernetes/alb-ref/ingress.md) resource either directly or as part of [HttpBackendGroup](../../../managed-kubernetes/alb-ref/http-backend-group.md) backend groups.

`Service` is a standard {{ k8s }} resource. Below, you can find the descriptions of the resource fields and annotations the {{ alb-name }} tools for {{ managed-k8s-name }} interface with. For a full description of the resource configuration, see the [{{ k8s }} documentation](https://kubernetes.io/docs/reference/kubernetes-api/service-resources/service-v1/).

## Service {#service}

{% include notitle [service-core](../../../_includes/managed-kubernetes/alb-ref/service-core-for-ingress.md) %}

## ObjectMeta {#metadata}

{% include notitle [service-object-meta](../../../_includes/managed-kubernetes/alb-ref/service-object-meta.md) %}

### Annotations (metadata.annotations) {#annotations}

{% include notitle [service-annotations](../../../_includes/managed-kubernetes/alb-ref/service-annotations.md) %}

## ServiceSpec {#servicespec}

{% include notitle [service-spec](../../../_includes/managed-kubernetes/alb-ref/service-spec.md) %}

## ServicePort {#ports}

{% include notitle [service-port](../../../_includes/managed-kubernetes/alb-ref/service-port.md) %}
