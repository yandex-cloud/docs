# Поля и аннотации ресурса Service для Gateway API


Ресурс `Service` соответствует [сервису {{ k8s }}](../../managed-kubernetes/concepts/index.md#service). Для [Gateway API](../tools/k8s-gateway-api/index.md) сервисы представляют собой бэкенды, между которыми распределяется входящий трафик в кластере {{ managed-k8s-name }}. Сервисы, выступающие в роли бэкендов {{ alb-name }}, указываются в ресурсе [HTTPRoute](http-route.md).

`Service` — стандартный ресурс {{ k8s }}. Ниже описаны поля и аннотации ресурса, с которыми работают инструменты {{ alb-name }} для {{ managed-k8s-name }}. Полное описание конфигурации ресурса см. в [документации {{ k8s }}](https://kubernetes.io/docs/reference/kubernetes-api/service-resources/service-v1/).

## Service {#service}

{% include notitle [service-core](../../_includes/managed-kubernetes/alb-ref/service-core-for-gateway.md) %}

## ServiceSpec {#servicespec}

{% include notitle [service-spec](../../_includes/managed-kubernetes/alb-ref/service-spec.md) %}

## ServicePort {#ports}

{% include notitle [service-port](../../_includes/managed-kubernetes/alb-ref/service-port.md) %}
