# Принципы работы Ingress-контроллера Application Load Balancer

{% note tip %}

Вместо ALB Ingress-контроллера и Gateway API рекомендуется использовать новый контроллер [Yandex Cloud Gwin](../gwin-index.md).

{% endnote %}

К [Ingress-контроллеру Application Load Balancer для Managed Service for Kubernetes](index.md) относятся два [пода](../../concepts/index.md#pod):

* Основной под `yc-alb-ingress-controller-*` отвечает за создание и изменение ресурсов Application Load Balancer. Отслеживать работу с ресурсами можно по логам этого пода.
* Под для [проверок состояния](../../../application-load-balancer/concepts/backend-group.md#health-checks) `yc-alb-ingress-controller-hc-*` с контейнером, который принимает проверочные запросы от L7-балансировщика на TCP-порт `10501` и проверяет работоспособность подов [kube-proxy](https://kubernetes.io/docs/reference/command-line-tools-reference/kube-proxy/) на каждом узле кластера. Если kube-proxy работоспособен, то даже если приложение в конкретном поде не отвечает, Kubernetes перенаправит трафик в другой под с этим приложением или на другой узел.

  Такая схема проверки состояния реализована в Ingress-контроллере Application Load Balancer по умолчанию. Чтобы контролировать работу приложений на всех подах, вы можете [настроить собственные проверки состояния](../../tutorials/custom-health-checks.md).

{% note warning %}

Не изменяйте напрямую ресурсы Application Load Balancer, созданные основным подом контроллера. Любые изменения будут автоматически отменены. Вместо этого пользуйтесь стандартными способами управления кластером Managed Service for Kubernetes.

{% endnote %}

Основной под управляет архитектурой ресурсов Application Load Balancer по следующим правилам:

* Балансировщики и HTTP-роутеры для приема трафика и его распределения между группами бэкендов создаются по ресурсам [Ingress](../ingress.md). 
  
  Если у нескольких `Ingress` одинаковые значения аннотации `ingress.alb.yc.io/group-name`, они объединяются в один балансировщик.

  * Чтобы балансировщик принимал HTTPS-трафик, в поле `spec.tls` описания `Ingress` должны быть указаны доменные имена и идентификаторы сертификатов из Certificate Manager:

    ```yaml
    spec:
      tls:
        - hosts:
            - <доменное_имя>
          secretName: yc-certmgr-cert-id-<идентификатор_сертификата>
    ```

    Где `secretName` — указание на сертификат из Yandex Certificate Manager.

    В этом случае для балансировщика будут созданы обработчики двух видов: одни будут принимать HTTPS-трафик на порте `443`, а другие — перенаправлять запросы с HTTP (порт `80`) на HTTPS с кодом состояния `301 Moved Permanently`. При этом правила распределения трафика для тех же доменных имен, явно указанные в других `Ingress`, без поля `spec.tls`, будут иметь приоритет над перенаправлением с HTTP на HTTPS.

    Если сертификат пока не добавлен в Certificate Manager, укажите секрет Kubernetes с сертификатом в поле `secretName`. Тогда Ingress-контроллер Application Load Balancer автоматически добавит сертификат в Certificate Manager.
    
  * Если в описании `Ingress` нет поля `spec.tls`, для балансировщика будут созданы только обработчики для приема HTTP-трафика на порте `80`.

  * Если в описании `Ingress` не заданы правила распределения входящего трафика по бэкендам, он будет перенаправляться на [бэкенд по умолчанию](../ingress.md#default-backend).

* Группы бэкендов, обрабатывающие полученный трафик, могут создаваться:

  * По сервисам Kubernetes, указанным в [правилах](../ingress.md#rule) `Ingress` напрямую. Этот способ полезен, если к маршруту нужно привязать простую группу бэкендов, состоящую из одного сервиса.

    В версиях [ALB Ingress Controller](https://yandex.cloud/ru/marketplace/products/yc/alb-ingress-controller) до 0.2.0 каждая группа бэкендов соответствует связке параметров `host`, `http.paths.path` и `http.paths.pathType` в правилах `Ingress`. В версиях 0.2.0 и позднее группа бэкендов соответствует параметру `backend.service`. Из-за этого при обновлении ALB Ingress Controller могут возникнуть коллизии. Чтобы избежать их, [узнайте, применимы ли ограничения при обновлении](../../operations/applications/upgrade-alb-ingress-controller.md) к вашей инфраструктуре.

  * По ресурсам [HttpBackendGroup](../http-backend-group.md), позволяющим явно описывать группы бэкендов. Это [custom resources](https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/custom-resources/) из группы API `alb.yc.io`, предоставляемой Ingress-контроллером.

    Указывать на `HttpBackendGroup`, как и на сервисы, нужно в правилах `Ingress` (`spec.rules[*].http.paths[*].backend.resource`). 

    При использовании `HttpBackendGroup` доступна расширенная функциональность Application Load Balancer. Бэкендами в такой группе могут быть сервисы Kubernetes и [бакеты Yandex Object Storage](../../../storage/concepts/bucket.md). Также в `HttpBackendGroup` можно указывать относительные веса бэкендов для пропорционального распределения трафика между ними.

  * По ресурсам [GrpcBackendGroup](../grpc-backend-group.md), позволяющим явно описывать группы бэкендов. Это [custom resources](https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/custom-resources/) из группы API `alb.yc.io`, предоставляемой Ingress-контроллером.

    Указывать на `GrpcBackendGroup`, как и на сервисы, нужно в правилах `Ingress` (`spec.rules[*].http.paths[*].backend.resource`).  

* На бэкендах развертываются сервисы, указанные в `Ingress` или `HttpBackendGroup`/`GrpcBackendGroup`. Они настраиваются с помощью ресурсов [Service](../service-for-ingress.md).

  {% note warning %}
  
  Сервисы Kubernetes, используемые в качестве бэкендов (указанные в правилах `Ingress` напрямую или в `HttpBackendGroup`/`GrpcBackendGroup`), должны иметь тип `NodePort`. Подробнее об этом типе см. в [документации Kubernetes](https://kubernetes.io/docs/concepts/services-networking/service/#type-nodeport).
  
  {% endnote %}

## Соответствие ресурсов Application Load Balancer и Kubernetes {#mapping}

| Application Load Balancer | Kubernetes |
| ----- | ----- |
| [Балансировщик](../../../application-load-balancer/concepts/application-load-balancer.md) | Набор ресурсов [Ingress](../ingress.md) с одинаковыми значениями аннотации `ingress.alb.yc.io/group-name` |
| [Виртуальные хосты](../../../application-load-balancer/concepts/http-router.md#virtual-host) HTTP-роутера | `Ingress.spec.rules` |
| [Маршруты](../../../application-load-balancer/concepts/http-router.md#routes) виртуального хоста | `Ingress.spec.rules[*].http.paths` |
| [Группа бэкендов](../../../application-load-balancer/concepts/backend-group.md) | [HttpBackendGroup](../http-backend-group.md)/[GrpcBackendGroup](../grpc-backend-group.md) или набор [сервисов](../service-for-ingress.md) |
| [Целевая группа](../../../application-load-balancer/concepts/target-group.md) | [Группа узлов](../../concepts/index.md#node-group) кластера |

## Идентификаторы ресурсов балансировщика в кластере Kubernetes {#alb-ids}

Идентификаторы ресурсов балансировщика Application Load Balancer, развернутого по конфигурации `Ingress`, указываются в пользовательском ресурсе `IngressGroupStatus` кластера Managed Service for Kubernetes. Чтобы просмотреть их:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором создан нужный кластер Managed Service for Kubernetes.
  1. В списке сервисов выберите **Managed Service for&nbsp;Kubernetes**.
  1. Выберите кластер Managed Service for Kubernetes, по конфигурации `Ingress` которого был создан балансировщик.
  1. На странице кластера Managed Service for Kubernetes перейдите на вкладку ![shapes-3](../../../_assets/console-icons/shapes-3.svg) **Пользовательские ресурсы**.
  1. Выберите `ingressgroupstatuses.alb.yc.io` и перейдите на вкладку **Ресурсы**.
  1. Выберите ресурс с именем группы ресурсов `Ingress`, указанным в аннотации `ingress.alb.yc.io/group-name`, и перейдите на вкладку **YAML**.

- kubectl CLI {#kubectl}

  1. [Установите kubectl](https://kubernetes.io/ru/docs/tasks/tools/install-kubectl) и [настройте его на работу с созданным кластером](../../operations/connect/index.md#kubectl-connect).
  1. Выполните команду:

      ```bash
      kubectl describe IngressGroupStatus
      ```

{% endlist %}