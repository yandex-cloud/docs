# Контроллер Gwin для Yandex Managed Service for Kubernetes

Yandex Application Load Balancer предоставляет инструмент для создания балансировщиков нагрузки и управления ими в [кластерах Yandex Managed Service for Kubernetes](../../../managed-kubernetes/concepts/index.md#kubernetes-cluster) — Gwin.

Контроллер Gwin, установленный в кластер, автоматически разворачивает [L7-балансировщики](../../concepts/application-load-balancer.md) на основе конфигурации созданных вами ресурсов Kubernetes.

Контроллер поддерживает спецификации [Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/) и [Gateway API](https://gateway-api.sigs.k8s.io/). Для настройки дополнительных возможностей Application Load Balancer, выходящих за рамки спецификации Kubernetes, реализован механизм [политик](../../../managed-kubernetes/alb-ref/gwin-policies.md), которые управляются с помощью [CustomResourceDefinitions](https://kubernetes.io/docs/tasks/extend-kubernetes/custom-resources/custom-resource-definitions/) или аннотаций. К дополнительным возможностям относятся, например, автомасштабирование, логирование и интеграция с [Yandex Smart Web Security](../../../smartwebsecurity/concepts/index.md).

Поддерживаемые ресурсы Kubernetes:

* [Ingress](../../../managed-kubernetes/gwin-ref/ingress.md) — стандартный [ресурс Kubernetes](https://kubernetes.io/docs/concepts/services-networking/ingress/), возможности которого расширены с помощью аннотаций.
* [IngressPolicy](../../../managed-kubernetes/gwin-ref/ingresspolicy.md) — обеспечивает дополнительные возможности для всех ресурсов Application Load Balancer.
* [IngressBackendGroup](../../../managed-kubernetes/gwin-ref/ingressbackendgroup.md) — позволяет настраивать группы бэкендов.
* [ServicePolicy](../../../managed-kubernetes/gwin-ref/servicepolicy.md) — позволяет настраивать целевые группы.
* [Service](../../../managed-kubernetes/gwin-ref/service.md) — содержит описание сервисов Kubernetes, используемых в качестве бэкендов.
* [Gateway](../../../managed-kubernetes/gwin-ref/gateway.md) — содержит правила приема входящего трафика и выбора маршрутов для этого трафика.
* [GatewayPolicy](../../../managed-kubernetes/gwin-ref/gatewaypolicy.md) — обеспечивает дополнительные возможности для балансировщиков, роутеров и обработчиков.
* [HTTPRoute](../../../managed-kubernetes/gwin-ref/httproute.md) — содержит правила для маршрутизации HTTP- и HTTPS-трафика по бэкендам.
* [GRPCRoute](../../../managed-kubernetes/gwin-ref/grpcroute.md) — содержит правила для маршрутизации gRPC-трафика по бэкендам.
* [TLSRoute](../../../managed-kubernetes/gwin-ref/tlsroute.md) — содержит правила для маршрутизации TLS-трафика по бэкендам.
* [RoutePolicy](../../../managed-kubernetes/gwin-ref/routepolicy.md) — обеспечивает дополнительные возможности для виртуальных хостов и маршрутов.
* [YCStorageBucket](../../../managed-kubernetes/gwin-ref/ycstoragebucket.md) — соответствует бакету Yandex Object Storage.
* [YCCertificate](../../../managed-kubernetes/gwin-ref/yccertificate.md) — соответствует сертификату Yandex Certificate Manager.

Схема работы контроллера Gwin:

![image](../../../_assets/managed-kubernetes/gwin.svg)

Установить контроллер Gwin можно [по инструкции](../../../managed-kubernetes/alb-ref/gwin-quickstart.md).

{% note tip %}

Вы можете использовать существующую инфраструктуру Application Load Balancer для ресурсов Kubernetes через Gwin с помощью механизма [Attachment](../../../managed-kubernetes/alb-ref/gwin-alb-attachment.md).

{% endnote %}

## Примеры конфигурации

Ниже приведены два примера конфигурации — с использованием ресурсов Gateway API и Ingress. В обоих случаях создается балансировщик Application Load Balancer, который:

  * автоматически получает динамический публичный IP-адрес;
  * принимает HTTP-трафик на порт `80`;
  * принимает HTTPS-трафик на порт `443`, используя сертификат Certificate Manager;
  * отправляет GET-запросы к тестовому сервису `example-service`.

{% list tabs group=instructions %}

  - Gateway API {#gw}

      ```yaml
      apiVersion: gateway.networking.k8s.io/v1
      kind: Gateway
      metadata:
        name: example-gateway
        namespace: example-ns
      spec:
        gatewayClassName: gwin-default
        listeners:
          - name: http
            protocol: HTTP
            port: 80
            hostname: "example.com"
            allowedRoutes:
              namespaces:
                from: Same
          - name: https
            protocol: HTTPS
            port: 443
            hostname: "example.com"
            allowedRoutes:
              namespaces:
                from: Same
            tls:
              certificateRefs:
                - group: gwin.yandex.cloud
                  kind: YCCertificate
                  name: example-certificate
        addresses:
          - type: gwin.yandex.cloud/autoIPv4
            value: auto
      ---
      apiVersion: gateway.networking.k8s.io/v1
      kind: HTTPRoute
      metadata:
        name: example-redirect-httproute
        namespace: example-ns
      spec:
        hostnames:
          - "example.com"
        parentRefs:
          - name: example-gateway
            sectionName: http
        rules:
          - filters:
              - type: RequestRedirect
                requestRedirect:
                  scheme: https
                  statusCode: 301
      ---
      apiVersion: gateway.networking.k8s.io/v1
      kind: HTTPRoute
      metadata:
        name: example-httproute
        namespace: example-ns
      spec:
        hostnames:
          - "example.com"
        parentRefs:
          - name: example-gateway
            sectionName: https
        rules:
          - matches:
              - path:
                  value: /api
                  type: PathPrefix
                method: GET
            backendRefs:
              - kind: Service
                name: example-service
                port: 80
      ---
      apiVersion: gwin.yandex.cloud/v1
      kind: YCCertificate
      metadata:
        name: example-certificate
        namespace: example-ns
      spec:
        certificateRef:
          certificateID: "<идентификатор_сертификата>"
      ```

  - Ingress {#ingress}

      ```yaml
      apiVersion: networking.k8s.io/v1
      kind: Ingress
      metadata:
        name: example-ingress
        namespace: example-ns
        annotations:
          gwin.yandex.cloud/groupName: example
          gwin.yandex.cloud/externalIPv4Address: auto
          gwin.yandex.cloud/rules.allowedMethods: "GET"
      spec:
        ingressClassName: gwin-default
        rules:
          - host: example.com
            http:
              paths:
                - pathType: Prefix
                  path: "/api"
                  backend:
                    service:
                      name: example-service
                      port:
                        number: 80
        tls:
          - hosts:
              - example.com
            secretName: "yc-certmgr-cert-id-<идентификатор_сертификата>"
      ```


{% endlist %}