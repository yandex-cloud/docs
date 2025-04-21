---
title: How to create a dataset for text classification in {{ foundation-models-name }}
description: Follow this guide to create a dataset for text classification in {{ foundation-models-name }} in the management console, using the API, and using {{ ml-sdk-name }}.
---

# Creating a dataset for tuning a text classification model

## Getting started {#before-begin}

{% include [tuning-before-beginning](../../../_includes/foundation-models/tuning-before-beginning.md) %}

## Upload the dataset {#create-dataset}

Depending on the [classification type](../../concepts/classifier/index.md) the fine-tuned model will be used for, prepare [UTF-8](https://{{ lang }}.wikipedia.org/wiki/UTF-8)-encoded [tuning data](../../concepts/resources/dataset.md#classifier) in [JSON Lines format](https://jsonlines.org/). If you want to split your data into two datasets for tuning and validation, repeat the steps below for each dataset. Use the IDs you got after uploading the datasets to start the fine-tuning process.

Create a tuning dataset:

{% list tabs group=programming_language %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder for which your account has the `ai.playground.user` and `ai.datasets.editor` [roles](../../security/index.md) or higher.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_foundation-models }}**.
  1. In the left-hand panel, click ![image](../../../_assets/console-icons/layers.svg) **{{ ui-key.yacloud.dataset.datasets }}**.
  1. Click **{{ ui-key.yacloud.dataset.create }}**.
  1. Enter a name and descriptions for the dataset. Follow these naming requirements:

     {% include [name-format](../../../_includes/name-format.md) %}

  1. In the **{{ ui-key.yacloud.common.type }}** field, select the classification type: **{{ ui-key.yacloud.dataset.text-classification-multilabel-key-value }}** or **{{ ui-key.yacloud.dataset.text-classification-multiclass-key-value }}**.
  1. Optionally, add or delete dataset [labels](../../../resource-manager/concepts/labels.md). They allow you to group resources into logical groups.
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