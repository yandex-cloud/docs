---
title: "Принципы работы Ingress-контроллера {{ alb-full-name }}"
description: "Узнайте, как работает Ingress-контроллер {{ alb-name }}, а также связь ресурсов {{ alb-name }} и {{ k8s }}."
---

# Принципы работы Ingress-контроллера {{ alb-name }}


К [Ingress-контроллеру {{ alb-name }} для {{ managed-k8s-name }}](index.md) относятся два [пода](../../../managed-kubernetes/concepts/index.md#pod):

* Основной под `yc-alb-ingress-controller-*` отвечает за создание и изменение ресурсов {{ alb-name }}. Отслеживать работу с ресурсами можно по логам этого пода.
* Под для [проверок состояния](../../concepts/backend-group.md#health-checks) `yc-alb-ingress-controller-hc-*` с контейнером, который принимает проверочные запросы от L7-балансировщика на TCP-порт `10501` и проверяет работоспособность подов [kube-proxy](https://kubernetes.io/docs/reference/command-line-tools-reference/kube-proxy/) на каждом узле кластера. Суть проверки состояния заключается в том, что когда kube-proxy работоспособен, то даже если приложение в конкретном поде не отвечает, {{ k8s }} перенаправит трафик в другой под с этим приложением или на другой узел. Эта схема проверки состояния реализована в Ingress-контроллере {{ alb-name }} по умолчанию. Также вы можете [настроить собственные проверки состояния](../../../managed-kubernetes/tutorials/custom-health-checks.md) в параметрах ресурса [HttpBackendGroup](../../k8s-ref/http-backend-group.md).

{% note warning %}

Не изменяйте напрямую ресурсы {{ alb-name }}, созданные основным подом контроллера. Любые изменения будут автоматически отменены. Вместо этого пользуйтесь стандартными способами управления кластером {{ managed-k8s-name }}.

{% endnote %}

Основной под управляет архитектурой ресурсов {{ alb-name }} по следующим правилам:

* Балансировщики и HTTP-роутеры для приема трафика и его распределения между группами бэкендов создаются по ресурсам [Ingress](../../k8s-ref/ingress.md). 
  
  Если у нескольких `Ingress` одинаковые значения аннотации `ingress.alb.yc.io/group-name`, они объединяются в один балансировщик.

  * Чтобы балансировщик принимал HTTPS-трафик, в поле `spec.tls` описания `Ingress` должны быть указаны доменные имена и идентификаторы сертификатов из {{ certificate-manager-name }}:

    ```yaml
    spec:
      tls:
        - hosts:
            - <доменное_имя>
          secretName: yc-certmgr-cert-id-<идентификатор_сертификата>
    ```

    Где `secretName` — указание на сертификат из {{ certificate-manager-full-name }}.

    В этом случае для балансировщика будут созданы обработчики двух видов: одни будут принимать HTTPS-трафик на порте `443`, а другие — перенаправлять запросы с HTTP (порт `80`) на HTTPS с кодом состояния `301 Moved Permanently`. При этом правила распределения трафика для тех же доменных имен, явно указанные в других `Ingress`, без поля `spec.tls`, будут иметь приоритет над перенаправлением с HTTP на HTTPS.

    {% include [k8s-ingress-controller-secret-name](../../../_includes/application-load-balancer/k8s-ingress-controller-secret-name.md) %}
    
  * Если в описании `Ingress` нет поля `spec.tls`, для балансировщика будут созданы только обработчики для приема HTTP-трафика на порте `80`.

* Группы бэкендов, обрабатывающие полученный трафик, могут создаваться:

  * По сервисам {{ k8s }}, указанным в [правилах](../../../application-load-balancer/k8s-ref/ingress.md#rule) `Ingress` напрямую. Этот способ полезен, если к маршруту нужно привязать простую группу бэкендов, состоящую из одного сервиса.

    В версиях [ALB Ingress Controller](/marketplace/products/yc/alb-ingress-controller) до 0.2.0 каждая группа бэкендов соответствует связке параметров `host`, `http.paths.path` и `http.paths.pathType` в правилах `Ingress`. В версиях 0.2.0 и позднее группа бэкендов соответствует параметру `backend.service`. Из-за этого при обновлении ALB Ingress Controller могут возникнуть коллизии. Чтобы избежать их, [узнайте, применимы ли ограничения при обновлении](../../operations/k8s-ingress-controller-upgrade.md) к вашей инфраструктуре.

  * По ресурсам [HttpBackendGroup](../../k8s-ref/http-backend-group.md), позволяющим явно описывать группы бэкендов. Это [custom resources](https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/custom-resources/) из группы API `alb.yc.io`, предоставляемой Ingress-контроллером.

    Указывать на `HttpBackendGroup`, как и на сервисы, нужно в правилах `Ingress` (`spec.rules[*].http.paths[*].backend.resource`). 

    {% include [k8s-ingress-controller-backend-group-features](../../../_includes/application-load-balancer/k8s-ingress-controller-backend-group-features.md) %}

* На бэкендах развертываются сервисы, указанные в `Ingress` или `HttpBackendGroup`. Они настраиваются с помощью ресурсов [Service](../../k8s-ref/service-for-ingress.md).

  {% include [k8s-ingress-controller-nodeport-note](../../../_includes/application-load-balancer/k8s-ingress-controller-nodeport-note.md) %}

## Соответствие ресурсов {{ alb-name }} и {{ k8s }} {#mapping}

| {{ alb-name }} | {{ k8s }} |
| ----- | ----- |
| [Балансировщик](../../concepts/application-load-balancer.md) | Набор ресурсов [Ingress](../../k8s-ref/ingress.md) с одинаковыми значениями аннотации `ingress.alb.yc.io/group-name` |
| [Виртуальные хосты](../../concepts/http-router.md#virtual-host) HTTP-роутера | `Ingress.spec.rules` |
| [Маршруты](../../concepts/http-router.md#routes) виртуального хоста | `Ingress.spec.rules[*].http.paths` |
| [Группа бэкендов](../../concepts/backend-group.md) | [HttpBackendGroup](../../k8s-ref/http-backend-group.md) или набор [сервисов](../../k8s-ref/service-for-ingress.md) |
| [Целевая группа](../../concepts/target-group.md) | [Группа узлов](../../../managed-kubernetes/concepts/index.md#node-group) кластера |

## Идентификаторы ресурсов балансировщика в кластере {{ k8s }} {#alb-ids}

Идентификаторы ресурсов балансировщика {{ alb-name }}, развернутого по конфигурации `Ingress`, указываются в пользовательском ресурсе `IngressGroupStatus` кластера {{ managed-k8s-name }}. Чтобы просмотреть их:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором создан нужный кластер {{ managed-k8s-name }}.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Выберите кластер {{ managed-k8s-name }}, по конфигурации `Ingress` которого был создан балансировщик.
  1. На странице кластера {{ managed-k8s-name }} перейдите на вкладку ![shapes-3](../../../_assets/console-icons/shapes-3.svg) **{{ ui-key.yacloud.k8s.cluster.switch_custom-resources }}**.
  1. Выберите `ingressgroupstatuses.alb.yc.io` и перейдите на вкладку **{{ ui-key.yacloud.k8s.custom-resources.label_tab-resources }}**.
  1. Выберите ресурс с именем группы ресурсов `Ingress`, указанным в аннотации `ingress.alb.yc.io/group-name`, и перейдите на вкладку **{{ ui-key.yacloud.k8s.workloads.label_tab-yaml }}**.

- kubectl CLI {#kubectl}

  1. {% include [kubectl-install-links](../../../_includes/managed-kubernetes/kubectl-install.md) %}
  1. Выполните команду:

      ```bash
      kubectl describe IngressGroupStatus
      ```

{% endlist %}