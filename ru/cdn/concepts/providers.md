---
noIndex: true
---

# Провайдеры CDN

В {{ cdn-full-name }} поддерживаются следующие провайдеры сети распространения контента:
* [EdgeCDN](https://edgecenter.ru/cdn) на базе внешней инфраструктуры партнера EdgeЦентр. Используется по умолчанию.
* [{{ cdn-full-name }}](#yc-cdn) на основе собственных технологий Яндекса. 

Функциональность провайдеров идентична. Для управления ресурсами и источниками CDN используются единые для обоих провайдеров интерфейсы: [консоль управления]({{ link-console-main }}), [CLI](../cli-ref/index.md), [{{ TF }}](../tf-ref.md) и [API](../api-ref/authentication.md).

Отличаются метрики, передаваемые провайдерами в сервис [{{ monitoring-full-name }}](../../monitoring/):
* [метрики провайдера EdgeCDN](../metrics.md)
* [метрики провайдера {{ cdn-full-name }}](../metrics-yc.md)

Соответственно, отличаются дашборды {{ monitoring-name }}. Подробнее на странице [{#T}](../operations/resources/get-stats.md).

## Провайдер {{ cdn-full-name }} {#yc-cdn} 

{% note info %}

До 1 августа 2025 года функциональность провайдера {{ cdn-full-name }} находится на [стадии Preview](../../overview/concepts/launch-stages.md) и не тарифицируется. Доступ осуществляется по запросу.

{% endnote %}

С помощью провайдера {{ cdn-full-name }} вы можете использовать для распространения контента развитую инфраструктуру Яндекса.

### Подключиться к провайдеру {{ cdn-full-name }} {#connect-to-yc-cdn}

1. Если вы ранее уже активировали в своем каталоге провайдер EdgeCDN, [создайте](../../resource-manager/operations/folder/create.md) новый каталог.

    {% note info %}

    В одном каталоге можно использовать только один провайдер. При подключении к провайдеру для каталога генерируется уникальное значение `cname`, которое необходимо для создания [ресурсных записей](../../dns/concepts/resource-record.md#cname) CNAME на CDN-ресурсы.

    {% endnote %}

1. Подключитесь к провайдеру:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления]({{ link-console-main }}) выберите каталог, который нужно подключить к CDN-провайдеру.
      1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.
      1. Нажмите кнопку **{{ ui-key.yacloud.cdn.label_activate-provider-empty-container_action-text }}**.
      1. В выпадающем списке выберите **{{ cdn-full-name }}**.

          Если кнопки **{{ ui-key.yacloud.cdn.label_activate-provider-empty-container_action-text }}** нет и вам доступно создание ресурсов и групп источников, — провайдер уже активирован.

    - CLI {#cli}

      {% include [include](../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
      Выполните команду:

      ```bash
      yc cdn provider activate --type ourcdn
      ```

    - API {#api}

      Чтобы подключиться к провайдеру, воспользуйтесь методом REST API [activate](../../cdn/api-ref/Provider/activate.md) для ресурса [Provider](../../cdn/api-ref/Provider/index.md) или вызовом gRPC API [ProviderService/Activate](../../cdn/api-ref/grpc/Provider/activate.md).

      В теле запроса передайте:

      ```json
      {
        "folderId": "<идентификатор_каталога>",
        "providerType": "ourcdn"
      }
      ```

    {% endlist %}

#### См. также {#see-also}

* [{#T}](../quickstart.md)
* [{#T}](./index.md)