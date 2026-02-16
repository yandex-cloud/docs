Images of products placed in the Marketplace must meet the [requirements](../../marketplace/operations/create-image.md#requirements).

If you do not have a VM image, create one:

* Use [Packer](../../tutorials/infrastructure-management/packer-quickstart.md). The image is automatically uploaded to {{ compute-name }}.<br>Recommendations for creating an image:
    * As a base image, use an image from the {{ yandex-cloud }} [public catalog](../../compute/operations/images-with-pre-installed-software/get-list.md).
    * See [examples of packer recipes](https://github.com/yandex-cloud-examples/yc-marketplace-vm-image-packer/packer).
    * [Automate](../../tutorials/infrastructure-management/jenkins.md) VM image builds using Jenkins.
* Use other tools that are convenient for you. In this case, you need to [upload](../../compute/operations/image-create/upload.md) an image to {{ compute-name }}.

{% include [available-image-format](../compute/available-image-format.md) %}
