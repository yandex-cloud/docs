[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud CDN](../../index.md) > [Пошаговые инструкции](../index.md) > Ресурсы > Настроить HTTP-ответ

# Настройка HTTP-ответов

CDN-ресурс может возвращать определенный код HTTP и содержимое вместо стандартного ответа на все запросы.

Настройка HTTP-ответов работает как глобально, так и для определенного URI в [локационных правилах](../../concepts/location-rules.md).

## Настроить перенаправление {#redirect}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором расположен ресурс.
  1. Перейдите в сервис **Cloud CDN**.
  1. Нажмите на имя необходимого ресурса.
  1. Перейдите на вкладку **HTTP-заголовки и методы**.
  1. В правом верхнем углу нажмите кнопку ![image](../../../_assets/console-icons/pencil.svg) **Редактировать**.
  1. В блоке **Настройки ответа** включите опцию **Настраиваемый HTTP-ответ**.
  1. В поле **Тип ответа** выберите `Настроить перенаправление`.
  1. Укажите код ответа.

      Поддерживаются коды `301`, `302`, `303`, `307` и `308`.

  1. Укажите URL, на который нужно перенаправлять запросы пользователей.
  1. Нажмите **Сохранить**.

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

      Поддерживаются коды `301`, `302`, `303`, `307` и `308`.

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

      Поддерживаются коды `301`, `302`, `303`, `307` и `308`.

  * `content` — URL, на который нужно перенаправлять запросы пользователей.

{% endlist %}

Чтобы новые настройки существующего ресурса применились к CDN-серверам, может потребоваться до 15 минут. После этого рекомендуется [очистить кеш ресурса](purge-cache.md).


## Задать содержимое ответа {#content}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором расположен ресурс.
  1. Перейдите в сервис **Cloud CDN**.
  1. Нажмите на имя необходимого ресурса.
  1. Перейдите на вкладку **HTTP-заголовки и методы**.
  1. В правом верхнем углу нажмите кнопку ![image](../../../_assets/console-icons/pencil.svg) **Редактировать**.
  1. В блоке **Настройки ответа** включите опцию **Настраиваемый HTTP-ответ**.
  1. В поле **Тип ответа** выберите `Задать содержимое ответа`.
  1. Укажите код ответа.

      Поддерживаются коды из списка [HTTP Status Code Registry](https://www.iana.org/assignments/http-status-codes/http-status-codes.xhtml), кроме тех кодов, у которых в описании указано `Unassigned`.

  1. Укажите JSON, HTML или простой текст, который нужно вернуть клиенту в теле ответа.
  1. Нажмите **Сохранить**.

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

      Поддерживаются коды из списка [HTTP Status Code Registry](https://www.iana.org/assignments/http-status-codes/http-status-codes.xhtml), кроме тех кодов, у которых в описании указано `Unassigned`.

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

      Поддерживаются коды из списка [HTTP Status Code Registry](https://www.iana.org/assignments/http-status-codes/http-status-codes.xhtml), кроме тех кодов, у которых в описании указано `Unassigned`.

  * `content` — JSON, HTML или простой текст, который нужно вернуть клиенту в теле ответа.

{% endlist %}

Чтобы новые настройки существующего ресурса применились к CDN-серверам, может потребоваться до 15 минут. После этого рекомендуется [очистить кеш ресурса](purge-cache.md).