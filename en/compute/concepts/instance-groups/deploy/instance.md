# Rules for updating instance groups

Updating an instance group is performed to ensure minimum implications for the instances managed by the group.

In ascending order of risk, instance groups can perform the following actions:
* Updating an instance without stopping.
* Updating an instance with restart: stopping and then starting the instance.
* Re-creating an instance: deleting an instance and creating a new one.
* Deleting an instance.

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

### Parameters whose change leads to instance restart {#ch-temp-with-restart}

* `platform_id`: The hardware platform.
* `resources_spec.{memory,cores,core_fraction,gpus}`: RAM, CPU, [guaranteed CPU %](../../performance-levels.md), [number of GPUs](../../gpus.md).
* `boot_disk_spec`: Boot disk.
* `metadata`: Instance metadata.

### Parameters whose change leads to instance re-creation {#ch-temp-with-recreate}

* `network_interface_specs`: You can't update network interfaces without re-creating the instance.
* `secondary_disk_specs`: You can't update secondary disks without re-creating the instance. Disks are retained whenever possible.
* `scheduling_policy`: You can't convert a regular instance into a preemptible instance or vice versa without re-creating the instance.
