# Create a target group

---

**[!TAB Management console]**

To create a new [target group](../concepts/target-resources.md):

1. Open the **Load Balancer** section in the folder where you want to create a target group.

1. Open the **Target group** tab.

1. Click **Create target group**.

1. Enter the name of the target group.

    [!INCLUDE [name-format](../../_includes/name-format.md)]

1. Select the VMs to add to the target group.

1. Click **Create target group**.

**[!TAB API]**

You can create a new target group using the [create](../api-ref/TargetGroup/create.md) API method.

Once the target group has been created, add targets that the load will be distributed across. You can use the [addTargets](../ api-ref/TargetGroup/addTargets) method to add targets to a group.

---

