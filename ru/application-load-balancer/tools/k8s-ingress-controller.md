# Ingress-контроллер для {{ managed-k8s-name }}

{{ alb-name }} предоставляет инструмент для создания и управления балансировщиками нагрузки в [кластерах {{ managed-k8s-full-name }}](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) — Ingress-контроллер {{ alb-name }}.

После установки контроллера вы сможете создать с его помощью объект [Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/), отвечающий за прием входящего трафика. По конфигурации Ingress будет автоматически развернут [L7-балансировщик](../concepts/application-load-balancer.md) с нужными [целевыми группами](../concepts/target-group.md), [группами бэкендов](../concepts/backend-group.md), [HTTP-роутерами](../concepts/http-router.md) и [обработчиками](../concepts/application-load-balancer.md#listener).

> Например, конфигурация может выглядеть так: 
> 
> ```yaml
> ---
> apiVersion: networking.k8s.io/v1
> kind: Ingress
> metadata:
>   name: alb-demo-tls
> spec:
>   tls:
>     - hosts:
>         - <доменное имя>
>       secretName: yc-certmgr-cert-id-<идентификатор сертификата из {{ certificate-manager-name }}>
>   rules:
>     - host: <доменное имя>
>       http:
>         paths:
>           - path: /app1
>             pathType: Prefix
>             backend:
>               service:
>                 name: alb-demo-1
>                 port:
>                   number: 80
>           - path: /app2
>             pathType: Prefix
>             backend:
>               service:
>                 name: alb-demo-2
>                 port:
>                   number: 80
>           - pathType: Prefix
>             path: "/"
>             backend:
>               service:
>                 name: alb-demo-2
>                 port:
>                   number: 80
> ```
> 
> По этой конфигурации контроллер создаст балансировщик с тремя обработчиками, которые принимают трафик на 80-м порту. Так как в конфигурации указано доменное имя и [сертификат из {{ certificate-manager-name }}](../../certificate-manager/concepts/index.md#types), с помощью HTTP-роутеров трафик перенаправляется на 443-й порт. Обработчик выбирается в зависимости от пути в URI запроса и передает трафик назначенному для него [сервису](../../managed-kubernetes/concepts/index.md#service) — `alb-demo-1` или `alb-demo-2`. Для каждого сервиса по его конфигурации создается своя группа бэкендов.

Подробнее об установке и использовании контроллера см. сценарий [{#T}](../../managed-kubernetes/solutions/alb-ingress-controller.md) в документации {{ managed-k8s-name }}.
