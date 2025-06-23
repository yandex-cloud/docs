---
title: Creating a fine-tuned classifier model in {{ foundation-models-name }}
description: Follow this guide to create a dataset and fine-tune a classifier model in {{ foundation-models-name }} using {{ ai-playground }}, the API, and {{ ml-sdk-name }}.
---

# Fine-tuning text classification models

{% include [lora-tuning-preview](../../../_includes/foundation-models/lora-tuning-preview.md) %}

If an out-of-the-box classifier model is not enough, you can [fine-tune](../../concepts/tuning/index.md) a {{ gpt-lite }}-based classifier model for it to classify your requests more accurately.

## Getting started {#before-begin}

{% include [tuning-before-beginning](../../../_includes/foundation-models/tuning-before-beginning.md) %}

## Upload the dataset {#create-dataset}

Depending on the [classification type](../../concepts/classifier/index.md) the fine-tuned model will be used for, prepare [UTF-8](https://{{ lang }}.wikipedia.org/wiki/UTF-8)-encoded [tuning data](../../concepts/resources/dataset.md#classifier) in [JSON Lines format](https://jsonlines.org/). If you want to split your data into two datasets for tuning and validation, repeat the steps below for each dataset. Use the IDs you got after uploading the datasets to start the fine-tuning process.

In this example, we only use the tuning dataset for fine-tuning. 

Create a tuning dataset:

{% list tabs group=programming_language %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder for which your account has the `ai.playground.user` and `ai.datasets.editor` [roles](../../security/index.md) or higher.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_foundation-models }}**.
  1. In the left-hand panel, click ![image](../../../_assets/console-icons/layers.svg) **{{ ui-key.yacloud.dataset.datasets }}**.
  1. Click **{{ ui-key.yacloud.dataset.create }}**.
  1. Enter a name and descriptions for the dataset. Follow these naming requirements:

     {% include [name-format](../../../_includes/name-format.md) %}

  1. In the **{{ ui-key.yacloud.common.type }}** field, select the classification type: **{{ ui-key.yacloud.dataset.text-classification-multilabel-key-value }}** or **{{ ui-key.yacloud.dataset.text-classification-multiclass-key-value }}**.
  1. Delete or add dataset [labels](../../../resource-manager/concepts/labels.md). You can use them to split or join resources into logical groups.
  1. Click **Select file** or drag the JSON file you created earlier to the loading area.
  1. Click **{{ ui-key.yacloud.dataset.create }}**.

