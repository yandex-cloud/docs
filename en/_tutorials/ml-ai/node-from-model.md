# Deploying a service from an ONNX model

{{ ml-platform-name }} allows you to deploy and run services based on a [model](../../datasphere/concepts/models/index.md) trained in the project.

In this tutorial, you will deploy a service from an ONNX model. The `fast-neural-style-mosaic-onnx` model transforms an image as per the specified style. The model is taken from the [ONNX model repository](https://github.com/onnx/models/).

1. [Prepare your infrastructure](#infra).
1. [Create a model](#create-model).
1. [Create a node](#create-node).
1. [Run a health check for the service you deployed](#check-node).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin-datasphere.md) %}

### Required paid resources {#paid-resources}

The cost of deploying a service from a model includes:

* Fee for continuously running node instances (see [{{ ml-platform-name }} pricing](../../datasphere/pricing.md)).
* Fee for running code cells for health checks of the deployed service.

## Prepare the infrastructure {#infra}

{% include [intro](../../_includes/datasphere/infra-intro.md) %}

{% include [intro](../../_includes/datasphere/federation-disclaimer.md) %}

### Create a folder {#create-folder}

Create a folder for you to deploy your infrastructure and for your service to store the logs.

{% note info %}

In our example, both the {{ yandex-cloud }} infrastructure and the deployed service operate from the same {{ yandex-cloud }} folder; however, this is not a requirement.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select a cloud and click ![create](../../_assets/console-icons/plus.svg)**{{ ui-key.yacloud.component.console-dashboard.button_action-create-folder }}**.
   1. Name your folder, e.g., `data-folder`.
   1. Click **{{ ui-key.yacloud.iam.cloud.folders-create.button_create }}**.

{% endlist %}

### Create a service account for the {{ ml-platform-name }} project {#create-sa}

{% list tabs group=instructions %}

- Management console {#console}

   1. Go to `data-folder`.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
   1. Click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
   1. Enter a name for the service account, e.g., `datasphere-sa`.
   1. Click **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** and assign the following [roles](../../iam/concepts/access-control/roles.md) to the service account:
      * `vpc.user`: To use the {{ ml-platform-name }} network.
      * `datasphere.user`: To send requests to the node.

   1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

{% endlist %}

## Create a model {#create-model}

The `fast-neural-style-mosaic-onnx` model is one of the style transfer models designed to convert an image to the style of another image.

1. {% include [include](../../_includes/datasphere/ui-before-begin.md) %}

1. Install the `onnx` module:

   ```python
   %pip install onnx
   ```

1. Download the `mosaic.onnx` file:

   ```python
   !wget -O "mosaic.onnx" "https://github.com/onnx/models/raw/main/validated/vision/style_transfer/fast_neural_style/model/mosaic-8.onnx"
   ```

1. Load the model into a variable and check it for consistency:

   ```python
   import onnx

   onnx_model = onnx.load("mosaic.onnx")
   onnx.checker.check_model(onnx_model)
   ```

1. In the right-hand panel, select ![models](../../_assets/console-icons/nodes-right.svg). In the window that opens, click **Create model**.
1. Select the name of the variable to create your model from.
1. Enter a name for the model, e.g., `onnx-model`.
1. Click **Create**.

## Create a node {#create-node}

1. {% include [find project](../../_includes/datasphere/ui-find-project.md) %}
1. In the top-right corner, click **{{ ui-key.yc-ui-datasphere.project-page.project-card.create-resource }}**. In the pop-up window, select **{{ ui-key.yc-ui-datasphere.resources.node }}**.
1. Enter a name for the node in the **{{ ui-key.yc-ui-datasphere.new-node.node-form-label.name }}** field.
1. Under **{{ ui-key.yc-ui-datasphere.new-node.node-form-label.type }}**, specify the resource type: **{{ ui-key.yc-ui-datasphere.common.model }}**.
1. In the **{{ ui-key.yc-ui-datasphere.common.models }}** field, select `onnx-model`.
1. Under **{{ ui-key.yc-ui-datasphere.new-node.title.folder }}**, select `data-folder`.
1. Under **{{ ui-key.yc-ui-datasphere.new-node.title.provisioning }}**, select the [configuration](../../datasphere/concepts/configurations.md) of [instance](../../datasphere/concepts/deploy/index.md) computing resources, the [availability zone](../../overview/concepts/geo-scope.md), and the ID of the [subnet](../../vpc/concepts/network.md#subnet) to host the instance in.
1. Under **{{ ui-key.yc-ui-datasphere.new-node.title.acl }}**, click ![Add](../../_assets/console-icons/plus.svg) **{{ ui-key.yc-ui-datasphere.new-node.add-acl }}** and specify the [IDs of the folders](../../resource-manager/operations/folder/get-id.md) to allow connections to the node from. By default, the ID of the folder owned by the user creating the node is specified.
1. Click **{{ ui-key.yc-ui-datasphere.common.create }}**.

## Run a health check for the service you deployed {#check-node}

1. [Create secrets](../../datasphere/operations/data/secrets.md#create) to test your node:

   * `IAM_SECRET`: [IAM token](../../iam/concepts/authorization/iam-token.md) value.
   * `NODE_ID`: Node ID.
   * `FOLDER_ID`: [Folder ID](../../resource-manager/operations/folder/get-id.md).

1. {% include [include](../../_includes/datasphere/ui-before-begin.md) %}

1. Install the `tritonclient` module:

   ```python
   %pip install tritonclient[http]
   ```

1. Import the required libraries:

   ```python
   import numpy as np
   import matplotlib.pyplot as plt
   from PIL import Image
   import requests
   import urllib
   import os
   %matplotlib inline
   ```

1. Prepare your image:

   ```python
   url, filename = ("https://github.com/pytorch/hub/raw/master/images/dog.jpg", "dog.jpg")
   try: urllib.URLopener().retrieve(url, filename)
   except: urllib.request.urlretrieve(url, filename)

   # loading input and resize if needed
   onnx_image = Image.open(filename)

   size_reduction_factor = 5
   onnx_image = onnx_image.resize((224, 224))

   # Preprocess image
   x = np.array(onnx_image).astype('float32')
   x = np.transpose(x, [2, 0, 1])
   onnx_input = np.expand_dims(x, axis=0)

   plt.figure(figsize=(15, 15))
   plt.imshow(onnx_image)
   plt.show()
   ```

1. Authenticate using the secrets created earlier:

   ```python
   IAM_SECRET = os.environ['IAM_SECRET']
   NODE_ID = os.environ['NODE_ID']
   FOLDER_ID = os.environ['FOLDER_ID']

   headers = {
       "Authorization": f"Bearer {IAM_SECRET}", # get IAM token from secrets
       "x-node-id": f"{NODE_ID}", # sample node
       "x-folder-id": f"{FOLDER_ID}" # node folder ID
   }
   ```

1. Send test requests with the model ID substituted as follows:

   ```python
   import tritonclient.http as httpclient

   model="<model_ID_in_DataSphere>"

   # request model config with model ready status
   print(f"""model_name: {model},\n
         model_ready: {triton_client.is_model_ready(model_name=model, headers=headers)},\n
         model_config: {triton_client.get_model_config(model_name=model, headers=headers)}\n""")
   ```

1. Prepare your image and send a request to the node:

   ```python
   payload = httpclient.InferInput("input1", list(onnx_input.shape), "FP32")
   payload.set_data_from_numpy(onnx_input, binary_data=False)
   results = triton_client.infer(model, inputs=[payload], headers=headers)
   ```

1. Receive the result of image transformation:

   ```python
   output = results.as_numpy("output1")[0]
   output = np.clip(output, 0, 255)
   output = output.transpose(1,2,0).astype("uint8")
   img = Image.fromarray(output)
   img
   ```

   You will get the transformed image in the response.

## How to delete the resources you created {#clear-out}

{% include [node warning](../../_includes/datasphere/nodes-pricing-warn.md) %}

1. [Delete the node](../../datasphere/operations/deploy/node-delete.md).
1. [Delete the secrets](../../datasphere/operations/data/secrets.md#delete).