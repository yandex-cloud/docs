---
title: Adding the {{ foundation-models-full-name }} extension
description: Follow this guide to add the {{ foundation-models-full-name }} extension using the specification constructor.
---

# Adding the x-yc-apigateway-integration:http extension for integration with the {{ foundation-models-full-name }} text generation API

{% list tabs %}

- Management console

    1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) in which you created or want to create an [API gateway](../../concepts/index.md).
    1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
    1. Select an API gateway or click **{{ ui-key.yacloud.serverless-functions.gateways.list.button_create }}** to create a new one.
    1. In the **{{ ui-key.yacloud.serverless-functions.gateways.form.field_spec }}** field, click ![image](../../../_assets/api-gateway/spec-constructor/cloud-yagpt.svg).
    1. Specify the following in the field:

        {% include [common-spec-constructor](../../../_includes/api-gateway/common-spec-constructor.md) %}

        * **{{ ui-key.yc-serverless-apigw.dynamic-forms.service_account_id_name }}**: Service account for authorization when accessing the [text generation API](../../../foundation-models/concepts/yandexgpt/index.md). If you do not have a service account, [create](../../../iam/operations/sa/create.md) one.

    1. Under **{{ ui-key.yc-serverless-apigw.dynamic-forms.foundation_models_model_uri_title }}**, select a model and specify:

        * For a `{{ ui-key.yc-serverless-apigw.dynamic-forms.foundation_models_model_uri_yagpt_label }}` model: Folder ID that will be specified in the text generation model URI.
        * For a `{{ ui-key.yc-serverless-apigw.dynamic-forms.foundation_models_model_uri_datasphere_label }}` model: ID of the model tuned in [{{ ml-platform-full-name }}](../../../datasphere/index.yaml).

    1. Under **{{ ui-key.yc-serverless-apigw.dynamic-forms.foundation_models_prompt_src_title }}**, select a prompt source and specify the following:

        * For the `{{ ui-key.yc-serverless-apigw.dynamic-forms.foundation_models_prompt_src_query_option }}` source: Name of the query parameter where you will provide the prompt for the text generation API request.
        * For the `{{ ui-key.yc-serverless-apigw.dynamic-forms.foundation_models_prompt_src_body_option }}` source: Name of the request body field you will use to provide the prompt for the text generation API request.
    1. Under **{{ ui-key.yc-serverless-apigw.dynamic-forms.foundation_models_api_service_title }}**, select the model use case and set the relevant parameters:

        * `{{ ui-key.yc-serverless-apigw.dynamic-forms.foundation_models_api_service_text_generation_hint }}`:

            * Optionally, **{{ ui-key.yc-serverless-apigw.dynamic-forms.foundation_models_api_service_text_generation_temp_title }}**: Determines the variability of the model's response. Specify a value from `0` to `1`. With a higher temperature, you get a more creative and randomized response from the model. The default value is `0.3`.
            * Optionally, **{{ ui-key.yc-serverless-apigw.dynamic-forms.foundation_models_api_service_text_generation_max_tokens_title }}**: Maximum number of generation [tokens](../../../foundation-models/concepts/yandexgpt/tokens.md). The default value is `5`. This allows you to limit the size of the model response, if required.

        * `{{ ui-key.yc-serverless-apigw.dynamic-forms.foundation_models_api_service_text_classification_hint }}`:

            * **{{ ui-key.yc-serverless-apigw.dynamic-forms.foundation_models_api_service_text_classification_task_desc_title }}**: Text description of the task for the classifier.
            * **{{ ui-key.yc-serverless-apigw.dynamic-forms.foundation_models_api_service_text_classification_labels_title }}**: List of classes the text can belong to. To add a class, click ![image](../../../_assets/console-icons/plus.svg).

                To get correct results, use meaningful class names.

            * Optionally, **{{ ui-key.yc-serverless-apigw.dynamic-forms.foundation_models_api_service_text_classification_samples_title }}**: Examples of text requests for classes in `text request:class` format. To add an example, click ![image](../../../_assets/console-icons/plus.svg). For more information, see [{#T}](../../../foundation-models/concepts/classifier/index.md#few-shot).

    1. Click **{{ ui-key.yacloud.common.add }}**.

{% endlist %}

{% include [constructor-result](../../../_includes/api-gateway/constructor-result.md) %}


## Requirements to the structure of an incoming request {#requirements}

For the API gateway to correctly process incoming requests, set the `Content-Type: application/json` header. Plus, consider the following:
* If `Query parameter` is selected as a method to deliver the prompt, the request must include the query parameter from the **{{ ui-key.yc-serverless-apigw.dynamic-forms.foundation_models_prompt_src_title }}** section and its value.

    Here is an API gateway call path example: `<path_to_integration>?<specified_query_parameter>=<prompt_contents>`.
* If `Request body` is selected as a method to deliver the prompt, the request body must include the field from the **{{ ui-key.yc-serverless-apigw.dynamic-forms.foundation_models_prompt_src_title }}** section and its value.
            
    Here is a request body example: `{"<request_body_field_name>": "<prompt_contents>"}`.