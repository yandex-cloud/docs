# Creating a Linux-based product image to upload to {{ marketplace-name }}

To add a product for {{ compute-full-name }} to the Marketplace, you need to upload the image to {{ yandex-cloud }}. The products can be based on Linux and Windows Server. This section will help you create an image based on Linux OS..

If you wish to add a product for {{ managed-k8s-full-name }}, follow the [relevant instructions](create-container.md).

## Creating an image {#create}

{% include [create-image](../../_includes/marketplace/image.md) %}

## Image requirements {#requirements}

{% include [image-create-requirements](../../_includes/compute/image-create-requirements.md) %}

For instructions on how to configure the OS to meet the requirements, see [{#T}](../../compute/operations/image-create/custom-image.md).

To use the image for a Marketplace product, also follow these steps:
1. Clean up:
   * The `/tmp`, `/var/tmp`, and `/var/log` directories.
   * The package manager cache.
   * `.bash_history` for all users.
   * The data on configurations previously received via DHCP (`dhcp.leases` and `dhcp.log`).
   * The `/etc/machine-id` file.

1. Make sure that:
   * The image only has the system users that the applications need.
   * There are no pre-generated SSH keys or passwords in the image. If necessary, application passwords are generated at VM startup. The user can change them the first time they log in via the serial console or SSH. Password-based access via SSH must be disabled for all users. They may log in only using a key obtained from the [metadata service](../../compute/operations/vm-info/get-info.md#inside-instance).
   * The `/etc/sudoers*` file has no extra privileges configured for users.

1. Use the supplemental guidelines for configuring images for the Marketplace:
   * The `/etc/fstab` configuration file is missing the lines to connect swap.

## Checking your image {#check-image}

You can clean up and check the system by the [yc-image-cleanup.sh](https://github.com/yandex-cloud/examples/blob/master/products-prepare/linux/yc-image-cleanup.sh) script.

You should run the `yc-image-cleanup.sh` script inside the image as a `root` user.

The `yc-image-cleanup.sh` script does not check the product image for compliance with all requirements and is not compatible with all distributions. Before uploading the image to the Marketplace, you'll need to perform additional checks yourself. To learn whether `yc-image-cleanup.sh` supports your distribution, run the script with the `-o` option. For the supported distributions, the script outputs the distribution name and version and detects the package manager. If the distribution is not supported, the resulting line will be `Unsupported OS/distribution; can't determine package manager type`.

To clean up a VM before creating an image from it, run the command:

```bash
./yc-image-cleanup.sh -c
```

{% note warning %}

The cleanup command deletes some files and directories. Before running it, make sure that you have backups of important data.

{% endnote %}

Before the cleanup, you can set the `YCCLEANUP_SYS_USER` environment variable by specifying the name of the system user who must be deleted together with the home folder during the cleaning. For example, in Ubuntu, the system user is `ubuntu`, in CentOS — `centos`. In some cases, the system user may be `cloud-user` or some other user. In the `YCCLEANUP_SYS_USER` variable, you can even specify the user executing the script. In this case, an error message is displayed, but the user is still deleted. If the `YCCLEANUP_SYS_USER` variable is not set, no user is deleted.

To check the image for compliance with some [requirements](#requirements), run the command:

```bash
./yc-image-cleanup.sh -d
```

To check the VM that you [created](../../compute/operations/image-create/upload.md#create-vm-from-user-image) from the image, run the command:

```
./yc-image-cleanup.sh -t
```

If your system design doesn't allow for any verification when starting with the `-t` key, you can disable this verification. The list of disabled checks is passed in the `-s` option in the format: `yc-image-cleanup.sh -s <spec1>,<spec2> -t`. You can disable checks using the specifiers:

* `users-locked-nocheck`: Disables the verification that password authentication should be disabled for all users and you can log in to the VM only by the key.
* `empty-history-nocheck`: Disables the verification that the bash history should be empty for all users.
* `one-auth-user-nocheck`: Disables the verification that only one user besides `root` can have an entry in `authorized_keys`. This user can be the only one specified in metadata.
* `one-auth-key-nocheck`: Disables the verification that each user has no more than one entry in `authorized_keys`. This verification isn't passed if any user with an entry in `authorized_keys` has not been deleted from the original image.
* `no-private-keys-nocheck`: Disables the verification that no user has any files of the "public key — private key" pair in the `.ssh` folder in the home folder.
* `no-passwords-nocheck`: Disables the verification that password authentication is turned off in the `sshd` configuration file.

You can run the `yc-image-cleanup.sh` script with the `-t` key in `verbose` mode to display the details of the verification process. When running with details for each verification stage, invalid configuration parameter values or a list of users who failed the check is displayed. Detail mode is supported only by the `normal` level. To run the verification script in detail mode, run the command (the keys must follow the specified order):

```
./yc-image-cleanup.sh -v normal -t
```

To view all available script parameters and all environment variables that affect its execution, run the command:

```
./yc-image-cleanup.sh -h
```
