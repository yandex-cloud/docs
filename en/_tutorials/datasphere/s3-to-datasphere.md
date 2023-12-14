# Using data from {{ objstorage-name }} to train a model in {{ ml-platform-name }}

You will create a bucket in [{{ objstorage-full-name }}](../../storage/), mount it to the Windows file system using [rclone](https://rclone.org), and upload data to this bucket to train a model in [{{ ml-platform-full-name }}]({{ link-datasphere-main }}).

To use data from {{ objstorage-name }} to train a model in {{ ml-platform-name }}:

1. [Prepare your infrastructure](#infra).
1. [Create a static access key](#create-static-key).
1. [Create a bucket](#bucket-create).
1. [Set up a connection to {{ objstorage-name }}](#rclone-config).
1. [Mount the bucket](#bucket-mount).
1. [Prepare data for model training](#prepare-data).
1. [Create an S3 connector](#create-s3).
1. [Attach your bucket to a project](#create-s3).
1. [Train the model](#train-model).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin-datasphere.md) %}

### Required paid resources {#paid-resources}

The cost of training a model based on data from {{ objstorage-name }} includes:

* Fee for [{{ ml-platform-name }} computing resource](../../datasphere/pricing.md) usage.
* Fee for storing data in a bucket (see [{{ objstorage-name }} pricing](../../storage/pricing.md#prices-storage)).
* Fee for data operations (see [{{ objstorage-name }} pricing](../../storage/pricing.md#prices-operations)).

## Prepare the infrastructure {#infra}

{% include [intro](../../_includes/datasphere/infra-intro.md) %}

{% include [intro](../../_includes/datasphere/federation-disclaimer.md) %}

### Set up a working environment {#environment-prepare}

{% list tabs %}

- Windows

   1. Download and install the [winfsp distribution](https://winfsp.dev/rel/) from the developer site.
   1. Download the [archive with sysinternals suite utilities](https://docs.microsoft.com/en-us/sysinternals/downloads/) and unpack it to your working directory on your local desktop.
   1. From the developer's site, download an [archive with the Windows Service Wrapper (winsw)](https://github.com/winsw/winsw/releases) and unpack it to your local working directory.
   1. From the developer's site, download an [archive with the rclone utility](https://rclone.org/downloads/) and unpack it to your local working directory.

{% endlist %}

### Create a folder {#create-folder}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select a cloud and click ![create](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.component.console-dashboard.button_action-create-folder }}**.
   1. Give your folder a name, e.g., `data-folder`.
   1. Click **{{ ui-key.yacloud.iam.cloud.folders-create.button_create }}**.

{% endlist %}

### Create a service account for {{ objstorage-name }} {#create-sa}

To access a bucket in {{ objstorage-name }}, you need a [service account](../../iam/concepts/users/service-accounts.md) with the `storage.editor` role.

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to `data-folder`.
   1. In the **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}** tab, click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
   1. Enter a name for the service account, e.g., `datasphere-sa`.
   1. Click **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** and assign the `storage.editor` role to the service account.
   1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

{% endlist %}

## Create a static access key {#create-static-key}

To access {{ objstorage-name }} from {{ ml-platform-name }}, you need a static key.

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder the service account belongs to.
   1. At the top of the screen, go to the **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}** tab.
   1. Select the `datasphere-sa` service account.
   1. In the top panel, click ![](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}**.
   1. Select **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_service-account-key }}**.
   1. Specify the key description and click **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_create }}**.
   1. Save the ID and private key. Once you close the dialog, the private key value will be unavailable.

- CLI

   1. Create an access key for the `datasphere-sa` service account:

      ```bash
      yc iam access-key create --service-account-name datasphere-sa
      ```

      Result:

      ```
      access_key:
        id: aje6t3vsbj8l********
        service_account_id: ajepg0mjt06s********
        created_at: "2022-07-18T14:37:51Z"
        key_id: 0n8X6WY6S24N7Oj*****
      secret: JyTRFdqw8t1kh2-OJNz4JX5ZTz9Dj1rI9hx*****
      ```

      For more information about the `yc iam access-key create` command, see the [CLI reference](../../cli/cli-ref/managed-services/iam/access-key/create.md).

   1. Save the ID `key_id` and `secret` key. You will not be able to get the key value again.

- API

   To create an access key, use the [create](../../iam/api-ref/AccessKey/create.md) method for the [AccessKey](../../iam/api-ref/AccessKey/index.md) resource.

{% endlist %}

## Create a bucket {#bucket-create}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create a bucket.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
   1. At the top right, click **{{ ui-key.yacloud.storage.buckets.button_create }}**.
   1. In the **{{ ui-key.yacloud.storage.bucket.settings.field_name }}** field, enter a name for the bucket following the [naming conventions](../../storage/concepts/bucket.md#naming).
   1. In the **{{ ui-key.yacloud.storage.bucket.settings.field_access-read }}**, **{{ ui-key.yacloud.storage.bucket.settings.field_access-list }}**, and **{{ ui-key.yacloud.storage.bucket.settings.field_access-config-read }}** fields, select **{{ ui-key.yacloud.storage.bucket.settings.access_value_private }}**.
   1. Click **{{ ui-key.yacloud.storage.buckets.create.button_create }}**.

- AWS CLI

   1. If you do not have the AWS CLI yet, [install and configure it](../../storage/tools/aws-cli.md).
   1. Enter the bucket name following the [naming conventions](../../storage/concepts/bucket.md#naming):

      ```bash
      aws --endpoint-url https://{{ s3-storage-host }} \
        s3 mb s3://<bucket_name>
      ```

      Result:

      ```text
      make_bucket: <bucket_name>
      ```

- {{ TF }}

   {% include [terraform-install](../../_includes/terraform-install.md) %}

   1. Add a section with bucket parameters to the configuration file and enter the bucket name following the [naming conventions](../../storage/concepts/bucket.md#naming):

      ```hcl
      resource "yandex_storage_bucket" "<bucket_name>" {
        bucket = "<bucket_name>"
      }
      ```

      For more information about the `yandex_storage_bucket` resource, see the [{{ TF }} provider documentation]({{ tf-provider-link }}/storage_bucket).

   1. Create resources:
      {% include [terraform-validate-plan-apply](../../_tutorials/terraform-validate-plan-apply.md) %}

      {{ TF }} will create all the required resources. You can check the new resources and their configuration using the [management console]({{ link-console-main }}).

- API

   Use the [create](../../storage/api-ref/Bucket/create.md) REST API method for the [Bucket](../../storage/api-ref/Bucket/index.md) resource, the [BucketService/Create](../../storage/api-ref/grpc/bucket_service.md#Create) gRPC API call, or the [create](../../storage/s3/api-ref/bucket/create.md) S3 API method.

{% endlist %}

## Set up a connection to {{ objstorage-name }} {#rclone-config}

To move data from your local disk to {{ objstorage-name }}, configure the `rclone` utility.

1. Open the command prompt in your working directory as an admin user and run the following command:

   ```powershell
   psexec -i -s cmd.exe
   ```

1. In the console that opens, run `whoami` and make sure that the session has been started by the system user.
1. Go to the working directory and run a configuration session for `rclone`:

   ```powershell
   rclone.exe config
   ```

1. Follow the prompts to create a new connection profile:

   1. Select creation of a new profile: enter `n` in the terminal.
   1. Enter the connection name: `s3-connect`.
   1. Select the storage type: enter `5` in the terminal.
   1. Select a provider: enter `1` in the terminal.
   1. Select manual entry of credentials: enter `1` in the terminal.
   1. Enter the secret key ID in the terminal.
   1. Enter the secret key value in the terminal.
   1. Specify a region: enter `{{ region-id }}` in the terminal.
   1. Specify an endpoint: enter `{{ s3-storage-host }}` in the terminal.
   1. You can leave other settings at defaults: press **Enter** to skip them.

{% note info %}

If required, you can run an advanced connection setup. For this, at the `Edit advanced config?` prompt, enter `y` in the terminal: For more information about advanced settings, see the `rclone` [documentation](https://rclone.org/s3/).

{% endnote %}

## Mount the bucket to the Windows file system {#bucket-mount}

1. Check the connection to the bucket. In the same terminal where you configured your connection, run the following command with the bucket name specified:

   ```powershell
   rclone.exe ls s3-connect:<bucket_name>
   ```

   If the configuration is set up correctly, the objects in the bucket will be listed in the console.

1. Mount the bucket to the file system specifying the bucket name and an available drive letter in the file system:

   ```powershell
   rclone.exe mount s3-connect:<bucket_name> <drive_letter>: --vfs-cache-mode full
   ```

   You will see a new disk with the objects from the bucket in Windows Explorer.

## Prepare data for model training {#prepare-data}

1. [Download a CSV file](https://storage.yandexcloud.net/doc-files/diabetes_data.csv) with diabetes prediction data. A dataset is created based on [Kaggle](https://www.kaggle.com/datasets/alexteboul/diabetes-health-indicators-dataset?select=diabetes_012_health_indicators_BRFSS2015.csv) data for 2015.
1. Copy the file to the mounted bucket.

## Attach your bucket to a project {#create-s3}

To connect to your bucket from {{ ml-platform-name }}, you need an S3 connector:

1. {% include [find project](../../_includes/datasphere/ui-find-project.md) %}
1. In the top-right corner, click **{{ ui-key.yc-ui-datasphere.common.create-resource }}**. In the pop-up window, select **{{ ui-key.yc-ui-datasphere.resources.s3 }}**.
1. Fill out the fields below:
   * **{{ ui-key.yc-ui-datasphere.common.name }}**: Name of the connector being created, such as `s3-datasphere-connect`.
   * **{{ ui-key.yc-ui-datasphere.common.endpoint }}**: {{ objstorage-full-name }} host (`https://{{ s3-storage-host }}/`).
   * **{{ ui-key.yc-ui-datasphere.common.bucket }}**: Name of your bucket.
   * **{{ ui-key.yc-ui-datasphere.new-s3-page.mount-name }}**: Name of the volume for mounting the bucket into the project file system.
   * **{{ ui-key.yc-ui-datasphere.new-s3-page.access-key-id }}** used to connect to storage.
   * In the **{{ ui-key.yc-ui-datasphere.new-s3-page.static-access-key }}** field, click **{{ ui-key.yc-ui-datasphere.common.create }}**. In the window that opens, enter the secret name and the secret key being used to connect to storage.
1. Click **{{ ui-key.yc-ui-datasphere.common.create }}**.
1. Go to the S3 connector page and click **{{ ui-key.yc-ui-datasphere.common.activate }}**. Once activated, the bucket is available in the {{ jlab }}Lab interface in the list on the **S3 Mounts** ![S3 Mounts](../../_assets/console-icons/bucket.svg) tab, and you can view it as a file system.

## Train the model {#train-model}

Clone the Git repository that contains the `diabetes_catboost.ipynb` notebook with an example of [CatBoost](https://catboost.ai/) model training:

1. {% include [include](../../_includes/datasphere/ui-before-begin.md) %}
1. In the top menu, click **Git** and select **Clone**.
1. In the window that opens, specify the repository URI: `https://github.com/yandex-cloud-examples/yc-datasphere-s3-mount.git`, and then click **Clone**.

In the `diabetes_catboost.ipynb` notebook, you will connect to the `diabetes_data.csv` dataset in the bucket you mounted and train the `CatBoost` model:

1. Install the required modules:

   ```python
   %pip install catboost
   %pip install scikit-learn
   %pip install ipywidgets
   ```

1. Import the required libraries:

   ```python
   import pandas as pd
   from catboost import CatBoostClassifier
   from sklearn.metrics import classification_report
   from sklearn.model_selection import train_test_split
   ```

1. Upload data for model training:

   ```python
   data = pd.read_csv('<dataset_path>')
   data.head()
   ```

   To get the `diabetes_data.csv` file path, open the **S3 Mounts** ![S3 Mounts](../../_assets/console-icons/bucket.svg) tab, right-click the file, and select **Copy path**.

1. Separate training factors from the target variable:

   ```python
   X = data.loc[:, data.columns != 'Diabetes_binary']
   y = data['Diabetes_binary']
   ```

1. Divide the sample into training and test ones:

   ```python
   X_train, X_validation, y_train, y_validation = train_test_split(X, y, train_size=0.75, random_state=42)
   ```

1. Create a classifier named `СatBoost` and set hyperparameters:

   ```python
   model = CatBoostClassifier(
       iterations=100,
       random_seed=42,
       logging_level='Verbose'
   )
   ```

1. Start model training:

   ```python
   model.fit(
       X_train, y_train,
       eval_set=(X_validation, y_validation),
       plot=True
   )
   ```

1. Output the trained model quality metrics:

   ```python
   print(classification_report(y_validation, model.predict(X_validation)))
   ```

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:
* [Delete the objects](../../storage/operations/objects/delete-all.md) from the bucket.
* [Delete the bucket](../../storage/operations/buckets/delete.md).
* [Delete](../../datasphere/operations/projects/delete.md) your project.
