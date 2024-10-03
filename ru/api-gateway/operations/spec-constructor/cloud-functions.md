---
title: Добавить расширение {{ sf-full-name }}
description: Следуя данной инструкции, вы сможете добавить расширение {{ sf-full-name }} с помощью конструктора спецификации.
---

# Добавить расширение x-yc-apigateway-integration:cloud_functions

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создали или хотите создать [API-шлюз](../../concepts/index.md).
    1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
    1. Выберите API-шлюз или нажмите кнопку **{{ ui-key.yacloud.serverless-functions.gateways.list.button_create }}**, чтобы создать новый.
    1. В поле **{{ ui-key.yacloud.serverless-functions.gateways.form.field_spec }}** нажмите значок ![image](../../../_assets/api-gateway/spec-constructor/cloud-functions.svg).
    1. Укажите в поле:

        {% include [common-spec-constructor](../../../_includes/api-gateway/common-spec-constructor.md) %}

        * (Опционально) **Сервисный аккаунт** — сервисный аккаунт для авторизации при обращении к функции. Если у вас нет сервисного аккаунта, [создайте](../../../iam/operations/sa/create.md) его.
        * (Опционально) **Версия формата запроса** — версию формата запроса к функции. Возможные значения — 0.1 и 1.0. Версия по умолчанию — 0.1.
        * **Функция** — имя [функции](../../../functions/concepts/function.md) и [тег версии](../../../functions/concepts/function.md#tag) функции.
    1. (Опционально) Вставьте или загрузите контекст операции — произвольный объект в формате YAML или JSON.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.add }}**.

{% endlist %}

{% include [constructor-result](../../../_includes/api-gateway/constructor-result.md) %}

## См. также {#see-also}

* [Расширение x-yc-apigateway-integration:cloud_functions](../../concepts/extensions/cloud-functions.md)
