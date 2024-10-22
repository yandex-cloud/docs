---
title: Adding the {{ yagpt-full-name }} extension
description: Follow this guide to add the {{ yagpt-full-name }} extension using the specification constructor.
---

# Adding the x-yc-apigateway-integration:http extension for integration with {{ yagpt-full-name }}

{% list tabs %}

- Management console

    1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) in which you created or want to create an [API gateway](../../concepts/index.md).
    1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
    1. Select an API gateway or click **{{ ui-key.yacloud.serverless-functions.gateways.list.button_create }}** to create a new one.
    1. In the **{{ ui-key.yacloud.serverless-functions.gateways.form.field_spec }}** field, click ![image](../../../_assets/api-gateway/spec-constructor/cloud-yagpt.svg).
    1. Specify the following in the field:

        {% include [common-spec-constructor](../../../_includes/api-gateway/common-spec-constructor.md) %}

        * **Service account**: Service account for authorization when accessing [{{ yagpt-full-name }}](../../../foundation-models/concepts/yandexgpt/index.md). If you do not have a service account, [create](../../../iam/operations/sa/create.md) one.

    1. Under **Model used** select a model and provide the following:

        * For a `{{ yagpt-name }}` model: Folder ID that will be specified in the {{ yagpt-full-name }} URI.
        * For a `{{ ml-platform-short-name }}` model: ID of the model tuned in [{{ ml-platform-full-name }}](../../../datasphere/index.yaml).

    1. Under **Prompt delivery method**, select a prompt source and specify the following:

        * For the `Query parameter` source: Name of the query parameter used to deliver the prompt for the {{ yagpt-full-name }} request.
        * For the `Request body` source: Name of the request body field used to deliver the prompt for the {{ yagpt-full-name }} request.
    1. Under **Use case**, select the model use case and set the relevant parameters:

        * `Text generation`:

            * (Optional) **Temperature**: Determines the variability of the model's response. Specify a value from `0` to `1`. With a higher temperature, you get more creative and randomized response from the model. Default value: `0.3`.
            * (Optional) **Number of tokens**: Maximum number of generation [tokens](../../../foundation-models/concepts/yandexgpt/tokens.md). The default value is `5`. This allows you to limit the size of the model response, if required.

        * `Text classification`:

            * **Task description**: Text description of the task for the classifier.
            * **Classes**: List of classes the text can belong to. To add a class, click ![image](../../../_assets/console-icons/plus.svg).

                To get correct results, use meaningful class names.

            * (Optional) **Request examples**: Examples of text requests for classes in `text request:class` format. To add an example, click ![image](../../../_assets/console-icons/plus.svg). For more information, see [{#T}](../../../foundation-models/concepts/classifier/index.md#few-shot).

    1. Click **{{ ui-key.yacloud.common.add }}**.

{% endlist %}

{% include [constructor-result](../../../_includes/api-gateway/constructor-result.md) %}


## Requirements to the structure of an incoming request {#requirements}

For the API gateway to correctly process incoming requests, set the `Content-Type: application/json` header. Plus, consider the following:
* If `Query parameter` is selected as a method to deliver the prompt, the request must include the query parameter from the **Prompt delivery method** section and its value.

    Here is a gateway call path example: `<path_to_integration>?<specified_query_parameter>=<prompt_contents>`.
* If `Request body` is selected as a method to deliver the prompt, the request body must include the field from the **Prompt delivery method** section and its value.
            
    Here is a request body example: `{"<request_body_field_name>": "<prompt_contents>"}`.