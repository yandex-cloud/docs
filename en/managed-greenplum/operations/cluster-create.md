# Creating a {{ GP }} cluster


A {{ mgp-name }} cluster consists of master hosts that accept client queries and segment hosts that provide data processing and storage capability.

For more information, see [{#T}](../concepts/index.md).


## Creating a cluster {#create-cluster}


To create a {{ mgp-name }} cluster, you will need the [{{ roles-vpc-user }}](../../vpc/security/index.md#vpc-user) and [{{ roles.mgp.editor }} roles or higher](../security/index.md#roles-list). For more information on assigning roles, see the [{{ iam-name }} documentation](../../iam/operations/roles/grant.md).


{% list tabs group=instructions %}

- Management console {#console}

    To create a {{ mgp-name }} cluster:

    1. In the [management console]({{ link-console-main }}), select the folder where you want to create a database cluster.
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Click **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
    1. Enter a name for the cluster. It must be unique within the folder.
    1. Optionally, enter a description for the cluster.
    1. Select the environment where you want to create your cluster (you cannot change the environment once the cluster is created):
        * `PRODUCTION`: For stable versions of your apps.
        * `PRESTABLE`: For testing purposes. The prestable environment is similar to the production environment and likewise covered by the SLA, but it is the first to get new features, improvements, and bug fixes. In the prestable environment, you can test the new versions for compatibility with your application.
    1. Select the {{ GP }} version.

    
    1. Optionally, to place master hosts or segment hosts on dedicated hosts, select [dedicated host](../../compute/concepts/dedicated-host.md) groups. You can assign groups to one of the two {{ GP }} host types or to both of them at once.

        You must first [create](../../compute/operations/dedicated-host/create-host-group.md) a group of dedicated hosts in {{ compute-full-name }}.

        {% include [Dedicated hosts note](../../_includes/mdb/mgp/note-dedicated-hosts.md) %}


    1. Under **{{ ui-key.yacloud.mdb.forms.section_network }}**, select:

        * [Cloud network](../../vpc/concepts/network.md#network) for the cluster.

        * [Security groups](../../vpc/concepts/security-groups.md) for the cluster network traffic. You may need to additionally [set up security groups](connect.md#configuring-security-groups) to be able connect to the cluster.

        * [Availability zone](../../overview/concepts/geo-scope.md) and [subnet](../../vpc/concepts/network.md#subnet) for the cluster. To create a new subnet, click **{{ ui-key.yacloud.mdb.forms.label_add-subnetwork }}** in the list of subnets.

           {% include [zone-cannot-be-changed](../../_includes/mdb/mgp/zone-cannot-be-changed.md) %}

           {% include [zone-d-disk-restrictions](../../_includes/mdb/ru-central1-d-local-ssd.md) %}

        
        * The **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}** option to enable connecting to the cluster from the internet.


    1. Optionally, enable **{{ ui-key.yacloud.greenplum.section_cloud-storage }}**.

        It enables [hybrid storage](../concepts/hybrid-storage.md). You cannot disable hybrid storage after you save your cluster settings.

        {% include [hybrid-storage-description](../../_includes/mdb/mgp/hybrid-storage-description.md) %}

        
        {% include [Cloud storage Preview](../../_includes/mdb/mgp/cloud-storage-preview.md) %}


    1. Specify the admin user credentials. This special user is required for managing the cluster and cannot be deleted. For more information, see [Users and roles](../concepts/cluster-users.md).

        * **{{ ui-key.yacloud.mdb.forms.database_field_user-login }}** may contain Latin letters, numbers, hyphens, and underscores, but cannot start with a hyphen. It must be from 1 to 32 characters long.

            {% include [reserved-usernames-note](../../_includes/mdb/mgp/reserved-usernames-note.md) %}

        * **{{ ui-key.yacloud.mdb.forms.database_field_user-password }}** must be from 8 to 128 characters long.

    1. Configure additional cluster settings, if required:

        * {% include [Backup time](../../_includes/mdb/console/backup-time.md) %}
        * **{{ ui-key.yacloud.mdb.forms.maintenance-window-type }}**: [Maintenance](../concepts/maintenance.md) window settings:

            {% include [Maintenance window](../../_includes/mdb/console/maintenance-window-description.md) %}

        
        * **{{ ui-key.yacloud.mdb.forms.base_field_service-account }}**: Select an existing service account for accessing {{ yandex-cloud }} services or create a new one.
        * **{{ ui-key.yacloud.logging.field_logging }}**: Enables logging of cluster operations. You pay for log storage according to the {{ cloud-logging-full-name }} pricing policy. For logging, [assign](../../iam/operations/sa/assign-role-for-sa.md) the `logging.writer` role to the service account you selected.

          If you enable this option, configure the logging settings:

          * Specify logging destination:

             * **{{ ui-key.yacloud.common.folder }}**: Log to the default log group for the selected folder.
             * **{{ ui-key.yacloud.logging.label_group }}**: Log either to a new [log group](../../logging/concepts/log-group.md) or one selected from the list.

          * Select the logs you need:

             * **Command Center logs**: Enables [Command Center](../concepts/command-center.md) logs.
             * **Greenplum logs**: Enables {{ GP }} logs. Use [Log min messages](../concepts/settings-list.md#setting-log-min-messages) under **{{ ui-key.yacloud.mdb.forms.section_settings }}** to specify the logging level.


        
        * {% include [Datalens access](../../_includes/mdb/console/datalens-access.md) %}
        * {% include [Query access](../../_includes/mdb/console/query-access.md) %}
        * {% include [WebSQL access](../../_includes/mdb/console/websql-access.md) %}



        * {% include [Deletion protection](../../_includes/mdb/console/deletion-protection.md) %}

            {% include [deletion-protection-limits-data](../../_includes/mdb/deletion-protection-limits-data.md) %}

    1. Optionally, configure the operating mode and [connection pooler](../concepts/pooling.md) parameters under **{{ ui-key.yacloud.mdb.forms.section_pooler }}**:

        {% include [Pooling mode](../../_includes/mdb/mgp/pooling-mode.md) %}

    1. Optionally, under **{{ ui-key.yacloud.greenplum.section_background-activities }}**, edit the parameters of [routine maintenance operations](../concepts/maintenance.md#regular-ops):

        {% include [background activities](../../_includes/mdb/mgp/background-activities-console.md) %}

    1. Specify the master host parameters on the **{{ ui-key.yacloud.greenplum.section_resource-master }}** tab. For the recommended configuration, see [Calculating the cluster configuration](../concepts/calculate-specs.md#master).

        * [{{ ui-key.yacloud.mdb.forms.section_resource }}](../concepts/instance-types.md): Defines technical properties of the virtual machines on which the cluster master hosts will be deployed.

        * Under **{{ ui-key.yacloud.mdb.forms.section_storage }}**, select the [disk type](../concepts/storage.md) and specify its size. Available disk types [depend](../concepts/storage.md) on the selected host class.

          {% include [warn-storage-resize](../../_includes/mdb/mgp/warn-storage-resize.md) %}

    1. Specify the parameters of segment hosts on the **{{ ui-key.yacloud.greenplum.section_resource-segment }}** tab. For the recommended configuration, see [Calculating the cluster configuration](../concepts/calculate-specs.md#segment).

        * Number of segment hosts.
        * [Number of segments per host](../concepts/index.md). The maximum value of this parameter depends on the host class.

            {% include [max-ram-each-process](../../_includes/mdb/mgp/max-ram-each-process.md) %}

        * [Host class](../concepts/instance-types.md): Defines technical properties of the virtual machines on which the cluster segment hosts will be deployed.
        * Under **{{ ui-key.yacloud.mdb.forms.section_storage }}**, select the [disk type](../concepts/storage.md) and specify its size. Available disk types [depend](../concepts/storage.md) on the selected host class.

           {% include [warn-storage-resize](../../_includes/mdb/mgp/warn-storage-resize.md) %}

           * Select the storage size.

    1. If required, configure [DBMS cluster-level settings](../concepts/settings-list.md#dbms-cluster-settings).

    1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To create a {{ mgp-name }} cluster:

    
    1. Check whether the folder has any subnets for the cluster hosts:

        ```bash
        yc vpc subnet list
        ```

        If your folder has no subnets, [create the required ones](../../vpc/operations/subnet-create.md) in {{ vpc-short-name }}.


    1. View the description of the CLI command to create a cluster:

        ```bash
        {{ yc-mdb-gp }} cluster create --help
        ```

    1. Specify cluster parameters in that command (our example does not use all available parameters):

        
        ```bash
        {{ yc-mdb-gp }} cluster create <cluster_name> \
           --greenplum-version=<Greenplum_version> \
           --environment=<environment> \
           --network-name=<network_name> \
           --user-name=<username> \
           --user-password=<user_password> \
           --master-config resource-id=<host_class>,`
                          `disk-size=<storage_size_in_GB>,`
                          `disk-type=<network-hdd|network-ssd|network-ssd-nonreplicated|local-ssd> \
           --segment-config resource-id=<host_class>,`
                          `disk-size=<storage_size_in_GB>,`
                          `disk-type=<network-ssd-nonreplicated|local-ssd> \
           --zone-id=<availability_zone> \
           --subnet-id=<subnet_ID> \
           --assign-public-ip=<allow_public_access_to_cluster_hosts> \
           --security-group-ids=<list_of_security_group_IDs> \
           --deletion-protection
        ```

        {% note info %}

        The cluster name must be unique within a folder. It may contain Latin letters, numbers, hyphens, and underscores. The name may be up to 63 characters long.

        {% endnote %}

        Where:

        * `--greenplum-version`: {{ GP }} version, {{ versions.cli.str }}.
        * `--environment`: Environment:
            * `PRODUCTION`: For stable versions of your apps.
            * `PRESTABLE`: For testing purposes. The prestable environment is similar to the production environment and likewise covered by the SLA, but it is the first to get new features, improvements, and bug fixes. In the prestable environment, you can test the new versions for compatibility with your application.
        * `--network-name`: [Network name](../../vpc/concepts/network.md#network).
        * `--user-name`: Username. It may contain Latin letters, numbers, hyphens, and underscores, and must start with a letter, number, or underscore. It must be from 1 to 32 characters long.
        * `--user-password`: Password. It must be from 8 to 128 characters long.
        * `--master-config` and `--segment-config`: Master and segment host configuration:
            * `resource-id`: [Host class](../concepts/instance-types.md).

                {% include [max-ram-each-process](../../_includes/mdb/mgp/max-ram-each-process.md) %}

            * `disk-size`: Storage size in GB.
            * `disk-type`: [Disk type](../concepts/storage.md):
                * `network-hdd` (for master hosts only)
                * `network-ssd` (for master hosts only)
                * `local-ssd`
                * `network-ssd-nonreplicated`.

        * `--zone-id`: [Availability zone](../../overview/concepts/geo-scope.md).
        * `--subnet-id`: [Subnet ID](../../vpc/concepts/network.md#subnet). You need to specify the ID if the selected availability zone has two or more subnets.
        * `--assign-public-ip`: Flag used if [public access](../concepts/network.md#public-access-to-a-host) to the hosts is required, `true` or `false`.
        * `--security-group-ids`: List of [security group](../../vpc/concepts/security-groups.md) IDs.
        * {% include [Deletion protection](../../_includes/mdb/cli/deletion-protection.md) %}


            {% include [deletion-protection-limits-data](../../_includes/mdb/deletion-protection-limits-data.md) %}

    1. To set the start time for the backup, provide the required value in `HH:MM:SS` format under `--backup-window-start`:

        ```bash
        {{ yc-mdb-gp }} cluster create <cluster_name> \
           ...
           --backup-window-start=<backup_start_time>
        ```

    
    1. Optionally, to create a cluster based on [dedicated host](../../compute/concepts/dedicated-host.md) groups, specify their IDs as a comma-separated list in the `--master-host-group-ids` and `--segment-host-group-ids` parameters:

        ```bash
        {{ yc-mdb-gp }} cluster create <cluster_name> \
           ...
           --master-host-group-ids=<IDs_of_dedicated_host_groups_for_master_hosts> \
           --segment-host-group-ids=<IDs_of_dedicated_host_groups_for_segment_hosts>
        ```

        You can assign groups to one of the two {{ GP }} host types or to both of them at once.

        You must first [create](../../compute/operations/dedicated-host/create-host-group.md) a group of dedicated hosts in {{ compute-full-name }}.

        {% include [Dedicated hosts note](../../_includes/mdb/mgp/note-dedicated-hosts.md) %}


    1. To set up a [maintenance](../concepts/maintenance.md) window (including for disabled clusters), provide the relevant value in the `--maintenance-window` parameter when creating your cluster:

        ```bash
        {{ yc-mdb-gp }} cluster create <cluster_name> \
           ...
           --maintenance-window type=<maintenance_type>,`
                               `day=<day_of_week>,`
                               `hour=<hour> \
        ```

        Where `type` is the maintenance type:

        {% include [maintenance-window](../../_includes/mdb/cli/maintenance-window-description.md) %}

    
    1. To allow access to the cluster from different services, provide the `true` value in the relevant parameters when creating the cluster:

        ```bash
        {{ yc-mdb-gp }} cluster create <cluster_name> \
           ...
           --datalens-access=<allow_access_from_{{ datalens-name }}> \
           --yandexquery-access=<allow_access_from_Yandex_Query> \
           --websql-access=<allow_access_from_{{ websql-name }}>
        ```

        Available services:

        * `--datalens-access`: [{{ datalens-full-name }}](../../datalens/concepts/index.md)
        * `--yandexquery-access`: [{{ yq-full-name }}](../../query/concepts/index.md)
        * `--websql-access`: [{{ websql-full-name }}](../../websql/concepts/index.md)



    
    1. To enable [transferring logs to {{ cloud-logging-full-name }}](mgp-to-cloud-logging.md), specify the following parameters when creating the cluster:

        ```bash
        {{ yc-mdb-gp }} cluster create <cluster_name> \
           ...
           --service-account <service_account_ID> \
           --log-enabled \
           --log-command-center-enabled \
           --log-greenplum-enabled \
           --log-pooler-enabled \
           --log-folder-id <folder_ID>
        ```

        Where:

        * `--service-account`: Service account ID.
        * `--log-enabled`: Enables log transfer.
        * `--log-command-center-enabled`: Transferring [Command Center](../concepts/command-center.md) logs.
        * `--log-greenplum-enabled`: Transferring {{ GP }} logs.
        * `--log-pooler-enabled`: Transferring [connection pooler](../concepts/pooling.md) logs.
        * `--log-folder-id`: Specify the ID of the folder whose log group you want to use.
        * `--log-group-id`: ID of the log group to write logs to.

            Specify either `--log-folder-id` or `--log-group-id`.


- {{ TF }} {#tf}

  
  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}


  To create a {{ mgp-name }} cluster:

  1. In the command line, navigate to the directory that contains the {{ TF }} configuration files with the infrastructure plan. If there is no such a directory, create one.

  
  1. {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Create a configuration file describing the [cloud network](../../vpc/concepts/network.md#network) and [subnets](../../vpc/concepts/network.md#subnet).

      The cluster is hosted on a cloud network. If you already have a suitable network, you do not need to describe it again.

      Cluster hosts are located on subnets of the selected cloud network. If you already have suitable subnets, you do not need to describe them again.

      Below is an example structure of a configuration file describing a single-subnet cloud network:

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
        assign_public_ip    = <allow_public_access_to_cluster_hosts>
        deletion_protection = <protect_cluster_from_deletion>
        version             = "<Greenplum_version>"
        master_host_count   = <number_of_master_hosts>
        segment_host_count  = <number_of_segment_hosts>
        segment_in_host     = <number_of_segments_per_host>
        master_subcluster {
          resources {
            resource_preset_id = "<host_class>"
            disk_size          = <storage_size_in_GB>
            disk_type_id       = "<disk_type>"
          }
        }
        segment_subcluster {
          resources {
            resource_preset_id = "<host_class>"
            disk_size          = <storage_size_in_GB>
            disk_type_id       = "<disk_type>"
          }
        }

        access {
          data_lens    = <allow_access_from_{{ datalens-name }}>
          yandex_query = <allow_access_from_Yandex_Query>
        }

        user_name     = "<username>"
        user_password = "<password>"

        security_group_ids = ["<list_of_security_group_IDs>"]
      }
      ```




      Where:

      * `assign_public_ip`: Public access to cluster hosts, `true` or `false`.
      * `deletion_protection`: Cluster protection from accidental deletion, `true` or `false`.

          {% include [deletion-protection-limits-data](../../_includes/mdb/deletion-protection-limits-data.md) %}

      * `version`: {{ GP }} version.
      * `master_host_count`: Number of master hosts, 2.
      * `segment_host_count`: Number of segment hosts, between 2 and 32.
      * `segment_in_host`: [Number of segments per host](../concepts/index.md). The maximum value of this parameter depends on the host class.

          {% include [max-ram-each-process](../../_includes/mdb/mgp/max-ram-each-process.md) %}

      
      * `access.data_lens`: Access to the cluster from [{{ datalens-full-name }}](../../datalens/concepts/index.md), `true` or `false`.

      * `access.yandex_query`: Access to the cluster from [{{ yq-full-name }}](../../query/concepts/index.md), `true` or `false`.



      For more information about the resources you can create with {{ TF }}, see [this provider article]({{ tf-provider-mgp }}).

  
  1. Optionally, specify [dedicated host](../../compute/concepts/dedicated-host.md) groups to place master or segment hosts on dedicated hosts:

      ```hcl
      resource "yandex_mdb_greenplum_cluster" "<cluster_name_in_{{ TF }}>" {
        ...
        master_host_group_ids = [<IDs_of_dedicated_host_groups_for_master_hosts>]
        segment_host_group_ids = [<IDs_of_dedicated_host_groups_for_segment_hosts>]
        ...
      }
      ```

      You can assign groups to one of the two {{ GP }} host types or to both of them at once.

      You must first [create](../../compute/operations/dedicated-host/create-host-group.md) a group of dedicated hosts in {{ compute-full-name }}.

      {% include [Dedicated hosts note](../../_includes/mdb/mgp/note-dedicated-hosts.md) %}

  1. To enable [transferring logs to {{ cloud-logging-full-name }}](mgp-to-cloud-logging.md), specify the following parameters:

      ```hcl
      resource "yandex_mdb_greenplum_cluster" "<cluster_name_in_{{ TF }}>" {
        ...
        service_account_id="<service_account_ID>"
        logging {
          enabled                = <enable_transferring_logs>
          command_center_enabled = <transfer_Yandex_Command_Center_logs>
          greenplum_enabled      = <transfer_{{ GP }}_logs>
          pooler_enabled         = <transfer_connection_pooler_logs>
          folder_id              = "<folder_ID>"
        }
      }
      ```

      Where:

      * `service_account_id`: Service account ID.
      * `logging`: Log transfer settings:

          * `enabled`: Enables log transfer, `true` or `false`.
          * `command_center_enabled`: Transferring [Command Center](../concepts/command-center.md) logs, `true` or `false`.
          * `greenplum_enabled`: Transferring {{ GP }} logs, `true` or `false`.
          * `pooler_enabled`: Transferring [connection pooler](../concepts/pooling.md) logs, `true` or `false`.
          * `folder_id`: Specify the ID of the folder whose log group you want to use.
          * `log_group_id`: ID of the log group to write logs to.

              Specify either `folder_id` or `log_group_id`.


  1. Make sure the {{ TF }} configuration files are correct:

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Create your cluster:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and save it as an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Create a file named `body.json` and paste the following code into it:

        
        ```json
        {
          "folderId": "<folder_ID>",
          "name": "<cluster_name>",
          "environment": "<environment>",
          "config": {
            "version": "<{{ GP }}_version>",
            "access": {
              "dataLens": <allow_access_from_{{ datalens-name }}>,
              "yandexQuery": <allow_access_from_Yandex_Query>
            },
            "zoneId": "<availability_zone>",
            "subnetId": "<subnet_ID>",
            "assignPublicIp": <enable_public_access_to_cluster_hosts>
          },
          "masterConfig": {
            "resources": {
              "resourcePresetId": "<host_class>",
              "diskSize": "<storage_size_in_bytes>",
              "diskTypeId": "<disk_type>"
            }
          },
          "segmentConfig": {
            "resources": {
              "resourcePresetId": "<host_class>",
              "diskSize": "<storage_size_in_bytes>",
              "diskTypeId": "<disk_type>"
            }
          },
          "masterHostCount": "<number_of_master_hosts>",
          "segmentHostCount": "<number_of_segment_hosts>",
          "segmentInHost": "<number_of_segments_per_host>",
          "userName": "<username>",
          "userPassword": "<user_password>",
          "networkId": "<network_ID>",
          "securityGroupIds": [
              "<security_group_1_ID>",
              "<security_group_2_ID>",
              ...
              "<security_group_N_ID>"
          ],
          "deletionProtection": <protect_cluster_from_deletion>,
          "configSpec": {
            "pool": {
              "mode": "<operation_mode>",
              "size": "<number_of_client_connections>",
              "clientIdleTimeout": "<client_timeout>"
            }
          },
          "cloudStorage": {
            "enable": <use_hybrid_storage>
          },
          "masterHostGroupIds": [
            "string"
          ],
          "segmentHostGroupIds": [
            "string"
          ],
          "serviceAccountId": "<service_account_ID>",
          "logging": {
            "enabled": "<enable_transferring_logs>",
            "commandCenterEnabled": "<transfer_Yandex_Command_Center_logs>",
            "greenplumEnabled": "<transfer_{{ GP }}_logs>",
            "poolerEnabled": "<transfer_connection_pooler_logs>",
            "folderId": "<folder_ID>"
          }
        }
        ```




        Where:

        * `folderId`: Folder ID. You can request it with the [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).
        * `name`: Cluster name.
        * `environment`: Cluster environment, `PRODUCTION` or `PRESTABLE`.
        * `config`: Cluster settings:

            * `version`: {{ GP }} version.

            
            * `access`: Cluster settings for access to the following {{ yandex-cloud }} services:

                * `dataLens`: [{{ datalens-full-name }}](../../datalens/index.yaml), `true` or `false`.
                * `yandexQuery`: [{{ yq-full-name }}](../../query/concepts/index.md), `true` or `false`.



            * `zoneId`: [Availability zone](../../overview/concepts/geo-scope.md).
            * `subnetId`: [Subnet](../../vpc/concepts/network.md#subnet) ID.
            * `assignPublicIp`: Public access to cluster hosts, `true` or `false`.

        * `masterConfig.resources`, `segmentConfig.resources`: Master and segment host configuration in the cluster:

            * `resourcePresetId`: [Host class](../concepts/instance-types.md).
            * `diskSize`: Disk size in bytes.
            * `diskTypeId`: [Disk type](../concepts/storage.md).

        * `masterHostCount`: Number of master hosts, `1` or `2`.
        * `segmentHostCount`: Number of segment hosts, from `2` to `32`.
        * `segmentInHost`: [Number of segments per host](../concepts/index.md). The maximum value of this parameter depends on the host class.

            {% include [max-ram-each-process](../../_includes/mdb/mgp/max-ram-each-process.md) %}

        * `userName`: Username.
        * `userPassword`: User password.
        * `networkId`: ID of the [network](../../vpc/concepts/network.md#network) the cluster will be in.

        
        * `securityGroupIds`: [Security group](../concepts/network.md#security-groups) IDs.


        * `deletionProtection`: Cluster protection from accidental deletion, `true` or `false`.

            {% include [deletion-protection-limits-data](../../_includes/mdb/deletion-protection-limits-data.md) %}

        * `configSpec.pool`: [Connection pooler](../concepts/pooling.md) settings:

            * `mode`: Operation mode, `SESSION` or `TRANSACTION`.
            * `size`: Maximum number of client connections.
            * `clientIdleTimeout`: Idle timeout for a client connection (in seconds).

        * `cloudStorage.enable`: Use of hybrid storage in clusters with {{ GP }} 6.25 or higher. Set it to `true` to enable the {{ yandex-cloud }} [{{ YZ }}](https://github.com/yezzey-gp/yezzey/) extension in a cluster. This extension is used to export [AO and AOCO tables](../tutorials/yezzey.md) from disks within the {{ mgp-name }} cluster to a cold storage in {{ objstorage-full-name }}. This way, the data will be stored in a service bucket in a compressed and encrypted form. This is a [more cost-efficient storage method](../../storage/pricing.md).

            You cannot disable hybrid storage after you save your cluster settings.

            
            {% include [Cloud storage Preview](../../_includes/mdb/mgp/cloud-storage-preview.md) %}


        
        * `masterHostGroupIds` and `segmentHostGroupIds`: Optionally, IDs of [dedicated host](../../compute/concepts/dedicated-host.md) groups for master and segment hosts.

            You must first [create](../../compute/operations/dedicated-host/create-host-group.md) a group of dedicated hosts in {{ compute-full-name }}.

            {% include [Dedicated hosts note](../../_includes/mdb/mgp/note-dedicated-hosts.md) %}

        * `serviceAccountId`: Service account ID.
        * `logging`: Settings for [transferring logs to {{ cloud-logging-full-name }}](mgp-to-cloud-logging.md):

            * `enabled`: Enables log transfer, `true` or `false`.
            * `commandCenterEnabled`: Transferring [Command Center](../concepts/command-center.md) logs, `true` or `false`.
            * `greenplumEnabled`: Transferring {{ GP }} logs, `true` or `false`.
            * `poolerEnabled`: Transferring [connection pooler](../concepts/pooling.md) logs, `true` or `false`.
            * `folderId`: Specify the ID of the folder whose log group you want to use.
            * `logGroupId`: ID of the log group to write logs to.

                Specify either `folderId` or `logGroupId`.


    1. Use the [Cluster.Create](../api-ref/Cluster/create.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-greenplum/v1/clusters' \
            --data "@body.json"
        ```

    1. View the [server response](../api-ref/Cluster/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and save it as an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Create a file named `body.json` and paste the following code into it:

        
        ```json
        {
          "folder_id": "<folder_ID>",
          "name": "<cluster_name>",
          "environment": "<environment>",
          "config": {
            "version": "<{{ GP }}_version>",
            "access": {
              "data_lens": <allow_access_from_{{ datalens-name }}>,
              "yandex_query": <allow_access_from_Yandex_Query>
            },
            "zone_id": "<availability_zone>",
            "subnet_id": "<subnet_ID>",
            "assign_public_ip": <enable_public_access_to_cluster_hosts>
          },
          "master_config": {
            "resources": {
              "resource_preset_id": "<host_class>",
              "disk_size": "<storage_size_in_bytes>",
              "disk_type_id": "<disk_type>"
            }
          },
          "segment_config": {
            "resources": {
              "resource_preset_id": "<host_class>",
              "disk_size": "<storage_size_in_bytes>",
              "disk_type_id": "<disk_type>"
            }
          },
          "master_host_count": "<number_of_master_hosts>",
          "segment_host_count": "<number_of_segment_hosts>",
          "segment_in_host": "<number_of_segments_per_host>",
          "user_name": "<username>",
          "user_password": "<user_password>",
          "network_id": "<network_ID>",
          "security_group_ids": [
              "<security_group_1_ID>",
              "<security_group_2_ID>",
              ...
              "<security_group_N_ID>"
          ],
          "deletion_protection": <protect_cluster_from_deletion>
          "config_spec": {
            "pool": {
              "mode": "<operation_mode>",
              "size": "<number_of_client_connections>",
              "client_idle_timeout": "<client_timeout>"
            }
          },
          "cloud_storage": {
            "enable": <use_hybrid_storage>
          },
          "master_host_group_ids": [
            "string"
          ],
          "segment_host_group_ids": [
            "string"
          ],
          "service_account_id": "<service_account_ID>",
          "logging": {
            "enabled": "<enable_transferring_logs>",
            "command_center_enabled": "<transfer_Yandex_Command_Center_logs>",
            "greenplum_enabled": "<transfer_{{ GP }}_logs>",
            "pooler_enabled": "<transfer_connection_pooler_logs>",
            "folder_id": "<folder_ID>"
          }
        }
        ```




        Where:

        * `folder_id`: Folder ID. You can request it with the [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).
        * `name`: Cluster name.
        * `environment`: Cluster environment, `PRODUCTION` or `PRESTABLE`.
        * `config`: Cluster settings:

            * `version`: {{ GP }} version.

            
            * `access`: Cluster settings for access to the following {{ yandex-cloud }} services:

                * `data_lens`: [{{ datalens-full-name }}](../../datalens/index.yaml), `true` or `false`.
                * `yandex_query`: [{{ yq-full-name }}](../../query/concepts/index.md), `true` or `false`.



            * `zone_id`: [Availability zone](../../overview/concepts/geo-scope.md).
            * `subnet_id`: [Subnet](../../vpc/concepts/network.md#subnet) ID.
            * `assign_public_ip`: Public access to cluster hosts, `true` or `false`.

        * `master_config.resources`, `segment_config.resources`: Master and segment host configuration in the cluster:

            * `resource_preset_id`: [Host class](../concepts/instance-types.md).
            * `disk_size`: Disk size in bytes.
            * `disk_type_id`: [Disk type](../concepts/storage.md).

        * `master_host_count`: Number of master hosts, `1` or `2`.
        * `segment_host_count`: Number of segment hosts, from `2` to `32`.
        * `segment_in_host`: [Number of segments per host](../concepts/index.md). The maximum value of this parameter depends on the host class.

            {% include [max-ram-each-process](../../_includes/mdb/mgp/max-ram-each-process.md) %}

        * `user_name`: Username.
        * `user_password`: User password.
        * `network_id`: ID of the [network](../../vpc/concepts/network.md#network) the cluster will be in.

        
        * `security_group_ids`: [Security group](../concepts/network.md#security-groups) IDs.


        * `deletion_protection`: Cluster protection from accidental deletion, `true` or `false`.

            {% include [deletion-protection-limits-data](../../_includes/mdb/deletion-protection-limits-data.md) %}

        * `config_spec.pool`: [Connection pooler](../concepts/pooling.md) settings:

            * `mode`: Operation mode, `SESSION` or `TRANSACTION`.
            * `size`: Maximum number of client connections.
            * `client_idle_timeout`: Idle timeout for a client connection (in seconds).

        * `cloud_storage.enable`: Use of hybrid storage in clusters with {{ GP }} 6.25 or higher. Set it to `true` to enable the {{ yandex-cloud }} [{{ YZ }}](https://github.com/yezzey-gp/yezzey/) extension in a cluster. This extension is used to export [AO and AOCO tables](../tutorials/yezzey.md) from disks within the {{ mgp-name }} cluster to a cold storage in {{ objstorage-full-name }}. This way, the data will be stored in a service bucket in a compressed and encrypted form. This is a [more cost-efficient storage method](../../storage/pricing.md).

            You cannot disable hybrid storage after you save your cluster settings.

            
            {% include [Cloud storage Preview](../../_includes/mdb/mgp/cloud-storage-preview.md) %}


        
        * `master_host_group_ids` and `segment_host_group_ids`: Optionally, IDs of [dedicated host](../../compute/concepts/dedicated-host.md) groups for master and segment hosts.

            You must first [create](../../compute/operations/dedicated-host/create-host-group.md) a group of dedicated hosts in {{ compute-full-name }}.

            {% include [Dedicated hosts note](../../_includes/mdb/mgp/note-dedicated-hosts.md) %}

        * `service_account_id`: Service account ID.
        * `logging`: Settings for [transferring logs to {{ cloud-logging-full-name }}](mgp-to-cloud-logging.md):

            * `enabled`: Enables log transfer, `true` or `false`.
            * `command_center_enabled`: Transferring [Command Center](../concepts/command-center.md) logs, `true` or `false`.
            * `greenplum_enabled`: Transferring {{ GP }} logs, `true` or `false`.
            * `pooler_enabled`: Transferring [connection pooler](../concepts/pooling.md) logs, `true` or `false`.
            * `folder_id`: Specify the ID of the folder whose log group you want to use.
            * `log_group_id`: ID of the log group to write logs to.

                Specify either `folder_id` or `log_group_id`.


    1. Use the [ClusterService.Create](../api-ref/grpc/Cluster/create.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/greenplum/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d @ \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.greenplum.v1.ClusterService.Create \
            < body.json
        ```

    1. View the [server response](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Creating a cluster copy {#duplicate}

You can create a {{ GP }} cluster using the settings of another one created earlier. To do so, import the {{ GP }} source cluster configuration to {{ TF }}. This way, you can either create an identical copy or use the configuration you imported as the baseline and modify it as needed. Importing a configuration is a good idea when a {{ GP }} source cluster has a lot of settings and you need to create a similar one.

To create a {{ GP }} cluster copy:

{% list tabs group=instructions %}

- {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

    1. In the same working directory, place a `.tf` file with the following contents:

        ```hcl
        resource "yandex_mdb_greenplum_cluster" "old" { }
        ```

    1. Write the ID of the initial {{ GP }} cluster to the environment variable:

        ```bash
        export GREENPLUM_CLUSTER_ID=<cluster_ID>
        ```

        You can request the ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. Import the settings of the initial {{ GP }} cluster into the {{ TF }} configuration:

        ```bash
        terraform import yandex_mdb_greenplum_cluster.old ${GREENPLUM_CLUSTER_ID}
        ```

    1. Get the imported configuration:

        ```bash
        terraform show
        ```

    1. Copy it from the terminal and paste it into the `.tf` file.
    1. Place the file in the new `imported-cluster` directory.
    1. Edit the copied configuration so that you can create a new cluster from it:

        * Specify the new cluster name in the `resource` string and the `name` parameter.
        * Delete the `created_at`, `health`, `id`, `status`, `master_hosts`, and `segment_hosts` parameters.
        * Add the `user_password` parameter.
        * If the `maintenance_window` section has `type = "ANYTIME"`, delete the `hour` parameter.
        * Optionally, make further changes if you need to customize the configuration.

    1. [Get the authentication credentials](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials) in the `imported-cluster` directory.

    1. In the same directory, [configure and initialize a provider](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). To avoid creating a configuration file with provider settings manually, [download it](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).

    1. Place the configuration file in the `imported-cluster` directory and [specify the parameter values](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). If you did not add the authentication credentials to environment variables, specify them in the configuration file.

    1. Check that the {{ TF }} configuration files are correct:

        ```bash
        terraform validate
        ```

        {{ TF }} will display any configuration errors detected in your files.

    1. Create the required infrastructure:

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Examples {#examples}

### Creating a cluster {#create-example}

{% list tabs group=instructions %}

- CLI {#cli}

    Create a {{ mgp-name }} cluster with the following test specifications:

    
    * Name: `gp-cluster`
    * Version: `{{ versions.cli.latest }}`.
    * Environment: `PRODUCTION`.
    * Network: `default`
    * User: `user1`.
    * Password: `user1user1`.
    * Master and segment hosts:

        * Class: `s2.medium`.
        * With 100 GB local SSD (`local-ssd`) storage

    * Availability zone: `{{ region-id }}-a`; subnet: `{{ subnet-id }}`.
    * With public access to hosts.
    * Security group: `{{ security-group }}`.
    * Deletion protection: Enabled.


    Run this command:

    
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
       --deletion-protection
    ```


{% endlist %}

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
