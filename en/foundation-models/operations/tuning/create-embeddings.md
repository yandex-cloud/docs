---
title: Creating a fine-tuned embedding model in {{ foundation-models-name }}
description: Follow this guide to create a dataset and fine-tune an embedding model in {{ foundation-models-name }} using {{ ai-playground }}, the API, and {{ ml-sdk-name }}.
---

# Fine-tuning an embedding model

{% include [lora-tuning-preview](../../../_includes/foundation-models/lora-tuning-preview.md) %}

This example shows how to [fine-tune](../../concepts/tuning/index.md) an embedding model based on the {{ lora }} method in {{ foundation-models-name }}. Links to other examples are available in the [See also](#see-also) section.

## Getting started {#before-begin}

{% include [tuning-before-beginning](../../../_includes/foundation-models/tuning-before-beginning.md) %}

## Prepare data {#create-dataset}

1. Prepare data in the required [format](../../concepts/resources/dataset.md#embeddings). To fine-tune an embedding model, use datasets of `TextEmbeddingPairParams` pairs or `TextEmbeddingTripletParams` triplets.
1. [Create a dataset](../resources/create-dataset.md) using any method of your choice. In the management console, you can also create a dataset later when creating the tuning.

## Start tuning {#start-tuning}

{% list tabs group=programming_language %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder for which your account has the `ai.playground.user`, `ai.datasets.user`, and `ai.models.editor` [roles](../../security/index.md) or higher.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_foundation-models }}**.
  1. In the left-hand panel, click ![image](../../../_assets/console-icons/sliders.svg) **{{ ui-key.yacloud.tuning.tunings }}**.
  1. Click **{{ ui-key.yacloud.tuning.train-model }}**.
  1. Enter a name and description for the tuned model. The naming requirements are as follows:

     {% include [name-format](../../../_includes/name-format.md) %}

  1. Optionally, add or delete the tuning [labels](../../../resource-manager/concepts/labels.md). You can use them to split or join resources into logical groups.
  1. In the **{{ ui-key.yacloud.tuning.task }}** field, select `{{ ui-key.yacloud.tuning.embedding }}`.
  1. Select **{{ ui-key.yacloud.tuning.embedding-type}}** that matches the prepared dataset. 
  1. In the **{{ ui-key.yacloud.yagpt.model }}** field, select the model you need.
  1. In the **{{ ui-key.yacloud.dataset.dataset }}** field, click ![plus](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.common.add }}**.
  1. In the window that opens, go to the **{{ ui-key.yacloud.dataset.select-from-created }}** tab and select the dataset you created earlier.
  1. Click **{{ ui-key.yacloud.tuning.addition-params }}** to do advanced fine-tuning setup.
  1. Click **{{ ui-key.yacloud.tuning.start-tuning }}**.

- SDK {#sdk}

  1. Create a file named `start-tuning.py` and add the following code to it:

     {% include [sdk-tuning-embeddings](../../../_includes/foundation-models/examples/tuning-sdk-embeddings.md) %}

     Where:

     * `<folder_ID>`: [ID of the folder](../../../resource-manager/operations/folder/get-id.md) the [service account](../../../iam/concepts/users/service-accounts.md) was created in.
     * `<API_key>`: Service account [API key](../../../iam/concepts/authorization/api-key.md) you got earlier required for [authentication in the API](../../../foundation-models/api-ref/authentication.md).

         {% include [sdk-auth-details-paragraph](../../../_includes/foundation-models/sdk-auth-details-paragraph.md) %}
     * `<dataset_type>`: Type of previously created [dataset](../../concepts/resources/dataset.md#embeddings). Possible values: `pair` and `triplet`.
     * `<dataset_ID>`: ID of the previously created dataset for fine-tuning.

  1. Run the file you created:

     ```bash
     python3 start-tuning.py
     ```

     Model tuning may take up to 1 day depending on the size of the dataset and the system load.

     Use the fine-tuned model's URI you got (the `uri` field value) when accessing the model.

  1. Fine-tuning metrics are available in TensorBoard format. You can open the downloaded file, for example, in the [{{ ml-platform-full-name }}]({{ link-datasphere-main }}) project:
  
     ```python
     metrics_url = new_model.get_metrics_url()
     download_tensorboard(metrics_url)
     ```

- cURL {#curl}

  1. Start tuning.
     
     * With a pair dataset:

       ```bash
       grpcurl \
         -H "Authorization: Bearer <IAM_token>" \
         -d @ \
         {{ api-host-llm }}:443 yandex.cloud.ai.tuning.v1.TuningService/Tune <<EOM
         {
           "base_model_uri": "emb://<folder_ID>/text-embeddings/latest",
           "train_datasets": [{"dataset_id": "<dataset_ID>", "weight": 1.0}],
           "name": "train-embeddings",
           "text_embedding_pair_params": {}
         } 
       EOM
       ```

     * With a triplet dataset:
     
       ```bash
       grpcurl \
         -H "Authorization: Bearer <IAM_token>" \
         -d @ \
         {{ api-host-llm }}:443 yandex.cloud.ai.tuning.v1.TuningService/Tune <<EOM
         {
           "base_model_uri": "emb://<folder_ID>/text-embeddings/latest",
           "train_datasets": [{"dataset_id": "<dataset_ID>", "weight": 1.0}],
           "name": "train-embeddings",
           "text_embedding_triplet_params": {}
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
       "id": "ftna7bps63gh********",
       "createdAt": "2025-07-16T10:44:57Z",
       "modifiedAt": "2025-07-16T10:44:57Z",
       "metadata": {
         "@type": "type.googleapis.com/yandex.cloud.ai.tuning.v1.TuningMetadata",
         "status": "CREATED",
         "tuningTaskId": "ftna7bps63gh********"
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
       "id": "ftna7bps63gh********",
       "createdAt": "2025-07-16T10:44:57Z",
       "modifiedAt": "2025-07-16T10:48:07Z",
       "done": true,
       "metadata": {
         "@type": "type.googleapis.com/yandex.cloud.ai.tuning.v1.TuningMetadata",
         "status": "COMPLETED",
         "tuningTaskId": "ftna7bps63gh********"
       },
       "response": {
         "@type": "type.googleapis.com/yandex.cloud.ai.tuning.v1.TuningResponse",
         "status": "COMPLETED",
         "targetModelUri": "emb://b1gt6g8ht345********/text-embeddings/latest@tamr0j6m2crpi********",
         "tuningTaskId": "ftna7bps63gh********"
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

     You can open the downloaded file, for example, in the [{{ ml-platform-full-name }}]({{ link-datasphere-main }}) project.

{% endlist %}

### Accessing a fine-tuned model {#model-call}

Once the model is fine-tuned, save its URI in this format: `emb://<folder_ID>/text-embeddings/latest@<tuning_suffix>`. Use it as a custom embedding model, if needed. For example, you can specify `model_uri` when [building a search index](../../concepts/assistant/search-index.md).

#### See also {#see-also}

* [{#T}](../../concepts/tuning/index.md)
* [{#T}](./create.md)
* [{#T}](./tune-classifiers.md)
* [{#T}](../../tutorials/models-fine-tuning.md)
* For more SDK examples, see our [GitHub repository](https://github.com/yandex-cloud/yandex-cloud-ml-sdk/tree/classifiers_tuning/examples/sync/tuning).