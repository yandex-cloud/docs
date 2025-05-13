---
title: How to create a dataset in {{ foundation-models-name }}
description: Follow this guide to create any dataset in {{ foundation-models-name }} in the management console, using the API, and using {{ ml-sdk-name }}.
---

# Creating a dataset

## Getting started {#before-begin}

{% include [tuning-before-beginning](../../../_includes/foundation-models/tuning-before-beginning.md) %}


Prepare a [UTF-8](https://{{ lang }}.wikipedia.org/wiki/UTF-8)-encoded [dataset](../../concepts/resources/dataset.md) file in [JSON Lines](https://jsonlines.org/) format. Dataset contents structure depends on the type of dataset.

## Get the JSON schema of the dataset {#get-schema}

If you need a JSON schema to prepare your data, you can get the structure of any dataset type via an API request:

{% list tabs group=programming_language %}

- cURL {#curl}

  ```json
  grpcurl \
    -H "Authorization: Bearer <IAM_token>" \
    -d '{"task_type": "<dataset_type>"}' \
    llm.api.cloud.yandex.net:443 yandex.cloud.ai.dataset.v1.DatasetService.ListUploadSchemas
  ```
  
  Where:
  * `<IAM_token>`
  * `<dataset_type>`: Dataset type for which you are requesting the JSON schema. The possible values are:
  
    {% include [dataset-types](../../../_includes/foundation-models/dataset-types.md) %}

{% endlist %}

## Upload the dataset {#create-dataset}

{% list tabs group=programming_language %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder for which your account has the `ai.playground.user` and `ai.datasets.editor` [roles](../../security/index.md) or higher.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_foundation-models }}**.
  1. In the left-hand panel, click ![image](../../../_assets/console-icons/layers.svg) **{{ ui-key.yacloud.dataset.datasets }}**.
  1. Click **{{ ui-key.yacloud.dataset.create }}**.
  1. Enter a name and descriptions for the dataset. The naming requirements are as follows:

     {% include [name-format](../../../_includes/name-format.md) %}

  1. In the **{{ ui-key.yacloud.common.type }}** field, select dataset type.
  1. Optionally, add or delete dataset [labels](../../../resource-manager/concepts/labels.md). They allow you to group resources into logical groups.
  1. Click **Select file** or drag the JSON file you created earlier to the loading area.
  1. Click **{{ ui-key.yacloud.dataset.create }}**.

- SDK {#sdk}

  1. Create a file named `dataset-create.py` and add the following code to it:

     {% include [dataset-sdk](../../../_includes/foundation-models/examples/dataset-sdk-create.md) %}

     Where:
     * `<IAM_token>`: [IAM token](../../../iam/concepts/authorization/iam-token.md) of the service account you got [before you started](#before-begin).
     * `<folder_ID>`: [ID of the folder](../../../resource-manager/operations/folder/get-id.md) you are creating the dataset in.
     * `<file_path>`: Path to the file prepared earlier.
     * `<dataset_type>`: [Type](#get-schema) of the new dataset. 

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

     Save the new dataset's ID (the `id` field value): you will need it to run the model.

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
         "task_type": "<dataset_type>", 
         "upload_format": "jsonlines"
       }
     EOM
     ```

     Where:
     * `<IAM_token>`: [IAM token](../../../iam/concepts/authorization/iam-token.md) of the service account you got [before you started](#before-begin).
     * `<folder_ID>`: [ID of the folder](../../../resource-manager/operations/folder/get-id.md) you are creating the dataset in.
     * `<dataset_type>`: [Type](#get-schema) of the new dataset. 

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