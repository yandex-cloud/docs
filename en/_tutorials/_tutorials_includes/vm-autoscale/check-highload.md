To test autoscaling for your instance group, increase the CPU utilization of each instance. In the `specification.yaml` file, the `scale_policy.auto_scale.cpu_utilization_rule.utilization_target` parameter is set to `40`: it means that the target utilization level is 40% CPU. If you exceed the target utilization, the number of VMs in the group will increase.
1. Increase the utilization for the instance group.

   To do this, save the script named `load.sh` to the home directory. The script sends requests to the instance group through 12 threads for 10 minutes. Each VM instance utilizes 20% CPU on each core that processes the request. The instance group utilization is 240% CPU at any given time. To be sure that requests are evenly distributed across the instances in the group, the script executes multiple parallel requests utilizing 20% CPU rather than one request utilizing 240% CPU.

   ```bash
   EXTERNAL_IP=$(yc load-balancer network-load-balancer get group-balancer --format=json | jq -r .listeners[0].address)

   wrk -H "Connection: close" -t12 -c12 -d10m "http://$EXTERNAL_IP/burn-cpu?time=5000&load=20"
   ```

1. Run the script:

   {% list tabs group=instructions %}

   - CLI {#cli}

     ```bash
     sh load.sh
     ```

     Result:

     ```text
     Running 10m test @ http://130.193.56.111/burn-cpu?time=5000&load=20
       12 threads and 12 connections
       Thread Stats   Avg      Stdev     Max   +/- Stdev
     ...
     Requests/sec: 15.04
     Transfer/sec: 3.20KB
     ```

   {% endlist %}

1. View the utilization levels:

   {% list tabs group=instructions %}

   - Management console {#console}

     1. In the [management console]({{ link-console-main }}), select the folder where you created the `auto-group` instance group.
     1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
     1. In the left-hand panel, click ![image](../../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.compute.instance-groups_hx3kX }}**.
     1. Select `auto-group`.
     1. Navigate to the **{{ ui-key.yacloud.common.monitoring }}** tab.
        The chart **Number of instances in zone** shows how the number of instances changed in each availability zone. The chart **Average CPU utilization in zone** shows average CPU utilization in each availability zone.
     1. Navigate to the **{{ ui-key.yacloud.common.logs }}** tab.
        The page displays messages relating to the instance group autoscaling.

     The total utilization of 240% CPU was evenly distributed between two instances in two availability zones and exceeded the target utilization of 40% CPU. [{{ compute-full-name }}](../../../compute/) created one instance more in each availability zone to result in four instances in the group. When the script stopped utilizing the CPU, {{ compute-name }} automatically decreased the number of instances in the group to two.

   {% endlist %}