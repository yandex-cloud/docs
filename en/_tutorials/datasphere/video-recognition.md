# Classification of images in video frames

{{ ml-platform-full-name }} lets you build machine learning (ML) models using the {{ jlab }} Notebook interface.

This tutorial solves the problem of binary image classification. Such a problem may arise when you need to detect vehicle types on images from CCTV cameras. It is assumed that the CCTV system captures images from a camera when it detects motion and saves them to a bucket in {{ objstorage-full-name }}.

To get an idea of how the problem might be solved:
1. [Prepare the infrastructure](#deploy-infrastructure).
1. [Configure {{ ml-platform-name }}](#project).
1. [Create secrets](#create-secrets).
1. [Prepare notebooks](#set-notebooks).
1. [Install dependencies](#satisfy-dependencies).
1. [Upload and label the data](#load-dataset).
1. [Prepare the ML model and calculate the properties](#get-cnn-model).
1. [Train the classifier on the obtained properties](#classifier-fit).
1. [Predict the property for the test image](#model-test).
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

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select a cloud and click ![create](../../_assets/plus-sign.svg) **{{ ui-key.yacloud.component.console-dashboard.button_action-create-folder }}**.
   1. Give your folder a name, e.g., `data-folder`.
   1. Click **{{ ui-key.yacloud.iam.cloud.folders-create.button_create }}**.

{% endlist %}

### Create a service account {#create-sa}

{% list tabs %}

- Management console

   1. Go to the `data-folder` folder.
   1. In the **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}** tab, click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
   1. Enter the name of the [service account](../../iam/concepts/users/service-accounts.md), e.g., `sa-for-project`.
   1. Click **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** and assign the following [roles](../../iam/concepts/access-control/roles.md) to the service account:
      * `storage.viewer` to read data from the {{ objstorage-name }} bucket.
      * `vpc.gateways.user` to use a subnet.

   1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

{% endlist %}

### Create a static access key for the service account {#create-key}

To allow your service account to get authenticated in {{ objstorage-name }}, create a [static access key](../../iam/concepts/authorization/access-key.md).

{% list tabs %}

- Management console

   1. In the `data-folder` folder, go to the **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}** tab.
   1. Choose the `sa-for-project` service account and click the line with its name.
   1. Click **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}** in the top panel.
   1. Select **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_service-account-key }}**.
   1. Enter a description of the key so that you can easily find it in the management console.
   1. Save the ID and secret key. The secret key is not saved in {{ yandex-cloud }}, so you will not be able to view it in the management console.

{% endlist %}

### Create an egress NAT gateway {#create-nat}

{% list tabs %}

- Management console

   1. In the `data-folder` folder, select **{{ vpc-name }}**.
   1. In the left-hand panel, select **{{ ui-key.yacloud.vpc.switch_gateways }}**.
   1. Click **{{ ui-key.yacloud.common.create }}** and set the gateway parameters:
      * Enter the gateway name, for example `nat-for-cluster`.
      * Gateway **{{ ui-key.yacloud.vpc.gateways.field_type }}**: **{{ ui-key.yacloud.vpc.gateways.value_gateway-type-egress-nat }}**.
      * Click **{{ ui-key.yacloud.common.save }}**.

   Create a route table:

   1. In the left-hand panel, select **{{ ui-key.yacloud.vpc.network.switch_route-table }}**.
   1. Click **{{ ui-key.yacloud.common.create }}** and specify the route table parameters:
      1. Enter the name, for example `route-table`.
      1. Select the `data-folder` folder's network.
      1. Click **{{ ui-key.yacloud.vpc.route-table-form.label_add-static-route }}**.
         * In the window that opens, select **{{ ui-key.yacloud.vpc.route-table-form.label_gateway }}** in the **{{ ui-key.yacloud.vpc.route-table-form.label_next-hop-address }}** field.
         * In the **{{ ui-key.yacloud.vpc.route-table-form.label_gateway }}** field, select the NAT gateway you created. The destination prefix will be propagated automatically.
         * Click **{{ ui-key.yacloud.common.add }}**.
      1. Click **{{ ui-key.yacloud.common.save }}**.
   1. Click **{{ ui-key.yacloud.vpc.route-table.create.button_create }}**.

   Link the route table to a subnet to route traffic from it via the NAT gateway:

   1. In the left-hand panel, select ![image](../../_assets/vpc/subnets.svg) **{{ ui-key.yacloud.vpc.switch_networks }}**.
   1. In the line with the desired subnet, click ![image](../../_assets/options.svg).
   1. In the menu that opens, select **{{ ui-key.yacloud.vpc.subnetworks.button_action-add-route-table }}**.
   1. In the window that opens, select the created table from the list.
   1. Click **{{ ui-key.yacloud.vpc.subnet.add-route-table.button_add }}**.

{% endlist %}

### Create an S3 bucket {#create-bucket}

{% list tabs %}

- Management console

   1. Go to the `data-folder` folder.
   1. In the list of services, select **{{ objstorage-name }}**.
   1. Click **{{ ui-key.yacloud.storage.buckets.button_empty-create }}**.
   1. On the bucket creation page:
      1. Enter the bucket name following the [naming guidelines](../../storage/concepts/bucket.md#naming), such as `bucketwithvideo`.

         {% note warning %}

         Don't use buckets that have dots in their names for connecting.

         {% endnote %}

      1. Limit the maximum bucket size, if required.
   1. Click **{{ ui-key.yacloud.storage.buckets.create.button_create }}** to complete the operation.

{% endlist %}

## Configure {{ ml-platform-name }} {#project}

### Create a project {#create-project}

{% include [include](../../_includes/datasphere/ui-create-project.md) %}

### Edit the project settings {#change-settings}

1. Go to the **{{ ui-key.yc-ui-datasphere.common.settings-key-value }}** tab and click **![pencil](../../_assets/pencil.svg) {{ ui-key.yc-ui-datasphere.common.edit }}**.
1. Under **{{ ui-key.yc-ui-datasphere.edit-project-page.advanced-settings }}**, specify:
   * **{{ ui-key.yc-ui-datasphere.common.folder }}**: `data-folder`.
   * **{{ ui-key.yc-ui-datasphere.edit-project-page.service-account }}**: `sa-for-project`.
   * **{{ ui-key.yc-ui-datasphere.edit-project-page.subnet }}**: A subnet of the `{{region-id}}-a` availability zone in the `data-folder` folder.

      {% include [subnet-create](../../_includes/subnet-create.md) %}

   * [Security groups](../../vpc/concepts/security-groups.md) if you use them in your organization.

1. Click **{{ ui-key.yc-ui-datasphere.common.save }}**.

## Create secrets {#create-secrets}

Create [secrets](../../datasphere/concepts/secrets.md) to store the ID and secret part of the static access key:

1. Under **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** on the project page, click ![secret](../../_assets/datasphere/jupyterlab/secret.svg)**{{ ui-key.yc-ui-datasphere.resources.secret }}**.
1. Click **{{ ui-key.yc-ui-datasphere.common.create }}**.
1. In the **{{ ui-key.yc-ui-datasphere.secret.name }}** field, enter a name for the secret. Name the secret with the static key ID as `token` and the secret with the secret part as `key_value`.
1. In the **{{ ui-key.yc-ui-datasphere.secret.content }}** field, enter a value to be stored in encrypted form.
1. Click **{{ ui-key.yc-ui-datasphere.common.create }}**. This will display the created secret's info page.

## Prepare notebooks {#set-notebooks}

Clone the Git repository containing the notebooks with the examples of the ML model training and testing:
1. In the top menu, click **Git** and select **Clone**.
1. In the window that opens, specify the repository URI `https://github.com/yandex-cloud-examples/yc-datasphere-video-recognition.git` and click **Clone**.

Wait until cloning is complete. It may take some time. The cloned repository folder appears in the ![folder](../../_assets/datasphere/jupyterlab/folder.svg) **File Browser** section.

There are two notebooks in the repository:

* `model-building.ipynb` to set up the environment and train the model using the ResNet50 [Convolutional Neural Network](https://en.wikipedia.org/wiki/Convolutional_neural_network) (CNN).
* `model-testing.ipynb` to test the model.

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

1. To run the cell, click ![run](../../_assets/datasphere/jupyterlab/run.svg) (or press **Shift** + **Enter**).
1. Wait for the operation to complete.

The solution uses the [Keras interface](https://keras.io/about/) of the TensorFlow library with a [CNTK backend](https://docs.microsoft.com/en-us/cognitive-toolkit/). The `boto3` package is required to connect to the bucket with images. The cell also sets the environment variables needed to access the CNTK backend and connect to the bucket.

The packages listed in the cell are already installed in {{ ml-platform-name }} and you can `import` them using the import command. For the full list of packages pre-installed in {{ ml-platform-name }}, see [{#T}](../../datasphere/concepts/preinstalled-packages.md).

## Upload and label the data {#load-dataset}

Go to the **Connect S3** section. You can use it to:

1. Set up a connection to the S3 bucket.
1. Load a list of objects, i.e., images of cars and buses. They will be used for training the model.
1. Define the function to extract an image using a key (name).

The next section, **Labeling**, is used for labeling data:
* Images are labeled according to the key value (folder name).
* Bus images are labeled with `0`, and car images are labeled with `1`.

To upload and label the data:

1. In the first cell, replace the `bucket_name` variable value with the name of your bucket. The default bucket name is `bucketwithvideo`.
1. Select all the cells containing code in the **Connect S3** and **Labeling** sections. To do this, hold **Shift** and click to the left of the cells in question:

   ```
   #!g1.1

   session = boto3.session.Session()
   ...
   ```

1. Run the selected cells.
1. Wait for the operation to complete. When the operation is complete, one of the images is displayed to check whether the data was uploaded and labeled correctly.

## Prepare the ML model and calculate the properties {#get-cnn-model}

Go to the **Calculating the characteristics** section. It is used to:

1. Load the ResNet50 model from the Keras package with weights pre-selected using the ImageNet dataset. This set contains 1.2 million images classified into 1,000 categories.
1. Define the `featurize_images` function. It splits the list of images into chunks with 32 images in each, converts their size to 224×224 pixels, and then converts them to a four-dimensional [tensor](https://en.wikipedia.org/wiki/Tensor) to upload to the Keras model. Next, the function calculates their properties and returns them in a NumPy array.
1. Leverage the function to calculate binary properties (`1` means car, `0` means other) and save them to a file. This step may take 10-15 minutes. You can read more about the ResNet50 model [here](https://www.kaggle.com/keras/resnet50).

To prepare the model and calculate the properties:

1. Select all the cells containing code in the **Calculating the characteristics** section:

   ```
   #!g1.1
   model = ResNet50(weights='imagenet',  input_shape=(224, 224, 3))
   ...
   ```

1. Run the selected cells.
1. Wait for the operation to complete.

## Train the classifier on the obtained properties {#classifier-fit}

In this section, you will train the LightGBM classifier on the properties calculated in the previous section. The model's characterization is done using cross-validation.

The [K-fold](http://scikit-learn.org/0.16/modules/generated/sklearn.cross_validation.StratifiedKFold.html) method of the scikit-learn package is used. Parts of the training sample (folds) are created based on the specified percentage of data from each class.

This is important when there are much fewer images of one category of your data than in another. This example uses cross-validation with five folds. You can set a different number of folds in the `n_splits` parameter.

Go to the **Training and cross-validation** and **Saving the model** sections. The following operations are performed there:

1. An object for cross-validation of training results is defined using the **K-fold** method.
1. A table is prepared to store the classification's quality metrics.
1. The `classification_metrics` function for calculating the selected metrics is defined.
1. Training of the LightGBM classifier is started. This example uses cross-validation with five folds:
   1. The training sample is divided into five equal non-overlapping parts.
   1. Five iterations are run. At each iteration, the following steps are performed:
      1. The model is trained on four parts from the sample.
      1. The model is tested on the sample's part not used for training.
      1. The selected quality metrics are output.
1. The classifier is trained on the full dataset, and the resulting error matrix is output.

To train the classifier, run all the cells in the **Training and cross-validation** and **Saving the model** sections one by one.

As a result, the trained model is saved to a separate file.

## Get the results of feature prediction based on test data {#model-test}

To use the resulting model:

1. Open the **ML** folder and then the **model-testing.ipynb** notebook.

   This notebook uses the previously trained LightGBM classifier to prepare the required entities to illustrate how your model can be used in practice.

   {% note info %}

   You need much fewer resources to use the model than to train it, that's why a minimum c1.4 configuration is left for this purpose (default).

   {% endnote %}

1. Run the first three cells. In these cells:
   1. The packages needed for the test are imported.
   1. The name of the bucket that stores the images is defined. The default bucket name is `bucketwithvideo`.
   1. A connection to the bucket with the images from the video monitoring service is set up.
1. Add a test image including a car:

   ```
   test_image = 'car/electric-cars-17.jpeg'
   ```

   {% note info %}

   If you run the cell again, specify a new image.

   {% endnote %}

1. In the cell from the **Prediction** section, load the ResNet50 model and the prepared LightGBM classifier and calculate the probability of the predicted binary property value (`1` means a car).

   It takes longer to process the cell with prediction calculation for the first time, because the models are loaded into the memory. At subsequent runs, the cell will run faster:

   ```
   %%time
   clf = lgb.Booster(model_file='ImageClassificationML/lightgbm_classifier.model')
   model = ResNet50(weights='imagenet',  input_shape=(224, 224, 3))
   ...
   ```

1. Make sure that the probability value is close to 1 (you should get ≈`0.98`).
1. Edit the cell code before loading the model:

   ```
   test_image = 'bus/electric_bus-183.jpeg'
   ```

   This is a test image that doesn't have a car in it.

1. Run the cell.
1. Repeat the probability calculation and make sure that the value is much less than `0.5`.

Now you see that the classifier well predicts the property for both images.

{% note info %}

You can [share](../../datasphere/operations/projects/publication.md) the available notebook containing the computations or [export the entire project](../../datasphere/operations/projects/export.md).

{% endnote %}

## Practical use of the model {#model-apply}

There are several practical uses of the model you built:

* Based on the code of the proposed solution, you can run a web service using [{{ sf-full-name }}](../../functions/) and analyze on-event images from a CCTV camera.
* For parallel processing of images collected from multiple video cameras into an S3 bucket, you can upload the code to an Apache Spark™ cluster in [{{ dataproc-full-name }}](../../data-proc/) using the PySpark package.


## How to delete the resources you created {#clear-out}

To shut down the model and stop paying for the resources created:

1. [Delete](../../storage/operations/objects/delete.md) all objects from the bucket.
1. [Delete](../../storage/operations/buckets/delete.md) the respective bucket.
1. [Delete](../../datasphere/operations/projects/delete.md) your project.
