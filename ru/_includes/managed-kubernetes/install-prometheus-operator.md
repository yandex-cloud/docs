Prometheus Operator с поддержкой {{ monitoring-full-name }} упрощает установку и управление системой мониторинга [{{ managed-prometheus-full-name }}](../../monitoring/operations/prometheus/index.md). С помощью нее можно собирать, хранить и читать метрики из контейнеров, приложений и инфраструктуры. Система использует модель данных {{ prometheus-name }} и язык запросов [{{ promql-name }}](https://prometheus.io/docs/prometheus/latest/querying/basics/), что позволяет работать с уже существующими дашбордами в [{{ grafana-name }}](https://grafana.com/grafana/).

## Перед началом работы {#before-you-begin}

1. На [главной странице сервиса]({{ link-monitoring }}) {{ monitoring-full-name }}, на панели слева, выберите **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.prometheus.title }}**.
1. На вкладке **{{ ui-key.yacloud_monitoring.prometheus.approved.tab.write }}** найдите URL-адрес эндпоинта для записи метрик:

   ```text
   https://{{ api-host-monitoring-1 }}/prometheus/workspaces/<идентификатор_Prometheus_Workspace>/api/v1/write
   ```

   Сохраните идентификатор Prometheus Workspace (подстрока вида `mon*****************`), он понадобится для дальнейшей настройки.

1. [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт для работы с Prometheus Operator.
1. [Назначьте](../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту [роль](../../monitoring/security/index.md#monitoring-editor) `monitoring.editor`.
1. [Создайте](../../iam/operations/api-key/create.md) API-ключ для сервисного аккаунта и сохраните его секретную часть.

## Установка с помощью {{ marketplace-full-name }} {#marketplace-install}

1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ managed-k8s-name }}**.
1. Нажмите на имя нужного кластера {{ k8s }} и выберите вкладку ![image](../../_assets/marketplace.svg) **{{ marketplace-short-name }}**.
2. В разделе **Доступные для установки приложения** выберите [Prometheus Operator с поддержкой {{ monitoring-full-name }}](/marketplace/products/yc/prometheus-operator) и нажмите кнопку **Использовать**.
3. Задайте настройки приложения:
   * **Пространство имен** — выберите [пространство имен](../../managed-kubernetes/concepts/index.md#namespace) или создайте новое.
   * **Название приложения** — укажите название приложения.
   * **Workspace ID** — введите идентификатор Prometheus Workspace (`mon*****************`).
   * **API-ключ** — введите секретную часть API-ключа.
4. Нажмите кнопку **Установить**.
5. Дождитесь перехода приложения в статус `Deployed`.

## Установка с помощью Helm-чарта {#helm-install}

1. {% include [Установка Helm](../managed-kubernetes/helm-install.md) %}
1. {% include [Настройка kubectl](../managed-kubernetes/kubectl-install.md) %}
1. Для установки [Helm-чарта](https://helm.sh/docs/topics/charts/) с Prometheus Operator выполните команду:

   ```bash
   export HELM_EXPERIMENTAL_OCI=1 && \
   helm pull oci://{{ mkt-k8s-key.yc_prometheus-operator.helmChart.name }} \
     --version {{ mkt-k8s-key.yc_prometheus-operator.helmChart.tag }} \
     --untar && \
   helm install \
     --namespace <пространство_имен_для_Prometheus_Operator> \
     --create-namespace \
     --set prometheusWorkspaceId=<идентификатор_Prometheus_Workspace> \
     --set apiKeySecret=<секретная_часть_API-ключа> \
     prometheus ./kube-prometheus-stack/
   ```

   Эта команда также создаст новое пространство имен для работы Prometheus Operator.

1. Убедитесь, что поды Prometheus Operator перешли в состояние `Running`:

   ```bash
   kubectl get pods --namespace=<пространство_имен_Prometheus_Operator> \
     | grep prometheus
   ```

## Подключение к дашборду {{ grafana-name }}

Чтобы подключиться к дашборду {{ grafana-name }}:

1. {% include [Настройка kubectl](../managed-kubernetes/kubectl-install.md) %}
1. Получите имя пода с работающим приложением {{ grafana-name }}:

   ```bash
   kubectl get pods --namespace=<пространство_имен_Prometheus_Operator> \
     | grep grafana
   ```

1. Настройте переадресацию порта сервиса `grafana` на локальный компьютер:

   ```bash
   kubectl port-forward --namespace=<пространство_имен_Prometheus_Operator> \
     <имя_пода_{{ grafana-name }}> 8080:3000
   ```

   {% note info %}

   Если закрыть окно терминала или прервать выполнение команды, переадресация порта будет остановлена.

   {% endnote %}

1. Откройте в браузере дашборд {{ grafana-name }} по адресу `http://localhost:8080`.
1. Авторизуйтесь, используя имя пользователя `admin` и пароль `prom-operator`.