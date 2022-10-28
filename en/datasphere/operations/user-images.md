# Configuring the environment using a Docker image

You can configure the environment to run your code using [Docker images](../concepts/resource-model.md#resources).

{{ ml-platform-full-name }} lets you create repositories of Docker images in a project and select an image for the project. The selected image will be used when running code in all project notebooks.

## Docker image requirements {#requirements}

For a Docker image to run and operate correctly in {{ ml-platform-name }}, it must include:
* A Python 3.7 or Python 3.8 installation.
* A pip installation.
* A {{ jlab }} user.

{% note info %}

The Docker image templates presented in {{ ml-platform-name }} already meet these requirements. If you are downloading an image from a third-party source or writing your own, include the required commands.

{% endnote %}

## Creating a Docker image {#create}

To create a Docker image:
1. {% include [find project](../../_includes/datasphere/ui-find-project.md) %}
1. In the upper-right corner, click **Create resource**. In the window that appears, select **Docker**.
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
1. Under **Resources**, select **Docker**.

