---
title: Как настроить локационные правила {{ cdn-full-name }}
description: Следуя данной инструкции, вы сможете настроить локационные правила {{ cdn-full-name }} для точечного переопределения настроек CDN-ресурса под определенные запросы.
---

# Настроить локационные правила {{ cdn-full-name }}

{% include [location-rules-disclaimer](../../../_includes/cdn/location-rules-disclaimer.md) %}

{% include [location-rules-description](../../../_includes/cdn/location-rules-description.md) %}

[Подробнее о локационных правилах](../../concepts/location-rules.md)

Чтобы настроить локационное правило:
1. [Создайте](#create) правило.
1. [Задайте](#setup) дополнительные параметры.

## Создать локационное правило {#create}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором расположен ресурс.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.
  1. Нажмите на имя нужного CDN-ресурса.
  1. Выберите вкладку ![image](../../../_assets/console-icons/map-pin-plus.svg) **{{ ui-key.yacloud.cdn.label_locations }}**.
  1. В правом верхнем углу нажмите **{{ ui-key.yacloud.cdn.button_resource-locations-empty-action }}**.
  1. В блоке **{{ ui-key.yacloud.common.overview }}** задайте основные параметры локационного правила:
      * **{{ ui-key.yacloud.common.name }}**.

        В имени правила можно использовать строчные латинские буквы, цифры, подчеркивание, дефис и пробел; максимальная длина — 50 символов.
      * **{{ ui-key.yacloud.cdn.colunm_location-weight }}** — приоритет срабатывания правила. Чем меньше вес правила, тем выше его приоритет в конфигурации ресурса пользователя. Если у нескольких правил будет одинаковый вес, то они будут применяться в произвольном порядке.

        <br>

        {% include [location-rules-weight-example](../../../_includes/cdn/location-rules-weight-example.md) %}

  1. В блоке **{{ ui-key.yacloud.cdn.label_rule-condition-section }}** задайте **{{ ui-key.yacloud.cdn.column_location-rule-pattern }}** — шаблон пути URI, на соответствие которому проверяются запросы. При успешном совпадении применяются настройки, специфичные именно для этого локационного правила.

      {% include [location-rules-pattern-tip](../../../_includes/cdn/location-rules-pattern-tip.md) %}

  1. Задайте настройки CDN-ресурса, которые вы хотите переопределить с помощью локационного правила:
      * **{{ ui-key.yacloud.cdn.label_resource-cache-cdn-cache-enabled }}** — временное хранение копий файлов из источников. Подробнее см. на странице [{#T}](./configure-caching.md).
      * **{{ ui-key.yacloud.cdn.field_rewrite-rule-redirect }}** — перенастройка пути запросов к контенту. Полезно при изменении структуры файлов и папок на источнике. Кроме того, перенаправление запросов можно использовать, если при переезде ресурса на новый адрес вы хотите сохранить ранжирование вашего контента в поисковых системах. Подробнее см. на странице [{#T}](./setup-http-rewrite.md).
      * **{{ ui-key.yacloud.cdn.field_secure-key-enabled }}** — ограничение прямого доступа к контенту. Доступ к файлам будет осуществляться по подписанным ссылкам с ограниченным сроком действия. Подробнее см. на странице [{#T}](./enable-secure-token.md).
      * **{{ ui-key.yacloud.cdn.field_address-acl }}** — ограничение доступа к контенту с помощью разрешающей или блокирующей политики. Подробнее см. на странице [{#T}](./configure-basics.md).

      {% include [location-rules-additional](../../../_includes/cdn/location-rules-additional.md) %}

  1. Нажмите **{{ ui-key.yacloud.common.create }}**.

- API {#api}

  Воспользуйтесь методом REST API [create](../../api-ref/ResourceRules/create.md) для ресурса [ResourceRules](../../api-ref/ResourceRules/index.md) или вызовом gRPC API [ResourceRulesService/Create](../../api-ref/grpc/ResourceRules/create.md).

{% endlist %}

## Задать дополнительные параметры {#setup}

После создания правила вы можете задать для него дополнительные параметры:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором расположен ресурс.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.
  1. Нажмите на имя нужного CDN-ресурса.
  1. Выберите вкладку ![image](../../../_assets/console-icons/map-pin-plus.svg) **{{ ui-key.yacloud.cdn.label_locations }}**.
  1. Нажмите на имя нужного локационного правила.
  1. Задайте дополнительные параметры правила:

      * Чтобы настроить дополнительные параметры кеширования контента, перейдите на вкладку ![image](../../../_assets/console-icons/cloud.svg) **{{ ui-key.yacloud.cdn.label_resource-cache }}** и нажмите ![image](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**. Подробнее см. на странице [{#T}](./configure-caching.md).
      * Чтобы настроить HTTP-заголовки запросов и ответов, CORS при ответах клиентам и разрешенные HTTP-методы запросов от клиентов, перейдите на вкладку ![image](../../../_assets/console-icons/arrow-up-to-line.svg) **{{ ui-key.yacloud.cdn.label_resource-http-headers }}** и нажмите ![image](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**. Подробнее см. на страницах:
          * [{#T}](configure-headers.md)
          * [{#T}](configure-cors.md)
          * [{#T}](configure-http.md)
      * Чтобы настроить сжатие и сегментацию файлов, перейдите на вкладку ![image](../../../_assets/console-icons/box.svg) **{{ ui-key.yacloud.cdn.label_resource-content }}** и нажмите ![image](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**. Подробнее см. на страницах:
          * [{#T}](enable-compression.md)
          * [{#T}](enable-segmentation.md)

      Отредактируйте параметры на нужной вкладке и нажмите **{{ ui-key.yacloud.common.save }}**.

- API {#api}

  Воспользуйтесь методом REST API [update](../../api-ref/ResourceRules/update.md) для ресурса [ResourceRules](../../api-ref/ResourceRules/index.md) или вызовом gRPC API [ResourceRulesService/Update](../../api-ref/grpc/ResourceRules/update.md).

{% endlist %}

### См. также {#see-also}

* [{#T}](../../concepts/location-rules.md)
* [{#T}](./configure-caching.md)
* [{#T}](./setup-http-rewrite.md)
* [{#T}](./enable-secure-token.md)
* [{#T}](./configure-basics.md)