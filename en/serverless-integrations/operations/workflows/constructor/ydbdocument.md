---
title: Adding {{ ydb-name }} interaction to {{ sw-name }}
description: Follow this guide to add interaction with document tables in {{ ydb-full-name }} to {{ sw-full-name }} using the workflow step constructor.
---

# Interacting with document tables in {{ ydb-full-name }}

{% list tabs %}

- Management console {#console}

  1. {% include [integrations-step1](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step1.md) %} 
  1. From the **{{ ui-key.yacloud.serverless-workflows.workflow-editor_integration-group-label }}** section on the left side of the screen, drag the ![ydb-icon](../../../../_assets/ydb-icon.svg) **{{ ydb-name }}** element to desired workflow location in the constructor window.

      {% include [step-drag-destination-desc](../../../../_includes/serverless-integrations/workflows-constructor/step-drag-destination-desc.md) %}
  1. In the workflow schema window, click the **{{ ydb-name }}** section you just added to select it.
  1. {% include [integrations-step-select-settings-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-select-settings-tab.md) %}

      1. {% include [integrations-name-the-step](../../../../_includes/serverless-integrations/workflows-constructor/integrations-name-the-step.md) %}
      1. In the **Database** field, select the database. Only databases created in [Serverless](../../../../ydb/concepts/serverless-and-dedicated.md#serverless) mode are supported.
      1. In the **Table path** field, specify the path to the table the workflow will interact with. Only [document tables](../../../../ydb/concepts/dynamodb-tables.md) are supported.
      1. Under **Action**, select:

          * `Get` to get the contents of an element in the database; in the **Key** field, specify the value of the primary key of the database related to the element in question.
          * `Put` to write data to the table; in the **Attributes** field, specify an associative array of attributes in `key`/`value` format.
          * `Update` to update data in the table. Configure the update options:

              1. In the **Key** field, specify the primary key value of the database element you want to update.
              1. In the **Update expression** field, specify an expression describing the updates of the element's attributes in the database. For details, refer to the `UpdateExpression` parameter information in the relevant [{{ ydb-full-name }} documentation](../../../../ydb/docapi/api-ref/actions/updateItem.md#parametry).
              1. In the **Attribute values** field, specify the attribute values used in the expression above. For details, refer to the `ExpressionAttributeValues` parameter information in the relevant [{{ ydb-full-name }} documentation](../../../../ydb/docapi/api-ref/actions/updateItem.md#parametry).

          * `Scan` to search the database. Configure the search parameters:

              1. In the **Key** field, specify the value of the primary key of the database element the search will start from.
              1. In the **Limit** field, set a limit on the maximum number of elements in the list of results.

      1. {% include [integrations-step-timeout](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-timeout.md) %}
      1. {% include [integrations-step-retry-policy](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-retry-policy.md) %}
  1. {% include [integrations-step-input-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-input-tab.md) %}
  1. {% include [integrations-step-output-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-output-tab.md) %}

{% endlist %}

## See also {#see-also}

* [YaWL specification](../../../concepts/workflows/yawl/integration/ydbdocument.md)
* [{#T}](../workflow/create-constructor.md)
* [{#T}](../workflow/update.md)
