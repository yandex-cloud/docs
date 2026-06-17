# Мониторинг кластера Yandex Managed Service for Kubernetes с помощью Prometheus Operator с поддержкой Yandex Monitoring

# Мониторинг кластера с помощью Prometheus Operator с поддержкой Yandex Monitoring

Managed Service for Kubernetes позволяет выгружать метрики объектов кластера в системы мониторинга.

Из этой статьи вы узнаете, как настроить мониторинг [кластера Yandex Managed Service for Kubernetes](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) с помощью Prometheus Operator с поддержкой Yandex Monitoring.

Prometheus Operator с поддержкой Monitoring упрощает установку Prometheus Operator, популярного решения для мониторига кластеров Kubernetes, и добавляет интеграцию с системой мониторинга Yandex Monitoring. С ее помощью можно собирать, хранить и читать метрики из контейнеров, приложений и инфраструктуры. Система использует модель данных Prometheus и язык запросов [PromQL](https://prometheus.io/docs/prometheus/latest/querying/basics/).

Чтобы настроить мониторинг кластера Managed Service for Kubernetes:

1. Установите Prometheus Operator с помощью [Helm-чарта](#helm-install) или [Yandex Cloud Marketplace](#marketplace-install).
1. [Настройте и проверьте алерты](#set-alerting).
1. [Визуализируйте метрики](#check-metrics).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки описываемого решения входят:

* Плата за мастер Managed Service for Kubernetes: ([тарифы Managed Service for Kubernetes](../../managed-kubernetes/pricing.md)).
* Плата за узлы кластера Managed Service for Kubernetes: использование вычислительных ресурсов и хранилища ([тарифы Yandex Compute Cloud](../../compute/pricing.md)).
* Плата за публичные IP-адреса для хостов кластера Managed Service for Kubernetes и узлов кластера Managed Service for Kubernetes, если для них включен публичный доступ ([тарифы Yandex Virtual Private Cloud](../../vpc/pricing.md#prices-public-ip)).


## Перед началом работы {#before-you-begin}

1. [Создайте группы безопасности](../../managed-kubernetes/operations/connect/security-groups.md) для кластера Managed Service for Kubernetes и входящих в него групп узлов.

    {% note warning %}
    
    От настройки групп безопасности зависит работоспособность и доступность кластера, а также запущенных в нем сервисов и приложений.
    
    {% endnote %}

1. [Создайте кластер Managed Service for Kubernetes](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) и [группу узлов](../../managed-kubernetes/operations/node-group/node-group-create.md) любой подходящей конфигурации с доступом в интернет и с группами безопасности, подготовленными ранее.

1. [Установите kubectl](https://kubernetes.io/ru/docs/tasks/tools/install-kubectl) и [настройте его на работу с созданным кластером](../../managed-kubernetes/operations/connect/index.md#kubectl-connect).

1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) с ролью [monitoring.editor](../../monitoring/security/index.md#monitoring-editor).

1. [Создайте API-ключ](../../iam/operations/authentication/manage-api-keys.md#create-api-key) для сервисного аккаунта:

   * Если вы будете устанавливать Prometheus Operator с помощью [Helm-чарта](#helm-install), выполните команду и сохраните полученный секретный ключ (`secret`):

      ```bash
      yc iam api-key create --service-account-name=<имя_сервисного_аккаунта>
      ```

   * Если вы будете устанавливать Prometheus Operator с помощью [Cloud Marketplace](#marketplace-install), создайте API-ключ в формате JSON и сохраните его в файл `sa-key.json`:

     ```bash
     yc iam api-key create \
        --service-account-name=<имя_сервисного_аккаунта> \
        --format=json | jq -c > sa-key.json
     ```

      {% note tip %}

      Вы также можете автоматически создать новый API-ключ во время установки приложения.

      {% endnote %}

1. Создайте воркспейс Prometheus:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

      1. Откройте [главную страницу сервиса](https://monitoring.yandex.cloud) Monitoring.
      1. На панели слева выберите **Prometheus**.
      1. Нажмите кнопку **Создать воркспейс**.

   {% endlist %}

## Установите Prometheus Operator с помощью Helm-чарта {#helm-install}

1. [Установите менеджер пакетов Helm](https://helm.sh/ru/docs/intro/install/) версии не ниже 3.8.0.

1. Получите идентификатор воркспейса Prometheus:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

      1. Откройте [главную страницу сервиса](https://monitoring.yandex.cloud) Monitoring.
      1. Слева выберите раздел **Prometheus**.
      1. Выберите воркспейс Prometheus.
      1. Откроется вкладка **Общая информация**, где отображается идентификатор воркспейса — сохраните его.

   {% endlist %}

1. Чтобы установить [Helm-чарт](https://helm.sh/docs/topics/charts/) с Prometheus Operator, выполните команду:

   ```bash
   helm pull oci://cr.yandex/yc-marketplace/yandex-cloud/prometheus/kube-prometheus-stack \
     --version 72.6.2-1 \
     --untar && \
   helm install \
     --namespace <пространство_имен_для_Prometheus_Operator> \
     --create-namespace \
     --set prometheusWorkspaceId=<идентификатор_воркспейса_Prometheus> \
     --set iam_api_key_value_generated.secretAccessKey=<секретная_часть_API-ключа> \
     prometheus ./kube-prometheus-stack/
   ```

   Эта команда также создаст новое пространство имен для работы Prometheus Operator.

   Если вы укажете в параметре `namespace` пространство имен по умолчанию, Prometheus Operator может работать некорректно. Используйте значение, отличное от всех существующих пространств имен, например `prometheus-operator-space`.

   {% note info %}
   
   Если вы используете версию Helm ниже 3.8.0, добавьте в начало команды строку `export HELM_EXPERIMENTAL_OCI=1 && \`, чтобы включить поддержку [Open Container Initiative](https://opencontainers.org/) (OCI) в клиенте Helm.
   
   {% endnote %}

1. Убедитесь, что поды Prometheus Operator перешли в состояние `Running`:

   ```bash
   kubectl get pods --namespace=<пространство_имен_для_Prometheus_Operator> \
      -l "release=prometheus"
   ```

## Установите Prometheus Operator с помощью Cloud Marketplace {#marketplace-install}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
   1. Перейдите в сервис **Managed Service for&nbsp;Kubernetes**.
   1. Нажмите на имя нужного кластера Kubernetes и выберите вкладку ![image](../../_assets/marketplace.svg) **Marketplace**.
   1. В разделе **Доступные для установки приложения** выберите [Prometheus Operator с поддержкой Monitoring](https://yandex.cloud/ru/marketplace/products/yc/prometheus-operator) и нажмите кнопку **Перейти к установке**.
   1. Задайте настройки приложения:

      * **Пространство имен** — создайте новое [пространство имен](../../managed-kubernetes/concepts/index.md#namespace), например `prometheus-operator-space`. Если вы оставите пространство имен по умолчанию, Prometheus Operator может работать некорректно.
      * **Название приложения** — укажите название приложения.
      * **Prometheus Workspace** — выберите воркспейс Prometheus.
      * **API-ключ** — укажите содержимое файла `sa-key.json`.

   1. Нажмите кнопку **Установить**.
   1. Дождитесь перехода приложения в статус `Deployed`.  

{% endlist %}

## Настройте алертинг по метрикам {#set-alerting}

1. [Создайте](../../monitoring/operations/alert/create-channel.md) канал уведомлений, выбрав доступный [способ отправки](../../monitoring/operations/prometheus/alerting-rules.md#rule-processing).
1. Настройте [Alert Manager](https://prometheus.io/docs/alerting/latest/alertmanager/), который отвечает за отправку уведомлений:

    1. Откройте [главную страницу сервиса](https://monitoring.yandex.cloud) Monitoring.
    1. Слева выберите раздел **Prometheus**.
    1. Выберите воркспейс Prometheus.
    1. Перейдите на вкладку **Конфигурация Alert manager**.
    1. Нажмите кнопку **Загрузить файл конфигурации** и загрузите файл [конфигурации](https://prometheus.io/docs/prometheus/latest/configuration/alerting_rules/) в формате `YAML`.

        {% cut "Пример файла конфигурации" %}

        ```yml
        global:
          resolve_timeout: 5m
        route:
          receiver: telegram
          routes:
            - receiver: "null"
              matchers:
                - severity="none"
              continue: false

        receivers:
          - name: telegram
            yandex_monitoring_configs:
              - channel_names:
                - "<имя канала уведомлений>"
          - name: "null"
            yandex_monitoring_configs:
              - channel_names: []
        ```

        {% endcut %}

1. Добавьте тестовое правило алертинга:

    ```bash
    cat <<EOF | kubectl apply -f -
    apiVersion: monitoring.coreos.com/v1                                                        
    kind: PrometheusRule
    metadata:
      labels:
        release: kube-prometheus-stack
      name: test
    spec:
      groups:
      - name: test
        rules:
          - alert: Test
            annotations:
              description: this is a test alert
              summary: test alert
            expr: vector(1)
            labels:
              severity: warning
    EOF
    ```

1. Дождитесь, пока в выбранный канал уведомлений придет алерт, или проверьте статус алерта в консоли управления:

    1. Откройте [главную страницу сервиса](https://monitoring.yandex.cloud) Monitoring.
    1. Слева выберите раздел **Prometheus**.
    1. Выберите воркспейс Prometheus.
    1. Перейдите на вкладку **Управление правилами**.
    1. Нажмите на имя тестового алерта.
    1. Перейдите на вкладку **Алерты**.
    1. Убедитесь, что тестовый алерт перешел в состояние `FIRING`.

## Визуализируйте метрики {#check-metrics}

Постройте график на основе метрик и добавьте его на дашборд.

### Постройте график по метрикам {#add-graph}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Откройте [главную страницу сервиса](https://monitoring.yandex.cloud) Monitoring.
  1. На панели слева выберите **Метрики**.
  1. Вверху в списке **Источник данных** выберите **Prometheus**.
  1. Выберите воркспейс.
  1. Введите запрос на языке [PromQL](https://prometheus.io/docs/prometheus/latest/querying/basics/).
  1. Чтобы отобразить на графике несколько линий, нажмите кнопку **Добавить запрос** и введите новый запрос.
  1. Нажмите кнопку **Выполнить запрос**, чтобы построить график.

      Получившийся график можно [добавить](#add-to-dashboard) на [дашборд](../../monitoring/concepts/visualization/dashboard.md) в качестве [виджета](../../monitoring/concepts/visualization/widget.md).

{% endlist %}

### Добавьте график на дашборд {#add-to-dashboard}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. [Постройте график](#add-graph).
   1. Справа вверху нажмите кнопку **Добавить на дашборд**.
   1. Введите название графика.
   1. Выберите облако и каталог.
   1. Выберите существующий дашборд или создайте новый.
   1. Выберите один из вариантов добавления графика:
      * **Добавить** — график будет добавлен на дашборд, вы останетесь в разделе **Метрики**.
      * **Добавить и перейти к дашборду** — график будет добавлен на дашборд, вы перейдете в раздел **Дашборды**. В разделе **Метрики** график не сохранится.

{% endlist %}

{% note tip %}

Вы также можете [создать](../../monitoring/operations/dashboard/create.md) пустой дашборд и потом добавить на него нужные графики.

{% endnote %}

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

1. [Удалите кластер Managed Service for Kubernetes](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
1. Если вы зарезервировали для кластера Managed Service for Kubernetes [публичный статический IP-адрес](../../vpc/concepts/address.md#public-addresses), [удалите его](../../vpc/operations/address-delete.md).