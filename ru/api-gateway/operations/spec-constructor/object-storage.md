---
title: "Добавить расширение {{ objstorage-full-name }}"
description: "Следуя данной инструкции, вы сможете добавить расширение {{ objstorage-full-name }} с помощью конструктора спецификации."
---

# Добавить расширение x-yc-apigateway-integration:object_storage

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создали или хотите создать [API-шлюз](../../concepts/index.md).
    1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
    1. Выберите API-шлюз или нажмите кнопку **{{ ui-key.yacloud.serverless-functions.gateways.list.button_create }}**, чтобы создать новый.
    1. В поле **{{ ui-key.yacloud.serverless-functions.gateways.form.field_spec }}** нажмите значок ![image](../../../_assets/api-gateway/spec-constructor/object-storage.svg).
    1. Укажите в поле:

        {% include [common-spec-constructor](../../../_includes/api-gateway/common-spec-constructor.md) %}

        * (Опционально) **Сервисный аккаунт** — сервисный аккаунт для авторизации при обращении к {{ objstorage-name }}.
        * **Бакет** — имя [бакета](../../../storage/concepts/bucket.md).
        * **Имя объекта** — имя [объекта](../../../storage/concepts/object.md).
        * (Опционально) **Объект ошибки** — имя объекта, который будет возвращаться, если вместо указанного имени объекта получена ошибка с HTTP-кодом 4xx.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.add }}**.

{% endlist %}

{% include [constructor-result](../../../_includes/api-gateway/constructor-result.md) %}

## См. также {#see-also}

* [Расширение x-yc-apigateway-integration:object_storage](../../concepts/extensions/object-storage.md)
