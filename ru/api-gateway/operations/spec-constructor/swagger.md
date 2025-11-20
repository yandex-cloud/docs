---
title: Добавить расширение Swagger UI
description: Следуя данной инструкции, вы сможете добавить расширение Swagger UI с помощью конструктора спецификации.
---

# Добавить расширение x-yc-apigateway-integration:swagger

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создали или хотите создать [API-шлюз](../../concepts/index.md).
    1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
    1. Выберите API-шлюз или нажмите кнопку **{{ ui-key.yacloud.serverless-functions.gateways.list.button_create }}**, чтобы создать новый.
    1. В поле **{{ ui-key.yacloud.serverless-functions.gateways.form.field_spec }}** нажмите значок ![swagger](../../../_assets/api-gateway/spec-constructor/swagger.svg) и в открывшемся окне:

        1. В поле **{{ ui-key.yc-serverless-apigw.dynamic-forms.path_name }}** укажите относительный путь к интеграции, который будет добавлен к URL-адресу {{ api-gw-name }}. Переменные указывайте в фигурных скобках, например `/docs/{document_id}`. Подробнее см. спецификацию [OpenAPI 3.0](https://github.com/OAI/OpenAPI-Specification).
        1. Нажмите кнопку **{{ ui-key.yacloud.common.add }}**.

{% endlist %}

{% include [constructor-result](../../../_includes/api-gateway/constructor-result.md) %}

## См. также {#see-also}

* [Расширение x-yc-apigateway-integration:swagger](../../concepts/extensions/swagger.md)