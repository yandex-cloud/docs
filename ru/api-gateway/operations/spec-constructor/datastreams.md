---
title: Добавить расширение {{ yds-full-name }}
description: Следуя данной инструкции, вы сможете добавить расширение {{ yds-full-name }} с помощью конструктора спецификации.
---

# Добавить расширение x-yc-apigateway-integration:cloud_datastreams

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создали или хотите создать [API-шлюз](../../concepts/index.md).
    1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
    1. Выберите API-шлюз или нажмите кнопку **{{ ui-key.yacloud.serverless-functions.gateways.list.button_create }}**, чтобы создать новый.
    1. В поле **{{ ui-key.yacloud.serverless-functions.gateways.form.field_spec }}** нажмите значок ![image](../../../_assets/api-gateway/spec-constructor/cloud-datastreams.svg).
    1. Укажите в поле:

        {% include [common-spec-constructor](../../../_includes/api-gateway/common-spec-constructor.md) %}

        * (Опционально) **Сервисный аккаунт** — сервисный аккаунт для авторизации при выполнении операции с [потоком](../../../data-streams/concepts/glossary.md#stream-concepts) {{ yds-name }}. Если у вас нет сервисного аккаунта, [создайте](../../../iam/operations/sa/create.md) его.
        * **Операция** — выполняемую операцию.
        * **Имя потока {{ yds-name }}** — имя потока данных {{ yds-name }}.
        * (Опционально) **Тип содержимого записи** — тип содержимого записи. Если значение — `body`, в поток записывается только тело запроса, если `request` — весь запрос в формате JSON. Значение по умолчанию — `body`.
        * (Опционально) **Ключ сегмента** — [ключ сегмента](../../../data-streams/concepts/partition-keys.md). Если не указан, запись выполняется в случайный сегмент.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.add }}**.

{% endlist %}

{% include [constructor-result](../../../_includes/api-gateway/constructor-result.md) %}

## См. также {#see-also}

* [Расширение x-yc-apigateway-integration:cloud_datastreams](../../concepts/extensions/datastreams.md)
