# Disabling request logging

Models log all request data by default. If you provide personal or private data or any kind of sensitive information in your requests, you may want to disable logging. To do this, add the `x-data-logging-enabled: false` option to the REST request header or gRPC call metadata. The requests you submit without logging will not be saved on {{ yandex-cloud }} servers.

Request example:

{% list tabs group=programming_language %}

- cURL {#curl}

  {% include [curl](../../_includes/curl.md) %}
  
  {% include [bash-windows-note-single](../../_includes/translate/bash-windows-note-single.md) %}

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
  * `<model_endpoint>`: Endpoint to access the model. Possible values:
    * `https://llm.{{ api-host }}/foundationModels/v1/completion`: For synchronous requests to [{{ yagpt-name }}](../concepts/yandexgpt/index.md).
    * `https://llm.{{ api-host }}/foundationModels/v1/completionAsync`: For [asynchronous](./yandexgpt/async-request.md) requests to {{ yagpt-name }}.
    * `https://{{ api-host-llm }}:443/foundationModels/v1/textClassification`: For [fine-tuned](../concepts/classifier/index.md#trainable) classifiers.
    * `https://{{ api-host-llm }}/foundationModels/v1/fewShotTextClassification`: For [zero-shot](../concepts/classifier/index.md#zero-shot) and [few-shot](../concepts/classifier/index.md#few-shot) classifiers.
    * `https://llm.{{ api-host }}/foundationModels/v1/imageGenerationAsync`: For [{{ yandexart-name }}](../concepts/yandexart/index.md).

{% endlist %}