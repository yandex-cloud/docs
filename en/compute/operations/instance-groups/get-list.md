# Get a list of instance groups

To get a list of instance groups:

---

**[!TAB Management console]**

1. Open the folder page in the management console.
1. Select **[!KEYREF compute-full-name]**.
1. On the **Virtual machines** page, go to the **Instance groups** tab.

**[!TAB CLI]**

[!INCLUDE [cli-install](../../../_includes/cli-install.md)]

[!INCLUDE [default-catalogue](../../../_includes/default-catalogue.md)]

1. See the description of the CLI's use instance group command:

    ```
    $ [!KEYREF yc-compute-ig] --help
    ```

1. Get a list of instance groups in the default folder:

    [!INCLUDE [instance-group-list](../../../_includes/instance-groups/instance-group-list.md)]

**[!TAB API]**

Use the [list](../../instancegroup/api-ref/InstanceGroup/list.md) API method.

To request a list of available groups, use the [listInstances](../../instancegroup/api-ref/InstanceGroup/listInstances.md) method.

---

