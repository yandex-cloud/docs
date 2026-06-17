# Настройка демо-приложения и сбор телеметрии в Kubernetes

Вы настроите демо-приложение в кластере Kubernetes и передадите телеметрию приложения в Monium. В инструкции для разворачивания кластера используется сервис Managed Service for Kubernetes, но вы можете использовать любой ваш кластер Kubernetes.

## Перед началом работы {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).

### Необходимые платные ресурсы {#paid-resources}

В стоимость ресурсов для работы с Monium входит:
* Плата за использование [мастера Managed Service for Kubernetes](../../managed-kubernetes/concepts/index.md#master) ([тарифы Managed Service for Kubernetes](../../managed-kubernetes/pricing.md)).
* Плата за [вычислительные ресурсы](../../compute/concepts/vm-platforms.md) и [диски](../../compute/concepts/disk.md) [группы узлов Managed Service for Kubernetes](../../managed-kubernetes/concepts/index.md#node-group) ([тарифы Yandex Compute Cloud](../../compute/pricing.md)).
* Плата за использование Monium ([тарифы Monium](../pricing.md)).

## Настройка кластера {#preparation}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Создайте кластер [Kubernetes](../../managed-kubernetes/quickstart.md).

  1. [Установите менеджер пакетов Helm](https://helm.sh/ru/docs/intro/install/) версии не ниже 3.8.0.

  1. [Установите kubectl](https://kubernetes.io/ru/docs/tasks/tools/install-kubectl) и [настройте его на работу с созданным кластером](../../managed-kubernetes/operations/connect/index.md#kubectl-connect).

  1. Добавьте репозиторий Helm-чартов OpenTelemetry:
      
      ```bash
      helm repo add open-telemetry https://open-telemetry.github.io/opentelemetry-helm-charts
      helm repo update
      ```

      Из этого репозитория будет установлен агент OpenTelemetry Collector для сборки телеметрии из приложений в кластере Kubernetes и демо-приложение OpenTelemetry Demo — интернет-магазин.

  1. Создайте [сервисный аккаунт](../../iam/operations/sa/create.md) с ролью `monium.telemetry.writer` и [API-ключ](../../iam/operations/authentication/manage-api-keys.md) с областью действия `yc.monium.telemetry.write`.

  1. Добавьте API-ключ в секреты кластера:
      
      ```bash
      export NS=default
      kubectl -n $NS create secret generic monium-secrets \
      --from-literal=MONIUM_API_KEY='<API-ключ>'
      ```

{% endlist %}

## Поставка и просмотр телеметрии {#view-telemetry}

1. Создайте файл со следующей конфигурацией `otel-demo-monium.yml`:

    ```yaml
    # https://github.com/open-telemetry/opentelemetry-helm-charts/blob/main/charts/opentelemetry-demo/README.md
    opentelemetry-collector:
    extraEnvsFrom:
        - secretRef:
            name: monium-secrets

    config:
        receivers:
        # Сбор метрик grafana, по умолчанию не настроено в демо-приложении
        prometheus:
            config:
            scrape_configs:
                - job_name: "grafana"
                kubernetes_sd_configs:
                    - role: pod
                relabel_configs:
                    # Фильтр по метке (оставляем только grafana)
                    - source_labels: [__meta_kubernetes_pod_label_app_kubernetes_io_name]
                    action: keep
                    regex: grafana

                    # Заменяем адрес на IP пода и порт 3000
                    - source_labels: [__address__]
                    action: replace
                    regex: "([^:]+)(?::\\d+)?"
                    replacement: "$1:3000"
                    target_label: __address__

                    # Указываем путь к метрикам
                    - action: replace
                    target_label: __metrics_path__
                    replacement: /grafana/metrics

        exporters:
        debug:
            verbosity: detailed

        otlp/monium:
            compression: none
            endpoint: ingest.monium.yandex.cloud:443
            headers:
            Authorization: "Api-Key ${env:MONIUM_API_KEY}"
            x-monium-project: folder__<идентификатор_каталога>

        service:
        extensions: [health_check]
        pipelines:
            traces:
            receivers: [otlp]
            exporters: [otlp, spanmetrics, otlp/monium]

            logs:
            receivers: [otlp]
            exporters: [opensearch, otlp/monium]

            metrics:
            receivers: [httpcheck/frontend-proxy, otlp, prometheus, redis, spanmetrics]
            exporters: [otlphttp/prometheus, otlp/monium]

        telemetry:
            resource:
            service: otel-collector
            metrics:
            level: detailed
            readers:
                - periodic:
                    exporter:
                    otlp:
                        endpoint: ${env:MY_POD_IP}:4317
                        protocol: grpc
                    interval: 10000
                    timeout: 5000
    ```

1. Установите демо-приложение с поставкой логов, метрик и трейсов в Monium:

    ```bash
    helm uninstall otel-demo-monium -n $NS --ignore-not-found
    helm install otel-demo-monium open-telemetry/opentelemetry-demo \
    --version 0.37 \
    -n $NS \
    --values otel-demo-monium.yml
    ```
1. Создайте трафик, чтобы отправлять телеметрию.

     1. Настройте проброс портов для сервиса `frontend-proxy`:

        ```bash
        kubectl --namespace default port-forward svc/frontend-proxy 8080:8080
        ```
     1. В браузере откройте интернет-магазин по адресу `http://localhost:8080/` и совершайте действия пользователя. Например, добавьте товар в корзину.

## Посмотрите данные телеметрии {#view-telemetry}

{% list tabs group=instructions %}

- Интерфейс Monium {#console}

  1. На главной странице [Monium](https://monium.yandex.cloud) слева выберите **Шарды**.
  1. В списке выберите шард с названием сервиса, который работает внутри интернет-магазина. Например, `cart` или `product-catalog`.

     Имя шарда формируется как `<имя_проекта>_<имя_кластера>_<имя_сервиса>`, например `folder__b1g86q4m5vej********_default_cart`.
  
  1. Чтобы посмотреть отдельный тип данных, слева выберите:

     * **Метрики**.
       
       В строке запроса последовательно выберите:
             * `project=folder__<идентификатор_каталога>`; 
             * `cluster=default`, 
             * `service=cart` 
             * и нажмите **Выполнить запрос**.

       {% cut "Пример графика с метриками" %}
       
       ![image](../../_assets/monium/shop-metrics.png)
       
       {% endcut %}

       Подробнее о [работе с метриками](../metrics/metric-explorer.md).

     * **Логи**.
     
       В строке запроса последовательно выберите `project`, `cluster`, `service` и нажмите **Выполнить запрос**.

       {% cut "Пример страницы с логами" %}
       
       ![image](../../_assets/monium/shop-logs.png)
       
       {% endcut %}

       Подробнее о [работе с логами](../logs/quickstart-resources.md).
     
     * **Трейсы**.

       В строке запроса последовательно выберите `project` и `service` и нажмите **Выполнить**.

       {% cut "Пример страницы с трейсами" %}
       
       ![image](../../_assets/monium/shop-traces.png)
       
       {% endcut %}

       Подробнее о [работе с трейсами](../traces/operations/traces-explorer.md).

{% endlist %}

Для использования данных телеметрии создайте [дашборд](../operations/dashboard/create.md) и [алерты](../operations/alert/create-alert.md).

## Если телеметрия не отображается в Monium {#troubleshooting}

* [Убедитесь](#preparation), что сервисный аккаунт и API-ключ имеют нужные роли и области действия.

* Проверьте, что в секретах указан верный API-ключ:

    ```bash
    kubectl get secret monium-secrets -n $NS -o jsonpath='{.data.MONIUM_API_KEY}' | base64 -d
    ```

* Проверьте логи OTel Collector:

    ```bash
    kubectl logs -l app.kubernetes.io/name=opentelemetry-collector -n $NS
    ```

* Убедитесь, что эндпоинт Monium доступен:

    ```bash
    kubectl run -it --rm debug --image=curlimages/curl --restart=Never -- \
    curl -v https://ingest.monium.yandex.cloud
    ```