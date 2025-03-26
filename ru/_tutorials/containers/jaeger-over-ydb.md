

Платформа для распределенной трассировки [Jaeger](https://github.com/jaegertracing/jaeger) позволяет выполнять мониторинг состояния запросов в распределенных системах микросервисных приложений.

В этой статье вы узнаете, как установить платформу Jaeger в [кластер {{ managed-k8s-name }}](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) и настроить ее для работы с [{{ ydb-full-name }}](../../ydb/):
1. [Установите и настройте Jaeger](#jaeger-install).
1. [Установите тестовое приложение](#hotrod-install), которое создаст нагрузку на кластер {{ k8s }}.
1. [Проверьте работу Jaeger](#jaeger-test), выполнив несколько тестовых запросов.


## Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки описываемого решения входят:

* Плата за кластер {{ managed-k8s-name }}: использование мастера и исходящий трафик (см. [тарифы {{ managed-k8s-name }}](../../managed-kubernetes/pricing.md)).
* Плата за узлы кластера (ВМ): использование вычислительных ресурсов, операционной системы и хранилища (см. [тарифы {{ compute-name }}](../../compute/pricing.md)).
* Плата за публичный IP-адрес, если он назначен узлам кластера (см. [тарифы {{ vpc-name }}](../../vpc/pricing.md#prices-public-ip)).
* Плата за базу данных {{ ydb-name }}, работающую в режиме Dedicated: использование вычислительных ресурсов, выделенных БД, и дискового пространства (см. [тарифы {{ ydb-name }}](../../ydb/pricing/dedicated.md)).


## Перед началом работы {#before-you-begin}

1. {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

1. {% include [configure-sg-manual](../../_includes/managed-kubernetes/security-groups/configure-sg-manual-lvl3.md) %}

    {% include [sg-common-warning](../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

1. [Создайте кластер {{ managed-k8s-name }}](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) и [группу узлов](../../managed-kubernetes/operations/node-group/node-group-create.md) любой подходящей конфигурации. При создании укажите группы безопасности, подготовленные ранее.

1. {% include [Install and configure kubectl](../../_includes/managed-kubernetes/kubectl-install.md) %}

## Установите и настройте Jaeger {#jaeger-install}

1. [Установите](../../managed-kubernetes/operations/applications/jaeger.md#marketplace-install) продукт [Jaeger over {{ ydb-short-name }}](/marketplace/products/yc/jaeger-ydb-store) из каталога приложений {{ marketplace-full-name }}. При установке приложения выберите [пространство имен](../../managed-kubernetes/concepts/index.md#namespace) по умолчанию (`default`).
1. Убедитесь, что все [поды](../../managed-kubernetes/concepts/index.md#pod) Jaeger перешли в состояние `Running`:

   ```bash
   kubectl get pods | grep jaeger
   ```

1. Узнайте имя [сервиса](../../managed-kubernetes/concepts/service.md) `jaeger-ydb-store-agent`:

   ```bash
   kubectl get svc | grep ydb-store-agent
   ```

   Результат:

   ```text
   <имя_приложения_jaeger-ydb-store-agent> ClusterIP 10.2.238.190 ...
   ```

## Установите тестовое приложение {#hotrod-install}

Для проверки работы Jaeger используется приложение [HotROD](https://github.com/jaegertracing/jaeger/tree/9f067714451068c2ba136f5899077346abbc4c6c/examples/hotrod), которое имитирует нагрузку на кластер {{ k8s }} с помощью нескольких микросервисов.

1. Создайте манифест `hotrod.yaml`, содержащий описание приложения:

   ```yaml
   ---
   apiVersion: v1
   kind: Pod
   metadata:
     name: hotrod
   spec:
     containers:
     - name: hotrod
       image: jaegertracing/example-hotrod:latest
       env:
       - name: JAEGER_AGENT_HOST
         value: "<имя_приложения_jaeger-ydb-store-agent>.default.svc.cluster.local"
       - name: JAEGER_AGENT_PORT
         value: "6831"
       ports:
       - containerPort: 8080
       - containerPort: 8081
       - containerPort: 8082
       - containerPort: 8083
   ```

1. Создайте под с приложением `hotrod`:

   ```bash
   kubectl apply -f hotrod.yaml
   ```

1. Убедитесь, что поды `hotrod` перешли в состояние `Running`:

   ```bash
   kubectl get pods | grep hotrod
   ```

## Проверьте работу Jaeger {#jaeger-test}

1. Узнайте имя сервиса `jaeger-ydb-store-query`:

   ```bash
   kubectl get svc | grep jaeger-ydb-store-query
   ```

   Результат:

   ```text
   <имя_приложения_jaeger-ydb-store-query>  LoadBalancer  10.2.222.155  130.133.51.247  16686:31189/TCP ...
   ```

1. Настройте переадресацию порта сервиса `jaeger-ydb-store-query` на локальный компьютер:

   ```bash
   kubectl port-forward service/<имя_приложения_jaeger-ydb-store-query> 16686:16686
   ```

1. В другом окне консоли настройте переадресацию порта приложения `hotrod` на локальный компьютер:

   ```bash
   kubectl port-forward hotrod 8080:8080
   ```

1. Откройте в браузере [URI приложения](https://localhost:8080) `hotrod` и выполните несколько тестовых запросов к сервису Jaeger.

    {% include [Настройка групп безопасности при недоступности ресурса](../../_includes/managed-kubernetes/security-groups/check-sg-if-url-unavailable-lvl3.md) %}

1. Откройте в браузере [URI Jaeger](https://localhost:16686).

   Убедитесь, что тестовые запросы успешно переданы и попали в трассировку.

## Удалите созданные ресурсы {#clear-out}

Удалите ресурсы, которые вы больше не будете использовать, чтобы за них не списывалась плата:

1. [Удалите базу данных {{ ydb-name }}](../../ydb/operations/manage-databases.md#delete-db).
1. [Удалите кластер {{ managed-k8s-name }}](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
1. Если вы зарезервировали для кластера публичный статический IP-адрес, [удалите его](../../vpc/operations/address-delete.md).
