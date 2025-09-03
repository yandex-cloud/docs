
# Model fine-tuning in {{ ml-platform-name }} Notebooks

You can [fine-tune](../../foundation-models/concepts/tuning/index.md) language models enabled by {{ foundation-models-full-name }} through APIs or {{ ml-sdk-name }} to better understand the specific features of your tasks. It is convenient to run fine-tuning on [{{ ml-platform-full-name }}](../../datasphere/) notebooks.

In this tutorial, you will fine-tune a model in {{ ml-platform-name }} using the SDK. You can also clone the [repository](https://github.com/yandex-cloud-examples/yc-foundation-models-datasphere-tuning) and run the notebook locally by changing the [authentication settings](../../foundation-models/sdk/index.md).

To fine-tune a model:

1. [Set up your infrastructure](#infra).
1. [Create an API key for the service account](#create-key).
1. [Create secrets](#create-secrets).
1. [Fine-tune your model](#fine-tuning).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin-datasphere.md) %}

### Required paid resources {#paid-resources}

The infrastructure support cost for fine-tuning a model includes:

* Fee for using [{{ ml-platform-name }} computing resources](../../datasphere/pricing.md).
* Fee for [text generation](../../foundation-models/pricing.md) by the model.

## Set up your infrastructure {#infra}

{% include [intro](../../_includes/datasphere/infra-intro.md) %}

{% include [intro](../../_includes/datasphere/federation-disclaimer.md) %}

### Create a folder {#create-folder}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select a cloud and click ![create](../../_assets/console-icons/plus.svg)**{{ ui-key.yacloud.component.console-dashboard.button_action-create-folder }}**.
   1. Name your folder, e.g., `data-folder`.
   1. Click **{{ ui-key.yacloud.iam.cloud.folders-create.button_create }}**.

{% endlist %}

### Create a service account for the {{ ml-platform-name }} project {#create-sa}

{% list tabs group=instructions %}

- Management console {#console}

  1. Navigate to `data-folder`.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. Click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
  1. Name the [service account](../../iam/concepts/users/service-accounts.md), e.g., `gpt-user`.
  1. Click **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** and assign the `{{ roles-yagpt-user }}` role to the service account.
  1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

{% endlist %}

### Add the service account to the project {#sa-to-project}

To enable the service account to access the model from the notebook, add it to the list of project members.

{% list tabs group=instructions %}

- Management console {#console}

  1. {% include [find project](../../_includes/datasphere/ui-find-project.md) %}
  1. In the **{{ ui-key.yc-ui-datasphere.project-page.tab.members }}** tab, click **{{ ui-key.yc-ui-datasphere.common.add-member }}**.
  1. Select the `gpt-user` account and click **{{ ui-key.yc-ui-datasphere.common.add }}**.

{% endlist %}

## Create an API key for the service account {#create-key}

To enable the service account to access the model, create an [API key](../../iam/concepts/authorization/api-key.md).

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to `data-folder`.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. In the left-hand panel, select ![FaceRobot](../../_assets/console-icons/face-robot.svg) **{{ ui-key.yacloud.iam.label_service-accounts }}**.
  1. In the list that opens, select the `gpt-user` service account.
  1. In the top panel, click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}** and select **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_api_key }}**.
  1. Click **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_create }}**.
  1. Save the ID and secret key.

{% endlist %}

## Create secrets {#create-secrets}

To get the API key and folder ID from the notebook, create [secrets](../../datasphere/concepts/secrets.md) with the key and folder IDs.

1. {% include [find project](../../_includes/datasphere/ui-find-project.md) %}
1. Under **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}**, click ![secret](../../_assets/console-icons/shield-check.svg)**{{ ui-key.yc-ui-datasphere.resources.secret }}**.
1. Click **{{ ui-key.yc-ui-datasphere.common.create }}**.
1. In the **{{ ui-key.yc-ui-datasphere.secret.name }}** field, enter the name for the secret: `API_KEY`.
1. In the **{{ ui-key.yc-ui-datasphere.secret.content }}** field, paste the key ID.
1. Click **{{ ui-key.yc-ui-datasphere.common.create }}**.
1. Create another secret named `FOLDER_ID` and containing the folder ID.

## Fine-tune the model {#fine-tuning}

You will run the fine-tuning code from the {{ ml-platform-name }} notebook. [Fine-tuning data](../../foundation-models/concepts/resources/dataset.md#generating) is stored in [JSON Lines](https://jsonlines.org/) format.

1. Open the notebook with the code by following the link below:

   <a href="{{ link-datasphere-main }}/import-ipynb?path=https://raw.githubusercontent.com/yandex-cloud-examples/yc-foundation-models-datasphere-tuning/main/LoRA-train-YandexGPT.ipynb"><img src="https://storage.yandexcloud.net/datasphere-assets/datasphere_badge_v2_ru.svg" 
     alt="Open in {{ ml-platform-name }}"/></a>

1. Download the `generations.jsonlines` file from the [GitHub](https://github.com/yandex-cloud-examples/yc-foundation-models-datasphere-tuning) repository and place it in the same directory as your notebook.

1. Install the {{ ml-platform-name }} SDK by running this code in a notebook cell:

   ```python
   %pip install yandex-cloud-ml-sdk --upgrade
   ```

1. Import the required libraries:

   ```python
   import pathlib
   import uuid
   import os
   from __future__ import annotations

   from yandex_cloud_ml_sdk import YCloudML
   import urllib.request
   import zipfile   
   ```

1. Run [TensorBoard](https://www.tensorflow.org/tensorboard?hl={{ lang }}). You will need it to view fine-tuning metrics:

   ```python
   def download_tensorboard(url):
       urllib.request.urlretrieve(url, "tensorboard.zip")
       with zipfile.ZipFile('tensorboard.zip', 'r') as zip_ref:
           zip_ref.extractall("tensorboard")
   ```

1. Upload the data for model fine-tuning:

   ```python
   def local_path(path: str) -> pathlib.Path:
       return pathlib.Path(path)

   dataset_path = local_path("generations.jsonlines")
   print(dataset_path)

   print("Tuning dataset")
   print(dataset_path.read_text())
   ```

1. Create an SDK object containing the authorization parameters:

   ```python
   sdk = YCloudML(
       folder_id=os.environ['FOLDER_ID'], # Folder ID stored in the DataSphere secret.
       auth=os.environ['API_KEY'] # Service account API key stored in the DataSphere secret.
   )
   ```

1. Create a dataset for fine-tuning and initiate its loading and validation:

   ```python
   dataset_draft = sdk.datasets.draft_from_path(
       task_type='TextToTextGeneration',
       path=dataset_path,
       upload_format='jsonlines',
       name='test-generations'
   )

   dataset = dataset_draft.upload()
   print('Dataset is being loaded and validated')
   print(f'New dataset {dataset=} \n')
   ```

1. Select the base model you want to fine-tune and run fine-tuning. In our example, it is {{ gpt-lite }}:

   ```python
   base_model = sdk.models.completions('yandexgpt-lite')

   tuning_task = base_model.tune_deferred(
       dataset,
       name=str(uuid.uuid4()),
       n_samples=10000 
   )
   
   print(f'Tuning started {tuning_task} \n')

   # Fine-tuning can last up to several hours.
   # Wait until the fine-tuning is complete to get a new model.
   new_model = tuning_task.wait()
   print(f'Tuning completed, new model = {new_model} \n')
   ```

1. Get your fine-tuned model:

   ```python
   # If you closed your notebook, you can use task_id to check the operation status.
   tuning_task = sdk.tuning.get(task_id)
   print(tuning_task.get_task_info())

   new_model = tuning_task.get_result()
   print({new_model})
   ```

1. Test your new model:

   ```python
   print('Sending queries to the new model\n')
   # Examples of queries to the model
   completion_result = new_model.run("What is your name?")
   print(f'{completion_result=} \n')

   # You can use the fine-tuned model by specifying its URI.
   tuned_uri = new_model.uri 
   model = sdk.models.completions(tuned_uri)

   completion_result = model.run("Where are you from?")
   print(f'{completion_result=} \n')
   ```

   The model will generate and return answers considering the fine-tuning.

1. Download fine-tuning metrics:

   ```python
   # Get the link with the data for TensorBoard and download the files.
   metrics_url = new_model.get_metrics_url()
   download_tensorboard(metrics_url)
   ```

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created, [delete the project](../../datasphere/operations/projects/delete.md).