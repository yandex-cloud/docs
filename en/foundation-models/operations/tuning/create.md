---
title: Creating a fine-tuned text generation model in {{ foundation-models-name }}
description: Follow this guide to create a dataset and fine-tune a text generation model in {{ foundation-models-name }} using the API and {{ ml-sdk-name }}.
---

# Creating a fine-tuned text generation model in {{ foundation-models-name }}

{% include [lora-tuning-preview](../../../_includes/foundation-models/lora-tuning-preview.md) %}

This example shows how to [fine-tune](../../concepts/tuning/index.md) a {{ gpt-lite }} model based on the {{ lora }} method in {{ foundation-models-name }}. Links to other examples are available in the [See also](#see-also) section.

## Getting started {#before-begin}

{% include [tuning-before-beginning](../../../_includes/foundation-models/tuning-before-beginning.md) %}

## Upload the dataset {#create-dataset}

Prepare [UTF-8](https://{{ lang }}.wikipedia.org/wiki/UTF-8)-encoded model [tuning data](../../concepts/tuning/generating.md) in [JSON Lines](https://jsonlines.org/) format. If you want to split your data into two datasets for tuning and validation, repeat the steps below for each dataset. Use the IDs you got after uploading the datasets to start the fine-tuning process.

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

     Result:

     ```text
     new dataset=AsyncDataset(id='fdsfehj6grsu********', folder_id='b1gt6g8ht345********', name='YandexGPT Lite tuning', description=None, metadata=None, created_by='ajegtlf2q28a********', created_at=datetime.datetime(2025, 1, 20, 11, 38, 19), updated_at=datetime.datetime(2025, 1, 20, 11, 39, 4), labels=None, status=<DatasetStatus.READY: 3>, task_type='TextToTextGeneration', rows=0, size_bytes=3514)
     ```

     Save the new dataset's ID (the `id` field value): you will need it when fine-tuning the model.

- cURL {#curl}

  1. Create a dataset:
  
     ```bash
     grpcurl \
       -H "Authorization: Bearer <IAM_token>" \
       -d @ \
       {{ api-host-llm }}:443 yandex.cloud.ai.dataset.v1.DatasetService/Create <<EOM
       {
         "folder_id": "<folder_ID>", 
         "name": "My awesome dataset", 
         "task_type": "TextToTextGeneration", 
         "upload_format": "jsonlines"
       }
     EOM
     ```

     Where:
     * `<IAM_token>`: [IAM token](../../../iam/concepts/authorization/iam-token.md) of the service account you got [before you started](#before-begin).
     * `<folder_ID>`: [ID of the folder](../../../resource-manager/operations/folder/get-id.md) you are creating the dataset in.

     Result:

     ```text
     {
       "datasetId": "fdso08c1u1cq********",
       "dataset": {
         "datasetId": "fdso08c1u1cq********",
         "folderId": "b1gt6g8ht345********",
         "name": "My awesome dataset",
         "status": "DRAFT",
         "taskType": "TextToTextGeneration",
         "createdAt": "2025-01-20T10:36:50Z",
         "updatedAt": "2025-01-20T10:36:50Z",
         "createdById": "ajeg2b2et02f********",
         "createdBy": "ajeg2b2et02f********"
       }
     }
     ```

     Save the new dataset's ID (the `datasetId` field value): you will need it to upload data to the dataset.

  1. {% include [tuning-dataset-api-step2](../../../_includes/foundation-models/tuning-dataset-api-step2.md) %}

  1. {% include [tuning-dataset-api-step3](../../../_includes/foundation-models/tuning-dataset-api-step3.md) %}

  1. {% include [tuning-dataset-api-step4](../../../_includes/foundation-models/tuning-dataset-api-step4.md) %}

  1. {% include [tuning-dataset-api-step5](../../../_includes/foundation-models/tuning-dataset-api-step5.md) %}

{% endlist %}

## Start tuning {#start-tuning}

{% list tabs group=programming_language %}

- SDK {#sdk}

  1. Create a file named `start-tuning.py` and add the following code to it:

     {% include [sdk-tuning](../../../_includes/foundation-models/examples/tuning-sdk.md) %}

     Where:

     * `<folder_ID>`: [ID of the folder](../../../resource-manager/operations/folder/get-id.md) the [service account](../../../iam/concepts/users/service-accounts.md) was created in.
     * `<API_key>`: Service account [API key](../../../iam/concepts/authorization/api-key.md) you got earlier required for [authentication in the API](../../../foundation-models/api-ref/authentication.md).

         {% include [sdk-auth-details-paragraph](../../../_includes/foundation-models/sdk-auth-details-paragraph.md) %}
     * `<dataset_ID>`: The new dataset's ID you saved in the previous step.

  1. Run the created file:

     ```bash
     python3 start-tuning.py
     ```

     Result:

     ```text
     Resulting GPTModelResult(alternatives=(Alternative(role='assistant', text='I'm Gene. My full name is Eugene Neuron.', status=<AlternativeStatus.FINAL: 3>),), usage=Usage(input_text_tokens=14, completion_tokens=11, total_tokens=25), model_version='23.10.2024') 
     completion_result=GPTModelResult(alternatives=(Alternative(role='assistant', text='From Perm', status=<AlternativeStatus.FINAL: 3>),), usage=Usage(input_text_tokens=13, completion_tokens=2, total_tokens=15), model_version='23.10.2024') 
     ```

     Model tuning may take up to 1 day depending on the size of the dataset and the system load.

     Use the fine-tuned model's URI you got (the `uri` field value) when [accessing](../../concepts/yandexgpt/models.md#addressing-models) the model.

  1. Fine-tuning metrics are available in TensorBoard format. You can open the downloaded file, for example, in the [{{ ml-platform-full-name }}]({{ link-datasphere-main }}) project:
  
     ```python
     metrics_url = new_model.get_metrics_url()
     download_tensorboard(metrics_url)
     ```


- cURL {#curl}

  1. Start tuning:

     ```bash
     grpcurl \
       -H "Authorization: Bearer <IAM_token>" \
       -d @ \
       {{ api-host-llm }}:443 yandex.cloud.ai.tuning.v1.TuningService/Tune <<EOM
       {
         "base_model_uri": "gpt://<folder_ID>/yandexgpt-lite/latest",
         "train_datasets": [{"dataset_id": "<dataset_ID>", "weight": 1.0}],
         "name": "my first model",
         "text_to_text_completion": {}
       } 
     EOM
     ```

     Where:
     * `<IAM_token>`: [IAM token](../../../iam/concepts/authorization/iam-token.md) of the service account you got [before you started](#before-begin).
     * `<folder_ID>`: [ID of the folder](../../../resource-manager/operations/folder/get-id.md) you are fine-tuning the model in.
     * `<dataset_ID>`: Dataset ID you saved in the previous step.

     Result:

     ```text
     {
       "id": "ftnlljf53kil********",
       "createdAt": "2025-01-20T11:17:33Z",
       "modifiedAt": "2025-01-20T11:17:33Z",
       "metadata": {
         "@type": "type.googleapis.com/yandex.cloud.ai.tuning.v1.TuningMetadata"
       }
     }
     ```

     You will get the [Operation](../../../api-design-guide/concepts/operation.md) object in response. Save the operation `id` you get in the response.

  1. Model tuning may take up to one day depending on the dataset size and the system load. To check if the fine-tuning is complete, request the operation status:

     ```bash
     grpcurl \
       -H "Authorization: Bearer <IAM_token>" \
       -d '{"operation_id": "<operation_ID>"}' \
       {{ api-host-llm }}:443 yandex.cloud.operation.OperationService/Get
     ```

     Where:
     * `<IAM_token>`: [IAM token](../../../iam/concepts/authorization/iam-token.md) of the service account you got [before you started](#before-begin).
     * `<operation_ID>`: Model fine-tuning operation ID you got in the previous step.

     If the fine-tuning process is over, the Operation object will contain the tuned model's URI in the `targetModelUri` field:

     ```json
     {
       "id": "ftnlljf53kil********",
       "createdAt": "2025-01-20T11:17:33Z",
       "modifiedAt": "2025-01-20T11:25:40Z",
       "done": true,
       "metadata": {
         "@type": "type.googleapis.com/yandex.cloud.ai.tuning.v1.TuningMetadata",
         "status": "COMPLETED",
         "tuningTaskId": "ftnlljf53kil********"
       },
       "response": {
         "@type": "type.googleapis.com/yandex.cloud.ai.tuning.v1.TuningResponse",
         "status": "COMPLETED",
         "targetModelUri": "gpt://b1gt6g8ht345********/yandexgpt-lite/latest@tamr2nc6pev5e********",
         "tuningTaskId": "ftnlljf53kil********"
       }
     }
     ```

     Use the fine-tuned model's URI you got (the `targetModelUri` field value) when [accessing](../../concepts/yandexgpt/models.md#addressing-models) the model.

  1. Fine-tuning metrics are available in TensorBoard format. Get the link to download the file: 
  
     ```bash
     grpcurl \
       -H "Authorization: Bearer <IAM_token>" \
       -d '{"task_id": "<job_ID>"}' \
       {{ api-host-llm }}:443 yandex.cloud.ai.tuning.v1.TuningService/GetMetricsUrl
     ```

     You can open the downloaded file, for example, in the [{{ ml-platform-full-name }}]({{ link-datasphere-main }}) project:

{% endlist %}

### Accessing a fine-tuned model {#model-call}

Once the model is fine-tuned, save its URI in `gpt://<base_model_URI>/<version>@<tuning_suffix>` format. Use it to send [synchronous](../yandexgpt/create-prompt.md) and [asynchronous](../yandexgpt/async-request.md) requests or [create an AI assistant](../assistant/create.md) based on the fine-tuned model. 

#### See also {#see-also}

* [{#T}](../../concepts/tuning/index.md)
* [{#T}](./tune-classifiers.md)
* For more SDK examples, see our [GitHub repository](https://github.com/yandex-cloud/yandex-cloud-ml-sdk/tree/classifiers_tuning/examples/sync/tuning).