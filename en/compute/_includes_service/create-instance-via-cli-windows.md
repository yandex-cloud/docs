1. See the description of the CLI's create VM command:

    ```
    $ yc compute instance create --help
    ```

1. Select one of the public [images](../operations/images-with-pre-installed-software/get-list.md) on Windows.

    [!INCLUDE [standard-images](../../_includes/standard-images.md)]

1. Create a YAML file (for example, `metadata.yaml`) and provide the following information::

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

    This command creates a VM instance with the following characteristics:
    - Named `second-instance`.
    - With the Windows Server 2016 OS.
    - In the `ru-central1-a` availability zone.
    - With the `Administrator` user.
    - With a public IP.

    To create a VM without a public IP, remove the `--public-ip` flag.

    Specify:

    - The VM name in the `--name` flag.

        The name must be unique within the folder. It may contain lowercase Latin letters, numbers, and hyphens. The first character must be a letter. The last character can't be a hyphen. The maximum length of the name is 63 characters.

        > [!NOTE]
        >
        > The virtual machine name is used for generating the FQDN, which cannot be changed later. If the FQDN is important to you, choose an appropriate name for the virtual machine at the creation stage. For more information about generating FQDN names, see the section [[!TITLE]](../concepts/network.md#hostname).

    - The administrator password in the `metadata.yaml` file. A password is required for accessing the VM via RDP.

        [!INCLUDE [password-requirements](../../_includes/compute/password-requirements.md)]

