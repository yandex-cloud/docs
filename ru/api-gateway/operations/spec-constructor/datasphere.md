---
title: Добавить расширение {{ ml-platform-full-name }}
description: Следуя данной инструкции, вы сможете добавить расширение {{ ml-platform-full-name }} с помощью конструктора спецификации.
---

# Добавить расширение x-yc-apigateway-integration:cloud_datasphere

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создали или хотите создать [API-шлюз](../../concepts/index.md).
    1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
    1. Выберите API-шлюз или нажмите кнопку **{{ ui-key.yacloud.serverless-functions.gateways.list.button_create }}**, чтобы создать новый.
    1. В поле **{{ ui-key.yacloud.serverless-functions.gateways.form.field_spec }}** нажмите значок ![image](../../../_assets/api-gateway/spec-constructor/cloud-datasphere.svg).
    1. Укажите в поле:

        {% include [common-spec-constructor](../../../_includes/api-gateway/common-spec-constructor.md) %}

        * (Опционально) **{{ ui-key.yc-serverless-apigw.dynamic-forms.service_account_id_name }}** — сервисный аккаунт для авторизации при вызове [ноды](../../../datasphere/concepts/deploy/index.md#node) {{ ml-platform-name }}. Если у вас нет сервисного аккаунта, [создайте](../../../iam/operations/sa/create.md) его.
        * **{{ ui-key.yc-serverless-apigw.dynamic-forms.cloud_datasphere_folder_id_name }}** — каталог, в котором создан [проект](../../../datasphere/concepts/project.md) {{ ml-platform-name }} и развернута нода.
        * **{{ ui-key.yc-serverless-apigw.dynamic-forms.cloud_datasphere_node_id_name }}** — идентификатор ноды {{ ml-platform-name }}.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.add }}**.

{% endlist %}

{% include [constructor-result](../../../_includes/api-gateway/constructor-result.md) %}

## См. также {#see-also}

* [Расширение x-yc-apigateway-integration:cloud_datasphere](../../concepts/extensions/datasphere.md)
