# Rules for updating instance groups

Updating an instance group is performed to ensure minimum implications for the instances managed by the group.

In ascending order of risk, instance groups can perform the following actions:
* Updating an instance without stopping.
* Updating an instance with restart: stopping and then starting the instance.
* Re-creating an instance: deleting an instance and creating a new one.
* Deleting an instance.

You can also set the [minimum action](../policies/deploy-policy.md#minimal-action) to perform for updating an instance group.

{% note alert %}

When an instance is deleted, all its associated resources are deleted, such as the boot disk, secondary disks, and dynamic IP addresses.

{% endnote %}

## Implications of changing settings of instance groups {#change-gr}

Changes to the settings of instance groups may affect instances in this group in different ways.

### Changes that don't affect instances {#ch-gr-not-affect}

* Changing the instance group metadata (`name`, `description`, `labels`, `service_account_id`).

* Changing the group deployment policy (`deploy_policy`).

* Changing the specification of [health checks](../../../operations/instance-groups/enable-autohealing.md) (`health_checks_spec`).

* Changing of target group specifications for a [network load balancer](../../../../network-load-balancer/concepts/index.md) (`load_balancer_spec`) and [L7 load balancer](../../../../application-load-balancer/concepts/index.md) (`application_load_balancer_spec`), but not adding or deleting these specifications.

### Changes that cause the restart or re-creation of instances {#ch-gr-affect}


* Changing the group scaling policy (`scale_policy`).

   If the user changed the group size in the parameter or enabled automatic scaling that changed the group size, then old instances may be deleted or new instances may be created.

* Changing the allocation policy (`allocation_policy`).

   When you change the policy for allocation of instances between zones, instances may be permanently deleted. Instances may also be deleted from one zone and created in another zone, since it's impossible to move instances between zones.

* Changing of target group specifications for a network load balancer (`load_balancer_spec`) and L7 load balancer (`application_load_balancer_spec`).

## Changing the instance template {#change-temp}

In some cases, changing the instance template (`instance_template`) causes the instance to restart or be re-created.

### Changes that don't affect an instance {#ch-temp-not-restart}

* Changing the instance name, description, and labels (`name`, `description`, `labels`).
* Changing the service account of an instance (not instance group) (`service_account_id`).
* Changing the VM security groups (`network_interface_specs.security_group_ids`).

### Parameters whose update leads to instance restart {#ch-temp-with-restart}


* `platform_id`: Hardware platform.
* `resources_spec.{memory,cores,core_fraction,gpus}`: RAM, CPU, [guaranteed CPU %](../../performance-levels.md), [number of GPUs](../../gpus.md).
* `boot_disk_spec`: Boot disk.
* `metadata`: Instance metadata.
* Network interface parameters:

   * `network_interface_specs.network_id`: Network ID
   * `network_interface_specs.subnet_ids`: Subnet IDs
   * `network_interface_specs.primary_v4_address_spec`: Parameters of the public IPv4 address
   * `network_interface_specs.primary_v6_address_spec`: Parameters of the public IPv6 address


### Parameters whose update leads to instance recreation {#ch-temp-with-recreate}

* `network_interface_specs`: Only when adding or deleting network interfaces. Updating the parameters of the available interfaces does not lead to instance recreation.
* `secondary_disk_specs`: You cannot update secondary disks without recreating the instance. Disks are retained whenever possible.
* `scheduling_policy`: You cannot convert a regular instance to a preemptible instance or vice versa without recreating it.
