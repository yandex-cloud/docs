# Creating a preemptible VM

To create a preemptible VM:

---

**[!TAB Management console]**

1. Open the folder where the VM will be created.

1. Click **Create resource**.

1. Select **Virtual machine**.

1. In the **Name** field, enter the VM name.

    [!INCLUDE [name-format](../../../_includes/name-format.md)]

1. Select the [availability zone](../../../overview/concepts/geo-scope.md) to locate the VM in.

1. Select one of the [public images](../../operations/images-with-pre-installed-software/get-list.md) on Linux.

1. In the **Computing resources** section:
    - Select the [core usage type](../../concepts/vm-types.md) (partial or full).
    - Specify the necessary number of vCPUs and amount of RAM.
    - Set the **Preemptible** flag.

1. In the **Network settings** section, select the subnet to connect the VM to when creating it.

1. Specify data required for accessing the VM:
    - Enter the username in the **Login** field.
    - In the **SSH key** field, paste the contents of the public key file.
        You need to create a key pair for SSH connection yourself. For more information, see the section [[!TITLE]](../vm-control/vm-connect-ssh.md#vm-connect).

1. Click **Create VM**.

**[!TAB CLI]**

[!INCLUDE [cli-install](../../../_includes/cli-install.md)]

[!INCLUDE [default-catalogue](../../../_includes/default-catalogue.md)]

1. See the description of the CLI's create VM command:

    ```
    $ yc compute instance create --help
    ```

1. Prepare the key pair (public and private) for SSH access to the VM.

1. Select a public [image](../images-with-pre-installed-software/get-list.md) based on Linux OS (for example, CentOS 7).

    [!INCLUDE [standard-images](../../../_includes/standard-images.md)]

1. Create a VM in the default folder:

    ```
    $ yc compute instance create \
        --name first-preemptible-instance \
        --zone ru-central1-a \
        --preemptible \
        --create-boot-disk image-folder-id=standard-images,image-family=centos-7 \
        --ssh-key ~/.ssh/id_rsa.pub
    ```

    This command creates a preemptible VM with the following characteristics:
    - Named `first-preemptible-instance`.
    - Running on CentOS 7.
    - In the `ru-central1-a` availability zone.

    [!INCLUDE [name-format](../../../_includes/name-format.md)]

**[!TAB API]**

Use the [Create](../../api-ref/Instance/create.md) method for the `Instance` resource.

---

[!INCLUDE [ip-fqdn-connection](../../../_includes/ip-fqdn-connection.md)]

#### See also

- [[!TITLE]](../vm-control/vm-connect-ssh.md)

