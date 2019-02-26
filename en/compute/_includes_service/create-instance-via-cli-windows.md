1. See the description of the CLI's create VM command:

    ```
    $ yc compute instance create --help
    ```

1. Select one of the public [images](../operations/images-with-pre-installed-software/get-list.md) on Windows.

    [!INCLUDE [standard-images](../../_includes/standard-images.md)]

1. Create a YAML file (for example, `metadata.yaml`) and specify the following:

    ```yaml
    #ps1
    net user administrator "<password>"
    ```

1. Create a VM in the default folder:

    ```
    $ yc compute instance create \
        --name second-instance \
        --metadata-from-file user-data=metadata.yaml \
        --zone ru-central1-a \
        --public-ip \
        --create-boot-disk image-folder-id=standard-images,image-family=windows-2016-gvlk
    ```

    This command creates a Windows Server 2016 VM named `second-instance` by the `administrator` user, located in the `ru-central1-a` availability zone with a public IP address. To create a VM without a public IP, remove the `--public-ip` flag.

    Specify:
    - The VM name in the `--name` flag. The name must be unique within the folder. It may contain lowercase Latin letters, numbers, and hyphens. The first character must be a letter. The last character can't be a hyphen. The maximum length of the name is 63 characters.
    - The administrator's password in the `metadata.yaml` file. A password is required for accessing the VM via RDP. Do not use passwords that are easy to guess. Passwords must meet the complexity requirements of the [security policy](https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh994562%28v%3dws.11%29) defined by Windows. Password complexity requirements are applied when creating a VM and may result in access denial if not met.

