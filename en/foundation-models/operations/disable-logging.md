# Disabling request logging

Models log all request data by default. Disable logging if you provide personal or confidential data or any manner of sensitive information in your requests. To do this, add the `x-data-logging-enabled: false` option to the REST request header or gRPC call metadata. The requests you submit without logging will not be saved on {{ yandex-cloud }} servers.

To disable request logging:

{% list tabs group=programming_language %}

- SDK {#sdk}

  When initializing a `YCloudML` class object, set the `enable_server_data_logging` parameter to `False`. In which case {{ ml-sdk-full-name }} will add `x-data-logging-enabled: false` to the meta information of each gRPC call.

  Here is an example:

  ```python
  ...
  sdk = YCloudML(
      folder_id="<folder_ID>",
      auth="<API_key>",
      enable_server_data_logging=False,
  )
  ...
  ```

  Where:

  * `<folder_ID>`: [ID of the folder](../../resource-manager/operations/folder/get-id.md) in which the [service account](../../iam/concepts/users/service-accounts.md) was created.
  * `<API_key>`: Service account [API key](../../iam/concepts/authorization/api-key.md) required for [authentication in the API](../api-ref/authentication.md). You can also use other authentication options. For more information, see [{#T}](../sdk/index.md#authentication).

- cURL {#curl}

  {% note info %}

  {% include [curl](../../_includes/curl.md) %}

  {% include [bash-windows-note-single](../../_includes/translate/bash-windows-note-single.md) %}

  {% endnote %}

  Add the `x-data-logging-enabled: false` header to your REST request. Here is an example:

  ```bash
  export FOLDER_ID=<folder_ID>
  export IAM_TOKEN=<IAM_token>

  curl \
    --request POST \
    --header "Content-Type: application/json" \
    --header "Authorization: Bearer ${IAM_TOKEN}" \
    --header "x-data-logging-enabled: false" \
    --header "x-folder-id: ${FOLDER_ID}" \
    --data "@<path_to_JSON_file>" \
    "<model_endpoint>"
  ```

  Where:

  * `FOLDER_ID`: ID of the folder for which your account has the required [role](../security/index.md).
  * `IAM_TOKEN`: [IAM token](../../iam/operations/iam-token/create.md) used for authentication.
  * `@<path_to_JSON_file>`: Path to the JSON file containing a request to the model.
  * `<model_endpoint>`: Endpoint to access the model. Examples:
    * `https://llm.{{ api-host }}/foundationModels/v1/completion`: For synchronous requests to [{{ yagpt-name }}](../concepts/yandexgpt/index.md).
    * `https://llm.{{ api-host }}/foundationModels/v1/completionAsync`: For [asynchronous](./yandexgpt/async-request.md) requests to {{ yagpt-name }}.
    * `https://{{ api-host-llm }}:443/foundationModels/v1/textClassification`: For [fine-tuned](../concepts/classifier/index.md#trainable) classifiers.
    * `https://{{ api-host-llm }}/foundationModels/v1/fewShotTextClassification`: For [zero-shot](../concepts/classifier/index.md#zero-shot) and [few-shot](../concepts/classifier/index.md#few-shot) classifiers.
    * `https://llm.{{ api-host }}/foundationModels/v1/imageGenerationAsync`: For [{{ yandexart-name }}](../concepts/yandexart/index.md).
    
    For a full list of available endpoints, see the relevant [{{ foundation-models-full-name }} API references](../concepts/api.md).

{% endlist %}