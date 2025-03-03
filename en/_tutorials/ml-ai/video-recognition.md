# Classification of images in video frames

{{ ml-platform-full-name }} allows you to build ML models using the {{ jlab }} Notebook interface.

This tutorial solves the problem of binary image classification. You may have to deal with it when recognizing vehicle types based on CCTV camera images. It is assumed that the CCTV system captures images from cameras when detecting motion and saves them to a bucket in {{ objstorage-full-name }}.

To get an idea of how the problem might be solved:
1. [Prepare your infrastructure](#deploy-infrastructure).
1. [Configure {{ ml-platform-name }}](#project).
1. [Create secrets](#create-secrets).
1. [Prepare notebooks](#set-notebooks).
1. [Install the dependencies](#satisfy-dependencies).
1. [Upload and label the data](#load-dataset).
1. [Prepare the ML model and calculate the features](#get-cnn-model).
1. [Train the classifier using the features you calculated](#classifier-fit).
1. [Predict the feature for the test image](#model-test).
1. [View practical applications of the model](#model-apply).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin-datasphere.md) %}

### Required paid resources {#paid-resources}

The model operation cost includes:

* Fee for bucket usage (see [{{ objstorage-full-name }} pricing](../../storage/pricing.md)).
* Fee for computing resource usage (see [{{ ml-platform-full-name }} pricing](../../datasphere/pricing.md)).

## Prepare the infrastructure {#deploy-infrastructure}

{% include [intro](../../_includes/datasphere/infra-intro.md) %}

{% include [intro](../../_includes/datasphere/federation-disclaimer.md) %}

### Create a folder to work in {#create-folder}

Create a [folder](../../resource-manager/concepts/resources-hierarchy.md) and [network](../../vpc/concepts/network.md#network) with subnets in each [availability zone](../../overview/concepts/geo-scope.md).

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select a cloud and click ![create](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.component.console-dashboard.button_action-create-folder }}**.
   1. Name your folder, e.g., `data-folder`.
   1. Click **{{ ui-key.yacloud.iam.cloud.folders-create.button_create }}**.

{% endlist %}

### Create a service account {#create-sa}

{% list tabs group=instructions %}

- Management console {#console}

   1. Go to `data-folder`:
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
   1. Click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
   1. Enter a name for the [service account](../../iam/concepts/users/service-accounts.md), e.g., `sa-for-project`.
   1. Click **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** and assign the following [roles](../../iam/concepts/access-control/roles.md) to the service account:
      * `storage.viewer`: To read data from the {{ objstorage-name }} bucket.
      * `vpc.gateways.user`: To use a subnet.

   1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

{% endlist %}

### Create a static access key for the service account {#create-key}

To allow your service account to get authenticated in {{ objstorage-name }}, create a [static access key](../../iam/concepts/authorization/access-key.md).

{% list tabs group=instructions %}

- Management console {#console}

  1. Go to `data-folder`.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. In the left-hand panel, select ![FaceRobot](../../_assets/console-icons/face-robot.svg) **{{ ui-key.yacloud.iam.label_service-accounts }}**.
  1. In the list that opens, select the `sa-for-project` service account.
  1. Click **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}** in the top panel.
  1. Select **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_service-account-key }}**.
  1. Enter a description of the key so that you can easily find it in the management console.
  1. Save the ID and secret key. The secret key is not saved in {{ yandex-cloud }}, so you will not be able to view it in the management console.

{% endlist %}

### Create an egress NAT gateway {#create-nat}

{% list tabs group=instructions %}

- Management console {#console}

   1. In `data-folder`, select **{{ vpc-name }}**.
   1. In the left-hand panel, select **{{ ui-key.yacloud.vpc.switch_gateways }}**.
   1. Click **{{ ui-key.yacloud.common.create }}** and set the gateway parameters:
      * Name the gateway, e.g., `nat-for-cluster`.
      * Gateway **{{ ui-key.yacloud.vpc.gateways.field_type }}**: **{{ ui-key.yacloud.vpc.gateways.value_gateway-type-egress-nat }}**.
      * Click **{{ ui-key.yacloud.common.save }}**.

   Create a route table:

   1. In the left-hand panel, select **{{ ui-key.yacloud.vpc.network.switch_route-table }}**.
   1. Click **{{ ui-key.yacloud.common.create }}** and specify the route table parameters:
      1. Enter a name, e.g., `route-table`.
      1. Select the `data-folder` network.
      1. Click **{{ ui-key.yacloud.vpc.route-table-form.label_add-static-route }}**.
         * In the window that opens, select **{{ ui-key.yacloud.vpc.add-static-route.value_gateway }}** in the **{{ ui-key.yacloud.vpc.route-table-form.label_next-hop-address }}** field.
         * In the **{{ ui-key.yacloud.vpc.add-static-route.value_gateway }}** field, select the NAT gateway you created. The destination prefix will apply automatically.
         * Click **{{ ui-key.yacloud.vpc.add-static-route.button_add }}**.
   1. Click **{{ ui-key.yacloud.vpc.route-table.create.button_create }}**.

   Link the route table to one of the subnets to route traffic from it through the NAT gateway:

   1. In the left-hand panel, select ![image](../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.vpc.switch_networks }}**.
   1. In the row with the subnet you need, click ![image](../../_assets/console-icons/ellipsis.svg).
   1. In the menu that opens, select **{{ ui-key.yacloud.vpc.subnetworks.button_action-add-route-table }}**.
   1. In the window that opens, select the created table from the list.
   1. Click **{{ ui-key.yacloud.vpc.subnet.add-route-table.button_add }}**.

{% endlist %}

### Create an S3 bucket {#create-bucket}

{% list tabs group=instructions %}

- Management console {#console}

   1. Go to `data-folder`.
   1. In the list of services, select **{{ objstorage-name }}**.
   1. Click **{{ ui-key.yacloud.storage.buckets.button_empty-create }}**.
   1. On the bucket creation page:
      1. Enter a name for the bucket according to the [naming requirements](../../storage/concepts/bucket.md#naming).
      
         {% note warning %}

         Do not use buckets with periods in their names for connection.

         {% endnote %}

      1. In the **{{ ui-key.yacloud.storage.bucket.settings.field_access-read }}**, **{{ ui-key.yacloud.storage.bucket.settings.field_access-list }}**, and **{{ ui-key.yacloud.storage.bucket.settings.field_access-config-read }}** fields, select **{{ ui-key.yacloud.storage.bucket.settings.access_value_private }}**.
      1. Limit the maximum bucket size, if required.
   1. Click **{{ ui-key.yacloud.storage.buckets.create.button_create }}** to complete the operation.

{% endlist %}

## Configure {{ ml-platform-name }} {#project}

### Create a project {#create-project}

{% include [include](../../_includes/datasphere/ui-create-project.md) %}

### Edit the project settings {#change-settings}

1. {% include [include](../../_includes/datasphere/ui-find-project.md) %}
1. Navigate to the **{{ ui-key.yc-ui-datasphere.project-page.tab.settings }}** tab.
1. Under **{{ ui-key.yc-ui-datasphere.edit-project-page.advanced-settings }}**, click **![pencil](../../_assets/console-icons/pencil-to-line.svg) {{ ui-key.yc-ui-datasphere.common.edit }}**.
1. Specify the parameters:
   * **{{ ui-key.yc-ui-datasphere.project-page.settings.default-folder }}**: `data-folder`.
   * **{{ ui-key.yc-ui-datasphere.project-page.settings.service-account }}**: `sa-for-project`.
   * **{{ ui-key.yc-ui-datasphere.project-page.settings.subnet }}**: Subnet of the `{{region-id}}-a` availability zone in `data-folder`.

   {% include [subnet-create](../../_includes/subnet-create.md) %}

   * **{{ ui-key.yc-ui-datasphere.edit-project-page.security-group }}**: Specify a [security group](../../vpc/concepts/security-groups.md), if used in your organization.
1. Click **{{ ui-key.yc-ui-datasphere.common.save }}**.

## Create secrets {#create-secrets}

Create [secrets](../../datasphere/concepts/secrets.md) to store the ID and secret part of the static access key:

1. Under **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** on the project page, click ![secret](../../_assets/console-icons/shield-check.svg)**{{ ui-key.yc-ui-datasphere.resources.secret }}**.
1. Click **{{ ui-key.yc-ui-datasphere.common.create }}**.
1. In the **{{ ui-key.yc-ui-datasphere.secret.name }}** field, enter a name for the secret. Name the secret with the static key ID as `token`, and the secret with the secret part as `key_value`.
1. In the **{{ ui-key.yc-ui-datasphere.secret.content }}** field, enter a value to store in encrypted form.
1. Click **{{ ui-key.yc-ui-datasphere.common.create }}**. You will see a page with detailed info on the secret you created.

## Prepare notebooks {#set-notebooks}

Clone the Git repository containing the notebooks with the examples of the ML model training and testing:
   1. In the top menu, click **Git** and select **Clone**.
   1. In the window that opens, enter `https://github.com/yandex-cloud-examples/yc-datasphere-video-recognition.git` and click **Clone**.
   
   Wait until cloning is complete. It may take some time. You will see the cloned repository folder in the ![folder](../../_assets/datasphere/jupyterlab/folder.svg) **File Browser** section.

There are two notebooks in the repository:

* `model-building.ipynb`: To set up the environment and train your model using the ResNet50 [convolutional neural network](https://en.wikipedia.org/wiki/Convolutional_neural_network) (CNN).
* `model-testing.ipynb`: To test your model.

## Install dependencies {#satisfy-dependencies}

{% note info %}

In this example, the model is trained and tested using the g1.1 computing resource [configuration](../../datasphere/concepts/configurations.md). You can use a different configuration with a GPU. To do this, change the configuration in the code in all notebook cells as needed.

{% endnote %}

1. Open the **ML** folder and then the **model-building.ipynb** notebook.
1. Click on the first cell to select it:

   ```
   #!g1.1
   %matplotlib inline
   import matplotlib
   import matplotlib.pyplot as plt
   import os
   import io
   from os import path
   ...
   ```

1. To run the cell, click ![run](../../_assets/datasphere/jupyterlab/run.svg) or press **Shift** + **Enter**.
1. Wait for the operation to complete.

The solution uses the [Keras interface](https://keras.io/about/) of the TensorFlow library with a [CNTK backend](https://docs.microsoft.com/en-us/cognitive-toolkit/). To connect to the bucket with images, you need the `boto3` package. The cell also sets the environment variables needed to access the CNTK backend and connect to the bucket.

The packages listed in the cell are already installed in {{ ml-platform-name }} and you can import them using the `import` command. For the full list of packages pre-installed in {{ ml-platform-name }}, see [{#T}](../../datasphere/concepts/preinstalled-packages.md).

## Upload and label the data {#load-dataset}

Go to the **Connect S3** section. You can use it to perform the following operations:

1. Set up a connection to the S3 bucket.
1. Load the list of objects, i.e., images of cars and buses. These will be used to train the model.
1. Define the function to extract an image using a key (name).

The next section, **Labeling**, is used for labeling data:
* Images are labeled according to the key value (folder name).
* Bus images are labeled with `0`, and car images are labeled with `1`.

To upload and label the data:

1. In the first cell, replace the `bucket_name` variable value with the name of your bucket. The default value is `bucketwithvideo`.
1. Select all the cells containing code in the **Connect S3** and **Labeling** sections. To do this, hold **Shift** and click to the left of the cells in question:

   ```
   #!g1.1

   session = boto3.session.Session()
   ...
   ```

1. Run the selected cells.
1. Wait for the operation to complete. When the operation is complete, one of the images is displayed to check if the data was uploaded and labeled correctly.

## Prepare the ML model and calculate the features {#get-cnn-model}

Go to the **Calculating the characteristics** section. You can use it to perform the following operations:

1. Load the ResNet50 model from the Keras package, with weights pretrained on the ImageNet dataset. This dataset contains 1.2 million images in 1,000 categories.
1. Define the `featurize_images` function. It splits the list of images into chunks of 32 images each, scales the images down to 224×224 pixels, and converts them to a four-dimensional [tensor](https://en.wikipedia.org/wiki/Tensor) to feed to the Keras model. Next, the function calculates their features and returns them as a NumPy array.
1. Use the function to calculate binary features (`1` means car, `0` means other) and save them to a file. This step may take 10-15 minutes. You can read more about the ResNet50 model [here](https://www.kaggle.com/keras/resnet50).

To prepare the model and calculate the features:

1. Select all the cells containing code in the **Calculating the characteristics** section:

   ```
   #!g1.1
   model = ResNet50(weights='imagenet',  input_shape=(224, 224, 3))
   ...
   ```

1. Run the selected cells.
1. Wait for the operation to complete.

## Train the classifier using the features you calculated {#classifier-fit}

In this section, you will train the LightGBM classifier on the features calculated in the previous section. To evaluate the model, you will use cross-validation.

The [K-fold](http://scikit-learn.org/0.16/modules/generated/sklearn.cross_validation.StratifiedKFold.html) method of the scikit-learn package is used. Parts of the training set (folds) are created based on the specified percentage of data from each class.

This is important when your data contains much fewer images of one category than another. This example uses five-fold cross-validation. You can set a different number of folds in the `n_splits` parameter.

Go to the **Training and cross-validation** and **Saving the model** sections. These are used to perform the following operations:

1. Define an object for cross-validation of training results using the **K-fold** method.
1. Prepare a table to store the classification quality metrics.
1. Define the `classification_metrics` function for calculating the selected metrics.
1. Start the LightGBM classifier training. This example uses cross-validation comprising five folds:
   1. The training sample is divided into five equal non-overlapping parts.
   1. Five iterations take place. At each one, the following steps are performed:
      1. The model is trained on four parts from the sample.
      1. The model is tested on the sample part not used for training.
      1. The selected quality metrics are output.
1. Train the classifier on the full dataset and output the resulting error matrix.

To train the classifier, run all the cells in the **Training and cross-validation** and **Saving the model** sections one by one.

The model thus trained will be saved to a separate file.

## Get the results of feature prediction based on test data {#model-test}

To use the resulting model:

1. Open the **ML** folder and then the **model-testing.ipynb** notebook.

   This notebook uses the previously trained LightGBM classifier to prepare the entities required to illustrate how you can use your model.

   {% note info %}

   You need much less resources to use your model than to train it; therefore, the minimum c1.4 configuration is left for this purpose (default).

   {% endnote %}

1. In the second cell, replace the `bucket_name` variable value with the name of your bucket. The default value is `bucketwithvideo`.
1. Run the first three cells. Use these cells to:
   1. Import the packages you need for the test.
   1. Identify the name of the bucket to store the images.
   1. Set up a connection to the bucket with CCTV images.
1. Specify a test image featuring a car:

   ```
   test_image = 'car/electric-cars-17.jpeg'
   ```

   {% note info %}

   If you run the cell again, specify a new image.

   {% endnote %}

1. In the cell from the **Prediction** section, load the ResNet50 model and the prepared LightGBM classifier and calculate the probability of the predicted binary feature value (`1` means a car).

   It takes longer to process the cell with prediction calculation for the first time, because the models are loaded into the memory. The subsequent runs will be executed faster:

   ```
   %%time
   clf = lgb.Booster(model_file='ImageClassificationML/lightgbm_classifier.model')
   model = ResNet50(weights='imagenet',  input_shape=(224, 224, 3))
   ...
   ```

1. Make sure that the probability value is close to 1 (you should get `≈0.98`).
1. Edit the cell code before loading the model:

   ```
   test_image = 'bus/electric_bus-183.jpeg'
   ```

   This is a test image with no car in it.

1. Run the cell.
1. Repeat the probability calculation and make sure that the value is much less than `0.5`.

This means the classifier can successfully predict the feature for both images.

{% note info %}

You can [share](../../datasphere/operations/projects/publication.md) your finished notebook of computations or [export the whole project](../../datasphere/operations/projects/export.md).

{% endnote %}

## Practical use of the model {#model-apply}

There are several practical uses for your model:

* The code of the proposed solution allows running a web service using [{{ sf-full-name }}](../../functions/) and analyze on-event CCTV content.
* For parallel processing of images collected from multiple video cameras into an S3 bucket, you can upload the code to an Apache Spark™ cluster in [{{ dataproc-full-name }}](../../data-proc/) using the PySpark package.


## How to delete the resources you created {#clear-out}

Some resources are not free of charge. To shut down the model and stop paying for the resources you created, delete those you no longer need:

1. [Delete all objects from the bucket](../../storage/operations/objects/delete.md).
1. [Delete the bucket](../../storage/operations/buckets/delete.md).
1. [Delete the project](../../datasphere/operations/projects/delete.md).
1. [Delete the route table](../../vpc/operations/delete-route-table.md).
1. [Delete the NAT gateway](../../vpc/operations/delete-nat-gateway.md).
