# Running an autoscaling instance group


In this tutorial, you will deploy an [instance group](../../compute/concepts/instance-groups/scale.md#auto-scale) with an autoscaling policy applied to manage extra load. You will place VMs in two [availability zones](../../overview/concepts/geo-scope.md) and set up a [{{ network-load-balancer-full-name }}](../../network-load-balancer/) to distribute load between them.

To configure an autoscaling instance group, you can use the following tools: