# Creating a {{ dataproc-name }} cluster

To create a {{ dataproc-name }} cluster, the user must be assigned the `editor` and `dataproc.agent` roles. For more information, see the [role description](../security/index.md#roles).

## Configure a network {#setup-network}

In the subnet that the subcluster with master host will connect to, [set up a NAT gateway](../../vpc/operations/create-nat-gateway.md). This will enable the subcluster to interact with {{ yandex-cloud }} services or hosts on other networks.

## Configure security groups {#change-security-groups}

{% note warning %}

Security groups must be created and configured before creating a cluster. If the selected security groups don't have the required rules, {{ yandex-cloud }} disables cluster creation.

{% endnote %}

1. [Create](../../vpc/operations/security-group-create.md) one or more security groups for cluster service traffic.
1. [Add rules](../../vpc/operations/security-group-add-rule.md):

   * One rule for inbound and outbound service traffic:

      * Port range: `{{ port-any }}`.
      * Protocol: ``Any``.
      * Source: `Security group`.
      * Security group: `Self` (`Self`).

   * A separate rule for outgoing HTTPS traffic:

      * Port range: `{{ port-https }}`.
      * Protocol: `TCP`.
      * Source type: `CIDR`.
      * CIDR blocks: `0.0.0.0/0`.

      This will enable you to use [{{ objstorage-full-name }} buckets](../../storage/concepts/bucket.md), [UI Proxy](../concepts/interfaces.md), and cluster [autoscaling](../concepts/autoscaling.md).

If you plan to use multiple security groups for a cluster, enable all traffic between these groups.

{% note info %}

You can set more detailed rules for security groups, such as allowing traffic in only specific subnets.

Security groups must be configured correctly for all subnets that will include cluster hosts.

{% endnote %}

You can set up security groups for [connections to cluster hosts](connect.md) via an intermediate VM after creating a cluster.

## Create a cluster {#create}

A cluster must include a subcluster with a master host and at least one subcluster for data storage or processing.

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create a cluster.

   1. Click **Create resource** and select ![image](../../_assets/data-proc/data-proc.svg) **{{ dataproc-name }} cluster** from the drop-down list.

   1. Name the cluster in the **Cluster name** field. Naming requirements:

      * It must be unique within the folder.

      {% include [name-format.md](../../_includes/name-format.md) %}

   1. Select a suitable [image version](../concepts/environment.md) and the services you would like to use in the cluster.

      {% include [note-light-weight-cluster](../../_includes/data-proc/note-light-weight-cluster.md) %}

      {% note tip %}

      To use the most recent image version, specify `2.0`.

      {% endnote %}

   1. Enter the public part of your SSH key in the **SSH key** field. For information about how to generate and use SSH keys, see the [{{ compute-full-name }} documentation](../../compute/operations/vm-connect/ssh.md).
   1. Select or create a [service account](../../iam/concepts/users/service-accounts.md) to be granted cluster access.
   1. Select the availability zone for the cluster.
   1. If necessary, configure the [properties of cluster components](../concepts/settings-list.md), jobs, and the environment.
   1. If necessary, specify the custom [initialization scripts](../concepts/init-action.md) of cluster hosts. For each script, specify:

      * **URI**: Link to the initialization script in the `https://`, `http://`, `hdfs://`, or `s3a://` scheme.
      * (Optional) **Timeout**: The script execution timeout (in seconds). If your initialization script runs longer than this time, it will be terminated.
      * (Optional) **Arguments**: The list of arguments of your initialization script, enclosed in square brackets `[]` and separated by commas, for example:

         ```text
         ["arg1","arg2",...,"argN"]
         ```

   1. Select the name of a bucket in {{ objstorage-full-name }} to store job dependencies and results.
   1. Select a network for the cluster.
   1. Select security groups that have the required permissions.

      {% note warning %}

      When creating a cluster, security group settings are verified. If a cluster cannot function with these settings, a warning is issued. A sample functional configuration is provided [above](#change-security-groups).

      {% endnote %}

   1. Enable the **UI Proxy** option to access the [web interfaces of {{ dataproc-name }} components](../concepts/interfaces.md).
      
   1. Cluster logs are saved in [{{ cloud-logging-full-name }}](../../logging/). Select a log group from the list or [create a new one](../../logging/operations/create-group.md).

      To enable this functionality, [assign the cluster service account](../../iam/operations/roles/grant.md#access-to-sa) the `logging.writer` role. For more information, see the [{{ cloud-logging-full-name }} documentation](../../logging/security/index.md).

   1. Configure subclusters: no more than one subcluster with a master host (called **Master**) and subclusters for data storage or processing.

      Storage and processing subcluster roles are different: you can deploy data storage components on data storage subclusters and computing components on data processing subclusters. Storage on a data processing subcluster is only used to temporarily store processed files.

   1. For each subcluster, you can configure:

      * The number of hosts.
      * [Host class](../concepts/instance-types.md): The platform and computing resources available to the host.
      * [Storage](../concepts/storage.md) size and type.
      * The subnet of the network where the cluster is located.

      In the subnet, you need to [set up an NAT gateway](../../vpc/operations/create-nat-gateway.md) for the subcluster with the master host. For more information, see [{#T}](#setup-network).

      1. To access subcluster hosts from the internet, select **Public access**. In this case, you can only connect to subcluster hosts over an SSL connection. For more information, see [{#T}](connect.md).

      {% note warning %}

      After you create your cluster, you can't request or disable public access to the subcluster. However, you can delete a data processing subcluster and then create it again with a relevant public access setting.

      {% endnote %}

   1. For data processing subclusters, you can specify the [autoscaling](../concepts/autoscaling.md) parameters.

      {% include [note-info-service-account-roles](../../_includes/data-proc/service-account-roles.md) %}

      1. Under **Add subcluster**, click **Add**.
      1. In the **Roles** field, select `COMPUTENODE`.
      1. Under **Scalability**, enable **Automatic scaling**.
      1. Set autoscaling parameters.
      1. The default metric used for autoscaling is `yarn.cluster.containersPending`. To enable scaling based on CPU usage, disable the **Default scaling** option and set the target CPU utilization level.
      1. Click **Add**.

   1. If necessary, configure additional cluster settings:

      **Deletion protection**: Manages cluster protection from accidental deletion by a user.

      Enabled protection will not prevent a manual connection to a cluster to delete data.

   1. Click **Create cluster**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To create a cluster:

   
   1. Check whether the folder has any subnets for the cluster hosts:

      ```bash
      yc vpc subnet list
      ```

      If there are no subnets in the folder, [create the necessary subnets](../../vpc/operations/subnet-create.md) in {{ vpc-full-name }}.


   1. View a description of the CLI's create cluster command:

      ```bash
      {{ yc-dp }} cluster create --help
      ```

   1. Specify cluster parameters in the create command (the list of supported parameters in the example is not exhaustive):

      
      ```bash
      {{ yc-dp }} cluster create <cluster name> \
         --bucket=<bucket name> \
         --zone=<availability zone> \
         --service-account-name=<cluster service account name> \
         --version=<image version> \
         --services=<component list> \
         --ssh-public-keys-file=<full path to the file with the public part of the SSH key> \
         --subcluster name=<name of subcluster with master host>,`
                     `role=masternode,`
                     `resource-preset=<host class>,`
                     `disk-type=<storage type: network-ssd, network-hdd, or network-ssd-nonreplicated>,`
                     `disk-size=<storage size, GB>,`
                     `subnet-name=<subnet name>,`
                     `assign-public-ip=<public access to subcluster host: true or false> \
         --subcluster name=<name of data storage subcluster>,`
                     `role=datanode,`
                     `resource-preset=<host class>,`
                     `disk-type=<storage type: network-ssd, network-hdd, or network-ssd-nonreplicated>,`
                     `disk-size=<storage size, GB>,`
                     `subnet-name=<subnet name>,`
                     `hosts-count=<host count>,`
                     `assign-public-ip=<public access to subcluster hosts: true or false> \
         --deletion-protection=<cluster deletion protection: true or false> \
         --ui-proxy=<access to component web interfaces: true or false> \
         --security-group-ids=<list of security group IDs> \
         --log-group-id=<log group ID>
      ```



      {% note info %}

      The cluster name must be unique within the folder. It may contain Latin letters, numbers, hyphens, and underscores. The maximum name length is 63 characters.

      {% endnote %}

      Where:

      * `--bucket`: The name of the bucket in {{ objstorage-full-name }} to store job dependencies and results. The cluster service account must have `READ and WRITE` permissions for this bucket.
      * `--zone`: The [availability zone](../../overview/concepts/geo-scope.md) to host the cluster hosts.
      * `--service-account-name`: The name of the [cluster service account](../../iam/concepts/users/service-accounts.md). Be sure to assign the cluster service account the `mdb.dataproc.agent` role.
      * `--version`: The [image version](../concepts/environment.md).

         {% include [note-light-weight-cluster](../../_includes/data-proc/note-light-weight-cluster.md) %}

         {% note tip %}

         To use the most recent image version, set the `--version` parameter value to `2.0`.

         {% endnote %}

      * `--services`: A list of [components](../concepts/environment.md) that you want to use in the cluster. If this parameter is omitted, the default set is used: `hdfs`, `yarn`, `mapreduce`, `tez`, and `spark`.
      * `--ssh-public-keys-file`: The full path to the file with the public part of the SSH key to be used to access the cluster hosts. For information about how to generate and use SSH keys, see the [{{ compute-full-name }} documentation](../../compute/operations/vm-connect/ssh.md).
      * `--subcluster`: Subcluster parameters:
         * `name`: Subcluster name.
         * `role`: Subcluster role (`masternode`, `datanode`, or `computenode`).
         * `resource-preset`: [Host class](../concepts/instance-types.md).
         * `disk-type`: [Storage type](../concepts/storage.md).
         * `disk-size`: Storage size in GB.
         * `subnet-name`: [Name of the subnet](../../vpc/concepts/network.md#subnet).
         * `hosts-count`: Number of hosts in data storage or processing subclusters. The minimum value is `1` and the maximum value is `32`.
         * `assign-public-ip`: Access to subcluster hosts from the internet. This way, you can only connect to the cluster over an SSL connection. For more information, see [{#T}](connect.md).

            {% note warning %}

            After you create your cluster, you can't request or disable public access to the subcluster. However, you can delete a data processing subcluster and then create it again with a relevant public access setting.

            {% endnote %}

      * `--deletion-protection`: Cluster deletion protection.

         {% include [Deletion protection limits](../../_includes/mdb/deletion-protection-limits-data.md) %}

      * `--ui-proxy`: Access to [{{ dataproc-name }} component web interfaces](../concepts/interfaces.md).
      * `--security-group-ids`: List of [security group](../../vpc/concepts/security-groups.md) IDs.
               * `--log-group-id`: [Log group ID](../concepts/logs.md).

      To create a cluster with multiple data storage or processing subclusters, pass the necessary number of `--subcluster` arguments in the cluster create command:

      ```bash
      {{ yc-dp }} cluster create <cluster name> \
         ...
         --subcluster <subcluster parameters> \
         --subcluster <subcluster parameters> \
         ...
      ```

      1. To enable [autoscaling](../concepts/autoscaling.md) in data processing subclusters, specify the following parameters:

         ```bash
         {{ yc-dp }} cluster create <cluster name> \
            ...
            --subcluster name=<subcluster name>,`
                        `role=computenode`
                        `...`
                        `hosts-count=<minimum number of hosts>`
                        `max-hosts-count=<maximum number of hosts>,`
                        `preemptible=<use preemptible VMs: true or false>,`
                        `warmup-duration=<instance warmup period>,`
                        `stabilization-duration=<stabilization period>,`
                        `measurement-duration=<utilization measurement period>,`
                        `cpu-utilization-target=<target CPU utilization level, %>,`
                        `autoscaling-decommission-timeout=<decommissioning timeout, seconds>
         ```

         Where:

         * `hosts-count`: The minimum number of hosts (VMs) in a subcluster. The minimum value is `1` and the maximum value is `32`.
         * `max-hosts-count`: The maximum number of hosts (VMs) in a subcluster. The minimum value is `1` and the maximum value is `100`.
         * `preemptible`: Indicates if [preemptible VMs](../../compute/concepts/preemptible-vm.md) are used.
         * `warmup-duration`: The time required to warm up a VM instance, in `<value>s` format. The minimum value is `0s` and the maximum value is `600s` (10 minutes).
         * `stabilization-duration`: The interval, in seconds, during which the required number of instances can't be decreased, in `<value>s` format. The minimum value is `60s` (1 minute) and the maximum value is `1800s` (30 minutes).
         * `measurement-duration`: The period, in seconds, for which utilization measurements should be averaged for each instance, in `<value>s` format. The minimum value is `60s` (1 minute) and the maximum value is `600s` (10 minutes).
         * `cpu-utilization-target`: The target CPU utilization level, %. Use this setting to enable [scaling](../concepts/autoscaling.md) based on CPU utilization. Otherwise, `yarn.cluster.containersPending` will be used as a metric (based on the number of pending resources). The minimum value is `10` and the maximum value is `100`.
         * `autoscaling-decommission-timeout`: The [decommissioning timeout](../concepts/decommission.md) in seconds. The minimum value is `0` and the maximum value is `86400` (24h).

         {% include [note-info-service-account-roles](../../_includes/data-proc/service-account-roles.md) %}

   
   1. To create a cluster deployed on [groups of dedicated hosts](../../compute/concepts/dedicated-host.md), specify host group IDs as a comma-separated list in the `--host-group-ids` parameter:

      ```bash
      {{ yc-dp }} cluster create <cluster name> \
         ...
         --host-group-ids=<IDs of groups of dedicated hosts>
      ```

      {% include [Dedicated hosts note](../../_includes/data-proc/note-dedicated-hosts.md) %}


   1. To configure cluster hosts using [initialization scripts](../concepts/init-action.md), specify them in one or more `--initialization-action` parameters:

      ```bash
      {{ yc-dp }} cluster create <cluster name> \
         ...
         --initialization-action uri=<initialization script URI>,`
                                `timeout=<script execution timeout>,`
                                `args=["arg1","arg2","arg3",...]
      ```

      Where:

      * `uri`: Link to the initialization script in the `https://`, `http://`, `hdfs://`, or `s3a://` scheme.
      * (Optional) `timeout`: Script execution timeout (in seconds). If your initialization script runs longer than this time, it will be terminated.
      * (Optional) `args`: Arguments, enclosed in square brackets and separated by commas, with which an initialization script must be executed.

- {{ TF }}

      {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   To create a cluster:

   1. Using the command line, navigate to the folder that will contain the {{ TF }} configuration files with an infrastructure plan. Create the directory if it does not exist.

   
   1. If you don't have {{ TF }} yet, [install it and create a configuration file with provider settings](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   1. Create a configuration file describing the [cloud network](../../vpc/concepts/network.md#network) and [subnets](../../vpc/concepts/network.md#subnet).

      The cluster is hosted on a cloud network. If you already have a suitable network, you don't need to describe it again.

      Cluster hosts are located on subnets of the selected cloud network. If you already have suitable subnets, you don't need to describe them again.

      Example structure of a configuration file that describes a cloud network with a single subnet:

      ```hcl
      resource "yandex_vpc_network" "<network name in {{ TF }}>" { name = "<network name>" }

      resource "yandex_vpc_subnet" "<subnet name in {{ TF }}>" {
        name           = "<subnet name>"
        zone           = "<availability zone>"
        network_id     = yandex_vpc_network.<network name in {{ TF }}>.id
        v4_cidr_blocks = ["<subnet>"]
      }
      ```


   1. Create a configuration file with a description of the [service account](../../iam/concepts/users/service-accounts.md) to be granted access to the cluster as well as a description of the [static key](../../iam/concepts/authorization/access-key.md) and [{{ objstorage-full-name }} bucket](../../storage/concepts/bucket.md) to store jobs and results.

      ```hcl
      resource "yandex_iam_service_account" "<name of service account in {{ TF }}>" {
        name        = "<service account name>"
        description = "<service account description>"
      }

      resource "yandex_resourcemanager_folder_iam_binding" "dataproc" {
        folder_id = "<folder ID>"
        role      = "mdb.dataproc.agent"
        members   = [
          "serviceAccount:${yandex_iam_service_account.<name of service account in {{ TF }}>.id}"
        ]
      }

      resource "yandex_resourcemanager_folder_iam_binding" "bucket-creator" {
        folder_id = "<folder ID>"
        role      = "editor"
        members   = [
          "serviceAccount:${yandex_iam_service_account.<name of service account in {{ TF }}>.id}"
        ]
      }

      resource "yandex_iam_service_account_static_access_key" "<name of static key in {{ TF }}>" {
        service_account_id = yandex_iam_service_account.<service account name in {{ TF }}>.id
      }

      resource "yandex_storage_bucket" "<bucket name in {{ TF }}>" {
        depends_on = [
          yandex_resourcemanager_folder_iam_binding.bucket-creator
        ]

        bucket     = "<bucket name>"
        access_key = yandex_iam_service_account_static_access_key.<static key name in {{ TF }}>.access_key
        secret_key = yandex_iam_service_account_static_access_key.<static key name in {{ TF }}>.secret_key
      }
      ```

   1. Create a configuration file with a description of the cluster and its subclusters.

      If necessary, you can also use it to specify the [properties of cluster components, jobs, and the environment](../concepts/settings-list.md).

      Sample structure of a configuration file that describes a cluster consisting of a subcluster with a master host, a data storage subcluster, and a data processing subcluster:

      ```hcl
      resource "yandex_dataproc_cluster" "<cluster name in {{ TF }}>" {
        bucket              = "<bucket name in {{ TF }}>"
        name                = "<cluster name>"
        description         = "<cluster description>"
        service_account_id  = "<service account ID in {{ TF }}>"
        zone_id             = "<availability zone>"
        security_group_ids  = ["<security group ID list>"]
        deletion_protection = <deletion protection: true or false>

        cluster_config {
          version_id = "<image version>"

          hadoop {
            services   = ["<component list>"]
            # Example list: ["HDFS", "YARN", "SPARK", "TEZ", "MAPREDUCE", "HIVE"]
            properties = {
              "<component properties>" = <value>
              ...
            }
            ssh_public_keys = [
              file("${file("<path to file with public SSH key>")}")
            ]
          }

          subcluster_spec {
            name = "<name of subcluster with master host>"
            role = "MASTERNODE"
            resources {
              resource_preset_id = "<host class>"
              disk_type_id       = "<storage type>"
              disk_size          = <storage size, GB>
            }
            subnet_id   = "<subnet ID in {{ TF }}>"
            hosts_count = 1
          }

          subcluster_spec {
            name = "<data storage subcluster name>"
            role = "DATANODE"
            resources {
              resource_preset_id = "<host class>"
              disk_type_id       = "<storage type>"
              disk_size          = <storage size, GB>
            }
            subnet_id   = "<subnet ID in {{ TF }}>"
            hosts_count = <number of subcluster hosts>
          }

          subcluster_spec {
            name = "<data processing subcluster name>"
            role = "COMPUTENODE"
            resources {
              resource_preset_id = "<host class>"
              disk_type_id       = "<storage type>"
              disk_size          = <storage size, GB>
            }
            subnet_id   = "<subnet ID in {{ TF }}>"
            hosts_count = <number of subcluster hosts>
          }
        }
      }
      ```

      {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

      {% include [note-light-weight-cluster](../../_includes/data-proc/note-light-weight-cluster.md) %}

      {% note tip %}

      To use the most recent image version, set the `version_id` parameter value to `2.0`.

      {% endnote %}

      To access {{ dataproc-name }} [component web interfaces](../concepts/interfaces.md), add a `ui_proxy` field to the cluster description:

      ```hcl
      resource "yandex_dataproc_cluster" "<cluster name in {{ TF }}>" {
        ...
        ui_proxy            = <enable UI Proxy: true or false>
        ...
      }
      ```

      To configure [autoscaling](../concepts/autoscaling.md) for data processing subclusters, add a section called `autoscaling_config` with the required settings to the description of the relevant `subcluster_spec` subcluster:

      ```hcl
      subcluster_spec {
        name = "<subcluster name>"
        role = "COMPUTENODE"
        ...
        autoscaling_config {
          max_hosts_count        = <maximum number of VMs in group>
          measurement_duration   = <load measurement interval (seconds)>
          warmup_duration        = <VM warmup time (seconds)>
          stabilization_duration = <stabilization interval (seconds)>
          preemptible            = <use preemptible VMs: true or false>
          cpu_utilization_target = <target vCPU workload, %>
          decommission_timeout   = <VM decommissioning timeout (seconds)>
        }
      }
      ```

      For more information about resources you can create using {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/dataproc_cluster).

   1. Check the {{ TF }} configuration files for errors:

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Create a cluster:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

- API

   To create a cluster, use the API [create](../api-ref/Cluster/create) method and pass the following in the request:

   * ID of the folder to host the cluster, in the `folderId` parameter.
   * The cluster name in the `name` parameter.
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

   To assign a public IP address to all subcluster hosts, pass the `true` value in the `configSpec.subclustersSpec.assignPublicIp` parameter.

   
   To create a cluster deployed on [groups of dedicated hosts](../../compute/concepts/dedicated-host.md), pass a list of host group IDs in the `hostGroupIds` parameter.

   {% include [Dedicated hosts note](../../_includes/data-proc/note-dedicated-hosts.md) %}


   To configure cluster hosts using [initialization scripts](../concepts/init-action.md), specify them in one or more `configSpec.hadoop.initializationActions` parameters.

{% endlist %}

After your cluster's status changes to **Running**, you can [connect](connect.md) to subcluster hosts using the specified SSH key.

## Examples {#examples}

### Creating a lightweight cluster for Spark and PySpark jobs {#creating-a-light-weight-cluster}

{% list tabs %}

- CLI

   Create a {{ dataproc-name }} cluster to run Spark jobs without HDFS and data storage subclusters and set the test characteristics:

   * Cluster name: `my-dataproc`.
   * With a bucket named `dataproc-bucket`.
   * In the `{{ zone-id }}` availability zone.
   * With a service account named `dataproc-sa`.
   * With image version `2.0`.
   * With `SPARK` and `YARN` components.
   * With the path to the public part of the SSH key: `/home/username/.ssh/id_rsa.pub`.
   * With the `master` subcluster for master hosts and a single `compute` subcluster for processing data:

      * Of the `{{ host-class }}` class.
      * With a network SSD storage (`{{ disk-type-example }}`) of 20 GB.
      * In the `{{ subnet-name }}` subnet.
      * With public access.

   * In the security group `{{ security-group }}`.
   * With protection against accidental cluster deletion.

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
