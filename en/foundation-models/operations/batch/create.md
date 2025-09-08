---
title: Running a model in batch mode in {{ foundation-models-name }}
description: Follow this guide to process large amounts of data by running a model in batch mode.
---

# Running a model in batch mode

## Getting started {#before-begin}


{% list tabs group=programming_language %}

- Management console {#console}

  You can start working from the management console right away.

- SDK {#sdk}

  1. [Create](../../../iam/operations/sa/create.md) a service account and [assign](../../../iam/operations/sa/assign-role-for-sa.md) the `ai.editor` role to it.
  1. [Get](../../../iam/operations/authentication/manage-api-keys.md#create-api-key) the service account API key and save it.

      {% include [sdk-auth-details-paragraph](../../../_includes/foundation-models/sdk-auth-details-paragraph.md) %}
  1. Use the [pip](https://pip.pypa.io/en/stable/) package manager to install the [{{ ml-sdk-name }}](../../sdk/index.md) library:

      ```bash
      pip install yandex-cloud-ml-sdk
      ```

{% endlist %}

## Prepare data {#create-dataset}

1. Prepare data to run the model. Depending on your task and model, it can be `TextTextToTextGenerationRequest` for [text generation](../../concepts/resources/dataset.md#text-requests) or `ImageTextToTextGenerationRequest` for [vision language models](../../concepts/resources/dataset.md#vlm-requests).
1. [Create a dataset](../resources/create-dataset.md) in any convenient way. You can also create a dataset later when running the model.

## Run the model {#run-batch}

{% list tabs group=programming_language %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder for which your account has the `ai.playground.user` and `ai.datasets.editor` [roles](../../security/index.md) or higher.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_foundation-models }}**.
  1. In the left-hand panel, click ![image](../../../_assets/console-icons/ellipsis.svg) and select ![image](../../../_assets/console-icons/gear-play.svg) **Batch jobs**.
  1. Click **Run**.
  1. Select a model to run.
  1. Add a dataset: select an existing one or upload a new file.
  1. Set the model temperature.
  1. Click **Run**.

- SDK {#sdk}

  1. Create a file named `batch-run.py` and add the following code to it:

     {% include [batch-run](../../../_includes/foundation-models/examples/batch-run.md) %}

     Where:

     * `<folder_ID>`: [ID of the folder](../../../resource-manager/operations/folder/get-id.md) the [service account](../../../iam/concepts/users/service-accounts.md) was created in.
     * `<API_key>`: Service account [API key](../../../iam/concepts/authorization/api-key.md) you got earlier required for [authentication in the API](../../../foundation-models/api-ref/authentication.md).

   	  {% include [sdk-auth-details-paragraph](../../../_includes/foundation-models/sdk-auth-details-paragraph.md) %}
        
     * `<model_URI>`: ID of the model to run. [Text generation](../../concepts/generation/models.md#batch) and vision language models are supported.
     * `<dataset_ID>`: ID of the dataset with requests to the model.

  1. Run the created file:

     ```bash
     python3 batch-run.py
     ```

{% endlist %}

{% note tip %}

The model runtime in batch mode depends on the dataset size and may take several days. You can track the current status in the [management console]({{ link-console-main }}/link/foundation-models/batches/).

{% endnote %}
