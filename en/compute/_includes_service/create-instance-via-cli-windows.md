1. See the description of the CLI's create VM command:

    ```
    $ yc compute instance create --help
    ```

1. Select one of the public [images](../operations/images-with-pre-installed-software/get-list.md) on Windows. To get a list of available images, use the command:

    ```
    $ yc compute image list --folder-id standard-images
    +----------------------+------------------------------+-------------------+----------------------+--------+-------------+
    |          ID          |             NAME             |       FAMILY      |     PRODUCT IDS      | STATUS | DESCRIPTION |
    +----------------------+------------------------------+-------------------+----------------------+--------+-------------+
    ...
    | fd8hph1ebp3md34nmo2v | windows-2016-gvlk-1537967224 | windows-2016-gvlk | f2eeomdch319df69gaib | READY  |     ...     |
    ...
    +----------------------+------------------------------+-------------------+----------------------+--------+-------------+
    ```

1. Create a VM in the default folder:

    ```
    $ yc compute instance create \
        --name my-yc-vm \
        --metadata user-data="#ps1\nnet user Administrator <password>" \
        --zone ru-central1-a \
        --public-ip \
        --create-boot-disk image-folder-id=standard-images,image-name=windows-2016-gvlk-1537967224
    ```

    This command creates a VM named `my-yc-vm` based on Windows Server 2016, with the `Administrator` user, located in the `ru-central1-a` zone and with a public IP.

    Specify:

    - The VM name in the `--name` flag. The name must be unique within the folder. It may contain lowercase Latin letters, numbers, and hyphens. The first character must be a letter. The last character can't be a hyphen. The maximum length of the name is 63 characters.
    - The administrator's password in the `--metadata` flag. A password is required for accessing the VM via RDP. Do not use passwords that are easy to guess. Passwords must meet the complexity requirements of the [security policy](https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh994562%28v%3dws.11%29) defined by Windows. Password complexity requirements are applied when creating a VM and may result in access denial if not met.
