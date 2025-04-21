---
title: How to create a dataset for tuning a text generation model in {{ foundation-models-name }}
description: Follow this guide to create a dataset for tuning a text generation model in {{ foundation-models-name }} using the management console, the API, and {{ ml-sdk-name }}.
---

# Creating a dataset for tuning a text generation model

## Getting started {#before-begin}

{% include [tuning-before-beginning](../../../_includes/foundation-models/tuning-before-beginning.md) %}

## Upload the dataset {#create-dataset}

Prepare [UTF-8](https://{{ lang }}.wikipedia.org/wiki/UTF-8)-encoded model [tuning data](../../concepts/resources/dataset.md#generating) in [JSON Lines](https://jsonlines.org/) format. If you want to split your data into two datasets for tuning and validation, repeat the steps below for each dataset. Use the IDs you got after uploading the datasets to start the fine-tuning process.

Create a tuning dataset:

{% list tabs group=programming_language %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder for which your account has the `ai.playground.user` and `ai.datasets.editor` [roles](../../security/index.md) or higher.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_foundation-models }}**.
  1. In the left-hand panel, click ![image](../../../_assets/console-icons/layers.svg) **{{ ui-key.yacloud.dataset.datasets }}**.
  1. Click **{{ ui-key.yacloud.dataset.create }}**.
  1. Enter a name and descriptions for the dataset. Follow these naming requirements:

     {% include [name-format](../../../_includes/name-format.md) %}

  1. In the **{{ ui-key.yacloud.common.type }}** field, select **{{ ui-key.yacloud.yagpt.foundation-models.playground.text-generation.title }}**.
  1. Optionally, add or delete dataset [labels](../../../resource-manager/concepts/labels.md). You can use them to split or join resources into logical groups.
  1. Click **Select file** or drag the JSON file you created earlier to the loading area.
  1. Click **{{ ui-key.yacloud.dataset.create }}**.

- SDK {#sdk}

  1. Create a file named `dataset-create.py` and add the following code to it:

     {% include [sdk-dataset](../../../_includes/foundation-models/examples/dataset-sdk.md) %}

  1. Run the created file:

     ```bash
     python3 dataset-create.py
     ```

     Result:

     ```text
     new tuning_dataset=Dataset(id='fdsv21bmp09v********', folder_id='b1gt6g8ht345********', name=
     'YandexGPT Lite tuning', description=None, metadata=None, created_by='ajegtlf2q28a********', 
     created_at=datetime.datetime(2025, 3, 12, 19, 31, 44), updated_at=datetime.datetime(2025, 3, 
     12, 19, 32, 20), labels=None, allow_data_logging=False, status=<DatasetStatus.READY: 3>, 
     task_type='TextToTextGeneration', rows=3, size_bytes=3514, validation_errors=())
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