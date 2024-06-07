# Поля и аннотации ресурса Service для Ingress-контроллера


Ресурс `Service` соответствует [сервису {{ k8s }}](../../../managed-kubernetes/concepts/index.md#service). Для [Ingress-контроллера](../../../application-load-balancer/tools/k8s-ingress-controller/index.md) {{ alb-name }} сервисы представляют собой бэкенды, между которыми распределяется входящий трафик в кластере {{ managed-k8s-name }}. Сервисы, выступающие в роли бэкендов {{ alb-name }}, могут быть указаны в ресурсе [Ingress](ingress.md) напрямую или в составе групп бэкендов [HttpBackendGroup](http-backend-group.md).

`Service` — стандартный ресурс {{ k8s }}. Ниже описаны поля и аннотации ресурса, с которыми работают инструменты {{ alb-name }} для {{ managed-k8s-name }}. Полное описание конфигурации ресурса см. в [документации {{ k8s }}](https://kubernetes.io/docs/reference/kubernetes-api/service-resources/service-v1/).

## Service {#service}

{% include notitle [service-core](../../../_includes/managed-kubernetes/alb-ref/service-core-for-ingress.md) %}

## ObjectMeta {#metadata}

{% include notitle [service-object-meta](../../../_includes/managed-kubernetes/alb-ref/service-object-meta.md) %}

### Аннотации (metadata.annotations) {#annotations}

{% include notitle [service-annotations](../../../_includes/managed-kubernetes/alb-ref/service-annotations.md) %}

## ServiceSpec {#servicespec}

{% include notitle [service-spec](../../../_includes/managed-kubernetes/alb-ref/service-spec.md) %}

## ServicePort {#ports}

{% include notitle [service-port](../../../_includes/managed-kubernetes/alb-ref/service-port.md) %}
