# Preparing your own images with Microsoft products

You can prepare your own images of Microsoft products to use them in {{ yandex-cloud }} with [your own license](byol.md). Make sure to contact Microsoft and confirm that your license is suitable for cloud environments. We recommend building images on Linux.

## Preparing an image {#prepare}

To prepare an image ready for use in {{ yandex-cloud }}:

1. [Install QEMU](https://www.qemu.org/download/).
1. [Install Packer](../tutorials/infrastructure-management/packer-quickstart#install-packer).
1. Download the archive with [Packer configurations](https://storage.yandexcloud.net/packer-recipies/windows-packer.zip) and unpack it to the desired folder, such as `windows-packer`.
1. Clone the [repository](https://github.com/virtio-win/kvm-guest-drivers-windows) with drivers. Move the folders `NetKVM`, `vioserial`, and `viostor` to the folder `windows-packer/drivers`. The folders contain drivers for different operating systems, so make sure to use the appropriate drivers.
1. Select the appropriate Packer configuration for your Microsoft product and make the following changes to the configuration file:
   1. Specify the path to your distribution in the `iso_url` parameter.
   1. Under `cd_files`, specify paths to unpacked drivers for your OS version. For example:

      ```
      cd_files = [
          "../drivers/netkvm/2k19/amd64/*",
          "../drivers/viostor/2k19/amd64/*",
          "../drivers/vioserial/2k19/amd64/*",
          "../scripts/qemu/*",
          "Autounattend.xml"
        ]
      ```

      If you put folders with drivers elsewhere, specify the appropriate paths.
   1. Find out the checksum of your distribution (for example, execute `openssl dgst -sha256 <path to distribution>`). Insert the obtained value to the `iso_checksum` parameter after `sha256:`.
   1. (optional) With MacOS, you need to replace the `accelerator  = "kvm"` value to `accelerator  = "hvf"`.
1. Go to the folder with the necessary image configuration (for example, `external-windows-packer/ws22gui-qemu`) and execute the `packer build .` command.

This creates a disk image in `.qcow2` format.

## Upload the image to {{ objstorage-name }} {#upload-to-storage}

Upload the created image to {{ objstorage-name }} using one of the [supported tools](../storage/tools).

## Import the image to {{ compute-name }} {#import-to-compute-cloud}

Using the [{{ compute-name }} API](../compute/api-ref/Image/create.md), you can import the image to the service:

{% list tabs %}

- CLI
  
  ```
  yc compute image create --name <image name> --description <image description> --os-type windows --source-uri <link to image in Object Storage>
  ```

- Bash

   ```bash
   curl -H "Authorization: Bearer `yc iam create-token`" -H  "accept: application/json" -X POST https://compute.api.cloud.yandex.net/compute/v1/images -d '{"folderId": "<ID of your folder>", "name": "<image name>", "description": "<image description>", "os": {"type": "WINDOWS"}, "pooled": false, "uri": "<link to image in Object Storage>"}'
   ```

- PowerShell

   ```powershell
   function Create-YCImage {
     param(
       [ValidateNotNullOrEmpty()]
       [string]$folderId = "",

       [ValidateNotNullOrEmpty()]
       [string]$name = "",

       [string]$description = "",

       [ValidateNotNullOrEmpty()]
       [string]$os_type = "WINDOWS",

       [int64]$minDiskSizeGb = 50GB,

       [ValidateNotNullOrEmpty()]
       [string]$uri = ""
     )

     $body = @"
   {
     "folderId": "$folderId",
     "name": "$name",
     "description": "$description",
     "os.type": "$os_type",
     "minDiskSize": "$minDiskSizeGb",
     "os": {
       "type": "$os_type"
     },
     "uri": "$uri"
   }
   "@

     Invoke-WebRequest `
       -Method POST `
       -URI https://compute.api.cloud.yandex.net/compute/v1/images `
       -header @{ "Authorization" = "Bearer $(& yc iam create-token)" } `
       -ContentType 'Application/json' `
       -body $body
   }


   $folderId = "<ID of your folder>"

   Create-YCImage `
     -folderId $folderId `
     -name "<image name>" `
     -uri "<link to image in Object Storage>"

   ```

{% endlist %}

You can use the imported image to create a VM boot disk.
