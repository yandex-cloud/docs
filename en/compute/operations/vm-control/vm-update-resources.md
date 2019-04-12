# Changing VM computing resources

After creating a VM, you can change its computing resources: the number and guaranteed performance of processor cores (vCPUs) and the amount of RAM.

For more information about how to change the name, description, and tags of a VM, see the section [[!TITLE]](vm-update.md).

---

**[!TAB Management console]**

1. In the management console, select the folder the VM belongs to.
1. Click on the **Compute Cloud** tile.
1. Select the VM.
1. Go to the VM's page.
1. Click **Stop** in the top right corner of the page.
1. Wait until the VM status changes to `STOPPED` and click **Update VM** in the top right corner of the page.
1. Change the VM's configuration: in the **Computing resources** section:
    - Choose the platform.
    - Specify the required amount of vCPUs and RAM.
1. Click **Save changes**.
1. Click **Run** in the top right corner of the page.

**[!TAB CLI]**

[!INCLUDE [cli-install](../../../_includes/cli-install.md)]

[!INCLUDE [default-catalogue](../../../_includes/default-catalogue.md)]

1. See the description of the CLI's update VM parameter command:

    ```
    $ yc compute instance update --help
    ```

1. Get a list of VMs in the default folder:

    [!INCLUDE [compute-instance-list](../../_includes_service/compute-instance-list.md)]

1. Select the `ID` or `NAME` of the VM you need (for example, `first-instance`).

1. Stop the VM:

    ```
    $ yc compute instance stop first-instance
    ```

1. Get information about the VM with the [metadata](../../concepts/vm-metadata.md):

    ```
    $ yc compute instance get --full first-instance
    ```

1. Change the VM's configuration:

    ```
    $ yc compute instance update first-instance \
        --memory 32 \
        --cores 4 \
        --core-fraction 100
    ```

    This command will change the configuration of the VM:
    * **Guaranteed vCPU share**: by 100%.
    * **vCPU**: by 4.
    * **RAM**: by 32 GB.

1. Start the VM:

    ```
    $ yc compute instance start first-instance
    ```

---

