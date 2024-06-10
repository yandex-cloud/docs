{{ prometheus-name }} Operator с поддержкой {{ monitoring-full-name }} упрощает установку и управление системой мониторинга [{{ managed-prometheus-full-name }}](../../monitoring/operations/prometheus/index.md). С помощью нее можно собирать, хранить и читать метрики из контейнеров, приложений и инфраструктуры. Система использует модель данных {{ prometheus-name }} и язык запросов [{{ promql-name }}](https://prometheus.io/docs/prometheus/latest/querying/basics/), что позволяет работать с уже существующими дашбордами в [{{ grafana-name }}](https://grafana.com/grafana/).

## Перед началом работы {#before-you-begin}

1. {% include [check-sg-prerequsites](./security-groups/check-sg-prerequsites-lvl3.md) %}

   {% include [sg-common-warning](./security-groups/sg-common-warning.md) %}

1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) с ролью [monitoring.editor](../../monitoring/security/index.md#monitoring-editor).
1. [Создайте API-ключ](../../iam/operations/api-key/create.md) для сервисного аккаунта:

   * Если установка {{ prometheus-name }} Operator будет выполняться с помощью [{{ marketplace-full-name }}](#marketplace-install), создайте API-ключ в формате JSON и сохраните его в файл `sa-key.json`:

      ```bash
      yc iam api-key create \
         --service-account-name=<имя_сервисного_аккаунта> \
         --format=json > sa-key.json
      ```

   * Если установка {{ prometheus-name }} Operator будет выполняться с помощью [Helm-чарта](#helm-install), выполните команду и сохраните полученный секретный ключ (`secret`):

      ```bash
      yc iam api-key create --service-account-name=<имя_сервисного_аккаунта>
      ```

1. {% include [Настройка kubectl](../managed-kubernetes/kubectl-install.md) %}

## Установка с помощью {{ marketplace-full-name }} {#marketplace-install}

1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
1. Нажмите на имя нужного кластера {{ k8s }} и выберите вкладку ![image](../../_assets/marketplace.svg) **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}**.
1. В разделе **{{ ui-key.yacloud.marketplace-v2.label_available-products }}** выберите [{{ prometheus-name }} Operator с поддержкой {{ monitoring-full-name }}](/marketplace/products/yc/prometheus-operator) и нажмите кнопку **{{ ui-key.yacloud.marketplace-v2.button_k8s-product-use }}**.
1. Задайте настройки приложения:
   * **Пространство имен** — выберите [пространство имен](../../managed-kubernetes/concepts/index.md#namespace) или создайте новое.
   * **Название приложения** — укажите название приложения.
   * **{{ prometheus-name }} Workspace** — выберите нужный воркспейс {{ prometheus-name }}.
   * **API-ключ** — укажите содержимое файла `sa-key.json`, полученного ранее.
1. Нажмите кнопку **Установить**.
1. Дождитесь перехода приложения в статус `Deployed`.

## Установка с помощью Helm-чарта {#helm-install}

1. {% include [Установка Helm](../managed-kubernetes/helm-install.md) %}
1. Получите идентификатор воркспейса {{ prometheus-name }}, он понадобится для дальнейшей настройки:

   1. На [главной странице сервиса]({{ link-monitoring }}) {{ monitoring-full-name }}, на панели слева, выберите **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.prometheus.title }}**.
   1. Перейдите на страницу нужного воркспейса. На ней отображается его идентификатор.

1. Для установки [Helm-чарта](https://helm.sh/docs/topics/charts/) с {{ prometheus-name }} Operator выполните команду:

   ```bash
   export HELM_EXPERIMENTAL_OCI=1 && \
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

1. Убедитесь, что поды {{ prometheus-name }} Operator перешли в состояние `Running`:

   ```bash
   kubectl get pods --namespace=<пространство_имен_для_{{ prometheus-name }}_Operator> \
      -l "release=prometheus"
   ```

## Подключение к дашборду {{ grafana-name }}

Чтобы подключиться к дашборду {{ grafana-name }}:

1. Получите имя пода с работающим приложением {{ grafana-name }}:

   ```bash
   kubectl get pods --namespace=<пространство_имен_{{ prometheus-name }}_Operator> \
     | grep grafana
   ```

1. Настройте переадресацию порта сервиса `grafana` на локальный компьютер:

   ```bash
   kubectl port-forward --namespace=<пространство_имен_{{ prometheus-name }}_Operator> \
     <имя_пода_{{ grafana-name }}> 8080:3000
   ```

   {% note info %}

   Если закрыть окно терминала или прервать выполнение команды, переадресация порта будет остановлена.

   {% endnote %}

1. Откройте в браузере дашборд {{ grafana-name }} по адресу `http://localhost:8080`.
1. Авторизуйтесь с логином `admin` и паролем `prom-operator`.
