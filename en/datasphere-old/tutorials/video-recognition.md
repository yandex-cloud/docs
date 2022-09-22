# Classification of images in video frames

{{ ml-platform-full-name }} lets you build machine learning (ML) models using the Jupyter Notebook interface in {{ yandex-cloud }}.

This use case solves the problem of binary image classification. Such a problem may arise when you need to detect vehicle types on images from CCTV cameras. It is assumed that the CCTV system captures images from the camera when it detects motion. Then the images are transmitted to an S3 bucket.

To get an idea of how the problem might be solved:
1. [Install dependencies](#satisfy-dependencies).
1. [Upload and label the data](#load-dataset).
1. [Prepare the ML model and calculate the properties](#get-cnn-model).
1. [Train the classifier on the obtained properties](#classifier-fit).
1. [Predict the property for the test image](#model-test).
1. [View practical applications of the model](#model-apply).

## Before you begin {#before-you-begin}

1. [Create](../../storage/quickstart.md#the-first-bucket) an S3 bucket. Follow the [link](https://www.kaggle.com/kdnishanth/bus-or-car-using-cnn-100-accuracy/data) to upload the training images from this folder data to it.
1. [Create](../../iam/operations/sa/create.md) a service account.
1. [Assign to the service account the role](../../iam/operations/sa/assign-role-for-sa.md) `storage.viewer` to read the object storage where you created the bucket.
1. [Create](../../iam/operations/sa/create-access-key.md) a static access key.
1. Save the static access key to a file:

   ```bash
   [default]
   aws_access_key_id=<static key ID>
   aws_secret_access_key=<secret key>
   ```

1. [Create a project](../operations/projects/create.md) in **{{ ml-platform-name }}** and open it.
1. [Clone](../operations/projects/work-with-git.md#clone) the Git repository containing the notebooks with the examples of the ML model training and testing:

   ```
   https://github.com/MaxKhlupnov/ImageClassificationML
   ```

   Wait until cloning is complete. It may take some time. Once the operation is complete, the folder of the cloned repository will appear in the ![folder](../../_assets/datasphere/jupyterlab/folder.svg) **File Browser** section.

1. Open the **ImageClassificationML** folder and then the `yc.config` file. Replace the file contents with lines from the local file that include your static access key.

1. Open the **ML** folder and then the **model-building.ipynb** notebook.

   {% include [safe-state-warn](../../_includes/datasphere/safe-state.md) %}

## Install dependencies {#satisfy-dependencies}

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

1. Run the selected cell. To do this, choose **Run → Run Selected Cells** or press **Shift** + **Enter**.

1. Wait for the operation to complete.

The solution uses the [Keras interface](https://keras.io/about/) of the TensorFlow library with a [CNTK backend](https://docs.microsoft.com/en-us/cognitive-toolkit/). The `boto3` package is used to connect to the S3 bucket: this is your image source. The cell also sets the environment variables needed to access the CNTK backend and connect to the S3 bucket.

The packages listed in the cell are already installed in {{ ml-platform-name }} and you can import them using the `import` command. For the full list of packages pre-installed in {{ ml-platform-name }}, see [{#T}](../concepts/preinstalled-packages.md).

{% note info %}

This cell and the next cells use the g1.1 configuration of computing resources to accelerate loading and training the model. For more information, see [{#T}](../concepts/configurations.md).

{% endnote %}

## Upload and label the data {#load-dataset}

Go to the **Functions for connecting to S3** section. The following operations are performed there:

1. Connection to the S3 bucket is being set up.
1. A list of objects, i.e., images of cars and buses, is being loaded. They will be used for training the model.
1. The function to extract an image using a key (name) is defined.

In the next section, **Labeling**, the data is labeled:
- Images are labeled according to the key value (folder name).
- Bus images are labeled with `0`, and car images are labeled with `1`.

To upload and label the data:

1. Select all the cells containing code under **Functions for connecting to S3** and **Labeling**. To do this, hold **Shift** and click to the left of the cells:

   ```
   #!g1.1
   
   session = boto3.session.Session()
   ...
   ```

1. Run the selected cells.
1. Wait for the operation to complete. When the operation is complete, one of the images is displayed to check whether the data was uploaded and labeled correctly.

## Prepare the ML model and calculate the properties {#get-cnn-model}

Go to the **Calculating properties** section. The following operations are performed there:

1. The ResNet50 model is loaded from the Keras package with weights pre-selected using the ImageNet dataset. This set contains 1.2 million images classified into 1000 categories.
1. A function is defined to split the image list into chunks, 32 images per chunk.
1. A function is defined that reads the list of images and converts them to a format suitable for the model. It also calculates their properties and returns them in a NumPy array.
1. These functions are used to calculate binary properties (`1` — car, `0` — other) and save them to a file. This step may take 10-15 minutes. [More about the ResNet50 model](https://www.kaggle.com/keras/resnet50).

To prepare the model and calculate the properties:

1. Select all the cells containing code under **Calculating properties**:

   ```
   #!g1.1
   model = ResNet50(weights='imagenet',  input_shape=(224, 224, 3))
   ...
   ```

1. Run the selected cells.
1. Wait for the operation to complete.


## Train the classifier on the obtained properties {#classifier-fit}

Go to the sections **Training and Cross Validation** and **Save the model**. The following operations are performed there:

1. An object for cross-validation of training results is defined using the **K-fold** method.
1. A table is prepared to store the classification's quality metrics.
1. The function for calculating the selected metrics is defined.
1. Training of the LightGBM classifier is started. This example uses cross-validation with five folds:
   1. The training sample is divided into five equal non-overlapping parts.
   1. Five iterations are run. At each iteration, the following steps are performed:
      1. The model is trained on four parts from the sample.
      1. The model is tested on the sample's part not used for training.
      1. The selected quality metrics are output.
1. The classifier is trained on the full dataset, and the resulting error matrix is output.

To train the classifier, run all the cells in the sections **Training and Cross Validation** and **Save the model** one-by-one.

The result of the training is a model saved to a separate file.

## Get the results of feature prediction based on test data {#model-test}

To use the resulting model:

1. Open the **ImageClassificationML/ML** folder and then the **model-testing.ipynb** notebook.

   {% note info %}

   You need much fewer resources to use the model than to train it, that's why a minimum c1.4 configuration is left for this purpose (default).

   {% endnote %}

1. Run the first two cells. In these cells:
   1. The packages needed for the test are imported.
   1. A connection to the S3 bucket with images from the video monitoring service is set up.
1. Add a test image including a car:

   ```
   test_image = 'car/test/3_60184_41.jpg'
   ```

1. In the next cell, load the ResNet50 model and the prepared LightGBM classifier and calculate the probability of the predicted binary property value (`1` means a car).

   It takes longer to process the cell with prediction calculation for the first time, because the models are loaded into the memory. At subsequent runs, the cell will run faster:

   ```
   %%time
   clf = lgb.Booster(model_file='ImageClassificationML/lightgbm_classifier.model')
   model = ResNet50(weights='imagenet', input_shape=(224, 224, 3))
   ...
   ```

1. Make sure that the probability value is close to 1 (you should get `≈0.98`).

1. Edit the cell code before loading the model:

   ```
   test_image = 'car/test/3_59296_27.jpg'
   ```

   This is a test image that doesn't have a car in it.

1. Run the cell.

1. Repeat the probability calculation and make sure that the value is much less than `0.5`.

Now you see that the classifier well predicts the property for both images.

{% note info %}

You can [share](../operations/projects/publication.md) the available notebook containing the computations or [export the entire project](../operations/projects/export.md).

{% endnote %}


{% if product == "yandex-cloud" %}

## Practical use of the model {#model-apply}

There are several practical uses of the model you built:
- Based on the code of the proposed solution, you can run a web service using [{{ sf-full-name }}](../../functions/) and analyze on-event images from a CCTV camera.
- For parallel processing of images collected from multiple video cameras into an S3 bucket, you can upload the code to an Apache Spark™ cluster in [{{ dataproc-full-name }}](../../data-proc/) using the PySpark package.

   Sample Python code to integrate the model with PySpark:

   ```python
   from sparkdl import readImages, KerasImageFileTransformer
   
   # load cctv image body from S3 and return image tensor
   
   def load_image_body_and_process(uri):
       import PIL.image
       from keras.applications.imagenet_utils import preprocess.input
   ...
   
   # load cctv images in batch (from S3 or copy to local hdfs)
   
   image_uri_dataset = readImages("/cctv-in/*.jpg")
   
   # create a Keras estimator that takes our saved model file and train it using Spark
   
   estimator = KerasImageFileEstimator(inputCol="imageUri",
                                       outputCol="predict_car",
                                       labelCol="categoryVec",
                                       imageLoader=load_image_body_and_process,
                                       kerasOptimizer="adam",
                                       kerasLoss="categorical_crossentropy",
                                       kerasFitParams={"epochs": 5, "batchSize": 64},
                                       modelFile="lightgbm_classifier.model")
   predictions = estimator.fit(image_uri_dataset)
   ```
{% endif %}
