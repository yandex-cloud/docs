# Attach a target group to a load balancer

> [!NOTE]

If a stopped VM instance is added to a target group, the load balancer will not start routing traffic to it after it is restarted. To start routing traffic to the running VM instance, you need to delete it from the group and add it again, or restart the load balancer.

---

**[!TAB Management console]**

To attach a [target group](../concepts/target-resources.md) to a load balancer:

1. Open the **Load Balancer** section in the folder where you want to attach the target group to the load balancer.
1. Click ![image](../../_assets/vertical-ellipsis.svg) in the row of that load balancer. If you already have a target group created, select it. If not, [create one](target-group-create.md).
1. Configure health check settings.
1. Click **Attach**

**[!TAB API]**

You can attach a target group to a load balancer using the [attachTargetGroup](../api-ref/NetworkLoadBalancer/attachTargetGroup.md) API method.

---

