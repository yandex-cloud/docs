# Fine-tuning in {{ foundation-models-name }}

_Model tuning based on the {{ lora }} method is at the [Preview](../../../overview/concepts/launch-stages.md) stage and available upon request. You can fill out the form in the [management console]({{ link-console-main }}/link/foundation-models/)._

This example shows how to fine-tune a {{ gpt-lite }} model based on the {{ lora }} method in {{ foundation-models-name }}. 

## Getting started {#before-begin}

To use the examples:

{% list tabs group=programming_language %}

- SDK {#sdk}

  1. [Create](../../../iam/operations/sa/create.md) a service account and [assign](../../../iam/operations/sa/assign-role-for-sa.md) the `ai.editor` [role](../../../foundation-models/security/index.md#languageModels-user) to it.
  1. [Get](../../../iam/operations/api-key/create.md) the service account API key and save it.

      {% include [sdk-auth-details-paragraph](../../../_includes/foundation-models/sdk-auth-details-paragraph.md) %}
  1. Use the [pip](https://pip.pypa.io/en/stable/) package manager to install the beta version of the {{ ml-sdk-name }} library:

    ```bash
    pip install yandex-cloud-ml-sdk --upgrade --pre
    ```

- cURL {#curl}

  1. {% include notitle [ai-before-beginning](../../../_includes/foundation-models/yandexgpt/ai-before-beginning.md) %}
  1. Install [gRPCurl](https://github.com/fullstorydev/grpcurl).
  1. {% include [curl](../../../_includes/curl.md) %}
  1. (Optional) Install the [jq](https://stedolan.github.io/jq/) JSON stream processor.
  1. [Get an IAM token](../../../iam/operations/iam-token/create.md) used for authentication in the API.
  
     {% note info %}

     The IAM token has a short [lifetime](../../../iam/concepts/authorization/iam-token.md#lifetime): no more than {{ iam-token-lifetime }}.

     {% endnote %}
   
{% endlist %}

## Upload the dataset {#create-dataset}

Prepare [UTF-8](https://{{ lang }}.wikipedia.org/wiki/UTF-8)-encoded model [tuning data](../../concepts/tuning/index.md#generation-data) in [JSON Lines](https://jsonlines.org/) format. If you want to split your data into two datasets for tuning and validation, repeat the steps below for each dataset. Use the IDs you got after uploading the datasets to start the fine-tuning process.

In this example, we only use the tuning dataset for fine-tuning. 

Create a tuning dataset:

{% list tabs group=programming_language %}

- SDK {#sdk}

  1. Create a file named `dataset-create.py` and add the following code to it:

     {% include [sdk-dataset](../../../_includes/foundation-models/examples/dataset-sdk.md) %}

  1. Run the created file:

     ```bash
     python3 dataset-create.py
     ```

- cURL {#curl}

  1. Create the dataset object:
  
     ```bash
     grpcurl \
       -H "Authorization: Bearer $<IAM_token>" \
       -d @ \
       llm.api.cloud.yandex.net:443 yandex.cloud.ai.dataset.v1.DatasetService/Create <<EOM
       {
         "folder_id": "<folder_ID>", 
         "name": "My awesome dataset", 
         "task_type": "TextToTextGeneration", 
         "upload_format": "jsonlines"
       }
     EOM
     ```

  1. Get a link to upload data into the dataset. In the `size_bytes` field, specify the size of the file with fine-tuning data in bytes. The size of the dataset in the example is 10 KB: 
  
     ```bash
     grpcurl \
       -H "Authorization: Bearer $<IAM_token>" \
       -d '{"dataset_id": "<dataset_ID>", "size_bytes": 10240}' \
       llm.api.cloud.yandex.net:443 yandex.cloud.ai.dataset.v1.DatasetService/GetUploadDraftUrl | jq
       ```

     The response will return a link to the dataset template you created.

     {% note tip %}
      
     If you did not use jq, replace all `\u0026` occurrences with `&` in the link to use it to upload the dataset.

     {% endnote %}

  1. Upload your data:
  
      ```bash 
      curl --request PUT --upload-file <path_to_file> "<link>"
      ```

  1. After the data upload is complete, run the dataset validation:
  
      ```bash
      grpcurl \
        -H "Authorization: Bearer $<IAM_token>" \
        -d '{"dataset_id": "<dataset_ID>"}' \
        llm.api.cloud.yandex.net:443 yandex.cloud.ai.dataset.v1.DatasetService/Validate
      ```

      The response will return an object containing the validation ID. 

  1. Dataset validation may take some time. To find out validation status and get an error report (if any), send a request containing the ID from the previous step:
  
     ```bash
     grpcurl \
       -H "Authorization: Bearer $<IAM_token>" \
       -d '{"operation_id": "ftnq****************"}' \
       llm.api.cloud.yandex.net:443 yandex.cloud.operation.OperationService/Get
     ```

{% endlist %}

## Start tuning {#start-tuning}

{% list tabs group=programming_language %}

- SDK {#sdk}

  1. Create a file named `start-tuning.py` and add the following code to it:

     {% include [sdk-tuning](../../../_includes/foundation-models/examples/tuning-sdk.md) %}

  1. Run the created file:

     ```bash
     python3 start-tuning.py
     ```

- cURL {#curl}
  
  1. Start tuning:
  
     ```bash
     grpcurl \
       -H "Authorization: Bearer $<IAM_token>" \
       -d @ \
       llm.api.cloud.yandex.net:443 yandex.cloud.ai.tuning.v1.TuningService/Tune <<EOM
       {
         "base_model_uri": "gpt://<folder_ID>/yandexgpt-lite/latest",
         "train_datasets": [{"dataset_id": "<dataset_ID>", "weight": 1.0}],
         "name": "my first model",
         "text_to_text_completion": {}
       } 
     EOM
     ```

     In response, you will get the [Operation](../../../api-design-guide/concepts/operation.md) object:

     ```json
     {"id":"f**********","description":"","createdAt":null,"createdBy":"","modifiedAt":null,"done":false,"metadata":null}
     ```

     Save the operation `id` you get in the response.

  1. Model tuning may take up to 1 day depending on the size of the dataset and the system load. To check if the fine-tuning is complete, request the operation status:
  
     ```bash
     grpcurl \
       -H "Authorization: Bearer $<IAM_token>" \
       -d '{"operation_id": "ftnq****************"}' \
       llm.api.cloud.yandex.net:443 yandex.cloud.operation.OperationService/Get
     ```

     If fine-tuning process is over, the Operation object will contain the tuned model's ID in the `targetModelUri` field:

     ```json
     {
       "id": "ftnq****************",
       "createdAt": "2024-12-04T10:56:08Z",
       "modifiedAt": "2024-12-04T11:14:25Z",
       "done": true,
       "metadata": {
         "@type": "type.googleapis.com/yandex.cloud.ai.tuning.v1.TuningMetadata",
         "status": "COMPLETED",
         "tuningTaskId": "ftn7****************"
       },
       "response": {
         "@type": "type.googleapis.com/yandex.cloud.ai.tuning.v1.TuningResponse",
         "status": "COMPLETED",
         "targetModelUri": "<fine-tuned_model_modelUri>",
         "tuningTaskId": "ftn7****************"
       }
     }
     ```


{% endlist %}

Use the fine-tuned model's ID as `modelURI` to send requests to the fine-tuned model.

#### See also {#see-also}

For more examples, see our [GitHub repository](https://github.com/yandex-cloud/yandex-cloud-ml-sdk/tree/classifiers_tuning/examples/sync/tuning).
