# Creating a custom Docker image for a project

{% include [link-on-new-ui-datasphere-in-old-ui](../../_includes/datasphere/datasphere-old-note.md) %}

You can configure the environment to run your code using Docker images.

{{ ml-platform-full-name }} lets you create repositories of Docker images in a project and select an image for the project. The selected image will be used when running code in all project notebooks.

## Docker image requirements {#requirements}

For a {% if lang == "ru" %}[Docker image](https://cloud.yandex.ru/blog/posts/2022/03/docker-containers){% else %}Docker image{% endif %} to run and operate correctly in {{ ml-platform-name }}, it must include:

* A Python 3.7 or Python 3.8 installation.
* A pip installation.
* A {{ jlab }} user.

{% note info %}

The Docker image templates presented in {{ ml-platform-name }} already meet these requirements. If you are downloading an image from a third-party source or writing your own, include the required commands.

{% endnote %}

## Creating a Docker image {#create}

To create a Docker image:

1. Go to the ![docker](../../_assets/datasphere/docker.svg) **Docker images** tab.
1. Click the ![plus-sign](../../_assets/plus-sign.svg).
1. On the tab that opens:
   1. Enter a name for the repository, such as `cuda`.
   1. Set a tag for the image, such as `1.0.0`.
   1. Select a Python installation script template: `python_3_7` or `python_3_8`.
   1. Edit the **Dockerfile** section. For example, to install CUDA<sup>®</sup> packages, you need a template of the python 3.8 image and the following code:

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
       apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/7fa2af80.pub &&\
       add-apt-repository "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/ /" &&\
       apt-get update &&\
       apt-get -y install cuda libcudnn8 nvidia-cuda-toolkit &&\
       exit
      RUN pip install tensorflow-gpu==2.6
      ```

   1. Click **Build**.

      This creates a Docker image with CUDA<sup>®</sup> packages to use the GPU in computations.

   1. To use the image in your project, click **Set image to project** and then click **Ok**.

Make sure that the custom image environment is available in your project. For example, for the image with CUDA<sup>®</sup> packages, create and run a cell with the following code:

```bash
#!g1.1
import tensorflow as tf
tf.config.list_physical_devices('GPU')
```

Result:

```text
...
[PhysicalDevice(name='/physical_device:GPU:0', device_type='GPU')]
```

{% note info %}

To return to the default environment, go to the ![docker](../../_assets/datasphere/docker.svg) **Docker images** tab and click **Set image to project**.

{% endnote %}
