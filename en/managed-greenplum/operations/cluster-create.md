# Creating a {{ GP }} cluster

A {{ mgp-name }} cluster consists of master hosts that accept client requests and segment hosts that provide data processing and storage.

Available disk types [depend](../concepts/storage.md) on the selected [host class](../concepts/instance-types.md).

For more information, see [{#T}](../concepts/index.md).

## How to create a {{ mgp-name }} cluster {#create-cluster}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create a database cluster.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
   1. Click **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
   1. Enter a name for the cluster. It must be unique within the folder.
   1. (Optional) Enter a cluster description.
   1. Select the environment where you want to create the cluster (you cannot change the environment once the cluster is created):
      * `PRODUCTION`: For stable versions of your apps.
      * `PRESTABLE`: For testing purposes. The prestable environment is similar to the production environment and likewise covered by the SLA, but it is the first to get new functionalities, improvements, and bug fixes. In the prestable environment, you can test compatibility of new versions with your application.
   1. Select the {{ GP }} version.

   
   1. (Optional) Select groups of [dedicated hosts](../../compute/concepts/dedicated-host.md) to host the cluster on.

      {% include [Dedicated hosts note](../../_includes/mdb/mgp/note-dedicated-hosts.md) %}

   1. Under **{{ ui-key.yacloud.mdb.forms.section_network }}**:
      * Select the cloud network for the cluster.
      * In the **{{ ui-key.yacloud.mdb.forms.field_security-group }}** parameter, specify the [security group](../operations/connect.md#configuring-security-groups) that contains the rules allowing all incoming and outgoing traffic over any protocol from any IP address.

         {% note alert %}

         For a {{ mgp-name }} cluster to work properly, at least one of its security groups must have rules allowing all incoming and outgoing traffic from any IP address.

         {% endnote %}


         * Select the availability zone and subnet for the cluster. To create a new subnet, click **{{ ui-key.yacloud.common.label_create-new_female }}** next to the availability zone.
         * Select **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}** to allow accessing the cluster from the internet.

   1. If you are not going to export {{ GP }} data to cold storage in {{ objstorage-full-name }}, disable the associated option under **{{ ui-key.yacloud.greenplum.section_cloud-storage }}** (enabled by default).

      This option activates the [{{ YZ }} extension](https://github.com/yezzey-gp/yezzey/) from {{ yandex-cloud }}. This extension is used to export [AO and AOCO tables](../tutorials/yezzey.md) from disks within the {{ mgp-name }} cluster to cold storage in {{ objstorage-name }}. This way, the data will be stored in a service bucket in a compressed and encrypted form. This is a [more cost-efficient storage method](../../storage/pricing.md).

      You cannot disable this option after you save your cluster settings.

      
      {% note info %}

      This functionality is at the [Preview](../../overview/concepts/launch-stages.md) stage and is free of charge.

      {% endnote %}


   1. Specify the admin user settings. This special user is required for managing the cluster and cannot be deleted. For more information, see [{#T}](../concepts/cluster-users.md).

      * **{{ ui-key.yacloud.mdb.forms.database_field_user-login }}** may contain Latin letters, numbers, hyphens, and underscores, and may not start with a hyphen. It must be from 1 to 32 characters long.

         {% note info %}

         Such names as `admin`, `gpadmin`, `mdb_admin`, `mdb_replication`, `monitor`, `none`, `postgres`, `public`, and `repl` are reserved for {{ mgp-name }}. You cannot create users with these names.

         {% endnote %}

      * **{{ ui-key.yacloud.mdb.forms.database_field_user-password }}** must be from 8 to 128 characters long.

   1. Configure additional cluster settings, if required:

      * {% include [Backup time](../../_includes/mdb/console/backup-time.md) %}
      * **{{ ui-key.yacloud.mdb.forms.maintenance-window-type }}**: [Maintenance window](../concepts/maintenance.md) settings:

         {% include [Maintenance window](../../_includes/mdb/console/maintenance-window-description.md) %}

      * {% include [Datalens access](../../_includes/mdb/console/datalens-access.md) %}
      * {% include [DataTransfer access](../../_includes/mdb/console/datatransfer-access.md) %}
      * {% include [Deletion protection](../../_includes/mdb/console/deletion-protection.md) %}

         {% include [Deletion protection limits db](../../_includes/mdb/deletion-protection-limits-db.md) %}

   1. (Optional) Configure the operating mode and [connection pooler](../concepts/pooling.md) parameters under **{{ ui-key.yacloud.mdb.forms.section_pooler }}**:

      {% include [Pooling mode](../../_includes/mdb/mgp/pooling-mode.md) %}

   1. (Optional) Under **{{ ui-key.yacloud.greenplum.section_background-activities }}**, edit the parameters of [scheduled maintenance operations](../concepts/maintenance.md#regular-ops):

      {% include [background activities](../../_includes/mdb/mgp/background-activities-console.md) %}

   1. Specify the master host parameters on the **{{ ui-key.yacloud.greenplum.section_resource-master }}** tab. For the recommended configuration, see [Calculating the cluster configuration](calculate-specs.md#master).

      * [{{ ui-key.yacloud.mdb.forms.section_resource }}](../concepts/instance-types.md): Defines technical properties of the virtual machines on which the cluster master hosts will be deployed.

      * Under **{{ ui-key.yacloud.mdb.forms.section_storage }}**:
         * Select the [disk type](../concepts/storage.md).

            
            {% include [storages-step-settings](../../_includes/mdb/mgp/settings-storages.md) %}


   1. Specify the parameters of segment hosts on the **{{ ui-key.yacloud.greenplum.section_resource-segment }}** tab. For the recommended configuration, see [Calculating the cluster configuration](calculate-specs.md#segment).

      * Number of segment hosts.
      * Number of segments per host. The maximum value of this parameter depends on a host class.
      * [Host class](../concepts/instance-types.md): Defines technical properties of the virtual machines on which the cluster segment hosts will be deployed.
      * Under **{{ ui-key.yacloud.mdb.forms.section_storage }}**:
         * Select the [disk type](../concepts/storage.md).

            
            {% include [storages-step-settings](../../_includes/mdb/mgp/settings-storages.md) %}


   1. If required, configure [DBMS cluster-level settings](../concepts/settings-list.md#dbms-cluster-settings).

   1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To create a cluster:

   
   1. Check whether the folder has any subnets for the cluster hosts:

      ```bash
      yc vpc subnet list
      ```

      If there are no subnets in the folder, [create the required subnets](../../vpc/operations/subnet-create.md) in {{ vpc-short-name }}.


   1. View a description of the create cluster CLI command:

      ```bash
      {{ yc-mdb-gp }} cluster create --help
      ```

   1. Specify cluster parameters in the create command (the list of supported parameters in the example is not exhaustive):

      
      ```bash
      {{ yc-mdb-gp }} cluster create <cluster_name> \
         --greenplum-version=<Greenplum_version> \
         --environment=<environment> \
         --network-name=<network_name> \
         --user-name=<username> \
         --user-password=<user_password> \
         --master-config resource-id=<host_class>,`
                        `disk-size=<storage_size_GB>,`
                        `disk-type=<disk_type> \
         --segment-config resource-id=<host_class>,`
                        `disk-size=<storage_size_GB>,`
                        `disk-type=<disk_type> \
         --zone-id=<availability_zone> \
         --subnet-id=<subnet_ID> \
         --assign-public-ip=<public_access_to_hosts> \
         --security-group-ids=<list_of_security_group_IDs> \
         --deletion-protection=<cluster_deletion_protection>
      ```

      {% note info %}

      The cluster name must be unique within a folder. It may contain Latin letters, numbers, hyphens, and underscores. The name may be up to 63 characters long.

      {% endnote %}

      Where:

      * `--greenplum-version`: {{ GP }} version: {{ versions.cli.str }}.
      * `--environment`: Environment:
         * `PRODUCTION`: For stable versions of your apps.
         * `PRESTABLE`: For testing purposes. The prestable environment is similar to the production environment and likewise covered by the SLA, but it is the first to get new functionalities, improvements, and bug fixes. In the prestable environment, you can test compatibility of new versions with your application.
      * `--network-name`: [Network name](../../vpc/concepts/network.md#network).
      * `--user-name`: Username. It may contain Latin letters, numbers, hyphens, and underscores, and must start with a letter, a number, or an underscore. It must be from 1 to 32 characters long.
      * `--user-password`: Password. It must be from 8 to 128 characters long.
      * `--master-config` and `--segment-config`: Master and segment host configurations:
         * `resource-id`: [Host class](../concepts/instance-types.md).
         * `disk-size`: Storage size in GB.
         * `disk-type`: [Disk type](../concepts/storage.md):
            * `network-hdd`
            * `network-ssd`
            * `local-ssd`
            * `network-ssd-nonreplicated`

      * `zone-id`: [Availability zone](../../overview/concepts/geo-scope.md).
      * `subnet-id`: [Subnet ID](../../vpc/concepts/network.md#subnet). Specify if two or more subnets are created in the selected availability zone.
      * `--assign-public-ip`: Flag to be set if [public access](../concepts/network.md#public-access-to-a-host) to the host is needed, `true` or `false`.
      * `--security-group-ids`: List of [security group](../../vpc/concepts/security-groups.md) IDs.
      * `--deletion-protection`: Cluster deletion protection, `true` or `false`.


           {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

   1. To set a backup start time, pass the desired value in `HH:MM:SS` format in `--backup-window-start`:

      ```bash
      {{ yc-mdb-gp }} cluster create <cluster name> \
         ...
         --backup-window-start=<backup_start_time>
      ```

   
   1. To create a cluster deployed on groups of [dedicated hosts](../../compute/concepts/dedicated-host.md), specify host IDs as a comma-separated list in the `--host-group-ids` parameter:

      ```bash
      {{ yc-mdb-gp }} cluster create <cluster name> \
         ...
         --host-group-ids=<IDs_of_groups_of_dedicated_hosts>
      ```

      {% include [Dedicated hosts note](../../_includes/mdb/mgp/note-dedicated-hosts.md) %}


   1. To set up a [maintenance window](../concepts/maintenance.md) (including for disabled clusters), pass the required value in the `--maintenance-window` parameter when creating your cluster:

      ```bash
      {{ yc-mdb-gp }} cluster create <cluster name> \
         ...
         --maintenance-window type=<maintenance_type>,`
                             `day=<day_of_week>,`
                             `hour=<hour> \
      ```

      Where `type` is the maintenance type:

      {% include [maintenance-window](../../_includes/mdb/cli/maintenance-window-description.md) %}

   1. To allow access from [{{ datalens-full-name }}](../../datalens/concepts/index.md) or [{{ data-transfer-full-name }}](../../data-transfer/), pass the `true` value in the corresponding parameters when creating a cluster:

      ```bash
      {{ yc-mdb-gp }} cluster create <cluster name> \
         ...
         --datalens-access=<access_from_DataLens> \
         --datatransfer-access=<access_from_Data_Transfer>
      ```

      Where:

      * `--datalens-access`: Access from {{ datalens-full-name }}: true or false.
      * `--datatransfer-access`: Access from {{ data-transfer-full-name }}: true or false.

- {{ TF }}

      {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   To create a cluster:

   1. Using the command line, navigate to the folder that will contain the {{ TF }} configuration files with an infrastructure plan. Create the directory if it does not exist.

   
   1. {% include [terraform-install](../../_includes/terraform-install.md) %}

   2. Create a configuration file describing the [cloud network](../../vpc/concepts/network.md#network) and [subnets](../../vpc/concepts/network.md#subnet).

      The cluster is hosted on a cloud network. If you already have a suitable network, you do not need to describe it again.

      Cluster hosts are located on subnets of the selected cloud network. If you already have suitable subnets, you do not need to describe them again.

      Example structure of a configuration file that describes a cloud network with a single subnet:

      ```hcl
      resource "yandex_vpc_network" "<network_name_in_{{ TF }}>" { name = "<network_name>" }

      resource "yandex_vpc_subnet" "<subnet_name_in_{{ TF }}>" {
        name           = "<subnet_name>"
        zone           = "<availability_zone>"
        network_id     = yandex_vpc_network.<network_name_in_{{ TF }}>.id
        v4_cidr_blocks = ["<subnet>"]
      }
      ```


   1. Create a configuration file with a description of the cluster and its hosts.

      Here is an example of the configuration file structure:

      
      ```hcl
      resource "yandex_mdb_greenplum_cluster" "<cluster_name_in_{{ TF }}>" {
        name                = "<cluster_name>"
        environment         = "<environment>"
        network_id          = yandex_vpc_network.<network_name_in_{{ TF }}>.id
        zone                = "<availability_zone>"
        subnet_id           = yandex_vpc_subnet.<subnet_name_in_{{ TF }}>.id
        assign_public_ip    = <public_access_to_cluster_hosts>
        deletion_protection = <cluster_deletion_protection>
        version             = "<Greenplum_version>"
        master_host_count   = <number_of_master_hosts>
        segment_host_count  = <number_of_segment_hosts>
        segment_in_host     = <number_of_segments_per_host>

        master_subcluster {
          resources {
            resource_preset_id = "<host_class>"
            disk_size          = <storage_size_GB>
            disk_type_id       = "<disk_type>"
          }
        }

        segment_subcluster {
          resources {
            resource_preset_id = "<host_class>"
            disk_size          = <storage_size_GB>
            disk_type_id       = "<disk_type>"
          }
        }

        user_name     = "<username>"
        user_password = "<password>"

        security_group_ids = ["<list_of_security_group_IDs>"]
      }
      ```


      Where:

      * `assign_public_ip`: Public access to cluster hosts, true or false.
      * `deletion_protection`: Cluster deletion protection, true or false.
      * `version`: {{ GP }} version.
      * `master_host_count`: Number of master hosts: 1 or 2.
      * `segment_host_count`: Number of segment hosts: between 2 and 32.
      * `disk_size`: Storage size in GB.

      Cluster deletion protection will not prevent a manual connection to delete the contents of a database.

      For more information about the resources you can create with {{ TF }}, see the [provider documentation]({{ tf-provider-mgp }}).

   1. Check the {{ TF }} configuration files for errors:

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Create a cluster:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

- API

   To create a cluster, use the [create](../api-ref/Cluster/create.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Create](../api-ref/grpc/cluster_service.md#Create) gRPC API call and provide the following in the request:

   * ID of the folder where the cluster should be placed, in the `folderId` parameter.
   * Cluster name in the `name` parameter.
   * Cluster environment in the `environment` parameter.
   * {{ GP }} version in the `config.version` parameter.
   * Username in the `userName` parameter.
   * User password in the `userPassword` parameter.
   * Network ID in the `networkId` parameter.
      * [Security group](../concepts/network.md#security-groups) identifiers in the `securityGroupIds` parameter.
   * Configuration of master hosts in the `masterConfig` parameter.
   * Configuration of segment hosts in the `segmentConfig` parameter.

   Provide additional cluster settings, if required:

   * Public access settings in the `assignPublicIp` parameter.
   * Backup window settings in the `config.backupWindowStart` parameter.
   * Settings for access from [{{ datalens-full-name }}](../../datalens/concepts/index.md), in the `config.access.dataLens` parameter.
   * Settings for access from [{{ data-transfer-full-name }}](../../data-transfer/), in the `config.access.dataTransfer` parameter.
   * Settings for the [maintenance window](../concepts/maintenance.md) (including those for disabled clusters) in the `maintenanceWindow` parameter.
   * [DBMS settings](../concepts/settings-list.md#dbms-cluster-settings) in the `configSpec.greenplumConfig_<version>` parameter.
   * [Scheduled maintenance operations](../concepts/maintenance.md#regular-ops) settings in the `configSpec.backgroundActivities.analyzeAndVacuum` parameter.
   * Cluster deletion protection settings in the `deletionProtection` parameter.

      {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

{% endlist %}

## Examples {#examples}

### Creating a cluster {#create-example}

{% list tabs %}

- CLI

   Create a {{ mgp-name }} cluster with the following test characteristics:

   
   * Name: `gp-cluster`
   * Version: `{{ versions.cli.latest }}`
   * Environment: `PRODUCTION`
   * Network: `default`
   * User: `user1`
   * Password: `user1user1`
   * With master and segment hosts:

      * Class: `S2.medium`
      * Local SSD storage (`local-ssd`): 100 GB

   * Availability zone: `{{ region-id }}-a`; subnet: `{{ subnet-id }}`
   * Public access to hosts: Allowed
   * Security group: `{{ security-group }}`
   * Protection against accidental cluster deletion: Enabled


   Run the following command:

   
   ```bash
   {{ yc-mdb-gp }} cluster create \
      --name=gp-cluster \
      --greenplum-version={{ versions.cli.latest }} \
      --environment=PRODUCTION \
      --network-name=default \
      --user-name=user1 \
      --user-password=user1user1 \
      --master-config resource-id=s2.medium,`
                     `disk-size=100,`
                     `disk-type=local-ssd \
      --segment-config resource-id=s2.medium,`
                      `disk-size=100,`
                      `disk-type=local-ssd \
      --zone-id={{ region-id }}-a \
      --subnet-id={{ subnet-id }} \
      --assign-public-ip=true \
      --security-group-ids={{ security-group }} \
      --deletion-protection=true
   ```


{% endlist %}

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
