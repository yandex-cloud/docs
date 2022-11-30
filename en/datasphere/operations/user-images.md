# Working with Docker images

You can configure the environment to run your code using [Docker images](../concepts/docker.md).

{{ ml-platform-full-name }} lets you create repositories of Docker images in a project and select an image for the project. The selected image will be used when running code in all project notebooks.

## Creating a Docker image {#create}

To create a Docker image:
1. {% include [find project](../../_includes/datasphere/ui-find-project.md) %}
1. In the upper-right corner, click **Create resource**. In the window that appears, select **Docker image**.
1. Complete the fields below:
   * **Build path**: Path inside a project where the created Docker image will be stored. `.` is the root directory.
   * **Image name**: Name of the image, such as `cuda`.
   * **Tag**: Image tag, such as `1.0.0`.
   * **Docker template**: Template of the script used to install Python (`python_3_7` or `python_3_8`).
   * **Docker file**: A set of instructions for creating a Docker image.

      Edit the contents of the field. For example, to install CUDA<sup>®</sup> packages, you need a template of the `python_3_8` image and the following code:

      ```bash
      FROM ubuntu:18.04
      ENV DEBIAN_FRONTEND noninteractive
      RUN useradd -ms /bin/bash --uid 1000 jupyter\
       && apt update\
       && apt install -y python3.8-dev python3.8-distutils gnupg wget software-properties-common curl\
       && ln -s /usr/bin/python3.8 /usr/local/bin/python3\
       && curl https://bootstrap.pypa.io/get-pip.py | python3
      ENV LD_LIBRARY_PATH /usr/local/cuda-11.2/lib64:/usr/local/nvidia/lib:/usr/local/nvidia/lib64:/usr/local/cuda/lib64:/usr/local/cuda/extras/CUPTI/lib64
      RUN apt-get update &&\
       apt-get install -y -q xserver-xorg-core wget &&\
       wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/cuda-ubuntu1804.pin -O /etc/apt/preferences.d/cuda-repository-pin-600 &&\
       apt-key adv --fetch-keys <public GPG key> &&\
       add-apt-repository "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/ /" &&\
       apt-get update &&\
       apt-get -y install cuda libcudnn8 nvidia-cuda-toolkit &&\
       exit
      RUN pip install tensorflow-gpu==2.4.1
      ```

      Replace the `<public GPG key>` with a link to a valid GPG key for working with CUDA<sup>®</sup>, such as `https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/3bf863cc.pub`. See details in the [Nvidia blog](https://developer.nvidia.com/blog/updating-the-cuda-linux-gpg-repository-key/).

1. Click **Build**.

   This creates a Docker image with CUDA<sup>®</sup> packages to use the GPU in computations.

To view all created Docker images:
1. {% include [find project](../../_includes/datasphere/ui-find-project.md) %}
1. Under **Project resources**, select ![docker](../../_assets/datasphere/docker.svg) **Docker image**.

## Applying a Docker image to a project {#set}

To use an image for a project:
1. {% include [find project](../../_includes/datasphere/ui-find-project.md) %}
1. Under **Project resources**, select ![docker](../../_assets/datasphere/docker.svg) **Docker image**.
1. Click ![Options](../../_assets/options.svg) next to the desired image and select ![Apply](../../_assets/datasphere/apply.svg) **Apply**.
1. Open the project in {{ jlab }}Lab and wait for it to load.
1. Open the notebook tab and check that the custom image environment is available in your project. For example, for the image with CUDA<sup>®</sup> packages, create and run a cell with the following code:

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
1. Under **Project resources**, select ![docker](../../_assets/datasphere/docker.svg) **Docker image**.
1. Click ![Options](../../_assets/options.svg) next to the default image and select ![Apply](../../_assets/datasphere/apply.svg) **Apply**.

{% note warning %}

The Python 3.7 system image won't work with the g2.x (GPU A100) [configurations](../../datasphere/concepts/configurations.md).

{% endnote %}

## Sharing a Docker image {#share}

Only a community admin can share a Docker image in the community.

To learn more about roles that apply in {{ ml-platform-name }}, see [{#T}](../../datasphere/security/index.md).

1. {% include [find project](../../_includes/datasphere/ui-find-project.md) %}
1. Under **Project resources**, click ![docker](../../_assets/datasphere/docker.svg)**Docker image**.
1. Select the desired image from the list.
1. Go to the **Access** tab.
1. Enable the visibility option next to the name of the community to share the Docker image in.

## Deleting a Docker image {#delete}

1. {% include [find project](../../_includes/datasphere/ui-find-project.md) %}
1. Under **Project resources**, click ![docker](../../_assets/datasphere/docker.svg).**Docker image**.
1. In the list of Docker images, select the one you want to delete.
1. Click ![options](../../_assets/options.svg) and select **Delete**.
1. Click **Confirm**.

You'll see a message like `<image_name> resource deleted`.
