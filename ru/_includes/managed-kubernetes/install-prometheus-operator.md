{{ prometheus-name }} Operator с поддержкой {{ monitoring-full-name }} упрощает установку {{ prometheus-name }} Operator, популярного решения для мониторига кластеров {{ k8s }}, и добавляет интеграцию с системой мониторинга {{ monitoring-full-name }}. С ее помощью можно собирать, хранить и читать метрики из контейнеров, приложений и инфраструктуры. Система использует модель данных {{ prometheus-name }} и язык запросов [{{ promql-name }}](https://prometheus.io/docs/prometheus/latest/querying/basics/).

## Перед началом работы {#before-you-begin}

1. {% include [check-sg-prerequsites](./security-groups/check-sg-prerequsites-lvl3.md) %}

   {% include [sg-common-warning](./security-groups/sg-common-warning.md) %}

1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) с ролью [monitoring.editor](../../monitoring/security/index.md#monitoring-editor).

1. [Создайте API-ключ](../../iam/operations/authentication/manage-api-keys.md#create-api-key) для сервисного аккаунта:

   * Если установка {{ prometheus-name }} Operator будет выполняться с помощью [{{ marketplace-full-name }}](#marketplace-install), создайте API-ключ в формате JSON и сохраните его в файл `sa-key.json`:

      ```bash
      yc iam api-key create \
         --service-account-name=<имя_сервисного_аккаунта> \
         --format=json | jq -c > sa-key.json
      ```

      {% note tip %}

      Вы также можете автоматически создать новый API-ключ во время установки приложения.

      {% endnote %}

   * Если установка {{ prometheus-name }} Operator будет выполняться с помощью [Helm-чарта](#helm-install), выполните команду и сохраните полученный секретный ключ (`secret`):

      ```bash
      yc iam api-key create --service-account-name=<имя_сервисного_аккаунта>
      ```

1. {% include [Настройка kubectl](../managed-kubernetes/kubectl-install.md) %}

1. Если у вас еще нет воркспейса {{ prometheus-name }}, создайте его:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

      1. Откройте [главную страницу сервиса]({{ link-monitoring }}) {{ monitoring-name }}.
      1. На панели слева выберите **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.prometheus.title }}**.
      1. Нажмите кнопку **{{ ui-key.yacloud_monitoring.prometheus.action_create }}**.

   {% endlist %} 

## Установка с помощью {{ marketplace-full-name }} {#marketplace-install}

{% include [install-marketplace](../../_includes/managed-kubernetes/prometheus-install-marketplace.md) %}

## Установка с помощью Helm-чарта {#helm-install}

{% include [install-helm-chart](../../_includes/managed-kubernetes/prometheus-install-helm-chart.md) %}

## Просмотр графиков по метрикам {#add-graph}

{% include [add-graph](../../_includes/managed-kubernetes/prometheus-add-graph.md) %}

## Добавление графика на дашборд {#add-to-dashboard}

{% include [add-graph-to-dashboard](../../_includes/managed-kubernetes/prometheus-add-graph-to-dashboard.md) %}

## (Опционально) Настройка алертинга по метрикам {#set-alerting}

{% include [set-alerting](../../_includes/managed-kubernetes/prometheus-alerting-set.md) %}
