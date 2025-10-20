# Migrating services from an NLB with an instance group as a target to an L7 ALB using the management console


To migrate a service from a network load balancer to an L7 load balancer:

1. [See the service migration recommendations](#recommendations).
1. [Create a migration infrastructure](#before-you-begin).
1. [Create a {{ sws-full-name }} profile](#create-profile-sws).
1. [Create an L7 load balancer](#create-alb). At this step, you will associate the {{ sws-name }} profile with a virtual host of the L7 load balancer.
1. [Test the L7 load balancer](#test).
1. [Migrate user traffic from the network load balancer to the L7 load balancer](#migration-nlb-to-alb).

## Service migration recommendations {#recommendations}

{% include [group-vm-recommendations](../_tutorials_includes/migration-from-nlb-to-alb/group-vm-recommendations.md) %}

## Create your infrastructure {#before-you-begin}

1. [Create subnets](../../vpc/operations/subnet-create.md) in three availability zones for the L7 load balancer.

1. Create [security groups](../../application-load-balancer/concepts/application-load-balancer.md#security-groups) that allow the L7 load balancer to receive inbound traffic and send it to the targets and allow the targets to receive inbound traffic from the load balancer.

1. When using HTTPS, [add the TLS certificate](../../certificate-manager/operations/import/cert-create.md#create-certificate) of your service to [{{ certificate-manager-full-name }}](../../certificate-manager/).

1. Optionally, [reserve an L3-L4 DDoS-protected static public IP address](../../vpc/operations/get-static-ip.md) for the L7 load balancer.

## Create a {{ sws-name }} profile {#create-profile-sws}

{% include [create-profile-sws](../_tutorials_includes/migration-from-nlb-to-alb/create-profile-sws.md) %}

## Create an L7 load balancer {#create-alb}

1. [Create a target group](../../application-load-balancer/operations/target-group-create.md) for the L7 load balancer. Under **{{ ui-key.yacloud.alb.label_targets }}**, select the VMs in your network load balancer's target group.

1. [Create a backend group](../../application-load-balancer/operations/backend-group-create.md) with the following settings:

    1. Select `{{ ui-key.yacloud.alb.label_proto-http }}` as the backend group type.
    1. If your service needs one and the same backend resource processing requests within a single user session, enable [session affinity](../../application-load-balancer/concepts/backend-group.md#session-affinity) for the backend group.
    1. Under **{{ ui-key.yacloud.alb.label_backends }}**, click **{{ ui-key.yacloud.common.add }}** and set up the backend:

        * **{{ ui-key.yacloud.common.type }}**: `{{ ui-key.yacloud.alb.label_target-group }}`.
        * **{{ ui-key.yacloud.alb.label_target-groups }}**: Target group you created earlier.
        * **{{ ui-key.yacloud.alb.label_port }}**: TCP port on which your service's VMs accept inbound traffic.
        * Under **{{ ui-key.yacloud.alb.label_protocol-settings }}**, specify the settings for connecting the L7 load balancer to the backend. Depending on the protocol type on your backend, select `{{ ui-key.yacloud.alb.label_proto-http-plain }}` or `{{ ui-key.yacloud.alb.label_proto-http-tls }}`.
        * Under **HTTP health check**, set the check up according to these [recommended practices](../../application-load-balancer/concepts/best-practices.md#health-checks-recommendations).
        * Optionally, configure other settings as per [this guide](../../application-load-balancer/operations/backend-group-create.md).

1. [Create an HTTP router](../../application-load-balancer/operations/http-router-create.md).

    Under **{{ ui-key.yacloud.alb.label_virtual-hosts }}**, click **{{ ui-key.yacloud.alb.button_virtual-host-add }}** and configure the virtual host:

    * **{{ ui-key.yacloud.alb.label_authority }}**: Your service domain name.
    * **{{ ui-key.yacloud.alb.label_security-profile-id }}**: {{ sws-name }} profile you created earlier.

        {% note warning %}

        {{ sws-name }} cannot be made operational without linking a security profile to the L7 load balancer's virtual host.

        {% endnote %}

    * Click **{{ ui-key.yacloud.alb.button_add-route }}** and configure the route:

        * **{{ ui-key.yacloud.alb.label_path }}**: `Starts with` `/`.
        * **{{ ui-key.yacloud.alb.label_route-action }}**: `{{ ui-key.yacloud.alb.label_route-action-route }}`.
        * **{{ ui-key.yacloud.alb.label_backend-group }}**: Backend group you created earlier.

1. [Create an L7 load balancer](../../application-load-balancer/operations/application-load-balancer-create.md) by selecting **{{ ui-key.yacloud.alb.label_alb-create-form }}**:

    1. Specify the security group you created earlier.
    1. Under **{{ ui-key.yacloud.alb.section_allocation-settings }}**, select subnets in three availability zones for the load balancer nodes. Enable traffic in these subnets.
    1. Under **{{ ui-key.yacloud.alb.section_autoscale-settings }}**, specify the [minimum number of resource units](../../application-load-balancer/concepts/application-load-balancer.md#lcu-scaling-settings) per availability zone based on expected load.
    1. Under **{{ ui-key.yacloud.alb.label_listeners }}**, click **{{ ui-key.yacloud.alb.button_add-listener }}** and set up the listener:

        1. Under **{{ ui-key.yacloud.alb.section_external-address-specs }}**, specify:

            * **{{ ui-key.yacloud.alb.label_port }}**: TCP port on which your service's VMs accept inbound traffic.
            * **{{ ui-key.yacloud.common.type }}**: `{{ ui-key.yacloud.alb.label_address-list }}`. Select a public IP address from the list. If you plan to enable DDoS protection at levels L3-L4, select a static public IP address with DDoS protection installed.
        1. Under **{{ ui-key.yacloud.alb.section_common-address-specs }}**, specify:

            * **{{ ui-key.yacloud.alb.label_listener-type }}**: `{{ ui-key.yacloud.alb.label_listener-type-http }}`.
            * **{{ ui-key.yacloud.alb.label_protocol-type }}**: Select `{{ ui-key.yacloud.alb.label_proto-http-plain }}` or `{{ ui-key.yacloud.alb.label_proto-http-tls }}` depending on the protocol your service uses.
            * If you select `{{ ui-key.yacloud.alb.label_proto-http-tls }}`, specify the TLS certificate you added to {{ certificate-manager-name }} earlier in the **{{ ui-key.yacloud.alb.label_certificate }}** field.
            * **{{ ui-key.yacloud.alb.label_http-router }}**: Select the HTTP router you created earlier.

## Test the L7 load balancer {#test}

1. Wait until the L7 load balancer goes `Active`.

1. Navigate to the new L7 load balancer and select **{{ ui-key.yacloud.alb.label_healthchecks }}** on the left. Make sure you get `HEALTHY` for all checks.

1. {% include [test](../_tutorials_includes/migration-from-nlb-to-alb/test.md) %}

## Migrate user traffic from the network load balancer to the L7 load balancer {#migration-nlb-to-alb}

{% note warning %}

Migration involves recreating the backend VMs.

{% endnote %}

If the network load balancer’s listener uses a public IP address without DDoS protection, save the current [health check](../../network-load-balancer/concepts/health-check.md) settings for the network load balancer’s target group before proceeding to the next step of the migration. You will need these settings to add a new target group to the load balancer.

To migrate traffic:

1. Update the target group integration for the instance group:

    1. In the [management console]({{ link-console-main }}), select the folder containing your instance group.
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
    1. In the left-hand panel, select ![image](../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.compute.instance-groups_hx3kX }}**.
    1. Select the group to update.
    1. In the top-right corner of the page, click **{{ ui-key.yacloud.common.edit }}**.
    1. Under **{{ ui-key.yacloud.compute.groups.create.section_alb }}**, enable **{{ ui-key.yacloud.compute.groups.create.field_target-group-attached }}**.
    1. Specify the name of the L7 load balancer’s target group and, optionally, the other [target group settings](../../compute/concepts/instance-groups/balancers.md#settings-alb).
    1. Click **{{ ui-key.yacloud.compute.groups.create.button_edit }}**.

    Updating an instance group involves the following stages:

    * The system [recreates the instances in the group](../../compute/concepts/instance-groups/deploy/instance.md#ch-gr-affect).
    * The system removes targets from the network load balancer’s target group, and the remaining targets take over user traffic. The service becomes partially unavailable to users through the network load balancer during this period.
    * Once the target group is empty, it is deleted. The service becomes unavailable through the network load balancer.

    You can proceed to the next step without waiting for the instance group update to complete.

1. [Update](../../application-load-balancer/operations/backend-group-update.md#update-backend) the target group for the backend in the L7 load balancer’s backend group. Specify only the target group you created in the previous step.

    The system will automatically add the VMs from the instance group to the L7 load balancer’s target group.

1. Select one of the following options to further migrate user traffic from the network load balancer to the L7 load balancer based on whether your NLB listener's public IP address is DDoS-protected:

    * If [using a DDoS-protected IP address](#ip-with-ddos-protection), during migration, your service will retain its public IP address.
    * If [using an IP address without DDoS protection](#ip-without-ddos-protection), during migration, your service will get a new public IP address.

### Your network load balancer listener uses a DDoS-protected public IP address {#ip-with-ddos-protection}

1. Monitor the [status](../../network-load-balancer/operations/check-resource-health.md) of your network load balancer’s targets. Wait until the targets are automatically deleted from the target group.

1. [Delete the listener](../../network-load-balancer/operations/listener-remove.md) in the network load balancer to release the static public IP address.

1. In the L7 load balancer, assign to the listener the public IP address previously used by the network load balancer:

    {% list tabs group=instructions %}

    * CLI {#cli}

        {% include [include](../../_includes/cli-install.md) %}

        {% include [default-catalogue](../../_includes/default-catalogue.md) %}

        To change the public IP address, run this command:

        ```bash
        yc application-load-balancer load-balancer update-listener <load_balancer_name> \
           --listener-name <listener_name> \
           --external-ipv4-endpoint address=<service_public_IP_address>,port=<service_port>
        ```

        Where `address` is the public IP address the network load balancer used previously.

    {% endlist %}

1. After the IP address changes, your service will again be available through the L7 load balancer. Monitor the L7 load balancer's user traffic on the [load balancer statistics](../../application-load-balancer/operations/application-load-balancer-get-stats.md) charts.

1. Delete the now free static public IP address you selected when creating the L7 load balancer.

1. Optionally, [delete the network load balancer](../../network-load-balancer/operations/load-balancer-delete.md) after migrating user traffic to the L7 load balancer.

### Your network load balancer listener uses a public IP address without DDoS protection {#ip-without-ddos-protection}

{% include [group-vm-not-save-public-ip](../_tutorials_includes/migration-from-nlb-to-alb/group-vm-not-save-public-ip.md) %}
