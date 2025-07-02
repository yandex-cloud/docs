---
title: Adding the {{ sw-full-name }} extension
description: Follow this guide to add the {{ sw-full-name }} extension using the specification constructor.
---

# Adding the x-yc-apigateway-integration:http extension for integration with {{ sw-full-name }}

{% list tabs %}

- Management console

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) in which you created or want to create an [API gateway](../../concepts/index.md).
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
  1. Select an API gateway or click **{{ ui-key.yacloud.serverless-functions.gateways.list.button_create }}** to [create](../../operations/api-gw-create.md) a new one.
  1. In the **{{ ui-key.yacloud.serverless-functions.gateways.form.field_spec }}** field, click ![image](../../../_assets/api-gateway/spec-constructor/workflows.svg).
  1. Specify the following in the field:

      {% include [common-spec-constructor](../../../_includes/api-gateway/common-spec-constructor.md) %}

      * **{{ ui-key.yc-serverless-apigw.dynamic-forms.service_account_id_name }}**: Service account with the `serverless.workflows.executor` role to [run a workflow](../../../serverless-integrations/concepts/workflows/execution.md). If you do not have a service account, [create](../../../iam/operations/sa/create.md) one.
      * **Workflow**: [Workflow](../../../serverless-integrations/concepts/workflows/workflow.md) name.

  1. Click **{{ ui-key.yacloud.common.add }}**.

{% endlist %}

{% include [constructor-result](../../../_includes/api-gateway/constructor-result.md) %}

## Requirements to the structure of an incoming request {#requirements}

For the API gateway to correctly process incoming requests, set the `Content-Type: application/json` header.