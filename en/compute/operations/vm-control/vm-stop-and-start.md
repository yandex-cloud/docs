# Stopping, starting, or restarting a VM

## Stop {#stop}

The **Stop** command shuts down the VM. After the VM is shut down, its status changes to `STOPPED`. While the VM is stopped, no fee is charged for it.

You can enable the VM at any time to continue working with it. All data and changes you've made are saved.

Some VM parameters (such as its boot disk) can only be modified when the VM is stopped.

To stop a VM:

---

**[!TAB Management console]**

1. In the management console, select the folder the VM belongs to.
1. Click on the **Yandex Compute Cloud** tile.
1. To stop a single VM, select the machine → click ![](../../../_assets/dots.png) → select **Stop**.

    To do this with multiple VMs, select the VMs you need to stop from the list → click **Stop** at the bottom of the screen.

**[!TAB CLI]**

[!INCLUDE [default-catalogue](../../../_includes/default-catalogue.md)]

1. See the description of the CLI's stop VM command:

    ```
    $ yc compute instance stop --help
    ```

1. Get a list of all VMs in the default folder:

    [!INCLUDE [compute-instance-list](../../_includes_service/compute-instance-list.md)]

1. Select the `ID` or `NAME` of the VM you need, for example `first-instance`.
1. Stop the VM:

    ```
    $ yc compute instance stop first-instance
    ```

---

## Start {#start}

The **Start** command starts a previously stopped VM. After the VM is started, its status changes to `RUNNING`, and the operating system starts loading. From this point on, you will be charged for using the VM.

To start a VM:

---

**[!TAB Management console]**

1. In the management console, select the folder the VM belongs to.
1. Click on the **Yandex Compute Cloud** tile.
1. To start a single VM, select the machine → click ![](../../../_assets/dots.png) → select **Start**.

    To do this with multiple VMs, select the VMs you need to start from the list → click **Start** at the bottom of the screen.

**[!TAB CLI]**

[!INCLUDE [default-catalogue](../../../_includes/default-catalogue.md)]

1. See the description of the CLI's start VM command:

    ```
    $ yc compute instance start --help
    ```

1. Get a list of all VMs in the default folder:

    [!INCLUDE [compute-instance-list](../../_includes_service/compute-instance-list.md)]

1. Select the `ID` or `NAME` of the VM you need, for example `first-instance`.
1. Start the VM:

    ```
    $ yc compute instance start first-instance
    ```

---

## Restart {#restart}

The **Restart** command restarts a VM.

To restart a VM:

---

**[!TAB Management console]**

1. In the management console, select the folder the VM belongs to.

1. Click on the **Yandex Compute Cloud** tile.

1. To restart a single VM, select the machine → click ![](../../../_assets/dots.png) → select **Restart**.

    To do this with multiple VMs, select the VMs you need to restart from the list → click **Restart** at the bottom of the screen.

**[!TAB CLI]**

[!INCLUDE [default-catalogue](../../../_includes/default-catalogue.md)]

1. See the description of the CLI's restart VM command:

    ```
    $ yc compute instance restart --help
    ```

1. Get a list of all VMs in the default folder:

    ```
    $ yc compute instance list
    +----------------------+---------------+---------------+---------+---------------------+
    |          ID          |     NAME      |    ZONE ID    | STATUS  |     DESCRIPTION     |
    +----------------------+---------------+---------------+---------+---------------------+
    | fhm0b28lgfp4tkoa3jl6 | my-windows-vm | ru-central1-a | RUNNING | my first vm via CLI |
    | fhm9gk85nj7gcoji2f8s | my-linux-vm   | ru-central1-a | RUNNING | my second vm via CLI |
    +----------------------+---------------+---------------+---------+---------------------+
    ```

1. Select the `ID` or `NAME` of the VM you need.

1. Restart the VM:

    ```
    $ yc compute instance restart my-windows-vm
    ```

---

