# Running an autoscaling instance group


In this tutorial, you will set up an [instance group](../../compute/concepts/instance-groups/scale.md#auto-scale) with an autoscaling policy applied to manage extra load. We will place VMs in two [availability zones](../../overview/concepts/geo-scope.md) and set up [{{ network-load-balancer-full-name }}](../../network-load-balancer/) to distribute load between them.

To configure an autoscaling instance group, you can use the following tools: