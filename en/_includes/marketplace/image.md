Images of products placed in the Marketplace must meet the [requirements](../../marketplace/operations/create-image.md#requirements).

If you don't have a VM image, create one:

* [Use Packer](../../solutions/infrastructure-management/packer-quickstart). The image is automatically uploaded to {{ compute-name }}.<br>Recommendations for creating an image:
    * As a base image, use an image from the [public catalog](../../compute/operations/images-with-pre-installed-software/get-list) in {{ yandex-cloud }}.
    * See [examples of packer recipes](https://github.com/yandex-cloud/examples/tree/master/jenkins-packer/packer).
    * [Automate](../../solutions/infrastructure-management/jenkins) the image build with Jenkins.
* Use other tools that are convenient for you. In this case, you need to [upload](../../compute/operations/image-create/upload.md) an image to {{ compute-name }} yourself. Supported image formats: Qcow2, VMDK, and VHD.

