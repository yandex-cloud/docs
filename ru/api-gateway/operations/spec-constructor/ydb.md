---
title: "Добавить расширение {{ ydb-full-name }}"
description: "Следуя данной инструкции, вы сможете добавить расширение {{ ydb-full-name }} с помощью конструктора спецификации."
---

# Добавить расширение x-yc-apigateway-integration:cloud_ydb

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создали или хотите создать [API-шлюз](../../concepts/index.md).
    1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
    1. Выберите API-шлюз или нажмите кнопку **{{ ui-key.yacloud.serverless-functions.gateways.list.button_create }}**, чтобы создать новый.
    1. В поле **{{ ui-key.yacloud.serverless-functions.gateways.form.field_spec }}** нажмите значок ![image](../../../_assets/api-gateway/spec-constructor/cloud-ydb.svg).
    1. Укажите в поле:

        {% include [common-spec-constructor](../../../_includes/api-gateway/common-spec-constructor.md) %}

        * **Сервисный аккаунт** — сервисный аккаунт для авторизации при обращении к [базе данных](../../../ydb/concepts/resources.md#database). Если у вас нет сервисного аккаунта, [создайте](../../../iam/operations/sa/create.md) его.
        * **База данных** — имя базы данных.
        * **Таблица** — название таблицы, с которой будет выполняться операция.
        * **Операция** — [тип операции](../../concepts/extensions/ydb.md#podderzhivaemye-operacii) и параметры, соответствующие этому типу операции:

            * `PutItem`.
            * `GetItem`:

                * **Ключ** — первичный ключ элемента, с которым будет выполняться операция.

            * `UpdateItem`:

                * **Ключ** — первичный ключ элемента, с которым будет выполняться операция.
                * **Выражение для обновления** — выражение, которое будет определять, как и какие атрибуты нужно обновить.
                * (Опционально) **Алиас** — алиас, который можно использовать в выражении для обновления вместо значения атрибута. Алиас должен начинаться с символа двоеточия `:`.

            * `DeleteItem`:

                * **Ключ** — первичный ключ элемента, с которым будет выполняться операция.

            * `Scan`:

                * (Опционально) **Лимит** — максимальное количество прочитанных элементов.
                * (Опционально) **Первичный ключ элемента** — первичный ключ элемента, с которого должен начинаться поиск.

    1. Нажмите кнопку **{{ ui-key.yacloud.common.add }}**.

{% endlist %}

{% include [constructor-result](../../../_includes/api-gateway/constructor-result.md) %}

## См. также {#see-also}

* [Расширение x-yc-apigateway-integration:cloud_ydb](../../concepts/extensions/ydb.md)
