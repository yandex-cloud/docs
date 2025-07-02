---
title: Adding the {{ ydb-full-name }} extension
description: Follow this guide to add the {{ ydb-full-name }} extension using the specification constructor.
---

# Adding the x-yc-apigateway-integration:cloud_ydb extenison

{% list tabs %}

- Management console

    1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) in which you created or want to create an [API gateway](../../concepts/index.md).
    1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
    1. Select an API gateway or click **{{ ui-key.yacloud.serverless-functions.gateways.list.button_create }}** to create a new one.
    1. In the **{{ ui-key.yacloud.serverless-functions.gateways.form.field_spec }}** field, click ![image](../../../_assets/api-gateway/spec-constructor/cloud-ydb.svg).
    1. Specify the following in the field:

        {% include [common-spec-constructor](../../../_includes/api-gateway/common-spec-constructor.md) %}

        * **{{ ui-key.yc-serverless-apigw.dynamic-forms.service_account_id_name }}**: Service account for authorization when accessing the [database](../../../ydb/concepts/resources.md#database). If you do not have a service account, [create](../../../iam/operations/sa/create.md) one.
        * **{{ ui-key.yc-serverless-apigw.dynamic-forms.cloud_ydb_database_name }}**: Database name.
        * **{{ ui-key.yc-serverless-apigw.dynamic-forms.cloud_ydb_table_name_name }}**: Name of the table the operation will be performed on.
        * **{{ ui-key.yc-serverless-apigw.dynamic-forms.cloud_ydb_action_title }}**: [Operation type](../../concepts/extensions/ydb.md#podderzhivaemye-operacii) and its relevant parameters:

            * `PutItem`
            * `GetItem`:

                * **{{ ui-key.yc-serverless-apigw.dynamic-forms.cloud_ydb_key_name }}**: Primary key of the element the operation will be performed on.

            * `UpdateItem`:

                * **{{ ui-key.yc-serverless-apigw.dynamic-forms.cloud_ydb_key_name }}**: Primary key of the element the operation will be performed on.
                * **{{ ui-key.yc-serverless-apigw.dynamic-forms.cloud_ydb_update_expression_name }}**: Expression that specifies the attributes to update and how to do it.
                * Optionally, **{{ ui-key.yc-serverless-apigw.dynamic-forms.cloud_ydb_expression_attribute_values_name }}**: Alias that can be used in the update expression instead of the attribute value. It must start with a colon (`:`).

            * `DeleteItem`:

                * **{{ ui-key.yc-serverless-apigw.dynamic-forms.cloud_ydb_key_name }}**: Primary key of the element the operation will be performed on.

            * `Scan`:

                * Optionally, **{{ ui-key.yc-serverless-apigw.dynamic-forms.cloud_ydb_limit_name }}**: Maximum number of elements read.
                * Optionally, **{{ ui-key.yc-serverless-apigw.dynamic-forms.cloud_ydb_exclusive_start_key_name }}**: Primary key of the element the search should start from.

    1. Click **{{ ui-key.yacloud.common.add }}**.

{% endlist %}

{% include [constructor-result](../../../_includes/api-gateway/constructor-result.md) %}

## See also {#see-also}

* [x-yc-apigateway-integration:cloud_ydb extension](../../concepts/extensions/ydb.md)
