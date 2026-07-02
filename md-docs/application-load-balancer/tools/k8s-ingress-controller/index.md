[Документация Yandex Cloud](../../../index.md) > [Yandex Application Load Balancer](../../index.md) > [Инструменты для Managed Service for Kubernetes](../index.md) > Ingress-контроллер > Обзор

# Ingress-контроллер для Managed Service for Kubernetes

{% note tip %}

Вместо ALB Ingress-контроллера и Gateway API рекомендуется использовать новый контроллер [Yandex Cloud Gwin](../gwin/index.md).

{% endnote %}

Application Load Balancer предоставляет инструмент для создания и управления балансировщиками нагрузки в [кластерах Yandex Managed Service for Kubernetes](../../../managed-kubernetes/concepts/index.md#kubernetes-cluster) — Ingress-контроллер Application Load Balancer.

Ingress-контроллер, установленный в кластер, будет автоматически разворачивать [L7-балансировщики](../../concepts/application-load-balancer.md) со всеми необходимыми ресурсами Application Load Balancer, основываясь на конфигурации созданных вами ресурсов [Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/).

Полная конфигурация ресурсов для Ingress-контроллера Application Load Balancer описана в следующих разделах:

* [Ingress](../../k8s-ref/ingress.md) — правила распределения трафика между бэкендами и настройки Ingress-контроллера.
* [HttpBackendGroup](../../k8s-ref/http-backend-group.md) и [GrpcBackendGroup](../../k8s-ref/grpc-backend-group.md) — объединение бэкендов в группы.
* [IngressClass](../../k8s-ref/ingress-class.md) — управление несколькими Ingress-контроллерами в кластере Kubernetes.
* [Service](../../k8s-ref/service-for-ingress.md) — описание сервисов Kubernetes, используемых в качестве бэкендов.

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

Где `secretName` — идентификатор сертификата из Yandex Certificate Manager.

{% endcut %}

При такой конфигурации ресурса `Ingress` в [ALB Ingress Controller](https://yandex.cloud/ru/marketplace/products/yc/alb-ingress-controller) версии 0.2.0 и позднее [группы бэкендов](../../concepts/backend-group.md) соответствуют параметру `backend.service`. В версиях 0.1.x используются другие параметры: `host`, `http.paths.path` и `http.paths.pathType`. В результате при обновлении ALB Ingress Controller могут возникнуть коллизии. Чтобы избежать их, [узнайте, применимы ли ограничения при обновлении](../../operations/k8s-ingress-controller-upgrade.md) к вашей инфраструктуре.

## Установка и требования {#install}

Для установки Ingress-контроллера Application Load Balancer требуются:

* Кластер Managed Service for Kubernetes.
* Группа узлов в кластере.
* Пространство имен в кластере для хранения ключа [сервисного аккаунта](service-account.md).

Установить Ingress-контроллер можно по [инструкции](../../operations/k8s-ingress-controller-install.md).

## Настройки логирования {#log-options}

Чтобы задать настройки логирования для L7-балансировщика, созданного с помощью Ingress-контроллера Application Load Balancer в кластере Managed Service for Kubernetes, добавьте аннотацию `ingress.alb.yc.io/group-settings-name` с именем для настроек группы ресурсов Ingress и укажите настройки в дополнительном ресурсе `IngressGroupSettings`. Подробнее в разделе [Аннотации ресурса Ingress](../../k8s-ref/ingress.md#annotations).

## Интеграция с сервисом Yandex Smart Web Security {#smart-web-security}

В Ingress-контроллере вы можете включить поддержку сервиса [Yandex Smart Web Security](../../../smartwebsecurity/concepts/index.md), который позволяет защититься от [DDoS-атак](../../../glossary/ddos.md) и ботов, а также задействовать [WAF](../../../smartwebsecurity/concepts/waf.md) и [ограничить нагрузку](../../../smartwebsecurity/concepts/arl.md) на защищаемый ресурс.

Сервис проверяет HTTP-запросы, которые поступают к защищаемому ресурсу через [виртуальный хост](../../concepts/http-router.md#virtual-host) L7-балансировщика. В зависимости от результатов проверки сервис направляет запросы на защищаемый ресурс, блокирует их или отправляет в [Yandex SmartCaptcha](../../../smartcaptcha/index.md) для дополнительной верификации.

Чтобы включить поддержку сервиса, в аннотации Ingress укажите идентификатор [профиля безопасности](../../../smartwebsecurity/concepts/profiles.md) Smart Web Security:

```yaml
ingress.alb.yc.io/security-profile-id: <идентификатор_профиля_безопасности>
```

Профиль содержит список условий проверки и действий, которые применяются к приходящим HTTP-запросам по результатам проверки.

Если у вас нет профиля безопасности, [создайте его](../../../smartwebsecurity/operations/profile-create.md).

## Маршрутизация трафика с помощью нескольких Ingress-контроллеров {#ingress-class}

Для одного приложения можно использовать несколько Ingress-контроллеров, например Application Load Balancer и NGINX. Чтобы корректно маршрутизировать трафик в такой инфраструктуре, создайте ресурс [IngressClass](../../k8s-ref/ingress-class.md) для каждого Ingress-контроллера. В ресурсе `Ingress`, в поле `spec.ingressClassName` укажите, к какому `IngressClass` относится ресурс `Ingress`. На GitHub есть [пример](https://github.com/yandex-cloud-examples/yc-mk8s-with-ingress-class), как настроить ресурсы `Ingress` и маршрутизировать трафик с помощью нескольких Ingress-контроллеров.

#### Полезные ссылки {#see-also}

* [Принципы работы контроллера](principles.md)
* [Настройка групп безопасности](security-groups.md) для кластера Kubernetes и балансировщика
* [Сервисный аккаунт](service-account.md) для работы контроллера
* [ALB Ingress Controller в Yandex Cloud Marketplace](https://yandex.cloud/ru/marketplace/products/yc/alb-ingress-controller)