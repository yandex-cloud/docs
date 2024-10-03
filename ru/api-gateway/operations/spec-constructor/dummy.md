---
title: Добавить расширение Статический ответ
description: Следуя данной инструкции, вы сможете добавить расширение Статический ответ с помощью конструктора спецификации.
---

# Добавить расширение x-yc-apigateway-integration:dummy

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создали или хотите создать [API-шлюз](../../concepts/index.md).
    1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
    1. Выберите API-шлюз или нажмите кнопку **{{ ui-key.yacloud.serverless-functions.gateways.list.button_create }}**, чтобы создать новый.
    1. В поле **{{ ui-key.yacloud.serverless-functions.gateways.form.field_spec }}** нажмите значок ![image](../../../_assets/api-gateway/spec-constructor/dummy.svg).
    1. Укажите в поле:

        {% include [common-spec-constructor](../../../_includes/api-gateway/common-spec-constructor.md) %}

        * **Код HTTP-ответа** — код HTTP-ответа.
        * (Опционально) **HTTP-заголовки** — cписок заголовков, которые будут отправлены в ответ.
        * **Данные** — данные, которые будут отправлены в ответ.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.add }}**.

{% endlist %}

{% include [constructor-result](../../../_includes/api-gateway/constructor-result.md) %}

## См. также {#see-also}

* [Расширение x-yc-apigateway-integration:dummy](../../concepts/extensions/dummy.md)
