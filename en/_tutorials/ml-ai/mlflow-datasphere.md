# Creating an MLFlow server for logging experiments and artifacts

This tutorial describes how to deploy an [MLFlow Tracking Server](https://mlflow.org/docs/latest/tracking.html) for logging experiments and artifacts on a separate [{{ compute-full-name }}](../../compute/) VM. Experiments will be run in {{ jlab }}Lab Notebook. We will use a [{{ mpg-full-name }}](../../managed-postgresql/) database to store internal objects and a [{{ objstorage-full-name }}](../../storage/) bucket to store artifacts.

To create an MLFlow server for logging {{ jlab }}Lab Notebook experiments and artifacts:

1. [Prepare your infrastructure](#infra).
1. [Create a static access key](#create-static-key).
1. [Create an SSH key pair](#create-ssh-keys).
1. [Create a VM](#create-vm).
1. [Create a managed DB](#create-db).
1. [Create a bucket](#create-bucket).
1. [Install the MLFlow tracking server and add it to the VM autoload](#setup-mlflow).
1. [Create secrets](#create-secrets).
1. [Train the model](#train-model).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin-datasphere.md) %}

### Required paid resources {#paid-resources}

The cost of training a model based on data from {{ objstorage-name }} includes:

* Fee for [{{ ml-platform-name }} computing resource](../../datasphere/pricing.md) usage.
* Fee for [{{ compute-name }} computing resource](../../compute/pricing.md) usage.
* Fee for a running [{{ mpg-name }}](../../managed-postgresql/pricing.md) cluster.
* Fee for storing data in a bucket (see [{{ objstorage-name }} pricing](../../storage/pricing.md#prices-storage)).
* Fee for data operations (see [{{ objstorage-name }} pricing](../../storage/pricing.md#prices-operations)).

## Prepare the infrastructure {#infra}

{% include [intro](../../_includes/datasphere/infra-intro.md) %}

{% include [intro](../../_includes/datasphere/federation-disclaimer.md) %}

### Create a folder {#create-folder}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select a cloud and click ![create](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.component.console-dashboard.button_action-create-folder }}**.
   1. Give your folder a name, e.g., `data-folder`.
   1. Click **{{ ui-key.yacloud.iam.cloud.folders-create.button_create }}**.

{% endlist %}

### Create a service account for {{ objstorage-name }} {#create-sa}

To access a bucket in {{ objstorage-name }}, you need a [service account](../../iam/concepts/users/service-accounts.md) with the `storage.viewer` and `storage.uploader` roles.

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), go to `data-folder`.
   1. In the **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}** tab, click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
   1. Enter a name for the service account, e.g., `datasphere-sa`.
   1. Click **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** and assign the service account the `storage.viewer` and `storage.uploader` roles.
   1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

{% endlist %}

## Create a static access key {#create-static-key}

To access {{ objstorage-name }} from {{ ml-platform-name }}, you need a static key.

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), navigate to the folder the service account belongs to.
   1. At the top of the screen, go to the **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}** tab.
   1. Select the `datasphere-sa` service account.
   1. In the top panel, click ![](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}**.
   1. Select **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_service-account-key }}**.
   1. Specify the key description and click **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_create }}**.
   1. Save the ID and private key. After you close the dialog, the private key value will become unavailable.

- CLI {#cli}

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

   1. Save the ID `key_id` and secret key `secret`. You will not be able to get the key value again.

- API {#api}

   To create an access key, use the [create](../../iam/api-ref/AccessKey/create.md) method for the [AccessKey](../../iam/api-ref/AccessKey/index.md) resource.

{% endlist %}

## Create an SSH key pair {#create-ssh-keys}

To connect to a [VM](../../compute/concepts/vm.md) over SSH, you need a key pair: the public key resides on the VM, while the private one is kept by the user. This method is more secure than connecting with login and password.

{% include [vm-connect-ssh-linux-note](../../_includes/vm-connect-ssh-linux-note.md) %}

To create a key pair:

{% include [vm-ssh-prepare-key](../../_includes/vm-ssh-prepare-key.md) %}

## Create a VM {#create-vm}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) to create your VM in.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
   1. Click **{{ ui-key.yacloud.compute.instances.button_create }}**.
   1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**:
      * Enter a name for the VM, e.g., `mlflow-vm`.
      * Select the `{{ region-id }}-a` availability zone.
   1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, select `Ubuntu 22.04`.
   1. Under **{{ ui-key.yacloud.compute.instances.create.section_storages_ru }}**, select the **{{ ui-key.yacloud.compute.instances.create.section_disk }}** tab and configure the boot disk:
      * **{{ ui-key.yacloud.compute.disk-form.field_type }}**: `{{ ui-key.yacloud.compute.value_disk-type-network-ssd }}`
      * **{{ ui-key.yacloud.compute.disk-form.field_size }}**: `20 GB`
   1. Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**:
      * **{{ ui-key.yacloud.component.compute.resources.field_cores }}**: `2`
      * **{{ ui-key.yacloud.component.compute.resources.field_memory }}**: `4`
   1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**, select the subnet specified in the {{ ml-platform-name }} [project settings](../../datasphere/operations/projects/update.md). Make sure to [set up a NAT gateway](../../vpc/operations/create-nat-gateway.md) for the subnet.
   1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**:
      * **{{ ui-key.yacloud.compute.instances.create.field_service-account }}**: `datasphere-sa`.
      * Enter the username in the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field.
      * In the **{{ ui-key.yacloud.compute.instances.create.field_key }}** field, paste the contents of the [public key](#create-ssh-keys) file.
   1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

{% endlist %}

## Create a managed DB {#create-db}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create a DB cluster.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
   1. Click **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
   1. Enter a name for the cluster, e.g., `mlflow-bd`.
   1. Under **{{ ui-key.yacloud.mdb.forms.section_resource }}**, select the `s3-c2-m8` configuration.
   1. Under **{{ ui-key.yacloud.mdb.forms.section_disk }}**, select `250 GB`.
   1. Under **{{ ui-key.yacloud.mdb.forms.section_database }}**, enter your username and password. You will need it to establish a connection.
   1. Under **{{ ui-key.yacloud.mdb.forms.section_host }}**, select the `{{ region-id }}-a` availability zone.
   1. Click **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
   1. Go to the DB you created and click **{{ ui-key.yacloud.mdb.clusters.button_action-connect }}**.
   1. Save the host link from the `host` field: you will need it to establish a connection.

{% endlist %}

## Create a bucket {#create-bucket}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create a bucket.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
   1. At the top right, click **{{ ui-key.yacloud.storage.buckets.button_create }}**.
   1. In the **{{ ui-key.yacloud.storage.bucket.settings.field_name }}** field, enter a name for the bucket, e.g., `mlflow-bucket`.
   1. In the **{{ ui-key.yacloud.storage.bucket.settings.field_access-read }}**, **{{ ui-key.yacloud.storage.bucket.settings.field_access-list }}**, and **{{ ui-key.yacloud.storage.bucket.settings.field_access-config-read }}** fields, select **{{ ui-key.yacloud.storage.bucket.settings.access_value_private }}**.
   1. Click **{{ ui-key.yacloud.storage.buckets.create.button_create }}**.
   1. To create a folder for MLflow artifacts, open the bucket you created and click **{{ ui-key.yacloud.storage.bucket.button_create }}**.
   1. Enter a name for the folder, e.g., `artifacts`.

{% endlist %}

## Install the MLFlow tracking server and add it to the VM autoload {#setup-mlflow}

1. [Connect](../../compute/operations/vm-connect/ssh.md#vm-connect) to the VM via SSH.
1. Download the `Anaconda` distribution:

   ```bash
   curl -O https://repo.anaconda.com/archive/Anaconda3-2023.07-1-Linux-x86_64.sh
   ```

1. Run its installation:

   ```bash
   bash Anaconda3-2023.07-1-Linux-x86_64.sh
   ```

   Wait for the installation to complete and restart the shell.

1. Create an environment:

   ```bash
   conda create -n mlflow
   ```

1. Activate the environment:

   ```bash
   conda activate mlflow
   ```

1. Install the required packages by running the following commands one by one:

   ```bash
   conda install -c conda-forge mlflow
   conda install -c anaconda boto3
   pip install psycopg2-binary
   pip install pandas
   ```

1. Create environment variables for S3 access:

   * Open the file with the variables:

      ```bash
      sudo nano /etc/environment
      ```

   * Add the following lines to the file by substituting your VM's internal IP address:

      ```bash
      MLFLOW_S3_ENDPOINT_URL=https://{{ s3-storage-host }}/
      MLFLOW_TRACKING_URI=http://<VM_internal_IP>:8000
      ```

1. Specify the data to be used by the `boto3` library for S3 access:

   * Create a directory named `.aws`:

      ```bash
      mkdir ~/.aws
      ```

   * Create a `credentials` file:

      ```bash
      nano ~/.aws/credentials
      ```

   * Add the following lines to the file by substituting the static key ID and value:

      ```bash
      [default]
      aws_access_key_id=<static_key_ID>
      aws_secret_access_key=<secret_key>
      ```

1. Run the MLFlow Tracking Server by substituting your cluster data:

   ```bash
   mlflow server --backend-store-uri postgresql://<username>:<password>@<host>:6432/db1?sslmode=verify-full --default-artifact-root s3://mlflow-bucket/artifacts -h 0.0.0.0 -p 8000
   ```

   You can check your connection to MLFlow at `http://<VM_public_IP>:8000`.

### Enable MLFlow autorun {#autorun}

For MLFlow to run automatically after the VM restarts, make it the `Systemd` service.

1. Create directories for storing logs and error details:

   ```bash
   mkdir ~/mlflow_logs/
   mkdir ~/mlflow_errors/
   ```

1. Create a file named `mlflow-tracking.service`:

   ```bash
   sudo nano /etc/systemd/system/mlflow-tracking.service
   ```

1. Add the following lines to the file, replacing the placeholders with your data:

   ```bash
   [Unit]
   Description=MLflow Tracking Server
   After=network.target

   [Service]
   Environment=MLFLOW_S3_ENDPOINT_URL=https://{{ s3-storage-host }}/
   Restart=on-failure
   RestartSec=30
   StandardOutput=file:/home/<VM_username>/mlflow_logs/stdout.log
   StandardError=file:/home/<VM_username>/mlflow_errors/stderr.log
   User=<VM_username>
   ExecStart=/bin/bash -c 'PATH=/home/<VM_username>/anaconda3/envs/mlflow_env/bin/:$PATH exec mlflow server --backend-store-uri postgresql://<DB_username>:<password>@<host>:6432/db1?sslmode=verify-full --default-artifact-root s3://mlflow-bucket/artifacts -h 0.0.0.0 -p 8000'

   [Install]
   WantedBy=multi-user.target
   ```
   Where:

   * `<VM_username>`: VM account username.
   * `<DB_username>`: Username specified when creating a database cluster.

1. Run the service and enable autoload at system startup:

   ```bash
   sudo systemctl daemon-reload
   sudo systemctl enable mlflow-tracking
   sudo systemctl start mlflow-tracking
   sudo systemctl status mlflow-tracking
   ```

## Create secrets {#create-secrets}

1. {% include [find project](../../_includes/datasphere/ui-find-project.md) %}
1. Under **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}**, click ![secret](../../_assets/console-icons/shield-check.svg)**{{ ui-key.yc-ui-datasphere.resources.secret }}**.
1. Click **{{ ui-key.yc-ui-datasphere.common.create }}**.
1. In the **{{ ui-key.yc-ui-datasphere.secret.name }}** field, enter the secret name: `MLFLOW_S3_ENDPOINT_URL`.
1. In the **{{ ui-key.yc-ui-datasphere.secret.content }}** field, paste this URL: `https://{{ s3-storage-host }}/`.
1. Click **{{ ui-key.yc-ui-datasphere.common.create }}**.
1. Create three more secrets:
   * `MLFLOW_TRACKING_URI` set to `http://<VM_internal_IP>:8000`.
   * `AWS_ACCESS_KEY_ID` with the static key ID.
   * `AWS_SECRET_ACCESS_KEY` with the static key value.

## Train the model {#train-model}

The example uses a set of data to predict the quality of wine based on quantitative characteristics, such as acidity, PH, residual sugar, etc. To train the model, copy and paste the code into notebook cells.

1. {% include [include](../../_includes/datasphere/ui-before-begin.md) %}

1. Install the required modules:

   ```python
   %pip install mlflow
   ```

1. Import the required libraries:

   ```python
   import os
   import warnings
   import sys

   import pandas as pd
   import numpy as np
   from sklearn.metrics import mean_squared_error, mean_absolute_error, r2_score
   from sklearn.model_selection import train_test_split
   from sklearn.linear_model import ElasticNet
   from urllib.parse import urlparse
   import mlflow
   import mlflow.sklearn
   from mlflow.models import infer_signature
   import logging
   ```

1. Create an experiment in MLFlow:

   ```python
   mlflow.set_experiment("my_first_experiment")
   ```

1. Create a function to assess the prediction quality:

   ```python
   def eval_metrics(actual, pred):
   rmse = np.sqrt(mean_squared_error(actual, pred))
   mae = mean_absolute_error(actual, pred)
   r2 = r2_score(actual, pred)
   return rmse, mae, r2
   ```

1. Prepare data, train the model, and register it with MLflow:

   ```python
   logging.basicConfig(level=logging.WARN)
   logger = logging.getLogger(__name__)

   warnings.filterwarnings("ignore")
   np.random.seed(40)

   # Upload the dataset to assess the quality of wine
   csv_url = (
      "https://raw.githubusercontent.com/mlflow/mlflow/master/tests/datasets/winequality-red.csv"
   )
   try:
       data = pd.read_csv(csv_url, sep=";")
   except Exception as e:
       logger.exception(
           "Unable to download training & test CSV, check your internet connection. Error: %s", e
      )

   # Split the dataset into training and test samples
   train, test = train_test_split(data)

   # Distinguish a target variable and variables used for forecasting
   train_x = train.drop(["quality"], axis=1)
   test_x  = test.drop(["quality"], axis=1)
   train_y = train[["quality"]]
   test_y  = test[["quality"]]

   alpha = 0.5
   l1_ratio = 0.5

   # Start a run in MLflow
   with mlflow.start_run():

      # Create an ElasticNet model and train it
      lr = ElasticNet(alpha=alpha, l1_ratio=l1_ratio, random_state=42)
      lr.fit(train_x, train_y)

      # Predicting quality based on the test sample
      predicted_qualities = lr.predict(test_x)

      (rmse, mae, r2) = eval_metrics(test_y, predicted_qualities)

      print("Elasticnet model (alpha={:f}, l1_ratio={:f}):".format(alpha, l1_ratio))
      print("  RMSE: %s" % rmse)
      print("  MAE: %s" % mae)
      print("  R2: %s" % r2)

      # Log information about hyperparameters and quality metrics in MLflow
      mlflow.log_param("alpha", alpha)
      mlflow.log_param("l1_ratio", l1_ratio)
      mlflow.log_metric("rmse", rmse)
      mlflow.log_metric("r2", r2)
      mlflow.log_metric("mae", mae)

      predictions = lr.predict(train_x)
      signature   = infer_signature(train_x, predictions)

      tracking_url_type_store = urlparse(mlflow.get_tracking_uri()).scheme

      # Register the model with MLflow
      if tracking_url_type_store != "file":
        mlflow.sklearn.log_model(
              lr, "model", registered_model_name="ElasticnetWineModel", signature=signature
        )
      else:
         mlflow.sklearn.log_model(lr, "model", signature=signature)
   ```

   You can check the result at `http://<VM_public_IP>:8000`.

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:
* [Delete the VM](../../compute/operations/vm-control/vm-delete.md).
* [Delete the database cluster](../../managed-postgresql/operations/cluster-delete.md).
* [Delete the objects](../../storage/operations/objects/delete-all.md) from the bucket.
* [Delete the bucket](../../storage/operations/buckets/delete.md).
* [Delete the project](../../datasphere/operations/projects/delete.md).
