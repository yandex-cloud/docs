---
title: Creating a {{ dataproc-full-name }} cluster
description: Follow this guide to create and set up a {{ dataproc-name }} cluster and see a real example of one.
---

# Creating a {{ dataproc-name }} cluster

## Roles for creating a cluster {#roles}

To create a {{ dataproc-name }} cluster, your {{ yandex-cloud }} account needs the following roles:

* [dataproc.editor](../security/index.md#dataproc-editor): To create a cluster.
* [{{ roles-vpc-user }}](../../vpc/security/index.md#vpc-user): To use the cluster [network](../../vpc/concepts/network.md#network).
* [iam.serviceAccounts.user](../../iam/security/index.md#iam-serviceAccounts-user): To assign a [service account](../../iam/concepts/users/service-accounts.md) to the cluster and use it to create resources.

Make sure to assign the following roles to the {{ dataproc-name }} cluster’s service account:

{% include [sa-roles](../../_includes/data-processing/sa-roles.md) %}

For more information about assigning roles, see [this {{ iam-full-name }} guide](../../iam/operations/roles/grant.md).


## Configure your network {#setup-network}

Configure internet access from the [subnet](../../vpc/concepts/network.md#subnet) to which the {{ dataproc-name }} [subcluster](../concepts/index.md#resources) with a master host will be connected, e.g., using a [NAT gateway](../../vpc/operations/create-nat-gateway.md). This will enable the {{ dataproc-name }} subcluster to work with {{ yandex-cloud }} services or hosts in other networks.

## Configure security groups {#change-security-groups}

{% note warning %}

Before creating a {{ dataproc-name }} cluster, you need to create and configure [security groups](../../vpc/concepts/security-groups.md). If the selected security groups lack the required rules, {{ yandex-cloud }} will prevent creating the {{ dataproc-name }} cluster.

{% endnote %}

1. [Create](../../vpc/operations/security-group-create.md) one or more security groups for the {{ dataproc-name }} cluster service traffic.
1. [Add these rules](../../vpc/operations/security-group-add-rule.md):
   * One inbound and one outbound rule for service traffic:
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-any }}`
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}`
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**/**{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}`
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-self }}`
   * A separate rule for outbound HTTPS traffic. This will allow using [{{ objstorage-full-name }}](../../storage/) [buckets](../../storage/concepts/bucket.md), [UI Proxy](../concepts/interfaces.md), and [autoscaling](../concepts/autoscaling.md) of {{ dataproc-name }} clusters.

     You can set up this rule using one of the two methods:

     {% list tabs %}

     - To all addresses

       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-https }}`.
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`.
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`.

     - To addresses used by {{ yandex-cloud }}

       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-https }}`
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**:
         * `84.201.181.26/32`: Getting the {{ dataproc-name }} cluster status, running jobs.
         * `158.160.167.170/32`: UI Proxy.
         * `158.160.59.216/32`: Monitoring the {{ dataproc-name }} cluster health, autoscaling.
         * `213.180.193.243/32`: Access to {{ objstorage-name }}.
         * `84.201.181.184/32`: {{ cloud-logging-name }} address.

     {% endlist %}

   * Rule to allow NTP server access for time sync:
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `123`.
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_udp }}`.
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`.

If you intend to use multiple security groups for your {{ dataproc-name }} cluster, allow all traffic between them.

{% note info %}

You can specify more granular security group rules, such as allowing traffic only in specific subnets.

Make sure to properly configure security groups for all subnets where the {{ dataproc-name }} cluster hosts will reside.

{% endnote %}

You can configure security groups after creating a {{ dataproc-name }} cluster to [connect to {{ metastore-name }}](../../metadata-hub/operations/metastore/data-processing-connect.md) or [{{ dataproc-name }} cluster hosts](connect.md) via the internet or an intermediate [VM](../../compute/concepts/vm.md).


## Create a {{ dataproc-name }} cluster {#create}

A {{ dataproc-name }} cluster must include a subcluster with a master host and at least one subcluster for data storage or processing.

If you want to create a {{ dataproc-name }} cluster copy, [import its configuration](#duplicate) to {{ TF }}.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create a {{ dataproc-name }} cluster.
  1. Click **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** and select ![image](../../_assets/data-processing/data-processing.svg) **{{ ui-key.yacloud.iam.folder.dashboard.value_data-proc }}** from the drop-down list.
  1. Enter a name for the {{ dataproc-name }} cluster. Optionally, add a cluster description.

     Follow these naming requirements:

     * The name must be unique within the folder.

     {% include [name-format.md](../../_includes/name-format.md) %}

  1. Select the [environment](../concepts/environment.md#environment) where you want to create your cluster (you cannot change the environment once the cluster is created):
     * `PRODUCTION`: For stable versions of your applications.
     * `PRESTABLE`: For testing purposes. The prestable environment is similar to the production environment and likewise covered by an SLA, but it is the first to get new features, improvements, and bug fixes. In the prestable environment, you can test new versions for compatibility with your application.
  1. Add or delete cluster [labels](../../resource-manager/concepts/labels.md). You can use them to organize resources into logical groups.
  1. Specify the following cluster settings:

     * [Image version](../concepts/environment.md) and services you want to use in the {{ dataproc-name }} cluster.

        {% include [note-light-weight-cluster](../../_includes/data-processing/note-light-weight-cluster.md) %}

        {% note tip %}

        To use the most recent image version, specify `2.1`.

        {% endnote %}

     * Method of connecting to a {{ dataproc-name }} cluster:

        * **{{ ui-key.yacloud.mdb.forms.config_field_public-keys }}**: Using SSH keys.
        * **{{ ui-key.yacloud.mdb.forms.config_field_os-login }}**: Using [{{ oslogin }}](../../organization/concepts/os-login.md).

       If you selected access via a SSH key, specify its public part in the **{{ ui-key.yacloud.mdb.forms.config_field_public-keys }}** field. For information on how to generate and use SSH keys, see [this {{ compute-full-name }} guide](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
     * Service account that needs access to the {{ dataproc-name }} cluster.
     * Availability zone for the {{ dataproc-name }} cluster.
     * Optionally, [cluster component properties](../concepts/settings-list.md).
     * Optionally, custom [initialization scripts](../concepts/init-action.md) for cluster hosts. For each script, specify the following information:

        * URI to the initialization script in the `https://`, `http://`, `hdfs://`, or `s3a://` scheme.
        * Optionally, script timeout in seconds. If your initialization script runs longer than the specified time period, it will be terminated.
        * Optionally, arguments enclosed in square brackets and separated by commas. The initialization script will use these arguments. Here is an example of arguments:

          ```text
          ["arg1","arg2",...,"argN"]
          ```

     * Format for specifying the [{{ objstorage-full-name }}](../../storage/concepts/bucket.md) bucket name, **{{ ui-key.yacloud.forms.label_form-list }}** or **{{ ui-key.yacloud.forms.label_form-id }}**.
     * Bucket the cluster will use.

        Depending on the format you selected, either pick a name from the list or specify it manually. You can get it with the [list of buckets in the folder](../../storage/operations/buckets/get-info.md#get-information).

        The {{ dataproc-name }} cluster’s [service account](../../iam/concepts/users/service-accounts.md) must have `READ and WRITE` permissions for this bucket.

     * Format for specifying a network for the {{ dataproc-name }} cluster.
     * Network for the cluster.
     * Security groups with the required permissions.

        {% note warning %}

        When you create a {{ dataproc-name }} cluster, security group settings are verified. If the {{ dataproc-name }} cluster cannot work properly with these settings, you will get a warning. You can find an example of working settings [above](#change-security-groups).

        {% endnote %}

     * [UI Proxy](./connect-interfaces.md#ui-proxy). Enabling the **{{ ui-key.yacloud.mdb.forms.config_field_ui_proxy }}** option will make available the [web interfaces](../concepts/interfaces.md) of the {{ dataproc-name }} components.
     * {{ cloud-logging-full-name }} [log group](../../logging/concepts/log-group.md) the cluster will send logs to.

        To save logs in a log group, [assign](../../iam/operations/sa/assign-role-for-sa.md) the `logging.writer` [role](../../logging/security/index.md#logging-writer) to the cluster service account.

  1. Configure {{ dataproc-name }} subclusters. The following types are available:

     * Subcluster with a master host, designated as `{{ ui-key.yacloud.mdb.forms.label_master-subcluster }}`. There can only be one such subcluster.
     * Data storage subclusters, designated as `{{ ui-key.yacloud.mdb.forms.label_data-subcluster }}`. These are used to deploy storage components.
     * Data processing subclusters, designated as `{{ ui-key.yacloud.mdb.forms.label_compute-subcluster }}`. These are used to deploy computing components. [Storage](../concepts/storage.md) of such a subcluster is intended only for temporarily storing files being processed.

     For each {{ dataproc-name }} subcluster, specify:

     * Subcluster name.
     * Number of hosts (with only one master host allowed).
     * [Host class](../concepts/instance-types.md), which defines the platform and computing resources available to the host.
     * Storage size and type.
     * Subnet.

        In the subnet, you need to set up a NAT gateway for the {{ dataproc-name }} subcluster with a master host. For more information, see [Configure your network](#setup-network).

     * Access to {{ dataproc-name }} subcluster hosts from the internet. To enable access, select **{{ ui-key.yacloud.mdb.forms.field_assign-public-ip }}**. In this case, you can only connect to {{ dataproc-name }} subcluster hosts over SSL. For more information, see [{#T}](connect.md).

       {% note warning %}

       After you create a {{ dataproc-name }} cluster, you cannot request or disable public access to a subcluster. However, you can delete the {{ dataproc-name }} subcluster for data processing and recreate it with the public access settings you need.

       {% endnote %}

  1. Optionally, set up [autoscaling](../concepts/autoscaling.md) for data processing subclusters:

     1. In the `{{ ui-key.yacloud.mdb.forms.label_compute-subcluster }}` type subcluster settings, enable **{{ ui-key.yacloud.mdb.forms.label_autoscaling-activated }}**.
     1. Configure the autoscaling settings.
     1. The default metric used for autoscaling is `yarn.cluster.containersPending`. To enable CPU-based scaling, disable **{{ ui-key.yacloud.compute.groups.create.field_default-utilization-target }}** and specify the target CPU utilization.
     1. Click **{{ ui-key.yacloud.mdb.forms.button_add-subcluster }}**.

  1. Optionally, add and configure additional subclusters for data storage or processing.
  1. Optionally, enable accidental cluster deletion protection in the additional settings.

     Even with cluster deletion protection enabled, you can still connect to the {{ dataproc-name }} cluster manually and delete the data.

  1. Click **{{ ui-key.yacloud.mdb.forms.button_create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a {{ dataproc-name }} cluster:

  
  1. Check whether your [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) has any subnets for the {{ dataproc-name }} cluster hosts:

     ```bash
     yc vpc subnet list
     ```

     If your folder has no subnets, [create them](../../vpc/operations/subnet-create.md) in [{{ vpc-full-name }}](../../vpc/).


  1. See the description of the [CLI](../../cli/) command for creating a {{ dataproc-name }} cluster:

     ```bash
     {{ yc-dp }} cluster create --help
     ```

  1. Specify the {{ dataproc-name }} cluster properties in this command (the example does not show all that are available):

     ```bash
     {{ yc-dp }} cluster create <cluster_name> \
       --environment=<environment> \
       --bucket=<bucket_name> \
       --zone=<availability_zone> \
       --service-account-name=<service_account_name> \
       --autoscaling-service-account-name=<name_of_service_account_of_autoscaling_subclusters> \
       --version=<image_version> \
       --services=<list_of_components> \
       --ssh-public-keys-file=<path_to_public_SSH_key> \
       --subcluster name=<name_of_subcluster_with_master_host>,`
                    `role=masternode,`
                    `resource-preset=<host_class>,`
                    `disk-type=<storage_type>,`
                    `disk-size=<storage_size_in_GB>,`
                    `subnet-name=<subnet_name>,`
                    `assign-public-ip=<public_access_to_subcluster_host> \
       --subcluster name=<name_of_subcluster_for_storing_data>,`
                    `role=datanode,`
                    `resource-preset=<host_class>,`
                    `disk-type=<storage_type>,`
                    `disk-size=<storage_size_in_GB>,`
                    `subnet-name=<subnet_name>,`
                    `hosts-count=<number_of_hosts>,`
                    `assign-public-ip=<public_access_to_subcluster_host> \
       --deletion-protection \
       --ui-proxy=<access_to_component_web_interfaces> \
       --log-group-id=<log_group_ID> \
       --security-group-ids=<list_of_security_group_IDs>
     ```

     {% note info %}

     The {{ dataproc-name }} cluster name must be unique within the folder. It may contain Latin letters, numbers, hyphens, and underscores. The name may be up to 63 characters long.

     {% endnote %}

     Where:
     * `--environment`: Cluster [environment](../concepts/environment.md#environment), `prestable` or `production`.
     * `--bucket`: Name of the {{ objstorage-name }} bucket to store job dependencies and results. The {{ dataproc-name }} cluster’s [service account](../../iam/concepts/users/service-accounts.md) must have `READ and WRITE` permissions for this bucket.
     * `--zone`: [Availability zone](../../overview/concepts/geo-scope.md) where the {{ dataproc-name }} cluster hosts will reside.
     * `--service-account-name`: Name of the {{ dataproc-name }} cluster service account.
     * `--autoscaling-service-account-name`: Name of the service account for managing autoscaling subclusters. This is an optional setting.
     * `--version`: [Image version](../concepts/environment.md).

       {% include [note-light-weight-cluster](../../_includes/data-processing/note-light-weight-cluster.md) %}

       {% note tip %}

       To use the most recent image version, set `--version` to `2.1`.

       {% endnote %}

     * `--services`: List of [components](../concepts/environment.md) you want to use in your {{ dataproc-name }} cluster. If you skip this setting, the `yarn`, `tez`, and `spark` components will be used by default.
     * `--ssh-public-keys-file`: Full path to the file with the public part of the SSH key for access to the {{ dataproc-name }} cluster hosts. For information on how to generate and use SSH keys, see [this {{ compute-full-name }} guide](../../compute/operations/vm-connect/ssh.md).

        {% note info %}

        To connect to your cluster via [{{ oslogin }}](../../organization/concepts/os-login.md), replace `--ssh-public-keys-file` with `--oslogin` in the command.

        {% endnote %}

     * `--subcluster`: Properties of {{ dataproc-name }} subclusters:
       * `name`: {{ dataproc-name }} subcluster name.
       * `role`: {{ dataproc-name }} subcluster role, which can be `masternode`, `datanode`, or `computenode`.
       * `resource-preset`: [Host class](../concepts/instance-types.md).
       * `disk-type`: [Storage type](../concepts/storage.md), which can be `network-ssd`, `network-hdd`, or `network-ssd-nonreplicated`.
       * `disk-size`: Storage size, in GB.
       * `subnet-name`: Subnet name.
       * `hosts-count`: Number of hosts in the {{ dataproc-name }} subclusters for data storage or processing. The valid values range from `1` to `32`.
       * `assign-public-ip`: Access to {{ dataproc-name }} subcluster hosts from the internet. It can either be `true` or `false`. If access is enabled, you can only connect to the {{ dataproc-name }} cluster over SSL. For more information, see [{#T}](connect.md).

         {% note warning %}

         After you create a {{ dataproc-name }} cluster, you cannot request or disable public access to a subcluster. However, you can delete the {{ dataproc-name }} subcluster for data processing and recreate it with the public access settings you need.

         {% endnote %}

     * `--deletion-protection`: {{ dataproc-name }} cluster deletion protection.

       {% include [Deletion protection limits](../../_includes/mdb/deletion-protection-limits-data.md) %}

     * `--ui-proxy`: Access to the [web interfaces](../concepts/interfaces.md) of the {{ dataproc-name }} components. It can be either `true` or `false`.
     * `--log-group-id`: [Log group ID](../concepts/logs.md).
     * `--security-group-ids`: List of [security group](../../vpc/concepts/security-groups.md) IDs.

     To create a {{ dataproc-name }} cluster with multiple subclusters for data storage or processing, provide the required number of `--subcluster` arguments in the cluster creation command:

     ```bash
     {{ yc-dp }} cluster create <cluster_name> \
       ...
       --subcluster <subcluster_properties> \
       --subcluster <subcluster_properties> \
       ...
     ```

  1. To enable [autoscaling](../concepts/autoscaling.md) in {{ dataproc-name }} subclusters for data processing, specify the following properties:

     ```bash
     {{ yc-dp }} cluster create <cluster_name> \
       ...
       --subcluster name=<subcluster_name>,`
                    `role=computenode`
                    `...`
                    `hosts-count=<minimum_number_of_hosts>`
                    `max-hosts-count=<maximum_number_of_hosts>,`
                    `preemptible=<using_preemptible_VMs>,`
                    `warmup-duration=<VM_warmup_period>,`
                    `stabilization-duration=<stabilization_period>,`
                    `measurement-duration=<load_measurement_interval>,`
                    `cpu-utilization-target=<target_CPU_utilization>,`
                    `autoscaling-decommission-timeout=<decommissioning_timeout>
     ```

     Where:
     * `hosts-count`: Minimum number of hosts (VMs) per {{ dataproc-name }} subcluster. The minimum value is `1`, and the maximum value is `32`.
     * `max-hosts-count`: Maximum number of hosts (VMs) per {{ dataproc-name }} subcluster. The valid values range from `1` to `100`.
     * `preemptible`: Specifies if [preemptible VMs](../../compute/concepts/preemptible-vm.md) are used. It can either be `true` or `false`.
     * `warmup-duration`: Time required to warm up a VM, in `<value>s` format. The minimum value is `0s` and the maximum, `600s` (ten minutes).
     * `stabilization-duration`: Period, in seconds, during which the required number of VMs cannot be decreased, in `<value>s` format. The minimum value is `60s` (one minute). The maximum value is `1800s` (30 minutes).
     * `measurement-duration`: Period, in seconds, for which average utilization is calculated for each VM, in `<value>s` format. The minimum value is `60s` (one minute). The maximum value is `600s` (ten minutes).
     * `cpu-utilization-target`: Target CPU utilization, in %. Use this setting to enable CPU-based [autoscaling](../concepts/autoscaling.md). Otherwise, `yarn.cluster.containersPending` will be used for autoscaling based on the number of pending resources. The minimum value is `10` and the maximum, `100`.
     * `autoscaling-decommission-timeout`: [Decommissioning timeout](../concepts/decommission.md), in seconds. The minimum value is `0` and the maximum, `86400` (24 hours).

  1. To create a {{ dataproc-name }} cluster based on [dedicated host groups](../../compute/concepts/dedicated-host.md), specify their IDs as a comma-separated list in the `--host-group-ids` parameter:

     ```bash
     {{ yc-dp }} cluster create <cluster_name> \
       ...
       --host-group-ids=<dedicated_host_group_IDs>
     ```

     {% include [Dedicated hosts note](../../_includes/data-processing/note-dedicated-hosts.md) %}

  1. To configure {{ dataproc-name }} cluster hosts using [initialization scripts](../concepts/init-action.md), specify them in one or multiple `--initialization-action` parameters:

     ```bash
     {{ yc-dp }} cluster create <cluster_name> \
       ...
       --initialization-action uri=<initialization_script_URI>,`
                               `timeout=<script_timeout>,`
                               `args=["arg1","arg2","arg3",...]
     ```

     Where:
     * `uri`: Link to the initialization script in the `https://`, `http://`, `hdfs://`, or `s3a://` scheme.
     * `timeout` (optional): Script timeout, in seconds. If your initialization script runs longer than the specified time period, it will be terminated.
     * `args` (optional): Arguments for the initialization script, provided as a comma-separated list.

- {{ TF }} {#tf}

  
  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}


  To create a {{ dataproc-name }} cluster:
  1. In the command line, navigate to the directory that will contain the {{ TF }} configuration files describing your infrastructure. If there is no such directory, create one.

  
  1. {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Create a configuration file with a description of your cloud network, subnets, security group, and NAT gateway.

     The {{ dataproc-name }} cluster resides in a cloud network. If you already have a network in place, you do not need to describe it again.

     The {{ dataproc-name }} cluster hosts reside in subnets of the selected cloud network. If you already have suitable subnets, you do not need to describe them again.

     Below is an example of a configuration file describing a single-subnet cloud network, security group, NAT gateway, and route table:

     ```hcl
     resource "yandex_vpc_network" "test_network" {
       name = "<network_name>"
     }

     resource "yandex_vpc_subnet" "test_subnet" {
       name           = "<subnet_name>"
       zone           = "<availability_zone>"
       network_id     = yandex_vpc_network.test_network.id
       v4_cidr_blocks = ["<subnet>"]
       route_table_id = yandex_vpc_route_table.data-processing-rt.id
     }

     resource "yandex_vpc_gateway" "data-processing-gateway" {
       name = "data-processing-gateway"
       shared_egress_gateway {}
     }

     resource "yandex_vpc_route_table" "data-processing-rt" {
       network_id = "${yandex_vpc_network.test-network.id}"

       static_route {
         destination_prefix = "0.0.0.0/0"
         gateway_id         = "${yandex_vpc_gateway.data-processing-gateway.id}"
       }
     }

     resource "yandex_vpc_security_group" "data-processing-sg" {
       description = "Security group for DataProc"
       name        = "data-processing-security-group"
       network_id  = yandex_vpc_network.data-proc-network.id

       egress {
         description    = "Allow outgoing HTTPS traffic"
         protocol       = "TCP"
         port           = 443
         v4_cidr_blocks = ["0.0.0.0/0"]
       }

       ingress {
         description       = "Allow any incomging traffic within the security group"
         protocol          = "ANY"
         from_port         = 0
         to_port           = 65535
         predefined_target = "self_security_group"
       }

       egress {
         description       = "Allow any outgoing traffic within the security group"
         protocol          = "ANY"
         from_port         = 0
         to_port           = 65535
         predefined_target = "self_security_group"
       }

       egress {
         description    = "Allow outgoing traffic to NTP servers for time synchronization"
         protocol       = "UDP"
         port           = 123
         v4_cidr_blocks = ["0.0.0.0/0"]
       }
     }
     ```


  1. Create a configuration file describing the following resources:
      * {{ dataproc-name }} cluster [service account](../../iam/concepts/users/service-accounts.md) that needs access to the {{ objstorage-name }} cluster.
      * Service account to manage autoscaling subclusters, if required.
      * Service account to create the {{ objstorage-name }} bucket.
      * [Static key](../../iam/concepts/authorization/access-key.md).
      * {{ objstorage-name }} bucket to store [job](../concepts/jobs.md) execution results.

     ```hcl
     resource "yandex_iam_service_account" "data_proc_sa" {
       name        = "<service_account_name>"
       description = "<service_account_description>"
     }

     resource "yandex_iam_service_account" "data_proc_sa_autoscaling" {
       name        = "<service_account_name>"
       description = "<service_account_description>"
     }

     resource "yandex_resourcemanager_folder_iam_member" "dataproc-agent" {
       folder_id = "<folder_ID>"
       role      = "dataproc.agent"
       member    = "serviceAccount:${yandex_iam_service_account.data_proc_sa.id}"
     }

     resource "yandex_resourcemanager_folder_iam_member" "dataproc-provisioner" {
       folder_id = "<folder_ID>"
       role      = "dataproc.provisioner"
       member    = "serviceAccount:${yandex_iam_service_account.data_proc_sa_autoscaling.id}"
     }

     resource "yandex_iam_service_account" "bucket_sa" {
       name        = "<service_account_name>"
       description = "<service_account_description>"
     }

     resource "yandex_resourcemanager_folder_iam_member" "storage-admin" {
       folder_id = "<folder_ID>"
       role      = "storage.admin"
       member    = "serviceAccount:${yandex_iam_service_account.bucket_sa.id}"
     }

     resource "yandex_iam_service_account_static_access_key" "bucket_sa_static_key" {
       service_account_id = yandex_iam_service_account.bucket_sa.id
     }

     resource "yandex_storage_bucket" "data_bucket" {
       depends_on = [
         yandex_resourcemanager_folder_iam_member.storage-admin
       ]

       grant {
         id          = yandex_iam_service_account.data_proc_sa.id
         type        = "CanonicalUser"
         permissions = ["READ","WRITE"]
       }

       bucket     = "<bucket_name>"
       access_key = yandex_iam_service_account_static_access_key.bucket_sa_static_key.access_key
       secret_key = yandex_iam_service_account_static_access_key.bucket_sa_static_key.secret_key
     }
     ```

  1. Create a configuration file describing the {{ dataproc-name }} cluster and its subclusters.

     Here, you can also specify the [properties of the {{ dataproc-name }} cluster components, jobs, and environment](../concepts/settings-list.md), if required.

     Below is an example of a configuration file structure that describes a {{ dataproc-name }} cluster consisting of a master host subcluster, data storage subcluster, and data processing subcluster:

     ```hcl
     resource "yandex_dataproc_cluster" "data_cluster" {
       bucket                         = "${yandex_storage_bucket.data_bucket.bucket}"
       name                           = "<cluster_name>"
       description                    = "<cluster_description>"
       environment                    = "<cluster_environment>"
       service_account_id             = yandex_iam_service_account.data_proc_sa.id
       autoscaling_service_account_id = yandex_iam_service_account.data_proc_sa_autoscaling.id
       zone_id                        = "<availability_zone>"
       security_group_ids             = [yandex_vpc_security_group.data-processing-sg.id]
       deletion_protection            = <cluster_deletion_protection>

       depends_on = [
         yandex_resourcemanager_folder_iam_member.dataproc-provisioner,
         yandex_resourcemanager_folder_iam_member.dataproc-agent
       ]

       cluster_config {
         version_id = "<image_version>"

         hadoop {
           services   = ["<list_of_components>"]
           # List example: ["HDFS", "YARN", "SPARK", "TEZ", "MAPREDUCE", "HIVE"].
           properties = {
             "<component_property>" = <value>
             ...
           }
           ssh_public_keys = [
             file("<path_to_public_SSH_key>")
           ]
         }

         subcluster_spec {
           name = "<name_of_subcluster_with_master_host>"
           role = "MASTERNODE"
           resources {
             resource_preset_id = "<host_class>"
             disk_type_id       = "<storage_type>"
             disk_size          = <storage_size_in_GB>
           }
           subnet_id   = yandex_vpc_subnet.test_subnet.id
           hosts_count = 1
         }

         subcluster_spec {
           name = "<name_of_subcluster_for_storing_data>"
           role = "DATANODE"
           resources {
             resource_preset_id = "<host_class>"
             disk_type_id       = "<storage_type>"
             disk_size          = <storage_size_in_GB>
           }
           subnet_id   = yandex_vpc_subnet.test_subnet.id
           hosts_count = <number_of_hosts_in_subcluster>
         }

         subcluster_spec {
           name = "<data_processing_subcluster_name>"
           role = "COMPUTENODE"
           resources {
             resource_preset_id = "<host_class>"
             disk_type_id       = "<storage_type>"
             disk_size          = <storage_size_in_GB>
           }
           subnet_id   = yandex_vpc_subnet.test_subnet.id
           hosts_count = <number_of_hosts_in_subcluster>
         }
       }
     }
     ```

     Where `deletion_protection` means {{ dataproc-name }} cluster deletion protection. It can either be `true` or `false`.

     {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

     {% include [note-light-weight-cluster](../../_includes/data-processing/note-light-weight-cluster.md) %}

     {% note tip %}

     To use the most recent [image version](../concepts/environment.md), set `version_id` to `2.1`.

     {% endnote %}

     To connect to your cluster via [{{ oslogin }}](../../organization/concepts/os-login.md), replace `ssh_public_keys` with `oslogin` set to `true`.

     To access the [web interfaces](../concepts/interfaces.md) of the {{ dataproc-name }} components, add the `ui_proxy` field set to `true` to the {{ dataproc-name }} cluster description:

     ```hcl
     resource "yandex_dataproc_cluster" "data_cluster" {
       ...
       ui_proxy = true
       ...
     }
     ```

     To configure [autoscaling](../concepts/autoscaling.md) in {{ dataproc-name }} subclusters for data processing, add the `autoscaling_config` section with the settings you need to `subcluster_spec` of the subcluster in question:

     ```hcl
     subcluster_spec {
       name = "<subcluster_name>"
       role = "COMPUTENODE"
       ...
       autoscaling_config {
         max_hosts_count        = <maximum_number_of_VMs_in_group>
         measurement_duration   = <load_measurement_interval>
         warmup_duration        = <warmup_period>
         stabilization_duration = <stabilization_period>
         preemptible            = <use_of_preemptible_VMs>
         cpu_utilization_target = <target_CPU_utilization>
         decommission_timeout   = <decommissioning_timeout>
       }
     }
     ```

     Where:
     * `max_hosts_count`: Maximum number of hosts (VMs) per {{ dataproc-name }} subcluster. The minimum value is `1`, and the maximum value is `100`.
     * `measurement_duration`: Period, in seconds, for which average utilization is calculated for each VM, in `<value>s` format. The minimum value is `60s` (1 minute), and the maximum value is `600s` (10 minutes).
     * `warmup_duration`: Time required to warm up a VM, in `<value>s` format. The minimum value is `0s`, and the maximum value is `600s`.
     * `stabilization_duration`: Period, in seconds, during which the required number of VMs cannot be decreased, in `<value>s` format. The minimum value is `60s` and the maximum value is `1800s`.
     * `preemptible`: Indicates if [preemptible VMs](../../compute/concepts/preemptible-vm.md) are used. It can be either `true` or `false`.
     * `cpu_utilization_target`: Target CPU utilization, in %. Use this setting to enable [scaling](../concepts/autoscaling.md) based on CPU utilization. Otherwise, `yarn.cluster.containersPending` will be used for scaling based on the number of pending resources. The minimum value is `10`, and the maximum value is `100`.
     * `decommission_timeout`: [Decommissioning timeout](../concepts/decommission.md), in seconds. The minimum value is `0` and the maximum, `86400` (24 hours).

     For more information about the resources you can create with {{ TF }}, see [this provider guide]({{ tf-provider-resources-link }}/dataproc_cluster).
  1. Validate your {{ TF }} configuration files:

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Create a {{ dataproc-name }} cluster:

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

     {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

- API {#api}

  To create a {{ dataproc-name }} cluster, call the [create](../api-ref/Cluster/create) API method and provide the following in the request:
  * ID of the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) to host the {{ dataproc-name }} cluster, in the `folderId` parameter.
  * {{ dataproc-name }} cluster name in the `name` parameter.
  * Cluster [environment](../concepts/environment.md#environment), `PRESTABLE` or `PRODUCTION`, in the `environment` parameter.
  * {{ dataproc-name }} cluster configuration in the `configSpec` parameter, including:
    * [Image version](../concepts/environment.md) in the `configSpec.versionId` parameter.

      {% include [note-light-weight-cluster](../../_includes/data-processing/note-light-weight-cluster.md) %}

      {% note tip %}

      To use the most recent image version, specify `2.0`.

      {% endnote %}

    * List of components in the `configSpec.hadoop.services` parameter.
    * Public part of the SSH key in the `configSpec.hadoop.sshPublicKeys` parameter.

      {% note info %}

      To connect to your cluster via [{{ oslogin }}](../../organization/concepts/os-login.md), provide `configSpec.hadoop.osloginEnabled: true` instead of `configSpec.hadoop.sshPublicKeys` in the request.

      {% endnote %}

    * Settings of the {{ dataproc-name }} subclusters in the `configSpec.subclustersSpec` parameter.
  * Availability zone of the {{ dataproc-name }} cluster in the `zoneId` parameter.
  * ID of the {{ dataproc-name }} cluster [service account](../../iam/concepts/users/service-accounts.md) in the `serviceAccountId` parameter.
  * ID of the service account for managing autoscaling subclusters in the `autoscalingServiceAccountId` parameter, if required.
  * Bucket name in the `bucket` parameter.
  * IDs of the {{ dataproc-name }} cluster security groups in the `hostGroupIds` parameter.
  * {{ dataproc-name }} cluster deletion protection settings in the `deletionProtection` parameter.

    {% include [Deletion protection limits](../../_includes/mdb/deletion-protection-limits-data.md) %}

  To assign a public IP address to all hosts of a {{ dataproc-name }} subcluster, provide `true` in `configSpec.subclustersSpec.assignPublicIp`.

  To create a {{ dataproc-name }} cluster based on [dedicated host groups](../../compute/concepts/dedicated-host.md), provide a list of their IDs in the `hostGroupIds` parameter.

  {% include [Dedicated hosts note](../../_includes/data-processing/note-dedicated-hosts.md) %}

  To configure {{ dataproc-name }} cluster hosts using [initialization scripts](../concepts/init-action.md), specify them in one or multiple `configSpec.hadoop.initializationActions` parameters.

{% endlist %}

After the {{ dataproc-name }} cluster status switches to **Running**, you can [connect](connect.md) to the {{ dataproc-name }} subcluster hosts.

## Create a {{ dataproc-name }} cluster copy {#duplicate}

You can create a {{ dataproc-name }} cluster with the settings of another one created earlier. Do this by importing the original {{ dataproc-name }} cluster configuration into {{ TF }}. This way, you can either create an identical copy or use the imported configuration as the baseline and modify it as needed. The import feature is handy when the original {{ dataproc-name }} cluster has a lot of settings (e.g., an HDFS cluster) and you need to create a similar one.

To create a {{ dataproc-name }} cluster copy:

{% list tabs group=instructions %}

- {{ TF }} {#tf}

  1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
  1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
  1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
  1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}
  1. In your current working directory, create a `.tf` file with the following contents:

     ```hcl
     resource "yandex_dataproc_cluster" "old" { }
     ```

  1. Save the ID of the original {{ dataproc-name }} cluster to an environment variable:

     ```bash
     export DATAPROC_CLUSTER_ID=<cluster_ID>
     ```

     You can get the cluster ID with the [list of clusters in the folder](../../data-proc/operations/cluster-list.md#list).

  1. Import the original {{ dataproc-name }} cluster settings to the {{ TF }} configuration:

     ```bash
     terraform import yandex_dataproc_cluster.old ${DATAPROC_CLUSTER_ID}
     ```

  1. Get the imported configuration:

     ```bash
     terraform show
     ```

  1. Copy it from your terminal and paste it into the `.tf` file.
  1. Place the file in the new `imported-cluster` directory.
  1. Edit the copied configuration so that you can create a new {{ dataproc-name }} cluster from it:
     * Specify the new {{ dataproc-name }} cluster name in the `resource` string and the `name` parameter.
     * Delete `created_at`, `host_group_ids`, `id`, and `subcluster_spec.id`.
     * If you are connecting to the cluster using an SSH key, change its format in the `ssh_public_keys` parameter. Initial format:

       ```hcl
       ssh_public_keys = [
         <<-EOT
           <key>
         EOT,
       ]
       ```

       Required format:

       ```hcl
       ssh_public_keys = [
         "<key>"
       ]
       ```

     * Optionally, make further changes if you need a customized configuration.
  1. [Get the authentication credentials](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials) in the `imported-cluster` directory.
  1. In the same directory, [configure and initialize the provider](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Instead of manually creating the provider configuration file, you can [download it](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
  1. Move the configuration file to the `imported-cluster` directory and [specify the arguments](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). If you have not set the authentication credentials as environment variables, specify them in the configuration file.
  1. Validate your {{ TF }} configuration files using this command:

     ```bash
     terraform validate
     ```

     {{ TF }} will display any configuration errors detected in your files.
  1. Create the required infrastructure:

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

     {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Example {#example}

### Creating a lightweight {{ dataproc-name }} cluster for Spark and PySpark jobs {#creating-a-light-weight-cluster}

{% list tabs group=instructions %}

- CLI {#cli}

  Create a {{ dataproc-name }} cluster to run Spark jobs without HDFS and data storage subclusters with the following test settings:
  * Name: `my-dataproc`.
  * Environment: `production`.
  * Bucket: `dataproc-bucket`.
  * Availability zone: `{{ zone-id }}`.
  * Service account: `dataproc-sa`.
  * Image version: `2.0`.
  * Components: `SPARK` and `YARN`.
  * Path to the public part of the SSH key: `/home/username/.ssh/id_rsa.pub`.
  * {{ dataproc-name }} subcluster with `master` hosts and a single `compute` subcluster for processing data:
    * Class: `{{ host-class }}`.
    * Network SSD storage (`{{ disk-type-example }}`): 20 GB.
    * Subnet: `{{ subnet-name }}`.
    * Public access: Enabled.
  * Security group: `{{ security-group }}`.
  * Protection against accidental {{ dataproc-name }} cluster deletion: Enabled.

  Run this command:

  ```bash
  {{ yc-dp }} cluster create my-dataproc \
     --environment=production \
     --bucket=dataproc-bucket \
     --zone={{ zone-id }} \
     --service-account-name=dataproc-sa \
     --version=2.0 \
     --services=SPARK,YARN \
     --ssh-public-keys-file=/home/username/.ssh/id_rsa.pub \
     --subcluster name="master",`
                  `role=masternode,`
                  `resource-preset={{ host-class }},`
                  `disk-type={{ disk-type-example }},`
                  `disk-size=20,`
                  `subnet-name={{ subnet-name }},`
                  `assign-public-ip=true \
     --subcluster name="compute",`
                  `role=computenode,`
                  `resource-preset={{ host-class }},`
                  `disk-type={{ disk-type-example }},`
                  `disk-size=20,`
                  `subnet-name={{ subnet-name }},`
                  `assign-public-ip=true \
     --security-group-ids={{ security-group }} \
     --deletion-protection
  ```

{% endlist %}
