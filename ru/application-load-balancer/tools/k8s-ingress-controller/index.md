# Ingress-контроллер для {{ managed-k8s-name }}

{{ alb-name }} предоставляет инструмент для создания и управления балансировщиками нагрузки в [кластерах {{ managed-k8s-full-name }}](../../../managed-kubernetes/concepts/index.md#kubernetes-cluster) — Ingress-контроллер {{ alb-name }}.

После установки контроллера вы сможете создать с его помощью ресурс [Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/), отвечающий за прием входящего трафика. По конфигурации `Ingress` будет автоматически развернут [L7-балансировщик](../../concepts/application-load-balancer.md) со всеми необходимыми ресурсами {{ alb-name }}.

## Пример конфигурации {#example}

Ниже приведен сокращенный пример конфигурации ресурса `Ingress`. По ней будет создан балансировщик, принимающий HTTPS-трафик и распределяющий его по двум сервисам в зависимости от пути в URI запроса.

{% cut "Пример" %}

```yaml
---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: alb-demo-tls
spec:
  tls:
    - hosts:
        - <доменное имя>
      secretName: yc-certmgr-cert-id-<идентификатор сертификата из {{ certificate-manager-full-name }}>
  rules:
    - host: <доменное имя>
      http:
        paths:
          - path: /app1
            pathType: Prefix
            backend:
              service:
                name: alb-demo-1
                port:
                  number: 80
          - path: /app2
            pathType: Prefix
            backend:
              service:
                name: alb-demo-2
                port:
                  number: 80
          - pathType: Prefix
            path: "/"
            backend:
              service:
                name: alb-demo-2
                port:
                  name: http
```

{% endcut %}

## Настройки логирования {#log-options}

Чтобы задать настройки логирования для L7-балансировщика, созданного с помощью Ingress-контроллера {{ alb-name }} в кластере {{ managed-k8s-name }}, добавьте аннотацию `ingress.alb.yc.io/group-settings-name` с именем для настроек Ingress-группы и укажите настройки в дополнительном ресурсе `IngressGroupSettings`. Подробнее см. в разделе [Аннотации ресурса Ingress](../../k8s-ref/ingress.md#annotations).

## Установка и требования {#install}

Для установки Ingress-контроллера {{ alb-name }} требуются:

* Кластер {{ managed-k8s-name }}.
* Группа узлов в кластере.
* Пространство имен в кластере для хранения ключа [сервисного аккаунта](service-account.md).

Установить Ingress-контроллер можно по [инструкции](../../operations/k8s-ingress-controller-install.md).

#### См. также {#see-also}

* [Принципы работы контроллера](principles.md).
* [Настройка групп безопасности](security-groups.md) для кластера {{ k8s }} и балансировщика.
* [Сервисный аккаунт](service-account.md) для работы контроллера.
