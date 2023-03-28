# Deploying a service based on a model trained in {{ ml-platform-name }}

In {{ ml-platform-name }}, you can both train a model and [deploy](../../datasphere/concepts/deploy/index.md) it as a microservice that can be accessed from external resources.

In this example, you will train a model for classifying clothing items from the [Keras](https://keras.io/about/) library and then complete all steps required to publish a service by creating a [node](../../datasphere/concepts/resource-model.md#resources) and an [alias](../../datasphere/concepts/resource-model.md#resources).

To create a microservice based on a trained model:
1. [Prepare the infrastructure](#infra).
1. [Prepare a model](#get-model).
1. [Create a checkpoint](#checkpoint).
1. [Create a node](#create-node).
1. [Send a test request to the node](#test-query).
1. [Create an alias](#create-alias).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin-datasphere.md) %}

### Required paid resources {#paid-resources}

The cost of deploying a microservice based on a trained model includes:
* Fee for the computation time spent for training the model.
* Fee for the uptime of each node instance.
* Fee for the outgoing traffic.

For more information, see [{{ ml-platform-full-name }} pricing](../../datasphere/pricing.md).

## Prepare the infrastructure {#infra}

{% include [intro](../../_includes/datasphere/infra-intro.md) %}

### Create a folder {#create-folder}

Create a folder to store logs of your service.

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select a cloud and click ![create](../../_assets/plus-sign.svg) **{{ ui-key.yacloud.component.console-dashboard.button_action-create-folder }}**.
   1. Give your folder a name, e.g., `data-folder`.
   1. Click **{{ ui-key.yacloud.iam.cloud.folders-create.button_create }}**.

{% endlist %}

### Create a service account for the {{ ml-platform-name }} project {#create-sa}

{% list tabs %}

- Management console

   1. Go to the `data-folder` folder.
   1. In the **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}** tab, click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
   1. Enter a name for the [service account](../../iam/concepts/users/service-accounts.md), such as `sa-with-network`.
   1. Click **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** and assign the following [roles](../../iam/concepts/access-control/roles.md) to the service account:
      * `vpc.user` to use the {{ ml-platform-name }} cluster network.
      * (optional) `datasphere.user` to send requests to the node.

   1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

{% endlist %}

### Create and set up a {{ ml-platform-name }} project {#prepare-project}

1. [Create](../../datasphere/operations/projects/create.md) a project.
1. In [project settings](../../datasphere/operations/projects/update.md), specify the service account named `sa-with-network` and the folder named `data-folder`.
1. Enable [auto-save mode](../../datasphere/concepts/save-state.md#auto-save).

## Prepare a model {#get-model}

{% note info %}

In this example, we will use the basic [c1.4 configuration](../../datasphere/concepts/configurations.md) to train a model and deploy a node. The [TensorFlow](https://www.tensorflow.org/) library installed in the project checks if there are drivers and CUDA libraries; however, it does not use them in our example. These checks might cause errors and warnings that do not affect the performance of {{ ml-platform-name }} and Tensorflow.

{% endnote %}

In this example, you will use an image classification model based on [fully connected layers](https://en.wikipedia.org/wiki/Convolutional_neural_network#Fully_connected_layers). The model returns ten probability values that show how confident the network is about the input image matching a certain class.

1. Import the required libraries to the project. To do this, copy and paste the code into the appropriate cell by selecting **Run → Run Selected Cells** or pressing **Shift** + **Enter**. Wait for the operation to complete.

    ```python
    #!c1.4
    import tensorflow as tf
    import numpy as np
    import matplotlib.pyplot as plt
    import base64
    ```

1. Create a model. In this example, we use a [dataset](../../datasphere/concepts/dataset.md) named [Fashion MNIST](https://en.wikipedia.org/wiki/Fashion_MNIST) with a selection of images that show different clothing items.

    ```python
    #!c1.4
    fashion_mnist = tf.keras.datasets.fashion_mnist

    (train_images, train_labels), (test_images, test_labels) = fashion_mnist.load_data()

    class_names = ['T-shirt/top', 'Trouser', 'Pullover', 'Dress', 'Coat',
                  'Sandal', 'Shirt', 'Sneaker', 'Bag', 'Ankle boot']

    model = tf.keras.Sequential([
        tf.keras.layers.Flatten(input_shape=(28, 28)),
        tf.keras.layers.Dense(128, activation='relu'),
        tf.keras.layers.Dense(10)
    ])
    ```

1. Set up the model for training:

    ```python
    #!c1.4
    model.compile(optimizer='adam',
              loss=tf.keras.losses.SparseCategoricalCrossentropy(from_logits=True),
              metrics=['accuracy'])
    ```

1. Train the model:

    ```python
    #!c1.4
    model.fit(train_images, train_labels, epochs=10)
    ```

1. Check the accuracy of the trained model based on test data:

    ```python
    #!c1.4
    test_loss, test_acc = model.evaluate(test_images,  test_labels, verbose=2)

    print('\nTest accuracy:', test_acc)
    ```

1. To use the model you obtained, provide `test_images` to it.

    ```python
    probability_model = tf.keras.Sequential([model, tf.keras.layers.Softmax()])
    predictions = probability_model.predict(test_images)
    np.argmax(predictions[0])
    ```

   A prediction is an array of 10 numbers. They describe the probability of an image match to each of 10 types of clothes.

1. (Optional) Test the model.
   * Create functions to display an image to classify and prediction results in a graphical view:

        ```python
        def plot_image(i, predictions_array, true_label, img):
            true_label, img = true_label[i], img[i]
            plt.grid(False)
            plt.xticks([])
            plt.yticks([])

            plt.imshow(img, cmap=plt.cm.binary)

            predicted_label = np.argmax(predictions_array)
            if predicted_label == true_label:
                color = 'blue'
            else:
                color = 'red'

            plt.xlabel("{} {:2.0f}% ({})".format(class_names[predicted_label],
                                    100*np.max(predictions_array),
                                    class_names[true_label]),
                                    color=color)

        def plot_value_array(i, predictions_array, true_label):
            true_label = true_label[i]
            plt.grid(False)
            plt.xticks(range(10))
            plt.yticks([])
            thisplot = plt.bar(range(10), predictions_array, color="#777777")
            plt.ylim([0, 1])
            predicted_label = np.argmax(predictions_array)

            thisplot[predicted_label].set_color('red')
            thisplot[true_label].set_color('blue')
        ```

    * Display the sixth image and prediction results:

        ```python
        i = 6
        plt.figure(figsize=(6,3))
        plt.subplot(1,2,1)
        plot_image(i, predictions[i], test_labels, test_images)
        plt.subplot(1,2,2)
        plot_value_array(i, predictions[i],  test_labels)
        plt.show()
        ```


## Create a checkpoint for deploying your microservice {#checkpoint}

1. Create an array of images in [Base64](https://en.wikipedia.org/wiki/Base64) encoding. This array will be used to classify the images based on the trained ML model.

    ```python
    #!c1.4
    encoded_images = [
        base64.b64encode(test_images[1].tobytes()),
        base64.b64encode(test_images[4].tobytes()),
        base64.b64encode(test_images[7].tobytes()),
        base64.b64encode(test_images[9].tobytes())
    ]
    print(encoded_images)
    ...
    ```
1. Set the input and output parameters and the way the deployed microservice will run:

    ```python
    #!c1.4
    # decode input
    images = np.stack([
        np.ndarray(
            (28, 28),
            buffer=base64.b64decode(encoded_img),
            dtype='uint8'
        )
        for encoded_img in encoded_images
    ])

    # apply model
    predictions = probability_model.predict(images)

    # prepare result
    labels = predictions.argmax(axis=1).tolist()
    ```

    This automatically creates a checkpoint in the project.

1. Pin the checkpoint:
    1. In the top left corner of the navigation chain, click {{ jlab }}Lab and go to **{{ ui-key.yc-ui-datasphere.common.checkpoint }}**.
    1. In the list, choose the last added checkpoint named `Cell run` and make sure it contains the appropriate code from the previous step.
    1. In the top right corner, click ![Pin](../../_assets/datasphere/pin.svg) **{{ ui-key.yc-ui-datasphere.common.pin }}**.
    1. In the window that appears, enter a name for the checkpoint, such as `checkpoint-for-node`, and click **{{ ui-key.yc-ui-datasphere.common.pin }}**.

## Create a node {#create-node}

1. To create a node:
    1. {% include [find project](../../_includes/datasphere/ui-find-project.md) %}
    1. In the top right corner, click **{{ ui-key.yc-ui-datasphere.project-page.project-card.create-resource }}**. In the window that opens, select **{{ ui-key.yc-ui-datasphere.resources.node }}**.
    1. Specify the node parameters:
        * **Type**: **Cell**.
        * **Name**: Node name, e.g., `classifier-node`.
        * In the **Checkpoint** field, select the checkpoint named `checkpoint-for-node`.
        * Under **Input variables**, click ![Add](../../_assets/plus-sign.svg) **Add** and create a variable with the following parameters:
           * **Name**: `encoded_images`.
           * **Type**: `list`.
        * Under **Output variables**, click ![Add](../../_assets/plus-sign.svg) **Add** and create a variable with the following parameters:
           * **Name**: `labels`.
           * **Type**: `list`.
        * Under **Docker image**, select `Default Python 3.8`.
     1. Under **Folder**, select `data-folder`.
     1. Under **Maintenance**, select:
        * **Instance configuration**: `c1.4`.
        * **Availability zone**: Set an [availability zone](../../overview/concepts/geo-scope.md), such as `{{region-id}}-a`.
        * Leave the **subnet ID** empty, as {{ ml-platform-name }} will set the default subnet ID.
     1. Click **{{ ui-key.yc-ui-datasphere.common.create }}**.

## Send a test request to the node {#test-query}

You can send requests from the {{ ml-platform-name }} interface or the notebook code.

{% list tabs %}

- {{ ml-platform-name }} interface

    {% note info %}

    {{ ml-platform-name }} sends test requests under the service account linked to the project. Make sure the service account has permissions to access the folder where the node is created.

    {% endnote %}

    1. On the `classifier-node` page, go to the **{{ ui-key.yc-ui-datasphere.node-page.tab.request }}** tab.
    1. Under **{{ ui-key.yc-ui-datasphere.node-page.request.create-test-request }}**, provide a Base64-encoded image to classify:

        ```json
        {"encoded_image": ["AAAAAAAAAAAAAA1DAAAAADImAAAAAAAAAAAAAAAAAAAAAAAIeNHi9+3////37uusSAAAAAAAAAAAAAAAAACJ7/zz6uXu9Pbw5ujv+PvCAAAAAAAAAAAAAABm/+fk4+Tp5ubl5Ojo5+Pg/LMAAAAAAAAAAAAA6fHl5///7ufj7vbk5uPq6+XxFAAAAAAAAAAAAPjx5/+VL/zk//LY7uj/5Nzq+jYAAAAAAAAAAAD/8Oj/DwD/7b8AANb/DXv/6vxyAAAAAAAAAAAG/+7v/7EA//8AgnQvQSsl/+z5ogAAAAAAAAAAIP/s9f/MAP9UACUcHwAZDf/s+ccAAAAAAAAAADX/7Pr65wL/FQDd/+w29cbz7vXfAAAAAAAAAABQ/+368P8AACedAADXXhR+/+3v+gAAAAAAAAAAZf/r/fTzhYrQ/8nW/+YHrv/w7v8AAAAAAAAAAH7/6f/46f//8Ojz8+f7///+8+7/AwAAAAAAAACT/+n5tfPj4Obq5ubr5Ovez//s/yMAAAAAAAAAo//13Vb/6enr7Orq6ujy533/7P83AAAAAAAAALX+/8hF/+To6uvq6unr8e1G/+v2OQAAAAAAAADF9/+8bv/g6erq6urq6vD9Rf/s+E0AAAAAAAAAyPb/lZH/3+vq6+vr6u3p/y//7/liAAAAAAAAAMzz/2+t/+Pr6+zr6+vv5f8T4/b5bgAAAAAAAADE8P9t1frl6+vs6+3s7eL/N8v79XgAAAAAAAAAwPP/cujw6Ovr7Ort7Ovl/4ar/PSJAAAAAAAAAL37/5ru6ezq6+zr7uzr6P+mff/zjgAAAAAAAAC3/P+r9+jq6unp6Orp6unw34D/8pcAAAAAAAAAsvP/Oe7x7u7u7ezt7fDt/rA0/++dAAAAAAAAALzw+j7a/9ze3t7f3+De2v+aIP/svAAAAAAAAACC9fIYAAAAAAAAAAAAAAAAACLy9IcAAAAAAAAATP/5FgAAAAAAAAAAAAAAAAAn+f97AAAAAAAAADHNxQsABAECAgICAgICAgMAA669QwAAAA=="]}
        ```

      You will get the code of the image class in response.

- Python

    1. Define the request parameters:

        ```python
        #!c1.4
        import json
        import os
        import requests

        resp = requests.post(
            "https://datasphere.api.cloud.yandex.net/datasphere/v1/nodes/<node_ID>",
            data = json.dumps({
                'node_id': '<node_ID>',
                'folder_id': '<folder_ID>',
                'input': {
                    'encoded_images': [
                        base64.b64encode(test_images[0].tobytes()).decode('ascii'),
                        base64.b64encode(test_images[1].tobytes()).decode('ascii'),
                        base64.b64encode(test_images[2].tobytes()).decode('ascii')
                    ]
                }
            }),
            headers = {
                'Authorization': f"Bearer <IAM token>"
            }
        )

        # check response
        print(resp.status_code, resp.reason)
        print(resp.text)
        ```

        Where:
        - `<node_ID>`: ID of `classifier-node`.
        - `<IAM token>`: Your account [IAM token](../../iam/operations/iam-token/create.md).
        - `<folder_ID>`: [ID of the folder](../../resource-manager/operations/folder/get-id.md) where the node was created.

        {% note info %}

        {% include [iam-token-disclaimer](../../_includes/iam/iam-token-note.md) %}

        {% endnote %}

     1. Run the cell. In response, you will get a list of image labels in the range from 0 to 9:

        ```json
        200 OK
        {
         "output": {
          "labels": [
           9,
           2,
           1
          ]
         }
        }
        ```

{% endlist %}

To view logs and check the node health, use the **{{ ui-key.yc-ui-datasphere.node-page.tab.logs }}** and **{{ ui-key.yc-ui-datasphere.node-page.tab.monitoring }}** tabs on the node page.


## Create an alias {#create-alias}

You can distribute the load across nodes and update the deployed services on the fly using [aliases](../../datasphere/concepts/deploy/index.md#alias).

To create an alias:
1. {% include [find project](../../_includes/datasphere/ui-find-project.md) %}
1. In the top right corner, click **{{ ui-key.yc-ui-datasphere.project-page.project-card.create-resource }}**. In the window that opens, select **{{ ui-key.yc-ui-datasphere.common.alias }}**.
1. Specify the alias parameters:
   * In the **{{ ui-key.yc-ui-datasphere.common.name }}** field, specify `fashion`.
   * In the **{{ ui-key.yc-ui-datasphere.common.prefix }}** field, select an available alias prefix.
   * Under **{{ ui-key.yc-ui-datasphere.new-alias.field.label-nodes }}**, select `classifier-node`. Specify the percentage of requests to redirect to the node.
   * Under **{{ ui-key.yc-ui-datasphere.common.folder }}**, select the folder to create new resources in.
1. Click **{{ ui-key.yc-ui-datasphere.common.save }}**.

To check whether the alias is working, click its name and go to the **{{ ui-key.yc-ui-datasphere.node-page.tab.monitoring }}** tab.

Use the alias instead of the node endpoint to make sure the service is always up and running.

## How to delete created resources {#clear-out}

To stop paying for the resources you created:
* [Delete](../../datasphere/operations/deploy/alias-delete.md) the alias.
* [Delete](../../datasphere/operations/deploy/node-delete.md) the node.