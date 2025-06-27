1. Create a load on an instance.

   To do this, save the script named `request.sh` to the home directory. The script will send a request to one of the VMs through the `group-balancer` load balancer. The request will utilize 100% CPU for 30 seconds.

   ```bash
   EXTERNAL_IP=$(yc load-balancer network-load-balancer get group-balancer --format=json | jq -r .listeners[0].address)

   curl "http://$EXTERNAL_IP/burn-cpu?time=30000&load=100"
   ```

1. Run the script:

   {% list tabs group=instructions %}

   - CLI {#cli}

     ```bash
     sh request.sh
     ```

     Result:

     ```text
     projects/b0g12ga82bcv********/zones/{{ region-id }}-b
     ```

   {% endlist %}

1. View the instance utilization:

   {% list tabs group=instructions %}

   - Management console {#console}

     1. In the [management console]({{ link-console-main }}), select the folder where you created the instance group.
     1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
     1. In the left-hand panel, click ![image](../../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.compute.instance-groups_hx3kX }}**.
     1. Select `auto-group`.
     1. Navigate to the **{{ ui-key.yacloud.common.monitoring }}** tab.

        The load balancer sent the request to an instance in the group. In the availability zone this instance belongs to, the average CPU utilization is higher than in other zones (see the **Average CPU utilization in zone** chart).

   {% endlist %}