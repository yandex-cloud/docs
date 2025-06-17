---
title: Добавить расширение {{ message-queue-full-name }}
description: Следуя данной инструкции, вы сможете добавить расширение {{ message-queue-full-name }} с помощью конструктора спецификации.
---

# Добавить расширение x-yc-apigateway-integration:cloud_ymq

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создали или хотите создать [API-шлюз](../../concepts/index.md).
    1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
    1. Выберите API-шлюз или нажмите кнопку **{{ ui-key.yacloud.serverless-functions.gateways.list.button_create }}**, чтобы создать новый.
    1. В поле **{{ ui-key.yacloud.serverless-functions.gateways.form.field_spec }}** нажмите значок ![image](../../../_assets/api-gateway/spec-constructor/cloud-ymq.svg).
    1. Укажите в поле:

        {% include [common-spec-constructor](../../../_includes/api-gateway/common-spec-constructor.md) %}

        * **{{ ui-key.yc-serverless-apigw.dynamic-forms.service_account_id_name }}** — сервисный аккаунт для авторизации при обращении к [очереди сообщений](../../../message-queue/concepts/queue.md). Если у вас нет сервисного аккаунта, [создайте](../../../iam/operations/sa/create.md) его.
        * **{{ ui-key.yc-serverless-apigw.dynamic-forms.cloud_ymq_info }}** — каталог, в котором находится очередь сообщений, и имя очереди сообщений.
        * (Опционально) **{{ ui-key.yc-serverless-apigw.dynamic-forms.cloud_ymq_payload_format_type_name }}** — тип содержимого сообщения. Если значение — `body`, в очередь записывается только тело запроса, если `request` — весь запрос в формате JSON. Значение по умолчанию — `body`.
        * (Опционально) **{{ ui-key.yc-serverless-apigw.dynamic-forms.cloud_ymq_delay_seconds_name }}** — время в секундах, на которое сообщение будет скрыто после отправки в очередь.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.add }}**.

{% endlist %}

{% include [constructor-result](../../../_includes/api-gateway/constructor-result.md) %}

## См. также {#see-also}

* [Расширение x-yc-apigateway-integration:cloud_ymq](../../concepts/extensions/ymq.md)
