# Getting information about an instance group

After creating an instance group, you can get basic information about the group.

User-defined [metadata](../../compute/concepts/vm-metadata.md) that was passed during group creation or update can only be obtained using the CLI or API.

To get information about an instance group:

---

**[!TAB Management console]**

1. Open the folder page in the management console.
1. Select **[!KEYREF compute-full-name]**.
1. On the **Virtual machines** page, go to the **Instance groups** tab.
1. Click on the name of the group you need.

**[!TAB CLI]**

[!INCLUDE [cli-install.md](../../_includes/cli-install.md)]

[!INCLUDE [default-catalogue.md](../../_includes/default-catalogue.md)]

1. See the description of the CLI's get instance group info command:

    ```
    $ [!KEYREF yc-compute-ig] get --help
    ```

1. Get a list of instance groups in the default folder:

    [!INCLUDE [instance-group-list.md](../../_includes/instance-groups/instance-group-list.md)]

1. Select the `ID` or `NAME` of the necessary group (for example, `first-instance-group`).

1. Get information about the instance group:

    ```
    $ [!KEYREF yc-compute-ig] get --name first-instance-group
    ```

**[!TAB API]**

Use the [get](../../instance-groups/api-ref/InstanceGroup/get.md) API method.

To request a list of available groups, use the [listInstances](../../instance-groups/api-ref/InstanceGroup/listInstances.md) method.

---

