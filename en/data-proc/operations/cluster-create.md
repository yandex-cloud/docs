# Creating a {{ dataproc-name }} cluster

To create a {{ dataproc-name }} cluster, a user must be assigned the `editor` and `dataproc.agent` roles. For more information, see the [role description](../security/index.md#roles-list).


## Configure a network {#setup-network}

Configure access to the internet from the subnet to which the subcluster with a master host will be connected, e.g., using a [NAT gateway](../../vpc/operations/create-nat-gateway.md). This will enable the subcluster to interact with {{ yandex-cloud }} services or hosts on other networks.

## Configure security groups {#change-security-groups}

{% note warning %}

Security groups must be created and configured before creating a cluster. If the selected security groups do not have the required rules, {{ yandex-cloud }} disables cluster creation.

{% endnote %}

1. [Create](../../vpc/operations/security-group-create.md) one or more security groups for cluster service traffic.
1. [Add rules](../../vpc/operations/security-group-add-rule.md):

   * One rule for inbound and another one for outbound service traffic:

      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-any }}`
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` (`Any`)
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**/**{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}`
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-self }}` (`Self`)

   * A separate rule for outgoing HTTPS traffic. This will allow you to use [{{ objstorage-full-name }} buckets](../../storage/concepts/bucket.md), [UI Proxy](../concepts/interfaces.md), and cluster [autoscaling](../concepts/autoscaling.md).

      You can set up this rule using one of the two methods:

      {% list tabs %}

      - To all addresses

         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-https }}`
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_tcp }}`
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`

      - To the addresses used by {{ yandex-cloud }}

         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-https }}`
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_tcp }}`
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**:
            * `84.201.181.26/32`: Getting cluster status, running jobs, UI Proxy
            * `158.160.59.216/32`: Monitoring cluster status, autoscaling
            * `213.180.193.243/32`: Access to {{ objstorage-name }}

      {% endlist %}

   * A rule that allows access to NTP servers for time syncing.

If you plan to use multiple security groups for a cluster, enable all traffic between these groups.

{% note info %}

You can set more detailed rules for security groups, such as allowing traffic in only specific subnets.

Security groups must be configured correctly for all subnets that will include cluster hosts.

{% endnote %}

You can set up security groups for [connections to cluster hosts](connect.md) through an intermediate VM and [connections to {{ metastore-name }}](./metastore/dataproc-connect.md) after creating a cluster.


## Create a cluster {#create}

A cluster must include a subcluster with a master host and at least one subcluster for data storage or processing.

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create a cluster.

   1. Click **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** and select ![image](../../_assets/data-proc/data-proc.svg) **{{ ui-key.yacloud.iam.folder.dashboard.value_data-proc }}** from the drop-down list.

   1. Enter a name for the cluster in the **{{ ui-key.yacloud.mdb.forms.base_field_name }}** field. The naming requirements are as follows:

      * It must be unique within the folder.

      {% include [name-format.md](../../_includes/name-format.md) %}

   1. Select a suitable [image version](../concepts/environment.md) and the services you would like to use in the cluster.

      {% include [note-light-weight-cluster](../../_includes/data-proc/note-light-weight-cluster.md) %}

      {% note tip %}

      To use the most recent image version, specify `2.0`.

      {% endnote %}

   1. Enter the public part of your SSH key in the **{{ ui-key.yacloud.mdb.forms.config_field_public-keys }}** field. For information about how to generate and use SSH keys, see the [{{ compute-full-name }} documentation](../../compute/operations/vm-connect/ssh.md).
   1. Select or create a [service account](../../iam/concepts/users/service-accounts.md) to be granted cluster access. Make sure to [assign](../security/index.md#grant-role) the `dataproc.agent` role to the cluster service account.
   1. Select the availability zone for the cluster.
   1. If required, configure the [properties of cluster components, jobs, and the environment](../concepts/settings-list.md).
   1. If necessary, specify the custom [initialization scripts](../concepts/init-action.md) of cluster hosts. For each script, specify:

      * **{{ ui-key.yacloud.mdb.forms.field_initialization-action-uri }}**: Link to the initialization script in the `https://`, `http://`, `hdfs://`, or `s3a://` scheme.
      * (Optional) **{{ ui-key.yacloud.mdb.forms.field_initialization-action-timeout }}**: Script execution timeout, in seconds. If your initialization script runs longer than this time period, it will be terminated.
      * (Optional) **{{ ui-key.yacloud.mdb.forms.field_initialization-action-args }}**: List of arguments of your initialization script, enclosed in square brackets `[]` and separated by commas, such as:

         ```text
         ["arg1","arg2",...,"argN"]
         ```

   1. Select the name of a bucket in {{ objstorage-full-name }} to store job dependencies and results.
   1. Select a network for the cluster.
   1. Select security groups that have the required permissions.

      {% note warning %}

      When creating a cluster, security group settings are verified. If a cluster cannot function with these settings, a warning is issued. A sample functional configuration is provided [above](#change-security-groups).

      {% endnote %}

   1. Enable the **{{ ui-key.yacloud.mdb.forms.config_field_ui_proxy }}** option to access the [web interfaces of {{ dataproc-name }} components](../concepts/interfaces.md).

   
   1. Cluster logs are saved in [{{ cloud-logging-full-name }}](../../logging/). Select a log group from the list or [create a new one](../../logging/operations/create-group.md).

      To enable this functionality, assign the [cluster service account](../../iam/operations/roles/grant.md#access-to-sa) the `logging.writer` role. For more information, see the [{{ cloud-logging-full-name }} documentation](../../logging/security/index.md).


   1. Configure subclusters: not more than one subcluster with a master host (**Master**) and subclusters for data storage or processing.

      Storage and processing subcluster roles are different: you can deploy data storage components on data storage subclusters and computing components on data processing subclusters. Storage on a data processing subcluster is only used to temporarily store processed files.

      For each subcluster, you can configure:

      * Number of hosts.
      * [Host class](../concepts/instance-types.md): Platform and computing resources available to the host.
      * [Storage](../concepts/storage.md) size and type.
      * Subnet of the network where the cluster is located.

         In the subnet, you need to [set up a NAT gateway](../../vpc/operations/create-nat-gateway.md) for the subcluster with a master host. For more information, see [{#T}](#setup-network).

      * To access subcluster hosts from the internet, select **{{ ui-key.yacloud.mdb.forms.field_assign-public-ip }}**. In this case, you can only connect to subcluster hosts over an SSL connection. For more information, see [{#T}](connect.md).

         {% note warning %}

         After you create your cluster, you cannot request or disable public access to the subcluster. However, you can delete a data processing subcluster and then create it again with a relevant public access setting.

         {% endnote %}

   1. For data processing subclusters, you can specify the [autoscaling](../concepts/autoscaling.md) parameters.

      {% include [note-info-service-account-roles](../../_includes/data-proc/service-account-roles.md) %}

      1. Under **{{ ui-key.yacloud.mdb.forms.label_create-subcluster }}**, click **{{ ui-key.yacloud.mdb.forms.button_configure }}**.
      1. In the **{{ ui-key.yacloud.mdb.forms.base_field_roles }}** field, select `COMPUTENODE`.
      1. Under **{{ ui-key.yacloud.mdb.forms.section_scaling }}**, enable the **{{ ui-key.yacloud.mdb.forms.label_autoscaling-activated }}** setting.
      1. Set autoscaling parameters.
      1. The default metric used for autoscaling is `yarn.cluster.containersPending`. To enable scaling based on CPU usage, disable the **{{ ui-key.yacloud.compute.groups.create.field_default-utilization-target }}** setting and specify the target CPU utilization level.
      1. Click **{{ ui-key.yacloud.mdb.forms.button_add-subcluster }}**.

   1. Configure additional cluster settings, if required:

      **{{ ui-key.yacloud.mdb.forms.label_deletion-protection }}**: Manages cluster protection against inadvertent deletion by a user.

      Enabled protection will not prevent a manual connection to the cluster and deletion of data.

   1. Click **{{ ui-key.yacloud.mdb.forms.button_create }}**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To create a cluster:

   
   1. Check whether the folder has any subnets for the cluster hosts:

      ```bash
      yc vpc subnet list
      ```

      If there are no subnets in the folder, [create the required subnets](../../vpc/operations/subnet-create.md) in {{ vpc-full-name }}.


   1. View a description of the create cluster CLI command:

      ```bash
      {{ yc-dp }} cluster create --help
      ```

   1. Specify cluster parameters in the create command (the list of supported parameters in the example is not exhaustive):

      
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

      It must be unique within the folder. It may contain Latin letters, numbers, hyphens, and underscores. The name may be up to 63 characters long.

      {% endnote %}

      Where:

      * `--bucket`: Name of the bucket in {{ objstorage-full-name }} to store job dependencies and results. The cluster service account must have `READ and WRITE` permissions for this bucket.
      * `--zone`: [Availability zone](../../overview/concepts/geo-scope.md) to host the cluster hosts.
      * `--service-account-name`: Name of the [cluster service account](../../iam/concepts/users/service-accounts.md). Make sure to [assign](../security/index.md#grant-role) the `dataproc.agent` role to the cluster service account.
      * `--version`: [Image version](../concepts/environment.md).

         {% include [note-light-weight-cluster](../../_includes/data-proc/note-light-weight-cluster.md) %}

         {% note tip %}

         To use the most recent image version, set the `--version` parameter value to `2.0`.

         {% endnote %}

      * `--services`: List of [components](../concepts/environment.md) that you want to use in the cluster. If this parameter is omitted, the default set will be used: `hdfs`, `yarn`, `mapreduce`, `tez`, and `spark`.
      * `--ssh-public-keys-file`: Full path to the file with the public part of the SSH key to be used to access the cluster hosts. For information about how to generate and use SSH keys, see the [{{ compute-full-name }} documentation](../../compute/operations/vm-connect/ssh.md).
      * `--subcluster`: Subcluster parameters:
         * `name`: Subcluster name.
         * `role`: Subcluster role (`masternode`, `datanode`, or `computenode`).
         * `resource-preset`: [Host class](../concepts/instance-types.md).
         * `disk-type`: [Storage type](../concepts/storage.md) (`network-ssd`, `network-hdd`, or `network-ssd-nonreplicated`).
         * `disk-size`: Storage size in GB.
         * `subnet-name`: [Name of the subnet](../../vpc/concepts/network.md#subnet).
         * `hosts-count`: Number of hosts in data storage or processing subclusters. The minimum value is `1` and the maximum value is `32`.
         * `assign-public-ip`: Access to subcluster hosts from the internet. It may take either the `true` or `false` value. If access is enabled, you can only connect to the cluster over an SSL connection. For more information, see [{#T}](connect.md).

            {% note warning %}

            After you create your cluster, you cannot request or disable public access to the subcluster. However, you can delete a data processing subcluster and then create it again with a relevant public access setting.

            {% endnote %}

      * `--deletion-protection`: Cluster deletion protection. It may take either the `true` or `false` value.

         {% include [Deletion protection limits](../../_includes/mdb/deletion-protection-limits-data.md) %}

      * `--ui-proxy`: Access to [{{ dataproc-name }} component web interfaces](../concepts/interfaces.md). It may take either the `true` or `false` value.

      
      * `--log-group-id`: [Log group ID](../concepts/logs.md).


      * `--security-group-ids`: List of [security group](../../vpc/concepts/security-groups.md) IDs.

      To create a cluster with multiple data storage or processing subclusters, provide the required number of `--subcluster` arguments in the `cluster create` command:

      ```bash
      {{ yc-dp }} cluster create <cluster name> \
         ...
         --subcluster <subcluster_parameters> \
         --subcluster <subcluster_parameters> \
         ...
      ```

   1. To enable [autoscaling](../concepts/autoscaling.md) in data processing subclusters, specify the following parameters:

      ```bash
      {{ yc-dp }} cluster create <cluster name> \
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

      * `hosts-count`: Minimum number of hosts (VMs) in a subcluster. The minimum value is `1` and the maximum value is `32`.
      * `max-hosts-count`: Maximum number of hosts (VMs) in a subcluster. The minimum value is `1` and the maximum value is `100`.
      * `preemptible`: Indicates if [preemptible VMs](../../compute/concepts/preemptible-vm.md) are used. It may take either the `true` or `false` value.
      * `warmup-duration`: Time required to warm up a VM instance, in `<value>s` format. The minimum value is `0s` and the maximum value is `600s` (10 minutes).
      * `stabilization-duration`: Interval in seconds, during which the required number of instances cannot be decreased, in `<value>s` format. The minimum value is `60s` (1 minute) and the maximum value is `1800s` (30 minutes).
      * `measurement-duration`: Period in seconds, for which utilization measurements should be averaged for each instance, in `<value>s` format. The minimum value is `60s` (1 minute) and the maximum value is `600s` (10 minutes).
      * `cpu-utilization-target`: Target CPU utilization level in percentage. Use this setting to enable [scaling](../concepts/autoscaling.md) based on CPU utilization. Otherwise, `yarn.cluster.containersPending` will be used as a metric (based on the number of pending resources). The minimum value is `10` and the maximum value is `100`.
      * `autoscaling-decommission-timeout`: [Decommissioning timeout](../concepts/decommission.md) in seconds. The minimum value is `0` and the maximum value is `86400` (24 hours).

      {% include [note-info-service-account-roles](../../_includes/data-proc/service-account-roles.md) %}

   
   1. To create a cluster deployed on [dedicated host groups](../../compute/concepts/dedicated-host.md), specify their IDs as a comma-separated list in the `--host-group-ids` parameter:

      ```bash
      {{ yc-dp }} cluster create <cluster name> \
         ...
         --host-group-ids=<IDs_of_groups_of_dedicated_hosts>
      ```

      {% include [Dedicated hosts note](../../_includes/data-proc/note-dedicated-hosts.md) %}


   1. To configure cluster hosts using [initialization scripts](../concepts/init-action.md), specify them in one or more `--initialization-action` parameters:

      ```bash
      {{ yc-dp }} cluster create <cluster name> \
         ...
         --initialization-action uri=<initialization_script_URI>,`
                                `timeout=<script_execution_timeout>,`
                                `args=["arg1","arg2","arg3",...]
      ```

      Where:

      * `URI`: Link to the initialization script in the `https://`, `http://`, `hdfs://`, or `s3a://` scheme.
      * (Optional) `timeout`: Script execution timeout in seconds. If your initialization script runs longer than this time period, it will be terminated.
      * (Optional) `args`: Arguments separated by commas with which an initialization script must be executed.

- {{ TF }} {#tf}

      {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

   To create a cluster:

   1. Using the command line, navigate to the folder that will contain the {{ TF }} configuration files with an infrastructure plan. Create the directory if it does not exist.

   
   1. {% include [terraform-install](../../_includes/terraform-install.md) %}

   1. Create a configuration file describing the [cloud network](../../vpc/concepts/network.md#network) and [subnets](../../vpc/concepts/network.md#subnet).

      The cluster is hosted on a cloud network. If you already have a suitable network, you do not need to describe it again.

      Cluster hosts are located on subnets of the selected cloud network. If you already have suitable subnets, you do not need to describe them again.

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


   1. Create a configuration file with a description of the [service account](../../iam/concepts/users/service-accounts.md) to be granted access to the cluster as well as a description of the [static key](../../iam/concepts/authorization/access-key.md) and [{{ objstorage-full-name }} bucket](../../storage/concepts/bucket.md) to store jobs and results.

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

   1. Create a configuration file with a description of the cluster and its subclusters.

      If necessary, you can also use it to specify the [properties of cluster components, jobs, and the environment](../concepts/settings-list.md).

      See below a sample structure of a configuration file that describes a cluster consisting of a subcluster with a master host, a data storage subcluster, and a data processing subcluster:

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
            # list example: ["HDFS", "YARN", "SPARK", "TEZ", "MAPREDUCE", "HIVE"]
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

      Where `deletion_protection` is cluster deletion protection. It may take either the `true` or `false` value.

      {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

      {% include [note-light-weight-cluster](../../_includes/data-proc/note-light-weight-cluster.md) %}

      {% note tip %}

      To use the most recent image version, set the `version_id` parameter value to `2.0`.

      {% endnote %}

      To access {{ dataproc-name }} [component web interfaces](../concepts/interfaces.md), add the `ui_proxy` field with the `true` value to the cluster description:

      ```hcl
      resource "yandex_dataproc_cluster" "data_cluster" {
        ...
        ui_proxy = true
        ...
      }
      ```

      To configure [autoscaling](../concepts/autoscaling.md) for data processing subclusters, add a section called `autoscaling_config` with the required settings to the description of the relevant `subcluster_spec` subcluster:

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

      * `max_hosts_count`: Maximum number of hosts (VMs) in a subcluster. The minimum value is `1` and the maximum value is `100`.
      * `measurement_duration`: Period, in seconds, for which utilization measurements are averaged for each instance, in `<value>s` format. The minimum value is `60s` (1 minute) and the maximum value is `600s` (10 minutes).
      * `warmup_duration`: Time required to warm up a VM instance, in `<value>s` format. The minimum value is `0s` and the maximum value is `600s` (10 minutes).
      * `stabilization_duration`: Period, in seconds, during which the required number of instances cannot be decreased, in `<value>s` format. The minimum value is `60s` (1 minute) and the maximum value is `1800s` (30 minutes).
      * `preemptible`: Indicates if [preemptible VMs](../../compute/concepts/preemptible-vm.md) are used. It may take either the `true` or `false` value.
      * `cpu_utilization_target`: Target CPU utilization level, in %. Use this setting to enable [scaling](../concepts/autoscaling.md) based on CPU utilization. Otherwise, `yarn.cluster.containersPending` will be used as a metric (based on the number of pending resources). The minimum value is `10` and the maximum value is `100`.
      * `decommission_timeout`: [Decommissioning timeout](../concepts/decommission.md) in seconds. The minimum value is `0` and the maximum value is `86400` (24 hours).

      For more information about resources you can create using {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/dataproc_cluster).

   1. Check the {{ TF }} configuration files for errors:

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Create a cluster:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

- API {#api}

   To create a cluster, use the [create](../api-ref/Cluster/create) API method and include the following in the request:

   * ID of the folder to host the cluster, in the `folderId` parameter.
   * Cluster name in the `name` parameter.
   * Cluster configuration in the `configSpec` parameter, including:
      * [Image version](../concepts/environment.md), in the `configSpec.versionId` parameter.

         {% include [note-light-weight-cluster](../../_includes/data-proc/note-light-weight-cluster.md) %}

         {% note tip %}

         To use the most recent image version, specify `2.0`.

         {% endnote %}

      * Component list, in the `configSpec.hadoop.services` parameter.
      * Public portion of the SSH key, in the `configSpec.hadoop.sshPublicKeys` parameter.
      * Subcluster settings, in the `configSpec.subclustersSpec` parameter.
   * Cluster availability zone, in the `zoneId` parameter.
   * Service account ID, in the `serviceAccountId` parameter.
   * Bucket name, in the `bucket` parameter.
   * Cluster security group IDs, in the `hostGroupIds` parameter.
   * Cluster deletion protection settings in the `deletionProtection` parameter.

      {% include [Deletion protection limits](../../_includes/mdb/deletion-protection-limits-data.md) %}

   To assign a public IP address to all subcluster hosts, provide the `true` value in the `configSpec.subclustersSpec.assignPublicIp` parameter.

   
   To create a cluster deployed on [groups of dedicated hosts](../../compute/concepts/dedicated-host.md), provide a list of host group IDs in the `hostGroupIds` parameter.

   {% include [Dedicated hosts note](../../_includes/data-proc/note-dedicated-hosts.md) %}


   To configure cluster hosts using [initialization scripts](../concepts/init-action.md), specify them in one or more `configSpec.hadoop.initializationActions` parameters.

{% endlist %}

After your cluster's status changes to **Running**, you can [connect](connect.md) to subcluster hosts using the specified SSH key.

## Example {#example}

### Creating a lightweight cluster for Spark and PySpark jobs {#creating-a-light-weight-cluster}

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
   * With the `master` subcluster for master hosts and a single `compute` subcluster for processing data:

      * Class: `{{ host-class }}`
      * Network SSD storage (`{{ disk-type-example }}`): 20 GB
      * Subnet: `{{ subnet-name }}`
      * Public access: Allowed

   * Security group: `{{ security-group }}`
   * Protection against accidental cluster deletion: Enabled

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
