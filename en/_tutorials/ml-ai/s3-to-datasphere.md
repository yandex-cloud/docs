# Using data from {{ objstorage-full-name }} to train a model in {{ ml-platform-name }}


You will create a [bucket](../../storage/concepts/bucket.md) in [{{ objstorage-name }}](../../storage/), mount it to the Windows file system using [rclone](https://rclone.org), and upload data to this bucket to train a [model](../../datasphere/concepts/models/index.md) in [{{ ml-platform-full-name }}]({{ link-datasphere-main }}).

To use data from {{ objstorage-name }} to train a model in {{ ml-platform-name }}:
1. [Set up your infrastructure](#infra).
1. [Create a static access key](#create-static-key).
1. [Create a bucket](#bucket-create).
1. [Set up a connection to {{ objstorage-name }}](#rclone-config).
1. [Mount your bucket](#bucket-mount).
1. [Prepare data for model training](#prepare-data).
1. [Create an S3 connector](#create-s3).
1. [Attach your bucket to a project](#create-s3).
1. [Train your model](#train-model).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin-datasphere.md) %}

### Required paid resources {#paid-resources}

The cost of training a model based on data from {{ objstorage-name }} includes:
* Fee for using [{{ ml-platform-name }} computing resource](../../datasphere/pricing.md).
* Fee for storing data in a bucket (see [{{ objstorage-name }} pricing](../../storage/pricing.md#prices-storage)).
* Fee for data operations (see [{{ objstorage-name }} pricing](../../storage/pricing.md#prices-operations)).

## Set up your infrastructure {#infra}

{% include [intro](../../_includes/datasphere/infra-intro.md) %}

{% include [intro](../../_includes/datasphere/federation-disclaimer.md) %}

### Set up the runtime environment {#environment-prepare}

{% list tabs group=operating_system %}

- Windows {#windows}

  Download and install the [winfsp distribution](https://winfsp.dev/rel/) from the `winfsp` website.

  Download from the respective developer’s website and unpack to the working directory on your local computer:
  * [_Sysinternals Suite_ archive](https://docs.microsoft.com/en-us/sysinternals/downloads/)
  * [_Windows Service Wrapper (winsw)_ archive](https://github.com/winsw/winsw/releases)
  * [_Rclone_ archive](https://rclone.org/downloads/)

{% endlist %}

### Create a folder {#create-folder}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select a [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud) and click ![create](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.component.console-dashboard.button_action-create-folder }}**.
  1. Name your [folder](../../resource-manager/concepts/resources-hierarchy.md#folder), e.g., `data-folder`.
  1. Click **{{ ui-key.yacloud.iam.cloud.folders-create.button_create }}**.

{% endlist %}

### Create a service account for {{ objstorage-name }} {#create-sa}

To access a bucket in {{ objstorage-name }}, you will need a [service account](../../iam/concepts/users/service-accounts.md) with the `storage.editor` [role](../../iam/concepts/access-control/roles.md).

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to `data-folder`.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. Click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
  1. Name your service account, e.g., `datasphere-sa`.
  1. Click **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** and assign the `storage.editor` role to this service account.
  1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

{% endlist %}

## Create a static access key {#create-static-key}

To access {{ objstorage-name }} from {{ ml-platform-name }}, you will need a [static key](../../iam/concepts/authorization/access-key.md).

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the folder the service account belongs to.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. In the left-hand panel, select ![FaceRobot](../../_assets/console-icons/face-robot.svg) **{{ ui-key.yacloud.iam.label_service-accounts }}**.
  1. In the list that opens, select `datasphere-sa`.
  1. In the top panel, click ![](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}**.
  1. Select **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_service-account-key }}**.
  1. Specify the static key description and click **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_create }}**.
  1. Save the ID and secret key. After you close this dialog, the key value will no longer be available.

- {{ yandex-cloud }} CLI {#cli}

  1. Create a static access key for the `datasphere-sa` service account:

     ```bash
     yc iam access-key create --service-account-name datasphere-sa
     ```

     Result:

     ```text
     access_key:
       id: aje6t3vsbj8l********
       service_account_id: ajepg0mjt06s********
       created_at: "2022-07-18T14:37:51Z"
       key_id: 0n8X6WY6S24N7Oj*****
     secret: JyTRFdqw8t1kh2-OJNz4JX5ZTz9Dj1rI9hx*****
     ```

     For more information about the `yc iam access-key create` command, see the [CLI reference](../../cli/cli-ref/iam/cli-ref/access-key/create.md).
  1. Save `key_id` and `secret`. You will not be able to get the secret key again.

- API {#api}

  To create a static access key, use the [create](../../iam/awscompatibility/api-ref/AccessKey/create.md) method for the [AccessKey](../../iam/awscompatibility/api-ref/AccessKey/index.md) resource.

{% endlist %}

## Create a bucket {#bucket-create}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create a bucket.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. At the top right, click **{{ ui-key.yacloud.storage.buckets.button_create }}**.
  1. In the **{{ ui-key.yacloud.storage.bucket.settings.field_name }}** field, enter a name for the bucket consistent with the [naming requirements](../../storage/concepts/bucket.md#naming).
  1. In the **{{ ui-key.yacloud.storage.bucket.settings.field_access-read }}**, **{{ ui-key.yacloud.storage.bucket.settings.field_access-list }}**, and **{{ ui-key.yacloud.storage.bucket.settings.field_access-config-read }}** fields, select **{{ ui-key.yacloud.storage.bucket.settings.access_value_private }}**.
  1. Click **{{ ui-key.yacloud.storage.buckets.create.button_create }}**.

- AWS CLI {#cli}
  
  1. If you do not have the AWS CLI yet, [install and configure it](../../storage/tools/aws-cli.md).
  1. Create a bucket by entering its name following the [naming requirements](../../storage/concepts/bucket.md#naming):

     ```bash
     aws --endpoint-url https://{{ s3-storage-host }} \
       s3 mb s3://<bucket_name>
     ```

     Result:

     ```text
     make_bucket: <bucket_name>
     ```

- {{ TF }} {#tf}

  {% include [terraform-role](../../_includes/storage/terraform-role.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Describe the properties for creating a service account and access key in the configuration file:

     {% include [terraform-sa-key](../../_includes/storage/terraform-sa-key.md) %}

  1. Add a section with bucket properties to the configuration file and enter the bucket name following the [naming requirements](../../storage/concepts/bucket.md#naming):

     ```hcl
     resource "yandex_storage_bucket" "<bucket_name>" {
       access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
       secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
       bucket     = "<bucket_name>"
     }
     ```

     For more information about `yandex_storage_bucket`, see the [{{ TF }} provider documentation]({{ tf-provider-link }}/storage_bucket).
  1. Create the resources:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} will create all the required resources. You can check the new resources and their configuration using the [management console]({{ link-console-main }}).

- API {#api}

  Use the [create](../../storage/api-ref/Bucket/create.md) REST API method for the [Bucket](../../storage/api-ref/Bucket/index.md) resource, the [BucketService/Create](../../storage/api-ref/grpc/Bucket/create.md) gRPC API call, or the [create](../../storage/s3/api-ref/bucket/create.md) S3 API method.

{% endlist %}

## Set up a connection to {{ objstorage-name }} {#rclone-config}

To transfer data from your local disk to {{ objstorage-name }}, configure the `rclone` utility.
1. Open the command line in your working directory as an admin and run the following command:

   ```powershell
   .\psexec -i -s cmd.exe
   ```

1. In the console that opens, run `whoami` and make sure the session has been started by the system user.
1. Navigate to the working directory and run a configuration session for `rclone`:

   ```powershell
   rclone.exe config
   ```

1. Follow the prompts to create a new connection profile:
   1. Start creating a new profile by entering `n` in the terminal.
   1. Enter the connection name: `s3-connect`.
   1. Select the storage type by entering `4` in the terminal.
   1. Select the provider by entering `1` in the terminal.
   1. Select manual entry of credentials by entering `1` in the terminal.
   1. Enter the secret key ID in the terminal.
   1. Enter the secret key value in the terminal.
   1. Specify the region by entering `{{ region-id }}` in the terminal.
   1. Specify the endpoint by entering `{{ s3-storage-host }}` in the terminal.
   1. You can leave the other settings at their defaults; press **Enter** to skip them.

{% note info %}

You can perform advanced connection setup if required. To do this, type `y` at the `Edit advanced config?` step. For more information about advanced settings, see the `rclone` [documentation](https://rclone.org/s3/).

{% endnote %}

## Mount your bucket to the Windows file system {#bucket-mount}

1. Check your connection to the bucket. In the same command line you used to configure the connection, run the following command with the bucket name specified:

   ```powershell
   rclone.exe ls s3-connect:<bucket_name>
   ```

   If your configuration is correct, you will see a list of objects in the bucket.
1. Mount your bucket to the file system specifying the bucket name and an available drive letter in the file system:

   ```powershell
   rclone.exe mount s3-connect:<bucket_name> <disk_letter>: --vfs-cache-mode full
   ```

   You will see a new disk with the objects from the bucket in Windows Explorer.

## Prepare data for model training {#prepare-data}

1. [Download a CSV file](https://storage.yandexcloud.net/doc-files/diabetes_data.csv) with diabetes prediction data. [This dataset](../../datasphere/concepts/dataset.md) is based on [Kaggle](https://www.kaggle.com/datasets/alexteboul/diabetes-health-indicators-dataset?select=diabetes_012_health_indicators_BRFSS2015.csv) data for 2015.
1. Copy the file to the bucket you mounted.

## Attach your bucket to a project {#create-s3}

To connect to your bucket from {{ ml-platform-name }}, you need an [S3 connector](../../datasphere/concepts/s3-connector.md):
1. {% include [find project](../../_includes/datasphere/ui-find-project.md) %}
1. In the top-right corner, click **{{ ui-key.yc-ui-datasphere.common.create-resource }}**. In the pop-up window, select **{{ ui-key.yc-ui-datasphere.resources.s3 }}**.
1. Fill out the fields as follows:
   * **{{ ui-key.yc-ui-datasphere.common.name }}**: Name of the new connector, e.g., `s3-datasphere-connect`.
   * **{{ ui-key.yc-ui-datasphere.common.endpoint }}**: {{ objstorage-name }} host, which is `https://{{ s3-storage-host }}/`.
   * **{{ ui-key.yc-ui-datasphere.common.bucket }}**: Name of your bucket.
   * **{{ ui-key.yc-ui-datasphere.new-s3-page.mount-name }}**: Name of the volume for mounting the bucket into the project file system.
   * **{{ ui-key.yc-ui-datasphere.new-s3-page.access-key-id }}**: ID of the access key used to connect to the storage.
   * In the **{{ ui-key.yc-ui-datasphere.new-s3-page.static-access-key }}** field, click **{{ ui-key.yc-ui-datasphere.common.create }}**. In the window that opens, enter the secret name and secret key used to connect to the storage.
1. Click **{{ ui-key.yc-ui-datasphere.common.create }}**.
1. Navigate to the S3 connector page and click **{{ ui-key.yc-ui-datasphere.common.activate }}**. Once activated, the bucket will be listed on the **S3 Mounts** ![S3 Mounts](../../_assets/console-icons/bucket.svg) tab in the {{ jlab }}Lab interface, and you will be able to view it as a file system.

## Train your model {#train-model}

Clone the Git repository containing the `diabetes_catboost.ipynb` notebook with a sample for [CatBoost](https://catboost.ai/) model training:
1. {% include [include](../../_includes/datasphere/ui-before-begin.md) %}
1. In the top menu, click **Git** and select **Clone**.
1. In the window that opens, enter `https://github.com/yandex-cloud-examples/yc-datasphere-s3-mount.git` and click **Clone**.

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

1. Upload the data for model training:

   ```python
   data = pd.read_csv('<path_to_dataset>')
   data.head()
   ```

   To get the `diabetes_data.csv` file path, open the **S3 Mounts** ![S3 Mounts](../../_assets/console-icons/bucket.svg) tab, right-click the file, and select **Copy path**.
1. Separate training factors from the target variable:

   ```python
   X = data.loc[:, data.columns != 'Diabetes_binary']
   y = data['Diabetes_binary']
   ```

1. Split the sample into training and test ones:

   ```python
   X_train, X_validation, y_train, y_validation = train_test_split(X, y, train_size=0.75, random_state=42)
   ```

1. Create a classifier named `CatBoost` and set hyperparameters:

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

1. Output quality metrics for the trained model:

   ```python
   print(classification_report(y_validation, model.predict(X_validation)))
   ```

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:
* [Delete the objects](../../storage/operations/objects/delete-all.md) from the bucket.
* [Delete the bucket](../../storage/operations/buckets/delete.md).
* [Delete the project](../../datasphere/operations/projects/delete.md).