1. In the [management console]({{ link-console-main }}), select a folder to create your VM group in.
1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
1. In the left-hand panel, select ![image](../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.compute.instance-groups_hx3kX }}**.
1. Click **{{ ui-key.yacloud.compute.groups.button_create }}**.
1. Under **{{ ui-key.yacloud.compute.groups.create.section_base }}**:
   * Enter a name and description for your instance group. Follow these naming requirements:

     {% include [name-format](../name-format.md) %}

     {% include [name-fqdn](../compute/name-fqdn.md) %}

   * Select the [service account](../../iam/concepts/users/service-accounts.md) from the list or create a new one. To be able to create, update, and delete VMs in the group, assign the [compute.editor](../../compute/security/index.md#compute-editor) role to the service account. By default, all operations in {{ ig-name }} are performed on behalf of a service account.

     {% include [sa-dependence-brief](../../_includes/instance-groups/sa-dependence-brief.md) %}

   * Enable **{{ ui-key.yacloud.compute.groups.create.field_deletion-protection }}**, if required. You cannot delete a group while it is enabled.
1. Under **{{ ui-key.yacloud.compute.groups.create.section_allocation }}**, select the required zones in the **{{ ui-key.yacloud.compute.groups.create.field_zone }}** field. Instances from a single group may reside in [different availability zones](../../overview/concepts/geo-scope.md).
1. Under **{{ ui-key.yacloud.compute.groups.create.section_instance }}**, click **{{ ui-key.yacloud.compute.groups.create.button_instance_empty-create }}** to configure a basic instance:
   * Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**, enter a description for the [template](../../compute/concepts/instance-groups/instance-template.md).
   * Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, select the system to deploy on the VM instance boot [disk](../../compute/concepts/disk.md).

   * Under **{{ ui-key.yacloud.compute.instances.create.section_storages }}**:
     * Select the [disk type](../../compute/concepts/disk.md#disks_types).
     * Specify the disk size.
     * To add more disks, click **{{ ui-key.yacloud.compute.component.instance-storage-dialog.button_add-disk }}**.
   * Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**:
     * Select a [platform](../../compute/concepts/vm-platforms.md).
     * Enter the required number of vCPUs, [guaranteed vCPU share](../../compute/concepts/performance-levels.md), and the amount of RAM.

     * {% include [include](specify-preemptible-vm.md) %}
     
     * (Optional) Enable a [software-accelerated network](../../compute/concepts/software-accelerated-network.md).
   * Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

     {% include [network-settings-group](../../_includes/compute/network-settings-group.md) %}

   * Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, specify the VM access credentials:
     * Select the service account to link to the VM instance.
     * If you selected a Linux [image](../../compute/concepts/image.md), fill out the **{{ ui-key.yacloud.compute.instances.create.field_user }}** and **{{ ui-key.yacloud.compute.instances.create.field_key }}** fields. Provide the contents of the [public key](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) file as the key value.
     * Enable `{{ ui-key.yacloud.compute.instance.overview.field_serial-port-enable }}`, if required.
   * Click **{{ ui-key.yacloud.compute.groups.create.button_edit }}**.
1. Under **{{ ui-key.yacloud.compute.groups.create.section_deploy }}**:
   * In the **{{ ui-key.yacloud.compute.groups.create.field_deploy-max-expansion }}** field, specify the maximum number of instances the group size can be scaled up by.

       {% include [max-expansion-notice](./max-expansion-notice.md) %}
   * In the field **{{ ui-key.yacloud.compute.groups.create.field_deploy-max-unavailable }}**, specify the maximum number of instances the group size can be scaled down by.
   * In the **{{ ui-key.yacloud.compute.groups.create.field_deploy-max-creating }}** field, specify how many instances can be created at the same time.
   * In **{{ ui-key.yacloud.compute.groups.create.field_deploy-startup-duration }}**, specify the period after which the instance will start receiving traffic.
   * In the **{{ ui-key.yacloud.compute.groups.create.field_deploy-max-deleting }}** field, specify how many instances can be stopped at the same time.
   * In the **{{ ui-key.yacloud.compute.groups.create.field_deploy-strategy }}** field, specify one of these [strategies](../../compute/concepts/instance-groups/policies/deploy-policy.md#strategy):
     * `{{ ui-key.yacloud.compute.groups.create.value_strategy-proactive }}`: {{ ig-name }} automatically selects which instances to stop when updating or scaling down the group.
     * `{{ ui-key.yacloud.compute.groups.create.value_strategy-opportunistic }}`: {{ ig-name }} waits for the instances to stop on their own or for the user to stop them.
1. Under **{{ ui-key.yacloud.compute.groups.create.section_scale }}**:
   * Select the `{{ ui-key.yacloud.compute.groups.create.value_scale-fixed }}` [scaling type](../../compute/concepts/instance-groups/scale.md).
   * Specify the instance group size.
1. Optionally, enable **{{ ui-key.yacloud.compute.groups.create.section_health-check }}** to get information about the state of instances and automatically recover them in case of failure.
   * In the **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-protocol }}** field, select the protocol for health checks: `{{ ui-key.yacloud.common.label_http }}` or `{{ ui-key.yacloud.common.label_tcp }}`.
   * In the **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-path }}** field (for the HTTP type), specify the URL path {{ ig-name }} will use to send HTTP check requests.
   * In the **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-port }}** field, specify the port number (between 1 and 32767) for {{ ig-name }} to send health check requests to.
   * In the **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-timeout }}** field, specify a response timeout of 1 to 60 seconds.
   * In the **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-interval }}** field, specify a health check interval of 1 to 60 seconds. The interval must be at least 1 second longer than the response timeout.
   * In the **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-healthy-threshold }}** field, specify the number of successful health checks required to consider the instance healthy.
   * In the **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-unhealthy-threshold }}** field, specify the number of failed health checks required to consider the instance unhealthy.
1. Under **{{ ui-key.yacloud.compute.groups.create.section_variables }}**, enter the `{{ ui-key.yacloud.common.label_key }}`-`{{ ui-key.yacloud.common.value }}` pairs, if required.
1. Click **{{ ui-key.yacloud.common.create }}**.
