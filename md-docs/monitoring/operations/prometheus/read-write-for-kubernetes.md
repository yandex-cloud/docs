# Чтение и запись метрик кластера Yandex Managed Service for Kubernetes с помощью Prometheus Operator


Prometheus Operator с поддержкой Yandex Monitoring упрощает установку Prometheus Operator, популярного решения для мониторига кластеров Kubernetes, и добавляет интеграцию с системой мониторинга Yandex Monitoring. С ее помощью можно собирать, хранить и читать метрики из контейнеров, приложений и инфраструктуры. Система использует модель данных Prometheus и язык запросов [PromQL](https://prometheus.io/docs/prometheus/latest/querying/basics/).

## Перед началом работы {#before-you-begin}

1. [Убедитесь](../../../managed-kubernetes/operations/connect/security-groups.md), что группы безопасности для кластера Managed Service for Kubernetes и его групп узлов настроены корректно. Если отсутствует какое-либо из правил — [добавьте](../../../vpc/operations/security-group-add-rule.md) его.

   {% note warning %}
   
   От настройки групп безопасности зависит работоспособность и доступность кластера, а также запущенных в нем сервисов и приложений.
   
   {% endnote %}

1. [Создайте сервисный аккаунт](../../../iam/operations/sa/create.md) с ролью [monitoring.editor](../../security/index.md#monitoring-editor).

1. [Создайте API-ключ](../../../iam/operations/authentication/manage-api-keys.md#create-api-key) для сервисного аккаунта:

   * Если установка Prometheus Operator будет выполняться с помощью [Yandex Cloud Marketplace](#marketplace-install), создайте API-ключ в формате JSON и сохраните его в файл `sa-key.json`:

      ```bash
      yc iam api-key create \
         --service-account-name=<имя_сервисного_аккаунта> \
         --format=json | jq -c > sa-key.json
      ```

      {% note tip %}

      Вы также можете автоматически создать новый API-ключ во время установки приложения.

      {% endnote %}

   * Если установка Prometheus Operator будет выполняться с помощью [Helm-чарта](#helm-install), выполните команду и сохраните полученный секретный ключ (`secret`):

      ```bash
      yc iam api-key create --service-account-name=<имя_сервисного_аккаунта>
      ```

1. [Установите kubectl](https://kubernetes.io/ru/docs/tasks/tools/install-kubectl) и [настройте его на работу с созданным кластером](../../../managed-kubernetes/operations/connect/index.md#kubectl-connect).

1. Если у вас еще нет воркспейса Prometheus, создайте его:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

      1. Откройте [главную страницу сервиса](https://monitoring.yandex.cloud) Monitoring.
      1. На панели слева выберите **Prometheus**.
      1. Нажмите кнопку **Создать воркспейс**.

   {% endlist %} 

## Установка с помощью Yandex Cloud Marketplace {#marketplace-install}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
   1. Перейдите в сервис **Managed Service for&nbsp;Kubernetes**.
   1. Нажмите на имя нужного кластера Kubernetes и выберите вкладку ![image](../../../_assets/marketplace.svg) **Marketplace**.
   1. В разделе **Доступные для установки приложения** выберите [Prometheus Operator с поддержкой Monitoring](https://yandex.cloud/ru/marketplace/products/yc/prometheus-operator) и нажмите кнопку **Перейти к установке**.
   1. Задайте настройки приложения:

      * **Пространство имен** — создайте новое [пространство имен](../../../managed-kubernetes/concepts/index.md#namespace), например `prometheus-operator-space`. Если вы оставите пространство имен по умолчанию, Prometheus Operator может работать некорректно.
      * **Название приложения** — укажите название приложения.
      * **Prometheus Workspace** — выберите воркспейс Prometheus.
      * **API-ключ** — укажите содержимое файла `sa-key.json`.

   1. Нажмите кнопку **Установить**.
   1. Дождитесь перехода приложения в статус `Deployed`.  

{% endlist %}

## Установка с помощью Helm-чарта {#helm-install}

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

## Просмотр графиков по метрикам {#add-graph}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Откройте [главную страницу сервиса](https://monitoring.yandex.cloud) Monitoring.
  1. На панели слева выберите **Метрики**.
  1. Вверху в списке **Источник данных** выберите **Prometheus**.
  1. Выберите воркспейс.
  1. Введите запрос на языке [PromQL](https://prometheus.io/docs/prometheus/latest/querying/basics/).
  1. Чтобы отобразить на графике несколько линий, нажмите кнопку **Добавить запрос** и введите новый запрос.
  1. Нажмите кнопку **Выполнить запрос**, чтобы построить график.

      Получившийся график можно [добавить](#add-to-dashboard) на [дашборд](../../concepts/visualization/dashboard.md) в качестве [виджета](../../concepts/visualization/widget.md).

{% endlist %}

## Добавление графика на дашборд {#add-to-dashboard}

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

Вы также можете [создать](../dashboard/create.md) пустой дашборд и потом добавить на него нужные графики.

{% endnote %}

## (Опционально) Настройка алертинга по метрикам {#set-alerting}

1. [Создайте](../alert/create-channel.md) канал уведомлений, выбрав доступный [способ отправки](alerting-rules.md#rule-processing).
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

## Полезные ссылки {#see-also}

* [Yandex Managed Service for Kubernetes](../../../managed-kubernetes/index.md)

_© 2025 Linux Foundation. Все права защищены. Linux Foundation зарегистрировала товарные знаки и использует товарные знаки. Список товарных знаков Linux Foundation смотрите на странице [Trademark Usage](https://www.linuxfoundation.org/legal/trademark-usage)._