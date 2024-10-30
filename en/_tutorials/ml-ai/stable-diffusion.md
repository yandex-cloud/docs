# Image generation using the Stable Diffusion model

In {{ ml-platform-name }}, you can deploy a neural network based on the Stable Diffusion model and generate images based on text descriptions.

[Stable Diffusion](https://github.com/CompVis/stable-diffusion) is an open-source text-to-image model developed by [stability.ai](https://stability.ai/).

In this tutorial, you will generate an image based on text description by implementing the Stable Diffusion model in the [Diffusers](https://huggingface.co/docs/diffusers/index) library. This library prioritizes ease of use and customization over performance.

To generate an image using the Stable Diffusion model:

1. [Prepare your infrastructure](#infra).
1. [Create a model and generate an image](#generate).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin-datasphere.md) %}

{% include [intro](../../_includes/datasphere/federation-disclaimer.md) %}

### Required paid resources {#paid-resources}

The cost of using the model includes a fee for running code cells (see [{{ ml-platform-name }} pricing](../../datasphere/pricing.md)).

## Prepare the infrastructure {#infra}

### Create a project {#create-project}

1. Open the {{ ml-platform-name }} [home page]({{ link-datasphere-main }}).
1. In the left-hand panel, select ![image](../../_assets/console-icons/circles-concentric.svg) **{{ ui-key.yc-ui-datasphere.common.spaces }}**.
1. Select the community to create a project in.
1. On the community page, click ![image](../../_assets/console-icons/folder-plus.svg) **{{ ui-key.yc-ui-datasphere.projects.create-project }}**.
1. In the window that opens, enter `Stable Diffusion` as your project name and add a description (optional).
1. Click **{{ ui-key.yc-ui-datasphere.common.create }}**.

### Create a notebook and install the libraries {#install-libraries}

{% note info %}

In this tutorial, all computations use the g1.1 configuration. However, you can run the model on other configurations as well.

{% endnote %}

1. In the {{ ml-platform-name }} interface, open the project you created.
1. Create a new notebook:

   1. In the top panel of the project window, click **File** → **New** → **Notebook**.
   1. In the window that opens, select **{{ ml-platform-name }} Kernel**.

1. Install the [Diffusers](https://huggingface.co/docs/diffusers/index) library. Paste the below code into the cell and click ![run](../../_assets/datasphere/jupyterlab/run.svg):

   ```python
   %pip install diffusers
   ```

1. Install the [Transformers](https://huggingface.co/docs/transformers/index) library:

   ```python
   %pip install transformers
   ```

1. Once the installation is complete, select **Kernel** ⟶ **Restart kernel...** on the top panel.

## Create a model and generate an image {#generate}

1. Import the libraries to the project:

   ```python
   from diffusers import StableDiffusionPipeline
   import torch
   ```

1. Create a model:

   ```python
   model_id = "runwayml/stable-diffusion-v1-5"
   pipe = StableDiffusionPipeline.from_pretrained(model_id, torch_dtype=torch.float16)
   pipe = pipe.to("cuda")
   ```

1. Generate an image by its description:

   ```python
   prompt = "a photo of an astronaut riding a horse on mars"
   image = pipe(prompt).images[0]
   ```

1. Save the output image:

   ```python
   image.save("astronaut_rides_horse.png")
   ```

   The image file will appear next to the notebook. Result:

   ![generate-image](../../_assets/datasphere/generated-image.png)

## How to delete the resources you created {#clear-out}

If you no longer plan to use the `Stable Diffusion` project, [delete it](../../datasphere/operations/projects/delete.md#delete-project).

#### See also {#see-also}

* [{#T}](../../datasphere/operations/data/models.md)
* [{#T}](../../datasphere/tutorials/batch-code-execution.md)
