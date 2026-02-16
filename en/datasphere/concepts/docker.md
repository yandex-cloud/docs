# Docker images

You can set up a {{ ml-platform-name }} project environment on your own by using a [_Docker image_](https://docs.docker.com/engine/reference/commandline/image/) with any software, libraries, environment variables, and configuration files. The Docker image you apply to your project will be used when running code in all its notebooks.

You cannot change Docker images after you create them.

{% note warning %}

Starting January 31, 2027, all Docker images created in {{ ml-platform-name }} before December 3, 2026, will no longer work. To use these images in projects, recreate them or use the migration tool.

{% endnote %}

## Ways to store Docker images {#storage}

There are two ways to store Docker images:
* In [{{ container-registry-full-name }}](../../container-registry/)
* In {{ ml-platform-name }}

### Storage in {{ container-registry-name }} {#cr}

By default, Docker images are stored in {{ container-registry-name }}. They are built on a {{ ml-platform-name }} VM and, if successful, pushed to the registry specified in the community settings, with its version logged in the relevant {{ ml-platform-name }} resource. Whenever a project using this image runs, {{ ml-platform-name }} pulls this version from the registry. Deleting the image version from the registry keeps the image in the project but disables its further optimization, activation, or use.

Storing images in {{ container-registry-name }} is cheaper, but it increases the project start time. You also cannot share an image from the registry with the community.

To reduce the project start time, you can create an optimized copy of your Docker image stored in {{ container-registry-name }}. This optimized copy is stored on a separate disk in {{ ml-platform-name }} and greatly reduces start time, but storing it adds extra [charges](../pricing.md#storage). You can [publish](../operations/user-images.md#share) an optimized Docker image in the community to use it in multiple projects. 

After you create an optimized copy, you can delete the original image from the registry to avoid paying for storing both the original and the copy. If you delete an optimized copy of the Docker image, {{ ml-platform-name }} will attempt to pull the Docker image from {{ container-registry-name }} again when the project starts. The project will continue using the original version if it is still available in {{ container-registry-name }}. 

{% note tip %}

To allow project users to build and store Docker images in {{ container-registry-name }}, the community administrator should specify the registry in the community settings and enable the [service agent](../operations/community/create-ssa.md).

{% endnote %}

### Storage in {{ ml-platform-name }} {#datasphere}

If you select {{ ml-platform-name }} for storage when creating a Docker image, it will be stored on a dedicated disk in {{ ml-platform-name }} once built and will not be pushed to {{ container-registry-name }}. This image is immediately considered optimized and billed accordingly.

If you delete a Docker image stored in {{ ml-platform-name }}, you will not be able to restore it.

You can [publish](../operations/user-images.md#share) a Docker image stored in {{ ml-platform-name }} in the community to use it in multiple projects. To do this, you need at least the `Editor` role in the project and the `Developer` role in the community you want to publish it in. You can open the access on the **{{ ui-key.yc-ui-datasphere.common.access }}** tab on the Docker image view page. The resource available to the community will appear on the community page under **{{ ui-key.yc-ui-datasphere.spaces-page.community-resources }}**. While the image is published, you cannot delete it.

For more information, see [{#T}](../operations/user-images.md).

## Docker image requirements {#requirements}

For a Docker image to run and work correctly in {{ ml-platform-name }}, it must include:
* Python 3.8, 3.9, 3.10, or 3.11 installation
* Pip installation
* `--uid 1000 jupyter` user

{% include [Docker hub limits](../../_includes/datasphere/dockerhub-limits.md) %}

{% note info %}

The Docker image templates available in {{ ml-platform-name }} already meet these requirements. If you are downloading an image from a third-party source or writing your own, include the required commands.

{% endnote %}

#### See also {#see-also}

[{#T}](../operations/user-images.md)
