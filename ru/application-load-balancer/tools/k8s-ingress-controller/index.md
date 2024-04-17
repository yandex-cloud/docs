# Ingress-контроллер для {{ managed-k8s-name }}


{{ alb-name }} предоставляет инструмент для создания и управления балансировщиками нагрузки в [кластерах {{ managed-k8s-full-name }}](../../../managed-kubernetes/concepts/index.md#kubernetes-cluster) — Ingress-контроллер {{ alb-name }}.

После установки контроллера вы сможете создать с его помощью ресурс [Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/), отвечающий за прием входящего трафика. По конфигурации `Ingress` будет автоматически развернут [L7-балансировщик](../../concepts/application-load-balancer.md) со всеми необходимыми ресурсами {{ alb-name }}.

Полную конфигурацию ресурсов для Ingress-контроллера {{ alb-name }} см. в следующих разделах:

* [Ingress](../../k8s-ref/ingress.md) — правила распределения трафика между бэкендами и настройки Ingress-контроллера.
* [HttpBackendGroup](../../k8s-ref/http-backend-group.md) — объединение бэкендов в группы.
* [IngressClass](../../k8s-ref/ingress-class.md) — управление несколькими Ingress-контроллерами в кластере {{ k8s }}.
* [Service](../../k8s-ref/service-for-ingress.md) — описание сервисов {{ k8s }}, используемых в качестве бэкендов.

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
        - <доменное_имя>
      secretName: yc-certmgr-cert-id-<идентификатор_сертификата>
  rules:
    - host: <доменное_имя>
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

Где `secretName` — идентификатор сертификата из {{ certificate-manager-full-name }}.

{% endcut %}

При такой конфигурации ресурса `Ingress` в [ALB Ingress Controller](/marketplace/products/yc/alb-ingress-controller) версии 0.2.0 и позднее [группы бэкендов](principles.md) соответствуют параметру `backend.service`. В версиях 0.1.x используются другие параметры: `host`, `http.paths.path` и `http.paths.pathType`. В результате при обновлении ALB Ingress Controller могут возникнуть коллизии. Чтобы избежать их, [узнайте, применимы ли ограничения при обновлении](../../operations/k8s-ingress-controller-upgrade.md) к вашей инфраструктуре.

## Настройки логирования {#log-options}

Чтобы задать настройки логирования для L7-балансировщика, созданного с помощью Ingress-контроллера {{ alb-name }} в кластере {{ managed-k8s-name }}, добавьте аннотацию `ingress.alb.yc.io/group-settings-name` с именем для настроек Ingress-группы и укажите настройки в дополнительном ресурсе `IngressGroupSettings`. Подробнее см. в разделе [Аннотации ресурса Ingress](../../k8s-ref/ingress.md#annotations).

## Установка и требования {#install}

Для установки Ingress-контроллера {{ alb-name }} требуются:

* Кластер {{ managed-k8s-name }}.
* Группа узлов в кластере.
* Пространство имен в кластере для хранения ключа [сервисного аккаунта](service-account.md).

Установить Ingress-контроллер можно по [инструкции](../../operations/k8s-ingress-controller-install.md).

## Маршрутизация трафика с помощью нескольких Ingress-контроллеров {#ingress-class}

Для одного приложения можно использовать несколько Ingress-контроллеров, например {{ alb-name }} и NGINX. Чтобы корректно маршрутизировать трафик в такой инфраструктуре, создайте ресурс [IngressClass](../../../application-load-balancer/k8s-ref/ingress-class.md) для каждого Ingress-контроллера. В ресурсе `Ingress`, в поле `spec.ingressClassName` укажите, к какому `IngressClass` относится ресурс `Ingress`. На GitHub есть [пример](https://github.com/yandex-cloud-examples/yc-mk8s-with-ingress-class), как настроить ресурсы `Ingress` и маршрутизировать трафик с помощью нескольких Ingress-контроллеров.

#### См. также {#see-also}

* [Принципы работы контроллера](principles.md).
* [Настройка групп безопасности](security-groups.md) для кластера {{ k8s }} и балансировщика.
* [Сервисный аккаунт](service-account.md) для работы контроллера.
* [ALB Ingress Controller в {{ marketplace-full-name }}]({{ link-cloud-marketplace }}/products/yc/alb-ingress-controller).