- SDK {#sdk}

  1. Create a file named `dataset-create.py` and add the following code to it:

     {% include [dataset-sdk-cls](../../../_includes/foundation-models/examples/dataset-sdk-cls.md) %}

  1. Run the created file:

     ```bash
     python3 dataset-create.py
     ```

     Result:

     ```text
     new tuning_dataset=Dataset(id='fds6vl5ttl0n********', folder_id='b1gt6g8ht345********', name='YandexGPT 
     Lite tuning', description=None, metadata=None, created_by='ajegtlf2q28a********', created_at=datetime.
     datetime(2025, 3, 13, 8, 12, 43), updated_at=datetime.datetime(2025, 3, 13, 8, 13, 17), labels=None, 
     allow_data_logging=False, status=<DatasetStatus.READY: 3>, task_type='TextClassificationMulticlass', 
     rows=4, size_bytes=5679, validation_errors=())
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
         "task_type": "<classification_type>", 
         "upload_format": "jsonlines"
       }
     EOM
     ```

     Where:
     * `<IAM_token>`: [IAM token](../../../iam/concepts/authorization/iam-token.md) of the service account you got [before you started](#before-begin).
     * `<folder_ID>`: [ID of the folder](../../../resource-manager/operations/folder/get-id.md) you are creating the dataset in.
     * `<classification_type>`: [Classification type](../../concepts/classifier/index.md) the model will be tuned for using the new dataset. The possible values are:

         * `TextClassificationMultilabel`: Binary classification or multi-label classification.
         * `TextClassificationMulticlass`: Multi-class classification.

     Result:

     ```text
     {
       "datasetId": "fds8hd01tset********",
       "dataset": {
         "datasetId": "fds8hd01tset********",
         "folderId": "b1gt6g8ht345********",
         "name": "My awesome dataset",
         "status": "DRAFT",
         "taskType": "<issue_type_specified_in_the_query>",
         "createdAt": "2025-01-20T14:51:34Z",
         "updatedAt": "2025-01-20T14:51:34Z",
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

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder for which your account has the `ai.playground.user`, `ai.datasets.user`, and `ai.models.editor` [roles](../../security/index.md) or higher.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_foundation-models }}**.
  1. In the left-hand panel, click ![image](../../../_assets/console-icons/sliders.svg) **{{ ui-key.yacloud.tuning.tunings }}**.
  1. Click **{{ ui-key.yacloud.tuning.train-model }}**.
  1. Enter a name and descriptions for the dataset. Follow these naming requirements:

     {% include [name-format](../../../_includes/name-format.md) %}

  1. In the **{{ ui-key.yacloud.tuning.task }}** field, select **{{ ui-key.yacloud.tuning.classification }}**.
  1. Select the **{{ ui-key.yacloud.tuning.classification-task }}**: **{{ ui-key.yacloud.dataset.text-classification-multiclass.short-title }}** or **{{ ui-key.yacloud.dataset.text-classification-multilabel.short-title }}**.
  1. Optionally, add or delete the tuning [labels](../../../resource-manager/concepts/labels.md). You can use them to split or join resources into logical groups.
  1. In the **{{ ui-key.yacloud.yagpt.model }}** field, select the model you need.
  1. In the **{{ ui-key.yacloud.dataset.dataset }}** field, click **{{ ui-key.yacloud.common.add }}**.
  1. In the window that opens, go to the **{{ ui-key.yacloud.dataset.select-from-created }}** tab and select the dataset you created earlier.
  1. Click **{{ ui-key.yacloud.tuning.addition-params }}** to do advanced fine-tuning setup.
  1. Click **{{ ui-key.yacloud.tuning.start-tuning }}**.

- SDK {#sdk}

  1. Create a file named `start-tuning.py` and add the following code to it:

     {% include [tuning-sdk-cls](../../../_includes/foundation-models/examples/tuning-sdk-cls.md) %}

     Where:

     * `<folder_ID>`: [ID of the folder](../../../resource-manager/operations/folder/get-id.md) the [service account](../../../iam/concepts/users/service-accounts.md) was created in.
     * `<API_key>`: Service account [API key](../../../iam/concepts/authorization/api-key.md) you got earlier required for [authentication in the API](../../../foundation-models/api-ref/authentication.md).

         {% include [sdk-auth-details-paragraph](../../../_includes/foundation-models/sdk-auth-details-paragraph.md) %}
     * `<dataset_ID>`: The new dataset's ID you saved in the previous step.
     * `<classification_type>`: [Classification type](../../concepts/classifier/index.md) the model will be tuned for. The possible values are:

         * `binary`: Binary classification.
         * `multilabel`: Multi-label classification.
         * `multiclass`: Multi-class classification.

  1. Run the created file:

     ```bash
     python3 start-tuning.py
     ```

     Result:

     ```text
     Resulting TextClassifiersModel(uri=cls://b1gt6g8ht345********/yandexgpt-lite/
     latest@tamrqj184r59v********, config=TextClassifiersModelConfig(task_description=None, labels=None, 
     samples=None))
     classification_result=TextClassifiersModelResult(predictions=(TextClassificationLabel(label='anger', 
     confidence=0.0026986361481249332), TextClassificationLabel(label='sadness', confidence=0.
     0013768149074167013), TextClassificationLabel(label='joy', confidence=0.00017048732843250036), 
     TextClassificationLabel(label='fear', confidence=0.9950377345085144), TextClassificationLabel
     (label='surprise', confidence=0.0007163778645917773)), model_version='')
     classification_result=TextClassifiersModelResult(predictions=(TextClassificationLabel(label='anger', 
     confidence=0.00042847482836805284), TextClassificationLabel(label='sadness', confidence=1.
     9441255062702112e-05), TextClassificationLabel(label='joy', confidence=2.6669084718378144e-07), 
     TextClassificationLabel(label='fear', confidence=0.999543309211731), TextClassificationLabel
     (label='surprise', confidence=8.627005627204198e-06)), model_version='')
     ```

     Model tuning may take up to one day depending on the dataset size and the system load.

     Use the fine-tuned model's URI you got (the `uri` field value) when [accessing](../../concepts/classifier/models#addressing-models) the model.

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
         "base_model_uri": "cls://<folder_ID>/yandexgpt-lite/latest",
         "train_datasets": [{"dataset_id": "<dataset_ID>", "weight": 1.0}],
         "name": "my first model",
         "<classification_type>": {}
       } 
     EOM
     ```

     Where:
     * `<IAM_token>`: [IAM token](../../../iam/concepts/authorization/iam-token.md) of the service account you got [before you started](#before-begin).
     * `<folder_ID>`: [ID of the folder](../../../resource-manager/operations/folder/get-id.md) you are fine-tuning the model in.
     * `<dataset_ID>`: Dataset ID you saved in the previous step.
     * `<classification_type>`: [Classification type](../../concepts/classifier/index.md) the model will be tuned for. The possible values are:

         * `text_classification_multilabel`: Binary classification or multi-label classification.
         * `text_classification_multiclass`: Multi-class classification.

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
       "id": "ftnc7at9r66t********",
       "createdAt": "2025-01-20T15:41:06Z",
       "modifiedAt": "2025-01-20T15:46:10Z",
       "done": true,
       "metadata": {
         "@type": "type.googleapis.com/yandex.cloud.ai.tuning.v1.TuningMetadata",
         "status": "COMPLETED",
         "tuningTaskId": "ftnc7at9r66t********"
       },
       "response": {
         "@type": "type.googleapis.com/yandex.cloud.ai.tuning.v1.TuningResponse",
         "status": "COMPLETED",
         "targetModelUri": "cls://b1gt6g8ht345********/yandexgpt-lite/latest@tamr8gqhetveg********",
         "tuningTaskId": "ftnc7at9r66t********"
       }
     }
     ```

     Use the fine-tuned model's URI you got (the `targetModelUri` field value) when [accessing](../../concepts/classifier/models#addressing-models) the model.

  1. Fine-tuning metrics are available in TensorBoard format. Get the link to download the file: 
  
     ```bash
     grpcurl \
       -H "Authorization: Bearer <IAM_token>" \
       -d '{"task_id": "<job_ID>"}' \
       {{ api-host-llm }}:443 yandex.cloud.ai.tuning.v1.TuningService/GetMetricsUrl
     ```

     You can open the downloaded file, for example, in the [{{ ml-platform-full-name }}]({{ link-datasphere-main }}) project:

{% endlist %}

### Accessing a fine-tuned classifier {#model-call}

Once the model is fine-tuned, save its URI in this format: `cls://<base_model_URI>/<version>@<tuning_suffix>`. Use the URI to send [synchronous](../classifier/additionally-trained.md) requests to your fine-tuned classifier. 


#### See also {#see-also}

* [{#T}](../../tutorials/models-fine-tuning.md).
* For more examples, see our [GitHub repository](https://github.com/yandex-cloud/yandex-cloud-ml-sdk/tree/classifiers_tuning/examples/sync/tuning).