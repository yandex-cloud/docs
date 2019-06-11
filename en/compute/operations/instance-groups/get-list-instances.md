# Getting a list of instances in a group

After creating an instance group, you can get a list of instances in the group.

To get a list of instances:

---

**[!TAB Management console]**

1. Open the folder page in the management console.
1. Select **[!KEYREF compute-full-name]**.
1. On the **Virtual machines** page, go to the **Instance groups** tab.
1. Click on the name of the group you need.
1. On the **Overview** page, go to the **List of VMs** tab.

**[!TAB CLI]**

[!INCLUDE [cli-install.md](../../../_includes/cli-install.md)]

[!INCLUDE [default-catalogue.md](../../../_includes/default-catalogue.md)]

1. See the description of the CLI's get instance list command:

    ```
    $ [!KEYREF yc-compute-ig] list-instances --help
    ```

1. Get a list of instance groups in the default folder:

    [!INCLUDE [instance-group-list.md](../../../_includes/instance-groups/instance-group-list.md)]

1. Select the `ID` or `NAME` of the necessary group (for example, `first-instance-group`).

1. Get information about the instance group:

    ```
    $ [!KEYREF yc-compute-ig] list-instances --name first-instance-group
    ```

**[!TAB API]**

Use the [listInstances](../../api-ref/InstanceGroup/listInstances.md) method.

---

