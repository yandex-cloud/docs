---
title: Как настроить HTTP-ответ в {{ cdn-full-name }}
description: Следуя данной инструкции, вы сможете настроить HTTP-ответ.
---

# Настройка HTTP-ответов

CDN-ресурс может возвращать определенный код HTTP и содержимое вместо стандартного ответа на все запросы.

Настройка HTTP-ответов работает как глобально, так и для определенного URI в [локационных правилах](../../concepts/location-rules.md).

## Настроить перенаправление {#redirect}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором расположен ресурс.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.
  1. Нажмите на имя необходимого ресурса.
  1. Перейдите на вкладку **{{ ui-key.yacloud.cdn.label_resource-http-headers }}**.
  1. В правом верхнем углу нажмите кнопку ![image](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. В блоке **{{ ui-key.yacloud.cdn.sections.StaticResponseSection.section_static-response_hGcUL }}** включите опцию **{{ ui-key.yacloud.cdn.sections.StaticResponseSection.field_static-response-enabled_sPsQU }}**.
  1. В поле **{{ ui-key.yacloud.cdn.sections.StaticResponseSection.field_static-response-type_5KyYv }}** выберите `{{ ui-key.yacloud.cdn.sections.StaticResponseSection.option_static-response_redirect_o58we }}`.
  1. Укажите код ответа.

      {% include [redirect-codes](../../../_includes/cdn/static-response/redirect-codes.md) %}

  1. Укажите URL, на который нужно перенаправлять запросы пользователей.
  1. Нажмите **{{ ui-key.yacloud.common.save }}**.

- REST API {#rest-api}

  Чтобы включить опцию, добавьте блок `staticResponse` при использовании метода [create](../../api-ref/Resource/create.md) или [update](../../api-ref/Resource/update.md) для ресурса [Resource](../../api-ref/Resource/index.md):

  ```json
  "staticResponse": {
    "enabled": "<true_или_false>",
    "code": "string",
    "content": "string"
  }
  ```

  Где:

  * `enabled` — включение опции:
      * `true` — включить опцию.
      * `false` — отключить опцию.

  * `code` — код ответа.

      {% include [redirect-codes](../../../_includes/cdn/static-response/redirect-codes.md) %}

  * `content` — URL, на который нужно перенаправлять запросы пользователей.

- gRPC API {#grpc-api}

  Чтобы включить опцию, добавьте блок `static_response` при использовании вызова [ResourceService/Create](../../api-ref/grpc/Resource/create.md) или [ResourceService/Update](../../api-ref/grpc/Resource/update.md):

  ```json
  "static_response": {
    "enabled": "<true_или_false>",
    "code": "string",
    "content": "string"
  }
  ```

  Где:

  * `enabled` — включение опции:
      * `true` — включить опцию.
      * `false` — отключить опцию.

  * `code` — код ответа.

      {% include [redirect-codes](../../../_includes/cdn/static-response/redirect-codes.md) %}

  * `content` — URL, на который нужно перенаправлять запросы пользователей.

{% endlist %}

{% include [after-changes-tip](../../../_includes/cdn/after-changes-tip.md) %}


## Задать содержимое ответа {#content}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором расположен ресурс.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.
  1. Нажмите на имя необходимого ресурса.
  1. Перейдите на вкладку **{{ ui-key.yacloud.cdn.label_resource-http-headers }}**.
  1. В правом верхнем углу нажмите кнопку ![image](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. В блоке **{{ ui-key.yacloud.cdn.sections.StaticResponseSection.section_static-response_hGcUL }}** включите опцию **{{ ui-key.yacloud.cdn.sections.StaticResponseSection.field_static-response-enabled_sPsQU }}**.
  1. В поле **{{ ui-key.yacloud.cdn.sections.StaticResponseSection.field_static-response-type_5KyYv }}** выберите `{{ ui-key.yacloud.cdn.sections.StaticResponseSection.option_static-response_data_rLo9U }}`.
  1. Укажите код ответа.

      {% include [content-codes](../../../_includes/cdn/static-response/content-codes.md) %}

  1. Укажите JSON, HTML или простой текст, который нужно вернуть клиенту в теле ответа.
  1. Нажмите **{{ ui-key.yacloud.common.save }}**.

- REST API {#rest-api}

  Чтобы включить опцию, добавьте блок `staticResponse` при использовании метода [create](../../api-ref/Resource/create.md) или [update](../../api-ref/Resource/update.md) для ресурса [Resource](../../api-ref/Resource/index.md):

  ```json
  "staticResponse": {
    "enabled": "<true_или_false>",
    "code": "string",
    "content": "string"
  }
  ```

  Где:

  * `enabled` — включение опции:
      * `true` — включить опцию.
      * `false` — отключить опцию.

  * `code` — код ответа.

      {% include [content-codes](../../../_includes/cdn/static-response/content-codes.md) %}

  * `content` — JSON, HTML или простой текст, который нужно вернуть клиенту в теле ответа.

- gRPC API {#grpc-api}

  Чтобы включить опцию, добавьте блок `static_response` при использовании вызова [ResourceService/Create](../../api-ref/grpc/Resource/create.md) или [ResourceService/Update](../../api-ref/grpc/Resource/update.md):

  ```json
  "static_response": {
    "enabled": "<true_или_false>",
    "code": "string",
    "content": "string"
  }
  ```

  Где:

  * `enabled` — включение опции:
      * `true` — включить опцию.
      * `false` — отключить опцию.

  * `code` — код ответа.

      {% include [content-codes](../../../_includes/cdn/static-response/content-codes.md) %}

  * `content` — JSON, HTML или простой текст, который нужно вернуть клиенту в теле ответа.

{% endlist %}

{% include [after-changes-tip](../../../_includes/cdn/after-changes-tip.md) %}