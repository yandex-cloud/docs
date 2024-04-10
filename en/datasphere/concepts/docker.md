# Docker images

You can set up a {{ ml-platform-name }} project environment on your own by using a [_Docker image_](https://docs.docker.com/engine/reference/commandline/image/) with any software, libraries, environment variables, and configuration files. The Docker image you apply to your project will be used when running code in all its notebooks.

You cannot change Docker images after you create them.

Like other {{ ml-platform-name }} resources, a Docker image can be [published](../operations/user-images.md#share) in a community and used in multiple projects. You can share Docker images of a {{ ml-platform-name }} project where you have the `Admin` role. Images can be shared with any community that you are a member of with the `Admin` role. For more information, see [{#T}](../security/index.md).

For more information about working with Docker images, see [{#T}](../operations/user-images.md).

## Docker image requirements {#requirements}

For a Docker image to run and work correctly in {{ ml-platform-name }}, it must comprise:
* Python 3.7, 3.8, 3.9, or 3.10 installation
* Pip installation
* `--uid 1000` {{ jlab }} user

{% include [Docker hub limits](../../_includes/datasphere/dockerhub-limits.md) %}

{% note info %}

The Docker image templates available in {{ ml-platform-name }} already meet these requirements. If you are downloading an image from a third-party source or writing your own, include the required commands.

{% endnote %}

#### See also {#see-also}

* [{#T}](../operations/user-images.md)