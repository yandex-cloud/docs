# Creating a {{ dataproc-name }} cluster

To create a {{ dataproc-name }} cluster, a user must be assigned the `editor` and `dataproc.agent` [roles](../../iam/concepts/access-control/roles.md). For more information, see the [role description](../security/index.md#roles-list).


## Configure a network {#setup-network}

Configure internet access from the [subnet](../../vpc/concepts/network.md#subnet) to which the {{ dataproc-name }} [subcluster](../concepts/index.md#resources) with a master host will be connected, e.g., using a [NAT gateway](../../vpc/operations/create-nat-gateway.md). This will enable the {{ dataproc-name }} subcluster to interact with {{ yandex-cloud }} services or hosts in other [networks](../../vpc/concepts/network.md#network).

## Configure security groups {#change-security-groups}

{% note warning %}

You need to create and configure [security groups](../../vpc/concepts/security-groups.md) before creating a {{ dataproc-name }} cluster. If the selected security groups do not have the required rules, {{ yandex-cloud }} disables the {{ dataproc-name }} cluster creation.

{% endnote %}

1. [Create](../../vpc/operations/security-group-create.md) one or more security groups for service traffic of the {{ dataproc-name }} cluster.
1. [Add rules](../../vpc/operations/security-group-add-rule.md):
   * One rule for inbound and another one for outbound service traffic:
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-any }}`.
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}`.
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**/**{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}`.
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-self }}`.
   * A separate rule for outgoing HTTPS traffic. This will allow you to use [{{ objstorage-full-name }}](../../storage/) [buckets](../../storage/concepts/bucket.md), [UI Proxy](../concepts/interfaces.md), and [autoscaling](../concepts/autoscaling.md) of {{ dataproc-name }} clusters.

      You can set up this rule using one of the two methods:

      {% list tabs %}

      - To all addresses

         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-https }}`.
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`.
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`.

      - To the addresses used by {{ yandex-cloud }}

         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-https }}`.
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`.
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**:
            * `84.201.181.26/32`: Getting the {{ dataproc-name }} cluster status, running jobs, UI Proxy.
            * `158.160.59.216/32`: Monitoring the {{ dataproc-name }} cluster state, autoscaling.
            * `213.180.193.243/32`: Access to {{ objstorage-name }}.

      {% endlist %}

   * A rule that allows access to NTP servers for time syncing:
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `123`
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_udp }}`.
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`.

If you plan to use multiple security groups for your {{ dataproc-name }} cluster, allow all traffic between these groups.

{% note info %}

You can specify more detailed rules for your security groups, e.g., to allow traffic only in specific subnets.

You must configure security groups correctly for all subnets in which the {{ dataproc-name }} cluster hosts will reside.

{% endnote %}

You can set up security groups after creating a {{ dataproc-name }} cluster to [connect to {{ metastore-name }}](./metastore/dataproc-connect.md) or [{{ dataproc-name }} cluster hosts](connect.md) via the internet or an intermediate [VM](../../compute/concepts/vm.md).


## Create a {{ dataproc-name }} cluster {#create}

A {{ dataproc-name }} cluster must include a subcluster with a master host and at least one subcluster for data storage or processing.

If you want to create a {{ dataproc-name }} cluster copy, [import its configuration](#duplicate) to {{ TF }}.

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create a {{ dataproc-name }} cluster.
   1. Click **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** and select ![image](../../_assets/data-proc/data-proc.svg) **{{ ui-key.yacloud.iam.folder.dashboard.value_data-proc }}** from the drop-down list.
   1. Enter a name for the {{ dataproc-name }} cluster in the **{{ ui-key.yacloud.mdb.forms.base_field_name }}** field. The naming requirements are as follows:
      * It must be unique within the folder.

      {% include [name-format.md](../../_includes/name-format.md) %}

   1. Select a suitable [image version](../concepts/environment.md) and the services you want to use in the {{ dataproc-name }} cluster.

      {% include [note-light-weight-cluster](../../_includes/data-proc/note-light-weight-cluster.md) %}

      {% note tip %}

      To use the most recent image version, specify `2.0`.

      {% endnote %}

   1. Enter the public part of your SSH key in the **{{ ui-key.yacloud.mdb.forms.config_field_public-keys }}** field. For information about how to generate and use SSH keys, see the [{{ compute-full-name }} documentation](../../compute/operations/vm-connect/ssh.md).
   1. Select or create a [service account](../../iam/concepts/users/service-accounts.md) to which you will grant access to the {{ dataproc-name }} cluster. Make sure to [assign](../security/index.md#grant-role) the `dataproc.agent` role to the service account of the {{ dataproc-name }} cluster.
   1. Select the availability zone for the {{ dataproc-name }} cluster.
   1. If required, configure the [properties of {{ dataproc-name }} cluster components, jobs, and the environment](../concepts/settings-list.md).
   1. If necessary, specify custom [initialization scripts](../concepts/init-action.md) for {{ dataproc-name }} cluster hosts. For each script, specify:
      * **{{ ui-key.yacloud.mdb.forms.field_initialization-action-uri }}**: Link to the initialization script in the `https://`, `http://`, `hdfs://`, or `s3a://` scheme.
      * (Optional) **{{ ui-key.yacloud.mdb.forms.field_initialization-action-timeout }}**: Script execution timeout, in seconds. If your initialization script runs longer than this time period, it will be terminated.
      * (Optional) **{{ ui-key.yacloud.mdb.forms.field_initialization-action-args }}**: List of arguments of your initialization script, enclosed in square brackets `[]` and separated by commas, such as:

         ```text
         ["arg1","arg2",...,"argN"]
         ```

   1. Select the name of a bucket in {{ objstorage-name }} to store job dependencies and results.
   1. Select a network for the {{ dataproc-name }} cluster.
   1. Select security groups that have the required permissions.

      {% note warning %}

      When you create a {{ dataproc-name }} cluster, security group settings are verified. If the {{ dataproc-name }} cluster cannot operate properly with these settings, a warning will appear. A sample functional configuration is provided [above](#change-security-groups).

      {% endnote %}

   1. Enable the **{{ ui-key.yacloud.mdb.forms.config_field_ui_proxy }}** option to access the [web interfaces of {{ dataproc-name }} components](../concepts/interfaces.md).
   1. [{{ cloud-logging-full-name }}](../../logging/) stores {{ dataproc-name }} cluster logs. Select a log group from the list or [create a new one](../../logging/operations/create-group.md).

      To enable this functionality, [assign](../../iam/operations/roles/grant.md#access-to-sa) the `logging.writer` role to the service account of the {{ dataproc-name }} cluster. For more information, see the [{{ cloud-logging-name }} documentation](../../logging/security/index.md).
   1. Configure {{ dataproc-name }} subclusters: maximum one subcluster with a master host (**Master**) and subclusters for data storage or processing.

      Roles of {{ dataproc-name }} subclusters for data storage and processing are different: you can deploy data storage components on data storage subclusters and computing components on data processing subclusters. You can use a [storage](../concepts/storage.md) on a {{ dataproc-name }} subcluster for data processing only to temporarily store the files being processed.

      For each {{ dataproc-name }} subcluster, you can configure:
      * Number of hosts.
      * [Host class](../concepts/instance-types.md): Platform and computing resources available to the host.
      * Storage size and type.
      * Subnet of the network where the {{ dataproc-name }} cluster resides.

         In the subnet, you need to [set up a NAT gateway](../../vpc/operations/create-nat-gateway.md) for the {{ dataproc-name }} subcluster with a master host. For more information, see [{#T}](#setup-network).
      * To access {{ dataproc-name }} subcluster hosts from the internet, select **{{ ui-key.yacloud.mdb.forms.field_assign-public-ip }}**. In this case, you can only connect to {{ dataproc-name }} subcluster hosts using SSL. For more information, see [{#T}](connect.md).

         {% note warning %}

         After you create a {{ dataproc-name }} cluster, you cannot request or disable public access to the subcluster. However, you can delete the {{ dataproc-name }} subcluster for data processing and create it again with the public access settings you need.

         {% endnote %}

   1. In {{ dataproc-name }} subclusters for data processing, you can specify [autoscaling](../concepts/autoscaling.md) parameters.

      {% include [note-info-service-account-roles](../../_includes/data-proc/service-account-roles.md) %}

      1. Under **{{ ui-key.yacloud.mdb.forms.label_create-subcluster }}**, click **{{ ui-key.yacloud.mdb.forms.button_configure }}**.
      1. In the **{{ ui-key.yacloud.mdb.forms.base_field_roles }}** field, select `COMPUTENODE`.
      1. Under **{{ ui-key.yacloud.mdb.forms.section_scaling }}**, enable the **{{ ui-key.yacloud.mdb.forms.label_autoscaling-activated }}** setting.
      1. Set autoscaling parameters.
      1. The default metric used for autoscaling is `yarn.cluster.containersPending`. To enable scaling based on CPU usage, disable the **{{ ui-key.yacloud.compute.groups.create.field_default-utilization-target }}** setting and specify the target CPU utilization level.
      1. Click **{{ ui-key.yacloud.mdb.forms.button_add-subcluster }}**.
   1. If required, configure additional settings of the {{ dataproc-name }} cluster:
      **{{ ui-key.yacloud.mdb.forms.label_deletion-protection }}** manages protection of the {{ dataproc-name }} cluster from accidental deletion by a user.

      Enabled protection will not prevent a manual connection to the {{ dataproc-name }} cluster and data deletion.
   1. Click **{{ ui-key.yacloud.mdb.forms.button_create }}**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To create a {{ dataproc-name }} cluster:

   
   1. Check whether the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) has any subnets for the {{ dataproc-name }} cluster hosts:

      ```bash
      yc vpc subnet list
      ```

      If there are no subnets in the folder, [create the required subnets](../../vpc/operations/subnet-create.md) in [{{ vpc-full-name }}](../../vpc/).


   1. View the description of the [CLI](../../cli/) command for creating a {{ dataproc-name }} cluster:

      ```bash
      {{ yc-dp }} cluster create --help
      ```

   1. Specify {{ dataproc-name }} cluster parameters in the create command (the list of supported parameters in the example is not exhaustive):

      ```bash
      {{ yc-dp }} cluster create <cluster_name> \
        --bucket=<bucket_name> \
        --zone=<availability_zone> \
        --service-account-name=<service_account_name> \
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
        --subcluster name=<name_of_data_storage_subcluster>,`
                     `role=datanode,`
                     `resource-preset=<host_class>,`
                     `disk-type=<storage_type>,`
                     `disk-size=<storage_size_in_GB>,`
                     `subnet-name=<subnet_name>,`
                     `hosts-count=<number_of_hosts>,`
                     `assign-public-ip=<public_access_to_subcluster_host> \
        --deletion-protection=<cluster_deletion_protection> \
        --ui-proxy=<access_to_component_web_interfaces> \
        --log-group-id=<log_group_ID> \
        --security-group-ids=<list_of_security_group_IDs>
      ```

      {% note info %}

      The {{ dataproc-name }} cluster name must be unique within the folder. It may contain Latin letters, numbers, hyphens, and underscores. The name may be up to 63 characters long.

      {% endnote %}

      Where:
      * `--bucket`: Name of the bucket in {{ objstorage-name }} that will store job dependencies and results. The [service account](../../iam/concepts/users/service-accounts.md) of the {{ dataproc-name }} cluster must have `READ and WRITE` permissions for this bucket.
      * `--zone`: [Availability zone](../../overview/concepts/geo-scope.md) where the {{ dataproc-name }} cluster hosts will reside.
      * `--service-account-name`: Name of the {{ dataproc-name }} cluster service account. Make sure to [assign](../security/index.md#grant-role) the `dataproc.agent` role to the service account of the {{ dataproc-name }} cluster.
      * `--version`: [Image version](../concepts/environment.md).

         {% include [note-light-weight-cluster](../../_includes/data-proc/note-light-weight-cluster.md) %}

         {% note tip %}

         To use the most recent image version, set the `--version` parameter value to `2.0`.

         {% endnote %}

      * `--services`: List of [components](../concepts/environment.md) that you want to use in the {{ dataproc-name }} cluster. If this parameter is omitted, the default set will be used: `yarn`, `tez`, and `spark`.
      * `--ssh-public-keys-file`: Full path to the file with the public part of the SSH key for access to the {{ dataproc-name }} cluster hosts. For information about how to generate and use SSH keys, see the [{{ compute-full-name }} documentation](../../compute/operations/vm-connect/ssh.md).
      * `--subcluster`: Parameters of {{ dataproc-name }} subclusters:
         * `name`: {{ dataproc-name }} subcluster name.
         * `role`: {{ dataproc-name }} subcluster role: `masternode`, `datanode`, or `computenode`.
         * `resource-preset`: [Host class](../concepts/instance-types.md).
         * `disk-type`: [Storage type](../concepts/storage.md) (`network-ssd`, `network-hdd`, or `network-ssd-nonreplicated`).
         * `disk-size`: Storage size in GB.
         * `subnet-name`: [Name of the subnet](../../vpc/concepts/network.md#subnet).
         * `hosts-count`: Number of hosts in the {{ dataproc-name }} subclusters for data storage or processing. The minimum value is `1` and the maximum value is `32`.
         * `assign-public-ip`: Access to {{ dataproc-name }} subcluster hosts from the internet. It may take either the `true` or `false` value. If access is enabled, you can only connect to the {{ dataproc-name }} cluster using SSL. For more information, see [{#T}](connect.md).

            {% note warning %}

            After you create a {{ dataproc-name }} cluster, you cannot request or disable public access to the subcluster. However, you can delete the {{ dataproc-name }} subcluster for data processing and create it again with the public access settings you need.

            {% endnote %}

      * `--deletion-protection`: Deletion protection of the {{ dataproc-name }} cluster. It may take either the `true` or `false` value.

         {% include [Deletion protection limits](../../_includes/mdb/deletion-protection-limits-data.md) %}

      * `--ui-proxy`: Access to [{{ dataproc-name }} component web interfaces](../concepts/interfaces.md). It may take either the `true` or `false` value.
      * `--log-group-id`: [Log group ID](../concepts/logs.md).
      * `--security-group-ids`: List of [security group](../../vpc/concepts/security-groups.md) IDs.

      To create a {{ dataproc-name }} cluster with multiple data storage or processing subclusters, provide the required number of `--subcluster` arguments in the `cluster create` command:

      ```bash
      {{ yc-dp }} cluster create <cluster_name> \
        ...
        --subcluster <subcluster_parameters> \
        --subcluster <subcluster_parameters> \
        ...
      ```

   1. To enable [autoscaling](../concepts/autoscaling.md) in {{ dataproc-name }} subclusters for data processing, specify the following parameters:

      ```bash
      {{ yc-dp }} cluster create <cluster_name> \
        ...
        --subcluster name=<subcluster_name>,`
                     `role=computenode`
                     `...`
                     `hosts-count=<minimum_number_of_hosts>`
                     `max-hosts-count=<maximum_number_of_hosts>,`
                     `preemptible=<use_preemptible_VMs>,`
                     `warmup-duration=<VM_warmup_time>,`
                     `stabilization-duration=<stabilization_period>,`
                     `measurement-duration=<utilization_measurement_interval>,`
                     `cpu-utilization-target=<target_CPU_utilization_level>,`
                     `autoscaling-decommission-timeout=<decommissioning_timeout>
      ```

      Where:

      * `hosts-count`: Minimum number of hosts (VMs) in the {{ dataproc-name }} subcluster. The minimum value is `1` and the maximum value is `32`.
      * `max-hosts-count`: Maximum number of hosts (VMs) in the {{ dataproc-name }} subcluster. The minimum value is `1` and the maximum value is `100`.
      * `preemptible`: Indicates if [preemptible VMs](../../compute/concepts/preemptible-vm.md) are used. It may take either the `true` or `false` value.
      * `warmup-duration`: Time required to warm up a VM instance, in `<value>s` format. The minimum value is `0s` and the maximum value is `600s` (10 minutes).
      * `stabilization-duration`: Interval in seconds, during which the required number of instances cannot be decreased, in `<value>s` format. The minimum value is `60s` (1 minute) and the maximum value is `1800s` (30 minutes).
      * `measurement-duration`: Period in seconds, for which utilization measurements should be averaged for each instance, in `<value>s` format. The minimum value is `60s` (1 minute) and the maximum value is `600s` (10 minutes).
      * `cpu-utilization-target`: Target CPU utilization level, in %. Use this setting to enable [scaling](../concepts/autoscaling.md) based on CPU utilization. Otherwise, `yarn.cluster.containersPending` will be used as a metric (based on the number of pending resources). The minimum value is `10` and the maximum value is `100`.
      * `autoscaling-decommission-timeout`: [Decommissioning timeout](../concepts/decommission.md) in seconds. The minimum value is `0` and the maximum value is `86400` (24 hours).

      {% include [note-info-service-account-roles](../../_includes/data-proc/service-account-roles.md) %}

   1. To create a {{ dataproc-name }} subcluster residing on [groups of dedicated hosts](../../compute/concepts/dedicated-host.md), specify their IDs separated by commas in the `--host-group-ids` parameter:

      ```bash
      {{ yc-dp }} cluster create <cluster_name> \
        ...
        --host-group-ids=<IDs_of_groups_of_dedicated_hosts>
      ```

      {% include [Dedicated hosts note](../../_includes/data-proc/note-dedicated-hosts.md) %}

   1. To configure {{ dataproc-name }} cluster hosts using [initialization scripts](../concepts/init-action.md), specify them in one or multiple `--initialization-action` parameters:

      ```bash
      {{ yc-dp }} cluster create <cluster_name> \
        ...
        --initialization-action uri=<initialization_script_URI>,`
                                `timeout=<script_execution_timeout>,`
                                `args=["arg1","arg2","arg3",...]
      ```

      Where:

      * `URI`: Link to the initialization script in the `https://`, `http://`, `hdfs://`, or `s3a://` scheme.
      * (Optional) `timeout`: Script execution timeout, in seconds. If your initialization script runs longer than this time period, it will be terminated.
      * (Optional) `args`: Arguments separated by commas with which an initialization script must be executed.

- {{ TF }} {#tf}

   
   {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}


   To create a {{ dataproc-name }} cluster:

   1. Using the command line, navigate to the folder that will contain the {{ TF }} configuration files with an infrastructure plan. Create the directory if it does not exist.

   
   1. {% include [terraform-install](../../_includes/terraform-install.md) %}

   1. Create a configuration file describing the cloud network and subnets.

      The {{ dataproc-name }} cluster resides in a cloud network. If you already have a suitable network, you do not need to describe it again.

      {{ dataproc-name }} cluster hosts reside in subnets of the selected cloud network. If you already have suitable subnets, you do not need to describe them again.

      Example structure of a configuration file that describes a cloud network with a single subnet:

      ```hcl
      resource "yandex_vpc_network" "test_network" {
        name = "<network_name>"
      }

      resource "yandex_vpc_subnet" "test_subnet" {
        name           = "<subnet_name>"
        zone           = "<availability_zone>"
        network_id     = yandex_vpc_network.test_network.id
        v4_cidr_blocks = ["<subnet>"]
      }
      ```


   1. Create a configuration file describing the [service account](../../iam/concepts/users/service-accounts.md) to access the {{ dataproc-name }} cluster, as well as the [static key](../../iam/concepts/authorization/access-key.md) and the {{ objstorage-name }} bucket to store jobs and results.

      ```hcl
      resource "yandex_iam_service_account" "data_proc_sa" {
        name        = "<service_account_name>"
        description = "<service_account_description>"
      }

      resource "yandex_resourcemanager_folder_iam_member" "dataproc" {
        folder_id = "<folder_ID>"
        role      = "dataproc.agent"
        member    = "serviceAccount:${yandex_iam_service_account.data_proc_sa.id}"
      }

      resource "yandex_resourcemanager_folder_iam_member" "bucket-creator" {
        folder_id = "<folder_ID>"
        role      = "dataproc.editor"
        member    = "serviceAccount:${yandex_iam_service_account.data_proc_sa.id}"
      }

      resource "yandex_iam_service_account_static_access_key" "sa_static_key" {
        service_account_id = yandex_iam_service_account.data_proc_sa.id
      }

      resource "yandex_storage_bucket" "data_bucket" {
        depends_on = [
          yandex_resourcemanager_folder_iam_member.bucket-creator
        ]

        bucket     = "<bucket_name>"
        access_key = yandex_iam_service_account_static_access_key.sa_static_key.access_key
        secret_key = yandex_iam_service_account_static_access_key.sa_static_key.secret_key
      }
      ```

   1. Create a configuration file describing the {{ dataproc-name }} cluster and its subclusters.

      If required, here you can also specify the [properties of the {{ dataproc-name }} cluster components, jobs, and the environment](../concepts/settings-list.md).

      Below is an example of a configuration file structure that describes a {{ dataproc-name }} cluster consisting of a subcluster with a master host, a data storage subcluster, and a data processing subcluster:

      ```hcl
      resource "yandex_dataproc_cluster" "data_cluster" {
        bucket              = "<bucket_name>"
        name                = "<cluster_name>"
        description         = "<cluster_description>"
        service_account_id  = yandex_iam_service_account.data_proc_sa.id
        zone_id             = "<availability_zone>"
        security_group_ids  = ["<list_of_security_group_IDs>"]
        deletion_protection = <cluster_deletion_protection>

        cluster_config {
          version_id = "<image_version>"

          hadoop {
            services   = ["<list_of_components>"]
            # Example of the list: ["HDFS", "YARN", "SPARK", "TEZ", "MAPREDUCE", "HIVE"].
            properties = {
              "<component_property>" = <value>
              ...
            }
            ssh_public_keys = [
              file("${file("<path_to_public_SSH_key>")}")
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
            name = "<name_of_data_storage_subcluster>"
            role = "DATANODE"
            resources {
              resource_preset_id = "<host_class>"
              disk_type_id       = "<storage_type>"
              disk_size          = <storage_size_in_GB>
            }
            subnet_id   = yandex_vpc_subnet.test_subnet.id
            hosts_count = <number_of_subcluster_hosts>
          }

          subcluster_spec {
            name = "<name_of_data_processing_subcluster>"
            role = "COMPUTENODE"
            resources {
              resource_preset_id = "<host_class>"
              disk_type_id       = "<storage_type>"
              disk_size          = <storage_size_in_GB>
            }
            subnet_id   = yandex_vpc_subnet.test_subnet.id
            hosts_count = <number_of_subcluster_hosts>
          }
        }
      }
      ```

      Where `deletion_protection` is the deletion protection of the {{ dataproc-name }} cluster. It may take either the `true` or `false` value.

      {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

      {% include [note-light-weight-cluster](../../_includes/data-proc/note-light-weight-cluster.md) %}

      {% note tip %}

      To use the most recent [image version](../concepts/environment.md), set the `version_id` parameter to `2.0`.

      {% endnote %}

      To access [web interfaces](../concepts/interfaces.md) of {{ dataproc-name }} components, add the `ui_proxy` field set to `true` to the {{ dataproc-name }} cluster description:

      ```hcl
      resource "yandex_dataproc_cluster" "data_cluster" {
        ...
        ui_proxy = true
        ...
      }
      ```

      To configure [autoscaling](../concepts/autoscaling.md) parameters in {{ dataproc-name }} subclusters for data processing, add the `autoscaling_config` section with the required settings to the `subcluster_spec` description of the relevant subcluster:

      ```hcl
      subcluster_spec {
        name = "<subcluster_name>"
        role = "COMPUTENODE"
        ...
        autoscaling_config {
          max_hosts_count        = <maximum_number_of_VMs_in_group>
          measurement_duration   = <utilization_measurement_interval>
          warmup_duration        = <warmup_time>
          stabilization_duration = <stabilization_period>
          preemptible            = <use_preemptible_VMs>
          cpu_utilization_target = <target_vCPU_utilization_level>
          decommission_timeout   = <decommissioning_timeout>
        }
      }
      ```

      Where:
      * `max_hosts_count`: Maximum number of hosts (VMs) in the {{ dataproc-name }} subcluster. The minimum value is `1` and the maximum value is `100`.
      * `measurement_duration`: Period, in seconds, for which utilization measurements are averaged for each instance, in `<value>s` format. The minimum value is `60s` (1 minute) and the maximum value is `600s` (10 minutes).
      * `warmup_duration`: Time required to warm up a VM instance, in `<value>s` format. The minimum value is `0s` and the maximum value is `600s` (10 minutes).
      * `stabilization_duration`: Period, in seconds, during which the required number of instances cannot be decreased, in `<value>s` format. The minimum value is `60s` (1 minute) and the maximum value is `1800s` (30 minutes).
      * `preemptible`: Indicates if [preemptible VMs](../../compute/concepts/preemptible-vm.md) are used. It may take either the `true` or `false` value.
      * `cpu_utilization_target`: Target CPU utilization level, in %. Use this setting to enable [scaling](../concepts/autoscaling.md) based on CPU utilization. Otherwise, `yarn.cluster.containersPending` will be used as a metric (based on the number of pending resources). The minimum value is `10` and the maximum value is `100`.
      * `decommission_timeout`: [Decommissioning timeout](../concepts/decommission.md) in seconds. The minimum value is `0` and the maximum value is `86400` (24 hours).

      For more information about resources you can create using {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/dataproc_cluster).

   1. Check that the {{ TF }} configuration files are correct:

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Create a {{ dataproc-name }} cluster:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

- API {#api}

   To create a {{ dataproc-name }} cluster, use the [create](../api-ref/Cluster/create) API method and include the following in the request:
   * ID of the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where the {{ dataproc-name }} cluster must reside, in the `folderId` parameter.
   * {{ dataproc-name }} cluster name in the `name` parameter.
   * {{ dataproc-name }} cluster configuration in the `configSpec` parameter, including:
      * [Image version](../concepts/environment.md) in the `configSpec.versionId` parameter.

         {% include [note-light-weight-cluster](../../_includes/data-proc/note-light-weight-cluster.md) %}

         {% note tip %}

         To use the most recent image version, specify `2.0`.

         {% endnote %}

      * Component list in the `configSpec.hadoop.services` parameter.
      * Public part of the SSH key in the `configSpec.hadoop.sshPublicKeys` parameter.
      * Settings of the {{ dataproc-name }} subclusters in the `configSpec.subclustersSpec` parameter.
   * Availability zone of the {{ dataproc-name }} cluster in the `zoneId` parameter.
   * ID of the {{ dataproc-name }} cluster's [service account](../../iam/concepts/users/service-accounts.md) in the `serviceAccountId` parameter.
   * Bucket name in the `bucket` parameter.
   * IDs of the {{ dataproc-name }} cluster's security groups in the `hostGroupIds` parameter.
   * {{ dataproc-name }} cluster deletion protection settings in the `deletionProtection` parameter.

      {% include [Deletion protection limits](../../_includes/mdb/deletion-protection-limits-data.md) %}

   To assign a public IP address to all hosts of a {{ dataproc-name }} subcluster, provide the `true` value in the `configSpec.subclustersSpec.assignPublicIp` parameter.

   To create a {{ dataproc-name }} cluster residing on [groups of dedicated hosts](../../compute/concepts/dedicated-host.md), provide the list of the host group IDs in the `hostGroupIds` parameter.

   {% include [Dedicated hosts note](../../_includes/data-proc/note-dedicated-hosts.md) %}

   To configure {{ dataproc-name }} cluster hosts using [initialization scripts](../concepts/init-action.md), specify them in one or multiple `configSpec.hadoop.initializationActions` parameters.

{% endlist %}

After the {{ dataproc-name }} cluster's status changes to **Running**, you can [connect](connect.md) to the {{ dataproc-name }} subcluster hosts using the specified SSH key.

## Create a {{ dataproc-name }} cluster copy {#duplicate}

You can create a {{ dataproc-name }} cluster with the settings of another cluster created earlier. To do so, you need to import the configuration of the source {{ dataproc-name }} cluster to {{ TF }}. Thus you can either create an identical copy or use the imported configuration as the baseline and modify it as needed. Importing is a convenient option when the source {{ dataproc-name }} cluster has lots of settings (e.g., it is an HDFS cluster) and you need to create a similar one.

To create a {{ dataproc-name }} cluster copy:

{% list tabs group=instructions %}

- {{ TF }} {#tf}

   1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
   1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
   1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
   1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}
   1. In the same working directory, place a `.tf` file with the following contents:

      ```hcl
      resource "yandex_dataproc_cluster" "old" { }
      ```

   1. Write the ID of the initial {{ dataproc-name }} cluster to the environment variable:

      ```bash
      export DATAPROC_CLUSTER_ID=<cluster_ID>
      ```

      You can request the ID with a [list of clusters in the folder](../../data-proc/operations/cluster-list.md#list).

   1. Import the settings of the initial {{ dataproc-name }} cluster into the {{ TF }} configuration:

      ```bash
      terraform import yandex_dataproc_cluster.old ${DATAPROC_CLUSTER_ID}
      ```

   1. Get the imported configuration:

      ```bash
      terraform show
      ```

   1. Copy it from the terminal and paste it into the `.tf` file.
   1. Place the file in the new `imported-cluster` directory.
   1. Edit the copied configuration so that you can create a new {{ dataproc-name }} cluster from it:
      * Specify the name of the new {{ dataproc-name }} cluster in the `resource` string and the `name` parameter.
      * Delete the `created_at`, `host_group_ids`, `id`, and `subcluster_spec.id` parameters.
      * Change the SSH key format in the `ssh_public_keys` parameter. Source format:

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

      * (Optional) Make further modifications if you are looking for more customization.
   1. In the `imported-cluster` directory, [get the authentication data](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials).
   1. In the same directory, [configure and initialize a provider](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). There is no need to create a provider configuration file manually, you can [download it](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
   1. Place the configuration file in the `imported-cluster` directory and [specify the parameter values](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). If you did not add the authentication credentials to environment variables, specify them in the configuration file.
   1. Make sure the {{ TF }} configuration files are correct using this command:

      ```bash
      terraform validate
      ```

      If there are any errors in the configuration files, {{ TF }} will point them out.

   1. Create the required infrastructure:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Example {#example}

### Creating a lightweight {{ dataproc-name }} cluster for Spark and PySpark jobs {#creating-a-light-weight-cluster}

{% list tabs group=instructions %}

- CLI {#cli}

   Create a {{ dataproc-name }} cluster to run Spark jobs without HDFS and data storage subclusters and set the test characteristics:

   * Cluster name: `my-dataproc`
   * Bucket name: `dataproc-bucket`
   * Availability zone: `{{ zone-id }}`
   * Service account: `dataproc-sa`
   * Image version: `2.0`
   * `SPARK` and `YARN` components
   * Path to the public part of the SSH key: `/home/username/.ssh/id_rsa.pub`
   * With the `master` {{ dataproc-name }} subcluster for master hosts and a single `compute` subcluster for processing data:
      * Class: `{{ host-class }}`
      * Network SSD storage (`{{ disk-type-example }}`): 20 GB
      * Subnet: `{{ subnet-name }}`
      * Public access: Allowed

   * Security group: `{{ security-group }}`
   * Protection against accidental {{ dataproc-name }} cluster deletion: Enabled

   Run the following command:

   ```bash
   {{ yc-dp }} cluster create my-dataproc \
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
      --deletion-protection=true
   ```

{% endlist %}
