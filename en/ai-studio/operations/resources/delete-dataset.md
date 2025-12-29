---
title: How to delete a dataset from {{ foundation-models-name }}
description: Follow this guide to delete a dataset from {{ foundation-models-name }} using the management console, API, and {{ ml-sdk-name }}.
---

# Deleting a dataset

## Getting started {#before-begin}

{% include [tuning-before-beginning](../../../_includes/ai-studio/tuning-before-beginning.md) %}

## Delete a dataset {#delete-dataset}

To delete a dataset:

{% list tabs group=programming_language %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) for which your account has the `ai.playground.user` and `ai.datasets.editor` [roles](../../security/index.md) or higher.
  1. [Go](../../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.dashboard.DashboardPage.AiStudioSection.section_title_1sDGx }}**.
  1. In the **{{ ui-key.yacloud.iam.folder.dashboard.label_ai-studio }}** panel, select ![image](../../../_assets/console-icons/layers.svg) **{{ ui-key.yacloud.dataset.datasets }}**.
  1. In the list that opens, click ![ellipsis](../../../_assets/console-icons/ellipsis.svg) next to the dataset in question and select ![trash-bin](../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.
  1. In the window that opens, confirm the deletion.

- SDK {#sdk}

  1. Create a file named `dataset-delete.py` and paste the following code into it:

      ```python
      from __future__ import annotations

      from yandex_cloud_ml_sdk import YCloudML

      YANDEX_API_KEY = "<API_key>"
      YANDEX_FOLDER_ID = "<folder_ID>"
      DATASET_ID = "<dataset_ID>"


      def main() -> None:

          sdk = YCloudML(
              folder_id=YANDEX_FOLDER_ID,
              auth=YANDEX_API_KEY,
          )

          # Saving the object with the dataset to delete into a variable
          dataset_to_delete = sdk.datasets.get(dataset_id=DATASET_ID)

          # Deleting a dataset
          dataset_to_delete.delete()


      if __name__ == "__main__":
          main()
      ```

      Where:

      * `YANDEX_API_KEY`: Service account [API key](../../../iam/concepts/authorization/api-key.md) you got before you started.
      * `YANDEX_FOLDER_ID`: [ID of the folder](../../../resource-manager/operations/folder/get-id.md) containing the dataset you are deleting.
      * `DATASET_ID`: ID of the dataset to delete. You can view the list of all datasets in the folder using the [management console]({{ link-console-main }}) or the [API](../../dataset/api-ref/grpc/Dataset/list.md).
      
          In {{ ml-sdk-name }}, you can view the list of datasets in the folder using the `list()` method.

          ```python
          for dataset in sdk.datasets.list():
              print(f"List of existing datasets {dataset=}")
          ```
  1. Run the file you created:

      ```bash
      python3 dataset-delete.py
      ```

      This will delete the specified dataset.

- cURL {#curl}

  1. Get the ID of the dataset you want to delete:
  
      ```bash
      grpcurl \
        -H "Authorization: Bearer <IAM_token>" \
        -d @ \
        {{ api-host-llm }}:443 yandex.cloud.ai.dataset.v1.DatasetService/List <<EOM
        {
          "folder_id": "<folder_ID>"
        }
      EOM
      ```

      Where:
      * `<IAM_token>`: [IAM token](../../../iam/concepts/authorization/iam-token.md) of the service account you got [before you started](#before-begin).
      * `<folder_ID>`: [ID of the folder](../../../resource-manager/operations/folder/get-id.md) you are creating the dataset in.

     Result:

     ```json
      {
        "datasets": [
          {
            "datasetId": "fdsl9hf65509********",
            "folderId": "b1gt6g8ht345********",
            "name": "sample-dataset",
            "status": "READY",
            "taskType": "TextToTextGeneration",
            "createdAt": "2025-11-28T08:53:59Z",
            "updatedAt": "2025-11-28T08:54:38Z",
            "rows": "354",
            "sizeBytes": "32314",
            "createdById": "ajeol2afu1js********",
            "createdBy": "ajeol2afu1js********"
          }
        ]
      }
     ```

     Save the ID of the dataset you want to delete (the `datasetId` field value): you will need it to delete the dataset.

  1. Delete the dataset:

      ```bash
      grpcurl \
        -H "Authorization: Bearer <IAM_token>" \
        -d @ \
        {{ api-host-llm }}:443 yandex.cloud.ai.dataset.v1.DatasetService/Delete <<EOM
        {
          "dataset_id": "<dataset_ID>"
        }
      EOM
      ```

      Where:
      * `<IAM_token>`: [IAM token](../../../iam/concepts/authorization/iam-token.md) of the service account you got [before you started](#before-begin).
      * `<dataset_ID>`: Dataset ID you saved in the previous step.

     The gRPC call will delete the specified dataset.


{% endlist %}

#### See also {#see-also}

* [{#T}](./create-dataset.md)