# Creating a Linux-based product image to upload to {{ marketplace-name }}

To add a product for {{ compute-full-name }} to the Marketplace, you need to upload the image to {{ yandex-cloud }}. You can add products based on Linux. This section will help you create a Linux-based image.

If you wish to add a product for {{ managed-k8s-full-name }}, follow the [relevant instructions](create-container.md).

## Creating an image {#create}

{% include [create-image](../../_includes/marketplace/image.md) %}

## Image requirements {#requirements}

{% include [image-create-requirements](../../_includes/compute/image-create-requirements.md) %}

For instructions on how to configure the OS to meet the requirements, see [{#T}](../../compute/operations/image-create/custom-image.md).

To use the image for a Marketplace product, also follow these steps:
1. Clean up:
   * Directories: `/tmp`, `/var/tmp`, `/var/log`.
   * The package manager cache.
   * `.bash_history`, for all users.
   * Any data on configurations previously received over DHCP (`dhcp.leases` and `dhcp.log`).
   * `/etc/machine-id`.

1. Make sure that:
   * The image only has the system users that the applications need.
   * Password-based access via SSH is disabled for all users. They must log in using a key obtained from the [metadata service](../../compute/operations/vm-info/get-info.md#inside-instance).
   * There are no pre-generated SSH keys or passwords in the image.

      {% note warning %}

      Application passwords must be generated when the VM starts to enable a user to change them when logging in for the first time via the serial console or SSH.

      {% endnote %}

   * The `/etc/sudoers*` file grants no excessive privileges to users.

1. Use the supplemental guidelines for configuring images for the Marketplace:
   * The `/etc/fstab` configuration file has no lines for connecting swap.

## Checking your image {#check-image}

You can clean up and check the system by the [yc-image-cleanup.sh](https://github.com/yandex-cloud/examples/blob/master/products-prepare/linux/yc-image-cleanup.sh) script.

You must run the `yc-image-cleanup.sh` script inside the image as a `root` user.

The `yc-image-cleanup.sh` script does not check if the product image meets all requirements and may not be compatible with certain distributions. Before uploading the image to the Marketplace, you'll need to perform additional checks yourself. To find out if `yc-image-cleanup.sh` supports your distribution, run the script with the `-o` key. For the supported distributions, the script prints the distribution name and version and detects the package manager. If the distribution is not supported, you will get this line in the result: `Unsupported OS/distribution; can't determine package manager type`.

To clean up a VM before creating an image from it, run the command:

```bash
./yc-image-cleanup.sh -c
```

{% note warning %}

The cleanup command deletes some files and directories. Before running it, make sure that you have backups of important data.

{% endnote %}

Before the VM cleanup, you can set the `YCCLEANUP_SYS_USER` environment variable by specifying the name of the system user to delete during the cleanup along with the home folder. For example, in Ubuntu, the system user is `ubuntu`; in CentOS, `centos`. In some cases, the system user may be `cloud-user` or some other user. In the `YCCLEANUP_SYS_USER` variable, you can even specify the user running the script. In this case, an error message is displayed, but the user is still deleted. If you do not set the `YCCLEANUP_SYS_USER` variable, no user will be deleted.

To check the image for compliance with some [requirements](#requirements), run the command:

```bash
./yc-image-cleanup.sh -d
```

To check the VM that you [created](../../compute/operations/image-create/upload.md#create-vm-from-user-image) from the image, run the command:

```bash
./yc-image-cleanup.sh -t
```

If your system design does not allow checks when running the script with the `-t` key, you can disable this check. You can use the `-s` key to provide the list of checks to disable as follows: `yc-image-cleanup.sh -s <spec1>,<spec2> -t`. You can disable checks using the specifiers:

  * `users-locked-nocheck`: Disables checking if password authentication is inactive for all users and the VM is accessible only with the key.
  * `empty-history-nocheck`: Disables checking if all users have empty bash history.
  * `one-auth-user-nocheck`: Disables checking if only a single user besides `root` has an entry in `authorized_keys`. This user can be the only one specified in metadata.
  * `one-auth-key-nocheck`: Disables checking if there is only one entry per user in `authorized_keys`. This check will fail if a user with an entry in `authorized_keys` was not removed from the source image.
  * `no-private-keys-nocheck`: Disables checking that no user has public–private key pair files in the home folder’s `.ssh` directory.
  * `no-passwords-nocheck`: Disables checking if password authentication is off in the `sshd` configuration file.

You can run the `yc-image-cleanup.sh` script with the `-t` key in `verbose` mode to output the check progress details. If running the script in detail mode, for each stage of the check, you will get a list of users who failed the check or invalid configuration parameter values. The detail mode is supported only at the `normal` level. To run the verification script in detail mode, run the command (the keys must follow the specified order):
  
 ```bash
 ./yc-image-cleanup.sh -v normal -t
 ```

To view all available script parameters and all environment variables that affect its execution, run the command:

 ```bash
 ./yc-image-cleanup.sh -h
 ```
