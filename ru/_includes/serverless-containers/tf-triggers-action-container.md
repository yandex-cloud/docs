* `action` — параметры приемника. Блок можно указать несколько раз, чтобы триггер вызывал несколько ресурсов, в том числе разных типов. Максимальное количество ресурсов ограничено [лимитами](../../serverless-containers/concepts/limits.md#serverless-containers-limits).

    * `invoke_container` — параметры контейнера:

        * `container_id` — идентификатор контейнера.
        * `path` — HTTP-путь, по которому будет вызван контейнер. Необязательный параметр.
        * `service_account_id` — идентификатор сервисного аккаунта с правами на вызов контейнера.

    {% include [tf-trigger-params](../functions/tf-trigger-params.md) %}
