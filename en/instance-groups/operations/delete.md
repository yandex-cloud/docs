# Delete an instance group

> [!IMPORTANT]
>
> Deleting an instance group is an operation that cannot be canceled or reversed. You cannot restore a deleted group. Along with the group, you delete the [!KEYREF load-balancer-name] target group, instances, and disks.

To delete an instance group:

---

**[!TAB Management console]**

1. Open the folder page in the management console.
1. Select **[!KEYREF compute-full-name]**.
1. On the **Virtual machines** page, go to the **Instance groups** tab.
1. Click ![image](../../_assets/vertical-ellipsis.svg) for the group you want to delete and select **Delete**.

**[!TAB CLI]**

[!INCLUDE [cli-install.md](../../_includes/cli-install.md)]

[!INCLUDE [default-catalogue.md](../../_includes/default-catalogue.md)]

1. See the description of the CLI's delete instance group command:

    ```
    $ [!KEYREF yc-compute-ig] delete --help
    ```

1. Get a list of instance groups in the default folder:

    [!INCLUDE [instance-group-list](../../_includes/instance-groups/instance-group-list.md)]

1. Select the `ID` or `NAME` of the necessary group (for example, `first-instance-group`).

1. Delete the instance group:

    ```
    $ [!KEYREF yc-compute-ig] delete --name first-instance-group
    ```

    [!KEYREF instance-groups-name] starts the operation to delete the instance group.

**[!TAB API]**

Use the [delete](../../instance-groups/api-ref/InstanceGroup/delete.md) API method.

To request a list of available groups, use the [listInstances](../../instance-groups/api-ref/InstanceGroup/listInstances.md) method.

---

