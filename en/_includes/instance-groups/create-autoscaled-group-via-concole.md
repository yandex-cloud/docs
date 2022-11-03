1. In the [management console]({{ link-console-main }}), select the folder where you want to create an instance group.
1. Select **{{compute-name}}**.
1. On the left-hand panel, select ![image](../../_assets/compute/vm-group-pic.svg) **Instance groups**.
1. Click **Create group**.
1. Under **Basic parameters**:
   * Enter the **Name** and **Description** of the instance group. Naming requirements:

      {% include [name-format](../name-format.md) %}

      {% include [name-fqdn](../compute/name-fqdn.md) %}

   * Select a [service account](../../iam/concepts/users/service-accounts.md) from the list or create a new one. To be able to create, update, and delete group instances, assign the `editor` role to the service account. All operations in {{ ig-name }} are performed on behalf of the service account.
   * Enable **Deletion protection** if needed. You can't delete a group with this option enabled.
1. In the **Allocation** section, select the desired **availability zones**. Instances of a group may reside in [different availability zones and regions](../../overview/concepts/geo-scope.md).
1. Under **Instance template**, click **Define** to set up the configuration for a basic instance:
   * Under **Basic parameters**, enter the template **Description**:
   * Under **Image/boot disk selection**, select a system to be deployed on the VM instance's boot disk.


   * In the **Disks** section:
      * Select the [disk type](../../compute/concepts/disk.md#disks_types).
      * Specify the **Size** of the disk.
      * To add more disks, click **Add disk**.
   * Under **Computing resources**:
      * Choose a [platform](../../compute/concepts/vm-platforms.md).
      * Enter the required number of **vCPUs**, [guaranteed vCPU performance](../../compute/concepts/performance-levels.md), and the amount of **RAM**.
      * {% include [include](specify-preemptible-vm.md) %}
   * Under **Network settings**:
      * Select a [cloud network](../../vpc/concepts/network.md#network) from the list or enter a cloud network ID. If you don't have a network, click **Create a new network** to create one:
         * In the window that opens, enter a name for the new network and choose the **Subnet in the zone** to connect the instance to. Each network should have a minimum of one [subnet](../../vpc/concepts/network.md#subnet) (if there are no subnets, [create one](../../vpc/operations/subnet-create.md)).
      * In the **Public IP** field, choose a method for assigning an IP address:
         * **Auto**: Assign a random IP address from the {{ yandex-cloud }} IP pool.
         * **No address**: Don't assign a public IP address.
      * Select [appropriate security groups](../../vpc/concepts/security-groups.md) (if there is no corresponding field, the virtual machine will be enabled for all incoming and outgoing traffic).
      * (optional) Create a record for the VM in the [DNS zone](../../dns/concepts/dns-zone.md). Expand the **DNS settings for internal addresses** section and specify the zone, FQDN, and TTL for the record. For more information, see [Cloud DNS integration with Compute Cloud](../../dns/concepts/compute-integration.md).
   * Under **Access**, specify the information required to access the instance:
      * Specify a **Service account** to be linked to the instance.
      * If you selected a Linux image, fill out **Login** and **SSH key**. As the key, use the [public key](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) file contents.
      * If you selected a Windows image, enter the **Password** for your `Administrator` user.
      * If needed, **Grant access to the serial console**.
   * Click **Save**.
1. Under **Allow when creating and updating**:
   * In the **Add above target value** field, specify the number of instances you can exceed the group size by.
   * In the field **Reduce below target value**, specify the number of instances you can decrease the group size by.
   * In the **Create simultaneously** field, specify how many instances can be created at the same time.
   * In **Start time**, specify the period after which the VM instance will start receiving the load.
   * In the **Stop simultaneously** field, specify how many instances can be stopped at the same time.
   * In the **Stop VMs by strategy** field, specify one of the [strategies](../../compute/concepts/instance-groups/policies/deploy-policy.md#strategy):
      * **Proactive**: {{ ig-name }} selects which instances to stop when updating or reducing the group on its own.
      * **Opportunistic**: {{ ig-name }} waits for the instances to stop on their own or by the user.
1. In the **Scalability** section:
   * Select **Automatic** as your [scaling type](../../compute/concepts/instance-groups/scale.md).
   * Indicate the following:
      * **Autoscaling type**: **Zonal** autoscaling adjusts the number of VMs separately for each availability zone specified in the group settings. **Regional** autoscaling is applied to the entire instance group.
      * **The minimum number of instances per zone**.
      * **Maximum group size**.
      * **Utilization measurement period** to average the utilization measurements for each instance in the group.
      * **Instance warmup period**: Time needed for an instance added to the group to warm up.
      * **Stabilization period**: The interval during which the recommended number of instances in the group can't be decreased.
      * **Initial size of the instance group**.
1. Under **Metrics**, enter:
   * **Metrics** type:
      * [CPU](../../compute/concepts/instance-groups/scale.md#cpu-utilization): Specify the average CPU utilization level that {{ ig-name }} must support.
      * [Custom](../../compute/concepts/instance-groups/scale.md#custom-metrics): Specify the name of the custom metric and the target value that {{ ig-name }} must support.
1. If needed, enable the **Health check** to get information about the state of instances and their automatic recovery on failure.
   * In the **Type** field, select the protocol for the health checks: **HTTP** or **TCP**.
   * In the **Path** field (for the HTTP type), specify the URL path for the HTTP check requests sent from {{ ig-name }}.
   * In the **Port** field, specify the port number from 1 to 32767 for {{ ig-name }} to send the health check requests to.
   * In the **Waiting time, s** field, specify the response wait time from 1 to 60 seconds.
   * In the **Interval in sec** field, specify the interval between the repeat checks from 1 to 60 seconds. The interval must be at least 1 second longer than the timeout.
   * In the **Performance threshold** field, specify the number of successful health checks required for the instance to be considered healthy.
   * In the **Failure threshold** field, specify the number of failed health checks for the instance to be considered unhealthy.
1. Under **Custom variables**, enter the **Key**-**Value** pairs if needed.
1. Click **Create**.