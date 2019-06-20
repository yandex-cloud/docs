# Images

_An image_ is a complete copy of the file system structure and data on a disk.

It is designed to quickly create a data disk, primarily a VM's boot disk. Images can be used for distributing software, such as OS distributions or disks with pre-installed software.

{% note info %}

To regularly back up your data on disks, use [snapshots](snapshot.md).

{% endnote %}

If you already have an image file, you can [import](../operations/image-create/upload.md) it to Yandex.Cloud. Currently, you cannot upload your own image with the Windows OS.

If you are creating a boot disk image, you can specify the type of operating system (Windows or Linux) when creating it.

## Image family {#family}

If you regularly update your images, you can group them into families. A search for an image by family will return the image that was created last in that family. For example, the result of a search for an image by `centos-7` family will be the latest version of CentOS 7.

## Public images {#public}

You can allow public access to your image by assigning the role `{{ roles-image-user }}` to the system group `{{ subjects-allAuthenticatedUsers }}`. Then other Yandex.Cloud users will be able to use your image to create their own disks and VMs. In this case, the role `{{ roles-image-user }}` does not give the right to delete or change your image.

An example of public images are OS distributions provided by Yandex.Cloud.

