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

1. {% include [configure-sg-manual](../../_includes/managed-kubernetes/security-groups/configure-sg-manual-lvl3.md) %}

    {% include [sg-common-warning](../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

1. [Создайте кластер {{ managed-k8s-name }}](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) и [группу узлов](../../managed-kubernetes/operations/node-group/node-group-create.md) любой подходящей конфигурации с доступом в интернет и с группами безопасности, подготовленными ранее.

1. {% include [Install and configure kubectl](../../_includes/managed-kubernetes/kubectl-install.md) %}

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

{% include [install-helm-chart](../../_includes/managed-kubernetes/prometheus-install-helm-chart.md) %}

## Установите {{ prometheus-name }} Operator с помощью {{ marketplace-name }} {#marketplace-install}

{% include [install-marketplace](../../_includes/managed-kubernetes/prometheus-install-marketplace.md) %}

## Настройте алертинг по метрикам {#set-alerting}

{% include [set-alerting](../../_includes/managed-kubernetes/prometheus-alerting-set.md) %}

## Визуализируйте метрики {#check-metrics}

Постройте график на основе метрик и добавьте его на дашборд.

### Постройте график по метрикам {#add-graph}

{% include [add-graph](../../_includes/managed-kubernetes/prometheus-add-graph.md) %}

### Добавьте график на дашборд {#add-to-dashboard}

{% include [add-graph-to-dashboard](../../_includes/managed-kubernetes/prometheus-add-graph-to-dashboard.md) %}

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

1. [Удалите кластер {{ managed-k8s-name }}](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
1. Если вы зарезервировали для кластера {{ managed-k8s-name }} [публичный статический IP-адрес](../../vpc/concepts/address.md#public-addresses), [удалите его](../../vpc/operations/address-delete.md).
