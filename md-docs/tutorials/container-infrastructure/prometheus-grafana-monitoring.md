# Мониторинг кластера {{ managed-k8s-full-name }} с помощью {{ prometheus-name }} Operator с поддержкой {{ monitoring-full-name }}

# Мониторинг кластера с помощью {{ prometheus-name }} Operator с поддержкой {{ monitoring-full-name }}

{{ managed-k8s-name }} позволяет выгружать метрики объектов кластера в системы мониторинга.

Из этой статьи вы узнаете, как настроить мониторинг [кластера {{ managed-k8s-full-name }}](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) с помощью {{ prometheus-name }} Operator с поддержкой {{ monitoring-full-name }}.

{{ prometheus-name }} Operator с поддержкой {{ monitoring-name }} упрощает установку {{ prometheus-name }} Operator, популярного решения для мониторига кластеров {{ k8s }}, и добавляет интеграцию с системой мониторинга {{ monitoring-full-name }}. С ее помощью можно собирать, хранить и читать метрики из контейнеров, приложений и инфраструктуры. Система использует модель данных {{ prometheus-name }} и язык запросов [{{ promql-name }}](https://prometheus.io/docs/prometheus/latest/querying/basics/).

Чтобы настроить мониторинг кластера {{ managed-k8s-name }}:

1. Установите {{ prometheus-name }} Operator с помощью [Helm-чарта](#helm-install) или [{{ marketplace-full-name }}](#marketplace-install).
1. [Настройте и проверьте алерты](#set-alerting).
1. [Визуализируйте метрики](#check-metrics).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки описываемого решения входят:

* Плата за мастер {{ managed-k8s-name }}: (см. [тарифы {{ managed-k8s-name }}](../../managed-kubernetes/pricing.md)).
* Плата за узлы кластера {{ managed-k8s-name }}: использование вычислительных ресурсов и хранилища (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md)).
* Плата за публичные IP-адреса для хостов кластера {{ managed-k8s-name }} и узлов кластера {{ managed-k8s-name }}, если для них включен публичный доступ (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md#prices-public-ip)).


## Перед началом работы {#before-you-begin}

1. [Создайте группы безопасности](../../managed-kubernetes/operations/connect/security-groups.md) для кластера {{ managed-k8s-name }} и входящих в него групп узлов.

    {% note warning %}
    
    От настройки групп безопасности зависит работоспособность и доступность кластера, а также запущенных в нем сервисов и приложений.
    
    {% endnote %}

1. [Создайте кластер {{ managed-k8s-name }}](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) и [группу узлов](../../managed-kubernetes/operations/node-group/node-group-create.md) любой подходящей конфигурации с доступом в интернет и с группами безопасности, подготовленными ранее.

1. [Установите kubectl]({{ k8s-docs }}/tasks/tools/install-kubectl) и [настройте его на работу с созданным кластером](../../managed-kubernetes/operations/connect/index.md#kubectl-connect).

1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) с ролью [monitoring.editor](../../monitoring/security/index.md#monitoring-editor).

1. [Создайте API-ключ](../../iam/operations/authentication/manage-api-keys.md#create-api-key) для сервисного аккаунта:

   * Если вы будете устанавливать {{ prometheus-name }} Operator с помощью [Helm-чарта](#helm-install), выполните команду и сохраните полученный секретный ключ (`secret`):

      ```bash
      yc iam api-key create --service-account-name=<имя_сервисного_аккаунта>
      ```

   * Если вы будете устанавливать {{ prometheus-name }} Operator с помощью [{{ marketplace-name }}](#marketplace-install), создайте API-ключ в формате JSON и сохраните его в файл `sa-key.json`:

     ```bash
     yc iam api-key create \
        --service-account-name=<имя_сервисного_аккаунта> \
        --format=json | jq -c > sa-key.json
     ```

      {% note tip %}

      Вы также можете автоматически создать новый API-ключ во время установки приложения.

      {% endnote %}

1. Создайте воркспейс {{ prometheus-name }}:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

      1. Откройте [главную страницу сервиса]({{ link-monitoring }}) {{ monitoring-name }}.
      1. На панели слева выберите **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.prometheus.title }}**.
      1. Нажмите кнопку **{{ ui-key.yacloud_monitoring.prometheus.action_create }}**.

   {% endlist %}

## Установите {{ prometheus-name }} Operator с помощью Helm-чарта {#helm-install}

1. [Установите менеджер пакетов Helm](https://helm.sh/ru/docs/intro/install/) версии не ниже 3.8.0.

1. Получите идентификатор воркспейса {{ prometheus-name }}:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

      1. Откройте [главную страницу сервиса]({{ link-monitoring }}) {{ monitoring-name }}.
      1. Слева выберите раздел **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.prometheus.title }}**.
      1. Выберите воркспейс {{ prometheus-name }}.
      1. Откроется вкладка **{{ ui-key.yacloud_monitoring.prometheus.approved.tab.info }}**, где отображается идентификатор воркспейса — сохраните его.

   {% endlist %}

1. Чтобы установить [Helm-чарт](https://helm.sh/docs/topics/charts/) с {{ prometheus-name }} Operator, выполните команду:

   ```bash
   helm pull oci://{{ mkt-k8s-key.yc_prometheus-operator.helmChart.name }} \
     --version {{ mkt-k8s-key.yc_prometheus-operator.helmChart.tag }} \
     --untar && \
   helm install \
     --namespace <пространство_имен_для_{{ prometheus-name }}_Operator> \
     --create-namespace \
     --set prometheusWorkspaceId=<идентификатор_воркспейса_{{ prometheus-name }}> \
     --set iam_api_key_value_generated.secretAccessKey=<секретная_часть_API-ключа> \
     prometheus ./kube-prometheus-stack/
   ```

   Эта команда также создаст новое пространство имен для работы {{ prometheus-name }} Operator.

   Если вы укажете в параметре `namespace` пространство имен по умолчанию, {{ prometheus-name }} Operator может работать некорректно. Используйте значение, отличное от всех существующих пространств имен, например `prometheus-operator-space`.

   {% note info %}
   
   Если вы используете версию Helm ниже 3.8.0, добавьте в начало команды строку `export HELM_EXPERIMENTAL_OCI=1 && \`, чтобы включить поддержку [Open Container Initiative](https://opencontainers.org/) (OCI) в клиенте Helm.
   
   {% endnote %}

1. Убедитесь, что поды {{ prometheus-name }} Operator перешли в состояние `Running`:

   ```bash
   kubectl get pods --namespace=<пространство_имен_для_{{ prometheus-name }}_Operator> \
      -l "release=prometheus"
   ```

## Установите {{ prometheus-name }} Operator с помощью {{ marketplace-name }} {#marketplace-install}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления]({{ link-console-main }}) выберите каталог.
   1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
   1. Нажмите на имя нужного кластера {{ k8s }} и выберите вкладку ![image](../../_assets/marketplace.svg) **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}**.
   1. В разделе **{{ ui-key.yacloud.marketplace-v2.label_available-products }}** выберите [{{ prometheus-name }} Operator с поддержкой {{ monitoring-name }}](https://yandex.cloud/ru/marketplace/products/yc/prometheus-operator) и нажмите кнопку **{{ ui-key.yacloud.marketplace-v2.button_k8s-product-use }}**.
   1. Задайте настройки приложения:

      * **Пространство имен** — создайте новое [пространство имен](../../managed-kubernetes/concepts/index.md#namespace), например `prometheus-operator-space`. Если вы оставите пространство имен по умолчанию, {{ prometheus-name }} Operator может работать некорректно.
      * **Название приложения** — укажите название приложения.
      * **{{ prometheus-name }} Workspace** — выберите воркспейс {{ prometheus-name }}.
      * **API-ключ** — укажите содержимое файла `sa-key.json`.

   1. Нажмите кнопку **Установить**.
   1. Дождитесь перехода приложения в статус `Deployed`.  

{% endlist %}

## Настройте алертинг по метрикам {#set-alerting}

1. [Создайте](../../monitoring/operations/alert/create-channel.md) канал уведомлений, выбрав доступный [способ отправки](../../monitoring/operations/prometheus/alerting-rules.md#rule-processing).
1. Настройте [Alert Manager](https://prometheus.io/docs/alerting/latest/alertmanager/), который отвечает за отправку уведомлений:

    1. Откройте [главную страницу сервиса]({{ link-monitoring }}) {{ monitoring-name }}.
    1. Слева выберите раздел **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.prometheus.title }}**.
    1. Выберите воркспейс {{ prometheus-name }}.
    1. Перейдите на вкладку **{{ ui-key.yacloud_monitoring.prometheus.tab.alert-manager-key-value }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud_monitoring.prometheus.alert-manager.upload-config }}** и загрузите файл [конфигурации](https://prometheus.io/docs/prometheus/latest/configuration/alerting_rules/) в формате `YAML`.

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

    1. Откройте [главную страницу сервиса]({{ link-monitoring }}) {{ monitoring-name }}.
    1. Слева выберите раздел **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.prometheus.title }}**.
    1. Выберите воркспейс {{ prometheus-name }}.
    1. Перейдите на вкладку **{{ ui-key.yacloud_monitoring.prometheus.tab.managing-rules }}**.
    1. Нажмите на имя тестового алерта.
    1. Перейдите на вкладку **{{ ui-key.yacloud_monitoring.prometheus.managing-rule.tabs.alerts }}**.
    1. Убедитесь, что тестовый алерт перешел в состояние `FIRING`.

## Визуализируйте метрики {#check-metrics}

Постройте график на основе метрик и добавьте его на дашборд.

### Постройте график по метрикам {#add-graph}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Откройте [главную страницу сервиса]({{ link-monitoring }}) {{ monitoring-name }}.
  1. На панели слева выберите **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.explorer.title }}**.
  1. Вверху в списке **Источник данных** выберите **{{ prometheus-name }}**.
  1. Выберите воркспейс.
  1. Введите запрос на языке [PromQL](https://prometheus.io/docs/prometheus/latest/querying/basics/).
  1. Чтобы отобразить на графике несколько линий, нажмите кнопку **{{ ui-key.yacloud_monitoring.querystring.action.add-query }}** и введите новый запрос.
  1. Нажмите кнопку **{{ ui-key.yacloud_monitoring.querystring.action.execute-query }}**, чтобы построить график.

      Получившийся график можно [добавить](#add-to-dashboard) на [дашборд](../../monitoring/concepts/visualization/dashboard.md) в качестве [виджета](../../monitoring/concepts/visualization/widget.md).

{% endlist %}

### Добавьте график на дашборд {#add-to-dashboard}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. [Постройте график](#add-graph).
   1. Справа вверху нажмите кнопку **{{ ui-key.yacloud_monitoring.wizard.wizard.mx.save-as }}**.
   1. Введите название графика.
   1. Выберите облако и каталог.
   1. Выберите существующий дашборд или создайте новый.
   1. Выберите один из вариантов добавления графика:
      * **{{ ui-key.yacloud_monitoring.component.add-to-dashboard-form.action.add }}** — график будет добавлен на дашборд, вы останетесь в разделе **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.explorer.title }}**.
      * **{{ ui-key.yacloud_monitoring.component.add-to-dashboard-form.action.add-and-go }}** — график будет добавлен на дашборд, вы перейдете в раздел **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.dashboards.title }}**. В разделе **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.explorer.title }}** график не сохранится.

{% endlist %}

{% note tip %}

Вы также можете [создать](../../monitoring/operations/dashboard/create.md) пустой дашборд и потом добавить на него нужные графики.

{% endnote %}

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

1. [Удалите кластер {{ managed-k8s-name }}](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
1. Если вы зарезервировали для кластера {{ managed-k8s-name }} [публичный статический IP-адрес](../../vpc/concepts/address.md#public-addresses), [удалите его](../../vpc/operations/address-delete.md).