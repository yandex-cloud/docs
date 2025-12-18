# CUDA unavailable on GPU platform


## Issue description {#issue-description}

CUDA is not available on the GPU platform.

## Solution {#issue-resolution}

Run these commands:

1. `sudo apt update -y`
1. `sudo apt upgrade -y`
1. `pip3 install torch`

Check whether CUDA is available by calling `torch.cuda.is_available()`.

You may also consider using [{{ ml-platform-name }}](../../../datasphere/concepts/configurations.md) that leverages GPU configurations. Every service project contains multiple Docker images with a specific software stack. You can still [build a custom image for your project](../../../datasphere/operations/user-images.md), if required.

{% note info %}

The base Docker image comes with CUDA and cuDNN pre-installed. 

{% endnote %}

To check the version of these components, use the following commands:

* `!nvcc --version` for CUDA.
* `!cat /usr/include/cudnn_version.h` for cuDNN.

You might also want to check out:

* Info on NVIDIA by running `!nvidia-smi`.
* CUDA availability using `torch` by calling `torch.cuda.is_available()`.
