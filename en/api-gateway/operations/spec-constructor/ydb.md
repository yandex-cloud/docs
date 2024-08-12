---
title: "Adding the {{ ydb-full-name }} extension"
description: "Follow this guide to add the {{ ydb-full-name }} extension using the specification constructor."
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

      * **Service account**: Service account for authorization when accessing the [database](../../../ydb/concepts/resources.md#database). If you do not have a service account, [create](../../../iam/operations/sa/create.md) one.
      * **Database**: Database name.
      * **Table**: Name of the table the operation will be performed on.
      * **Operation**: [Operation type](../../concepts/extensions/ydb.md#podderzhivaemye-operacii) and its respective parameters:

         * `PutItem`
         * `GetItem`:

            * **Key**: Primary key of the element the operation will be performed on.

         * `UpdateItem`:

            * **Key**: Primary key of the element the operation will be performed on.
            * **Update expression**: Expression that will define which attributes must be updated and how.
            * (Optional) **Alias**: Alias that can be used in the update expression instead of the attribute value. It must start with a colon `:`.

         * `DeleteItem`:

            * **Key**: Primary key of the element the operation will be performed on.

         * `Scan`:

            * (Optional) **Limit**: Maximum number of read elements.
            * (Optional) **Element primary key**: Primary key of the element to start the search.

   1. Click **{{ ui-key.yacloud.common.add }}**.

{% endlist %}

{% include [constructor-result](../../../_includes/api-gateway/constructor-result.md) %}

## See also {#see-also}

* [x-yc-apigateway-integration:cloud_ydb extension](../../concepts/extensions/ydb.md)
