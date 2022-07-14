# Creating a {{ dataproc-name }} cluster

## Configure a network {#setup-network}

In the subnet that the {{ dataproc-name }} subcluster will connect to with the `Master` role, [enable NAT to the internet](../../vpc/operations/enable-nat.md). This will enable the subcluster to interact with {{ yandex-cloud }} services or hosts on other networks.

## Configure security groups {#change-security-groups}

{% note warning %}

Security groups must be created and configured before creating a cluster. If the selected security groups don't have the required rules, {{ yandex-cloud }} disables cluster creation.

{% endnote %}

1. [Create](../../vpc/operations/security-group-create.md) one or more security groups for cluster service traffic.
1. [Add rules](../../vpc/operations/security-group-update.md#add-rule):

   * One rule for inbound and outbound service traffic:

      * Port range: `{{ port-any }}`.
      * Protocol: `Any`.
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

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create a cluster.

   1. Click **Create resource** and select **{{ dataproc-name }} cluster** from the drop-down list.

   1. Name the cluster in the **Cluster name** field. The cluster name must be unique within the folder. Naming requirements:

      {% include [name-format.md](../../_includes/name-format.md) %}

   1. Select a suitable [image version](../concepts/environment.md) and the services you would like to use in the cluster.

      {% note info %}

      Note that some components require other components to work. For example, to use Spark, you need YARN.

      {% endnote %}

   1. Enter the public part of your SSH key in the **SSH key** field. For information about how to generate and use SSH keys, see the [{{ compute-full-name }} documentation](../../compute/operations/vm-connect/ssh.md).
   1. Select or create a [service account](../../iam/concepts/users/service-accounts.md) to be granted cluster access.
   1. Select the availability zone for the cluster.
   1. If necessary, configure the [properties of cluster components](../concepts/settings-list.md), jobs, and the environment.
   1. If necessary, specify the custom [initialization scripts](../concepts/init-action.md) of cluster hosts. For each script, specify:

      * **uri**: Link to the initialization script in the `https://` or `s3a://` scheme.
      * (Optional) **Timeout**: Script execution timeout (in seconds). The initialization script that runs longer than the specified time will be terminated.
      * (Optional) **Arguments**: Arguments, enclosed in square brackets `[]` and separated by commas, with which an initialization script must be executed, for example:

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

      To enable this functionality, assign the [cluster service account](../../iam/operations/roles/grant.md#access-to-sa) the `logging.writer` role. For more information, see the [{{ cloud-logging-full-name }} documentation](../../logging/security/index.md).

   1. Configure subclusters: no more than one main subcluster with a **Master** host and subclusters for data storage or computing.

      The roles of `Compute` and `Data` subcluster are different: you can deploy data storage components on `Data` subclusters, and data processing components on `Compute` subclusters. Storage on a `Compute` subcluster is only used to temporarily store processed files.

   1. For each subcluster, you can configure:

      * The number of hosts.
      * The [host class](../concepts/instance-types.md), which dictates the platform and computing resources available to the host.
      * [Storage](../concepts/storage.md) size and type.
      * The subnet of the network where the cluster is located.

      NAT to the internet must be enabled in the subnet for the subcluster with the `Master` role. For more information, see [{#T}](#setup-network).

      1. To access subcluster hosts from the internet, select **Public access**. In this case, you can only connect to subcluster hosts over an SSL connection. For more information, see [{#T}](connect.md).

      {% note warning %}

      After you create your cluster, you can't request or disable public access to the subcluster. However, you can delete any subcluster (if its role is not `Master`) and then create it again with a relevant public access setting.

      {% endnote %}

   1. For `Compute` subclusters, you can specify the [autoscaling](../concepts/autoscaling.md) parameters.

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

   1. View a description of the CLI's create cluster command:

      ```bash
      yc dataproc cluster create --help
      ```

   1. Specify cluster parameters in the create command (the list of supported parameters in the example is not exhaustive):

      ```bash
      {{ yc-dp }} cluster create <cluster name> \
        --zone <cluster availability zone> \
        --service-account-name <cluster service account name> \
        --version <image version> \
        --services <component list> \
        --subcluster name=<name of MASTERNODE subcluster>,`
                    `role=masternode,`
                    `resource-preset=<host class>,`
                    `disk-type=<storage type>,`
                    `disk-size=<storage size, GB>,`
                    `subnet-name=<subnet name>,`
                    `hosts-count=1`
                    `assign-public-ip=<assignment of public IP address to subcluster host: true or false> \
        --subcluster name=<name of DATANODE subcluster>,`
                    `role=datanode,`
                    `resource-preset=<host class>,`
                    `disk-type=<storage type>,`
                    `disk-size=<storage size, GB>,`
                    `subnet-name=<subnet name>,`
                    `hosts-count=<host count>,`
                    `assign-public-ip=<assignment of public IP address to all subcluster hosts: true or false> \
        --bucket <bucket name> \
        --ssh-public-keys-file <path to public portion of SSH key> \
        --security-group-ids <security group ID list> \
        --deletion-protection=<cluster deletion protection: true or false> \
        --log-group-id <log group ID>
      ```

      {% include [Deletion protection limits](../../_includes/mdb/deletion-protection-limits-data.md) %}

   1. To create a cluster deployed on [groups of dedicated hosts](../../compute/concepts/dedicated-host.md), specify host IDs as a comma-separated list in the `--host-group-ids` parameter:

      ```bash
      {{ yc-dp }} cluster create <cluster name> \
         ...
        --host-group-ids <IDs of dedicated host groups>
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

      * `uri`: link to the initialization script in the `https://` or `s3a://` scheme.
      * (Optional) `timeout`: Script execution timeout (in seconds). The initialization script that runs longer than the specified time will be terminated.
      * (Optional) `args`: Arguments, enclosed in square brackets and separated by commas, with which an initialization script must be executed.

- Terraform

  {% if audience != "internal" %}

  {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

  {% endif %}

   To create a cluster:

   1. Using the command line, navigate to the folder that will contain the {{ TF }} configuration files with an infrastructure plan. Create the directory if it does not exist.

   {% if audience != "internal" %}

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

   {% endif %}

   1. Create a configuration file with a description of the [service account](../../iam/concepts/users/service-accounts.md) to be granted access to the cluster as well as a description of the [static key](../../iam/concepts/authorization/access-key.md) and [{{ objstorage-full-name }} bucket](../../storage/concepts/bucket.md) to store jobs and output.

      ```hcl
      resource "yandex_iam_service_account" "<name of service account in {{ TF }}>" {
        name        = "<service account name>"
        description = "<service account description>"
      }

      resource "yandex_resourcemanager_folder_iam_binding" "dataproc" {
        role    = "mdb.dataproc.agent"
        members = [
          "serviceAccount:${yandex_iam_service_account.<name of serivce account in {{ TF }}>.id}"
        ]
      }

      resource "yandex_resourcemanager_folder_iam_binding" "bucket-creator" {
        role    = "editor"
        members = [
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

      Example configuration file structure describing a cluster of a single primary data storage subcluster:

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
            name = "<subcluster name>"
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
            name = "<subcluster name>"
            role = "DATANODE"
            resources {
              resource_preset_id = "<host class>"
              disk_type_id       = "<storage type>"
              disk_size          = <storage size, GB>
            }
            subnet_id   = "<subnet ID in {{ TF }}>"
            hosts_count = <number of hosts in subcluster>
          }

          subcluster_spec {
            name = "<subcluster name>"
            role = "COMPUTENODE"
            resources {
              resource_preset_id = "<host class>"
              disk_type_id       = "<storage type>"
              disk_size          = <storage size, GB>
            }
            subnet_id   = "<subnet ID in {{ TF }}>"
            hosts_count = <number of hosts in subcluster>
          }
        }
      }
      ```

      {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

      To access {{ dataproc-name }} [component web interfaces](../concepts/interfaces.md), add a `ui_proxy` field to the cluster description:

      ```hcl
      resource "yandex_dataproc_cluster" "<cluster name in {{ TF }}>" {
        ...
        ui_proxy            = <enable UI Proxy: true or false>
        ...
      }
      ```

      To configure [autoscaling](../concepts/autoscaling.md) for `Compute` subclusters, add a section called `autoscaling_config` with the required settings to the description of the relevant subcluster named `subcluster_spec`:

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

      For more information about the resources that you can create using Terraform, see the [provider documentation]({{ tf-provider-link }}/dataproc_cluster).

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
      * [Image](../concepts/environment.md) version, in the `configSpec.versionId` parameter.
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

   To create a cluster deployed on [groups of dedicated hosts](../../compute/concepts/dedicated-host.md), pass a list of host IDs in the `hostGroupIds` parameter.

   {% include [Dedicated hosts note](../../_includes/data-proc/note-dedicated-hosts.md) %}

   To use [initialization scripts](../concepts/init-action.md) for the initial configuration of cluster hosts, specify them in the `config_spec.hadoop.initialization_actions[]` parameter.

{% endlist %}

After your cluster's status changes to **Running**, you can [connect](connect.md) to the primary subcluster host using the specified SSH key.
