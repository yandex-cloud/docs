# Working with Docker images

You can configure the environment to run your code using [Docker images](../concepts/docker.md).

{{ ml-platform-full-name }} lets you create repositories of Docker images in a project and select an image for the project. The selected image will be used when running code in all project notebooks.

## Creating a Docker image {#create}

1. {% include [find project](../../_includes/datasphere/ui-find-project.md) %}
1. In the top-right corner, click **{{ ui-key.yc-ui-datasphere.project-page.project-card.create-resource }}**. In the pop-up window, select **{{ ui-key.yc-ui-datasphere.resources.docker }}**.
1. Fill out the fields below:
   * **{{ ui-key.yc-ui-datasphere.docker.build-path }}**: Path inside the project where the created Docker image will be stored. `.` is the root directory.
   * **{{ ui-key.yc-ui-datasphere.docker.repository }}**: Image name, e.g., `tensorflow`.
   * **{{ ui-key.yc-ui-datasphere.docker.tag }}**: Image tag, e.g., `1.0.0`.
   * **{{ ui-key.yc-ui-datasphere.docker.docker-template }}**: Template of the script used to install Python (`python_3_7` or `python_3_8`).
   * **{{ ui-key.yc-ui-datasphere.docker.dockerfile }}**: A set of instructions for creating a Docker image.

      Edit the contents of the field. For example, the following code will create a Docker image with `python_3_8` based on the original TensorFlow image:

      ```bash
      FROM tensorflow/tensorflow:2.7.0-gpu

      RUN set -e \
        && useradd -ms /bin/bash --uid 1000 jupyter \
        && pip install --no-cache-dir --upgrade pip \
        && pip install --no-cache-dir nptyping==1.4.4 pandas==1.4.1 opencv-python-headless==4.5.5.62 scikit-learn==1.0.2 \
        && ln -s /usr/bin/python3 /usr/local/bin/python3
      ```

1. (Optional) Under **{{ ui-key.yc-ui-datasphere.docker.credentials-switcher-label }}**, enter your Docker Hub account username and password.

1. Click **{{ ui-key.yc-ui-datasphere.common.build }}**.

   This will create a Docker image with TensorFlow packages for the use of the GPU in computations.

1. {% include [find project](../../_includes/datasphere/ui-find-project.md) %}
1. Under **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}**, select ![docker](../../_assets/console-icons/logo-docker.svg) **{{ ui-key.yc-ui-datasphere.resources.docker }}**.

{% include [Docker hub limits](../../_includes/datasphere/dockerhub-limits.md) %}

## Applying a Docker image to a project {#set}

1. {% include [find project](../../_includes/datasphere/ui-find-project.md) %}
1. Under **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}**, select ![docker](../../_assets/console-icons/logo-docker.svg) **{{ ui-key.yc-ui-datasphere.resources.docker }}**.
1. Click ![Options](../../_assets/console-icons/ellipsis.svg) next to the desired image and select ![Apply](../../_assets/console-icons/circle-check-fill.svg) **{{ ui-key.yc-ui-datasphere.common.activate }}**.
1. Open the project in {{ jlab }}Lab and wait for it to load.
1. Open the notebook tab and check that the custom image environment is available in your project. For example, for the TensorFlow image, create and run a cell with the following code:

   ```bash
   #!g1.1
   import tensorflow as tf
   tf.config.list_physical_devices('GPU')
   ```

   Result:

   ```bash
   ...
   [PhysicalDevice(name='/physical_device:GPU:0', device_type='GPU')]
   ```
To return to the default environment:
1. {% include [find project](../../_includes/datasphere/ui-find-project.md) %}
1. Under **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}**, select ![docker](../../_assets/console-icons/logo-docker.svg) **{{ ui-key.yc-ui-datasphere.resources.docker }}**.
1. Click ![Options](../../_assets/console-icons/ellipsis.svg) next to the default image and select ![Apply](../../_assets/console-icons/circle-check-fill.svg) **{{ ui-key.yc-ui-datasphere.common.activate }}**.

{% note warning %}

The Python 3.7 system image won't work with the g2.x (GPU A100) [configurations](../../datasphere/concepts/configurations.md).

{% endnote %}

## Sharing a Docker image {#share}

Only a community admin can share a Docker image in the community.

To learn more about roles that apply in {{ ml-platform-name }}, see [{#T}](../../datasphere/security/index.md).

1. {% include [find project](../../_includes/datasphere/ui-find-project.md) %}
1. Under **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}**, click ![docker](../../_assets/console-icons/logo-docker.svg)**{{ ui-key.yc-ui-datasphere.resources.docker }}**.
1. Select the image from the list.
1. Go to the **{{ ui-key.yc-ui-datasphere.common.access }}** tab.
1. Enable the visibility option next to the name of the community to share the Docker image in.

## Deleting a Docker image {#delete}

1. {% include [find project](../../_includes/datasphere/ui-find-project.md) %}
1. Under **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}**, click ![docker](../../_assets/console-icons/logo-docker.svg)**{{ ui-key.yc-ui-datasphere.resources.docker }}**.
1. In the list of Docker images, select the one you want to delete.
1. Click ![options](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yc-ui-datasphere.common.delete }}**.
1. Click **{{ ui-key.yc-ui-datasphere.common.submit }}**.

You will see a message saying that the resource has been deleted.
