# Recover an instance group

You can recover a group if one of its instances becomes unhealthy and the status changes to `FAILED`. For more information about statuses, see the section [[!TITLE]](../concepts/vm-statuses.md).

To recover an instance group:

---

**[!TAB Management console]**

1. Open the folder page in the management console.
1. Select **[!KEYREF compute-full-name]**.
1. On the **Virtual machines** page, go to the **Instance groups** tab.
1. Click on the name of the group you want to recover.
1. Click **Recover** in the upper-right corner of the page.

**[!TAB CLI]**

[!INCLUDE [cli-install.md](../../_includes/cli-install.md)]

[!INCLUDE [default-catalogue.md](../../_includes/default-catalogue.md)]

1. See the description of the CLI's recover group command:

   ```
   $ [!KEYREF yc-compute-ig] recover --help
   ```

1. Get a list of instance groups in the default folder:

    [!INCLUDE [instance-group-list.md](../../_includes/instance-groups/instance-group-list.md)]

1. Select the `ID` or `NAME` of the necessary group (for example, `first-instance-group`).

1. Recover the instance group in the default folder:

    ```
    $ [!KEYREF yc-compute-ig] recover --name first-instance-group
    ```

   [!KEYREF ig-name] starts the operation to recover the instance group.

**[!TAB API]**

Use the [recover](../../instance-groups/api-ref/InstanceGroup/recover.md) API method.

To request a list of available groups, use the [listInstances](../../instance-groups/api-ref/InstanceGroup/listInstances.md) method.

---

