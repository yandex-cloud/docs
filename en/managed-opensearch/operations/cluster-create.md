---
title: Creating an {{ OS }} cluster
description: A cluster in Yandex Managed Service for {{ OS }} is a group of multiple interlinked {{ OS }} hosts.
keywords:
  - Creating an OpenSearch cluster
  - OpenSearch cluster
  - OpenSearch
---

# Creating an {{ OS }} cluster


A {{ mos-name }} cluster is a group of multiple interlinked {{ OS }} and [Dashboards]({{ os.docs }}/dashboards/index/) hosts. A cluster provides high search performance by distributing search and indexing tasks across all cluster hosts with the `DATA` role. To learn more about roles in the cluster, see [Host roles](../concepts/host-roles.md).

Available disk types [depend](../concepts/storage.md) on the selected [host class](../concepts/instance-types.md).

For more information, see [Resource relationships in the service](../concepts/index.md).


## Roles for creating a cluster {#roles}

To create a {{ mos-name }} cluster, you will need the [{{ roles-vpc-user }}](../../vpc/security/index.md#vpc-user) and [{{ roles.mos.editor }}](../security/index.md#managed-opensearch-editor) roles or higher.

To link a service account to a cluster, e.g., to [use {{ objstorage-full-name }}](s3-access.md), make sure your {{ yandex-cloud }} account has the [iam.serviceAccounts.user](../../iam/security/index.md#iam-serviceAccounts-user) role or higher.

For more information about assigning roles, see [this {{ iam-full-name }} guide](../../iam/operations/roles/grant.md).


## Creating a cluster {#create-cluster}

When creating a cluster, you need to specify individual parameters for each [host group](../concepts/host-roles.md).

{% list tabs group=instructions %}

- Management console {#console}

  To create a {{ mos-name }} cluster:

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create a cluster.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
  1. Click **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
  1. Under **{{ ui-key.yacloud.mdb.forms.section_base }}**:

      1. Enter a name for the cluster. It must be unique within the folder.
      1. Optionally, enter a description for the cluster.
      1. Select the environment where you want to create your cluster (the environment cannot be changed after cluster creation):

          * `PRODUCTION`: For stable versions of your applications.
          * `PRESTABLE`: For testing purposes. The prestable environment is similar to the production environment and likewise covered by the SLA, but it is the first of the two to get new features, improvements, and bug fixes. In the prestable environment, you can test the new versions for compatibility with your application.

      1. Select the {{ OS }} version.
      1. Select the [plugins](plugins.md#supported-plugins) you want to install in the cluster.

  
  1. Under **{{ ui-key.yacloud.mdb.forms.section_network-settings }}**, select a cloud network to host the cluster and security groups for cluster network traffic. You may need to [configure the security groups](connect.md#security-groups) to connect to the cluster.


  1. Under **{{ ui-key.yacloud.opensearch.cluster.node-groups.title_virtual-node-group }} 1**, configure the [`{{ OS }}`](../concepts/host-roles.md) host group:

      1. Select the host group type: `{{ OS }}`.

      1. Enter a name for the host group. It must be unique within the cluster.

      1. Select the `DATA` and `MANAGER` [host roles](../concepts/host-roles.md).

      1. Select the platform, host type, and host class.

          The host class defines the technical characteristics of virtual machines that {{ OS }} nodes are deployed on. All available options are listed under [Host classes](../concepts/instance-types.md).

      1. Select the [disk type](../concepts/storage.md) and data storage size.

          {% include [storages-step-settings](../../_includes/mdb/settings-storages-no-broadwell.md) %}

      
      1. Optionally, select **{{ ui-key.yacloud.compute.disk-form.label_disk-encryption }}** to encrypt the disk with a [custom KMS key](../../kms/concepts/key.md).

          * To [create](../../kms/operations/key.md#create) a new key, click **{{ ui-key.yacloud.component.symmetric-key-select.button_create-key-new }}**.

          * To use the key you created earlier, select it in the **{{ ui-key.yacloud.compute.disk-form.label_disk-kms-key }}** field.

          To learn more about disk encryption, see [Storage](../concepts/storage.md#disk-encryption).


      1. Optionally, set up automatic increase of disk size:

          {% include [console-autoscaling](../../_includes/mdb/mos/console_autoscaling.md) %}

      1. Specify how hosts should be distributed across [availability zones](../../overview/concepts/geo-scope.md) and subnets.

      1. Select the number of hosts to create.

      
      1. Enable **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}** if you want to allow [connecting](connect.md) to hosts over the internet.

          {% note tip %}

          For security reasons, we do not recommend enabling public access for hosts with the `MANAGER` role.

          {% endnote %}


  1. Configure the `Dashboards` [host group](../concepts/host-roles.md#dashboards) under **{{ ui-key.yacloud.opensearch.cluster.node-groups.title_virtual-node-group }} 2**, if required:

      1. Select the platform, host type, and host class.
      1. Set up storage in the same way as for `{{ OS }}` hosts.
      1. Specify how hosts should be distributed across availability zones and subnets.
      1. Select the number of hosts to create.
        
      
      1. Enable **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}** if you want to allow [connecting](connect.md) to hosts over the internet.

          {% include [mos-tip-public-dashboards](../../_includes/mdb/mos/public-dashboards.md) %}


  1. If required, click **{{ ui-key.yacloud.opensearch.cluster.node-groups.action_add-virtual-node-group }}** to add another host group or more.

  1. Under **{{ ui-key.yacloud.mdb.forms.section_service-settings }}**:

      1. Enter the password for the `admin` user.

          {% include [os-password-requirements.md](../../_includes/mdb/mos/os-password-requirements.md) %}

          {% include [Superuser](../../_includes/mdb/mos/superuser.md) %}

      1. If required, change additional cluster settings:

          {% include [Extra settings](../../_includes/mdb/mos/extra-settings.md) %}

  1. Click **{{ ui-key.yacloud.mdb.forms.button_create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a {{ mos-name }} cluster:

  1. See the description of the CLI command for creating a cluster:

      ```bash
      {{ yc-mdb-os }} cluster create --help
      ```

  1. Specify the cluster settings in the creation command (our example does not include all available settings):

      ```bash
      {{ yc-mdb-os }} cluster create \
         --name <cluster_name> \
         --description <cluster_description> \
         --labels <labels> \
         --environment <environment> \
         --network-name <network_name> \
         --security-group-ids <security_group_IDs> \
         --service-account-name <service_account_name> \
         --delete-protection \
         --maintenance schedule=<maintenance_type>,`
                      `weekday=<day_of_week>,`
                      `hour=<hour> \
         --disk-encryption-key-id <KMS_key_ID> \
         --version <{{ OS }}_version> \
         --read-admin-password \
         --data-transfer-access=<allow_access_from_Data_Transfer> \
         --serverless-access=<allow_access_from_Serverless_Containers> \
         --plugins <{{ OS }}_plugins> \
         --advanced-params <additional_parameters> \
         --opensearch-node-group name=<{{ OS }}_host_group_name>,`
                                `resource-preset-id=<host_class>,`
                                `disk-size=<disk_size_in_bytes>,`
                                `disk-type-id=<network-hdd|network-ssd|network-ssd-io-m3|network-ssd-nonreplicated|local-ssd>,`
                                `hosts-count=<number_of_hosts_in_group>,`
                                `zone-ids=<availability_zones>,`
                                `subnet-names=<subnet_names>,`
                                `assign-public-ip=<allow_public_access_to_hosts>,`
                                `roles=<host_roles> \
         --dashboards-node-group name=<Dashboards_host_group_name>,`
                                `resource-preset-id=<host_class>,`
                                `disk-size=<disk_size_in_bytes>,`
                                `disk-type-id=<network-ssd>,`
                                `hosts-count=<number_of_hosts_in_group>,`
                                `zone-ids=<availability_zones>,`
                                `subnet-names=<subnet_names>,`
                                `assign-public-ip=<allow_public_access_to_hosts>
      ```

      Where:

      * `--labels`: [{{ yandex-cloud }} labels](../../resource-manager/concepts/labels.md) in `<key>=<value>` format. You can use them to logically separate resources.
      * `--environment`: Environment:

          * `production`: For stable versions of your apps.
          * `prestable`: For testing purposes. The prestable environment is similar to the production environment and likewise covered by the SLA, but it is the first of the two to get new features, improvements, and bug fixes. In the prestable environment, you can test the new versions for compatibility with your application.

      * `--service-account-name`: Name of the service account for [access to {{ objstorage-full-name }}](s3-access.md) as a repository of {{ OS }} snapshots. For more information on service accounts, see the [{{ iam-full-name }} documentation](../../iam/concepts/users/service-accounts.md).

      * {% include [Deletion protection](../../_includes/mdb/cli/deletion-protection.md) %}
      
        Even with cluster deletion protection enabled, one can still delete a user or connect to the cluster manually and delete the data.

      * `--maintenance`: Maintenance window settings:

          * To allow maintenance at any time, do not specify the `--maintenance` parameter in the command (default configuration) or specify `--maintenance schedule=anytime`.
          * To specify the preferred start time for maintenance, specify this parameter in the command: `--maintenance schedule=weekly,weekday=<day_of_week>,hour=<hour_in_UTC>`. In this case, maintenance will take place every week on a specified day at a specified time.

          Both enabled and disabled clusters undergo maintenance. Maintenance may involve such operations as applying patches or updating DBMS's.

      
      * `--disk-encryption-key-id`: Disk encryption using a [custom KMS key](../../kms/concepts/key.md).

          To learn more about disk encryption, see [Storage](../concepts/storage.md#disk-encryption).


      * `--read-admin-password`: `admin` user password. If you specify this parameter in the command, it will prompt you to enter a password.

          {% include [os-password-requirements.md](../../_includes/mdb/mos/os-password-requirements.md) %}

          {% include [Superuser](../../_includes/mdb/mos/superuser.md) %}


      * `--serverless-access`: Access from [{{ serverless-containers-full-name }}](../../serverless-containers/index.yaml), `true` or `false`.
      * `--plugins`: [{{ OS }} plugins](../concepts/plugins.md) to install in the cluster.
      * `--advanced-params`: Additional cluster parameters. The possible values are:

          * `max-clause-count`: Maximum allowed number of boolean clauses per query. For more information, see [this {{ OS }} guide]({{ os.docs }}/query-dsl/compound/bool/).
          * `fielddata-cache-size`: JVM heap size allocated for the `fielddata` data structure. You can specify either an absolute value or percentage, e.g., `512mb` or `50%`. For more information, see the [{{ OS }} documentation]({{ os.docs }}/install-and-configure/configuring-opensearch/index-settings/#cluster-level-index-settings).
          * `reindex-remote-whitelist`: List of remote hosts whose indexes contain documents to copy for reindexing. Specify the parameter value as `<host_address>:<port>`. If you need to specify more than one host, list values separated by commas. For more information, see [this {{ OS }} guide]({{ os.docs }}/im-plugin/reindex-data/#reindex-from-a-remote-cluster).

      {% include [cli-for-os-and-dashboards-groups](../../_includes/managed-opensearch/cli-for-os-and-dashboards-groups.md) %}

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To create a {{ mos-name }} cluster:

  1. In the configuration file, describe the properties of resources you want to create:

      * DB cluster: Description of the {{ mos-name }} cluster and its hosts

      * {% include [Terraform network description](../../_includes/mdb/terraform/network.md) %}

      * {% include [Terraform subnet description](../../_includes/mdb/terraform/subnet.md) %}

      Here is an example of the configuration file structure:

      ```hcl
      resource "yandex_mdb_opensearch_cluster" "<cluster_name>" {
        name                   = "<cluster_name>"
        environment            = "<environment>"
        network_id             = "<network_ID>"
        security_group_ids     = ["<list_of_security_group_IDs>"]
        disk_encryption_key_id = <KMS_key_ID>
        deletion_protection    = "<protect_cluster_from_deletion>"

        config {

          version        = "<{{ OS }}_version>"
          admin_password = "<admin_user_password>"

          opensearch {
            node_groups {
              name             = "<virtual_host_group_name>"
              assign_public_ip = <allow_public_access_to_hosts>
              hosts_count      = <number_of_hosts>
              zone_ids         = ["<list_of_availability_zones>"]
              subnet_ids       = ["<list_of_subnet_IDs>"]
              roles            = ["<role_list>"]
              resources {
                resource_preset_id = "<host_class>"
                disk_size          = <storage_size_in_bytes>
                disk_type_id       = "<disk_type>"
              }
            }

            plugins = ["<list_of_plugin_names>"]

          }

          dashboards {
            node_groups {
              name             = "<virtual_host_group_name>"
              assign_public_ip = <allow_public_access_to_hosts>
              hosts_count      = <number_of_hosts>
              zone_ids         = ["<list_of_availability_zones>"]
              subnet_ids       = ["<list_of_subnet_IDs>"]
              resources {
                resource_preset_id = "<host_class>"
                disk_size          = <storage_size_in_bytes>
                disk_type_id       = "<disk_type>"
              }
            }
          }
        }
        maintenance_window {
          type = <maintenance_type>
          day  = <day_of_week>
          hour = <hour>
        }
      }

      resource "yandex_vpc_network" "<network_name>" { 
        name = "<network_name>"
      }

      resource "yandex_vpc_subnet" "<subnet_name>" {
        name           = "<subnet_name>"
        zone           = "<availability_zone>"
        network_id     = "<network_ID>"
        v4_cidr_blocks = ["<range>"]
      }
      ```

      Where:

      * `environment`: Environment, `PRESTABLE` or `PRODUCTION`.

      
      * `disk_encryption_key_id`: Disk encryption with a [custom KMS key](../../kms/concepts/key.md).

          To learn more about disk encryption, see [Storage](../concepts/storage.md#disk-encryption).


      * `deletion_protection`: Cluster protection from accidental deletion, `true` or `false`.

        Even with cluster deletion protection enabled, one can still delete a user or connect to the cluster manually and delete the data.

      * `admin_password`: `admin` user password.

        {% include [os-password-requirements.md](../../_includes/mdb/mos/os-password-requirements.md) %}

        {% include [Superuser](../../_includes/mdb/mos/superuser.md) %}

      * `assign_public_ip`: Public access to the host, `true` or `false`.
      * `roles`: `DATA` and `MANAGER` host roles.
      * `maintenance_window`: [Maintenance window](../concepts/maintenance.md) settings (including those for disabled clusters):
          * `type`: Maintenance type. The possible values include:
              * `ANYTIME`: Any time.
              * `WEEKLY`: On a schedule.
          * `day`: Day of week in `DDD` format for the `WEEKLY` type, e.g., `MON`.
          * `hour`: Time of day (UTC) in `HH` format for the `WEEKLY` type, e.g., `21`.

      For a complete list of configurable {{ mos-name }} cluster fields, refer to the [{{ TF }} provider guides]({{ tf-provider-mos }}).

  1. Validate your configuration.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Create a cluster.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [Terraform timeouts](../../_includes/mdb/mos/terraform/timeouts.md) %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and save it as an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Create a file named `body.json` and paste the following code into it:

      
      ```json
      {
          "folderId": "<folder_ID>",
          "name": "<cluster_name>",
          "environment": "<environment>",
          "networkId": "<network_ID>",
          "securityGroupIds": [
              "<security_group_1_ID>",
              "<security_group_2_ID>",
              ...
              "<security_group_N_ID>"
          ],
          "serviceAccountId": "<service_account_ID>",
          "deletionProtection": <protect_cluster_from_deletion>,
          "configSpec": {
              "version": "<{{ OS }}_version>",
              "adminPassword": "<admin_password>",
              "opensearchSpec": {
                  "plugins": [
                      "<{{ OS }}_pugin_1>",
                      "<{{ OS }}_pugin_2>",
                      ...
                      "<{{ OS }}_pugin_N>"
                  ],
                  "nodeGroups": [
                      {
                          "name": "<host_group_name>",
                          "resources": {
                              "resourcePresetId": "<host_class>",
                              "diskSize": "<storage_size_in_bytes>",
                              "diskTypeId": "<disk_type>"
                          },
                          "roles": ["<role_1>","<role_2>"],
                          "hostsCount": "<number_of_hosts>",
                          "zoneIds": [
                              "<availability_zone_1>",
                              "<availability_zone_2>",
                              "<availability_zone_3>"
                          ],
                          "subnetIds": [
                              "<subnet_1_ID>",
                              "<subnet_2_ID>",
                              "<subnet_3_ID>"
                          ],
                          "assignPublicIp": <allow_public_access_to_hosts>,
                          "diskSizeAutoscaling": {
                              "plannedUsageThreshold": "<scheduled_increase_percentage>",
                              "emergencyUsageThreshold": "<immediate_increase_percentage>",
                              "diskSizeLimit": "<maximum_storage_size_in_bytes>"
                          }
                      },
                      ...
                  ]
              },
              "dashboardsSpec": {
                  "nodeGroups": [
                      {
                          "name": "<host_group_name>",
                          "resources": {
                              "resourcePresetId": "<host_class>",
                              "diskSize": "<storage_size_in_bytes>",
                              "diskTypeId": "<disk_type>"
                          },
                          "hostsCount": "<number_of_hosts>",
                          "zoneIds": ["<availability_zone>"],
                          "subnetIds": ["<subnet_ID>"],
                          "assignPublicIp": <allow_public_access_to_hosts>,
                          "diskSizeAutoscaling": {
                              "plannedUsageThreshold": "<scheduled_increase_percentage>",
                              "emergencyUsageThreshold": "<immediate_increase_percentage>",
                              "diskSizeLimit": "<maximum_storage_size_in_bytes>"
                          }
                      }
                  ]
              },
              "access": {
                  "dataTransfer": <allow_access_from_Data_Transfer>,
                  "serverless": <allow_access_from_Serverless_Containers>
              }
          },
          "maintenanceWindow": {
              "weeklyMaintenanceWindow": {
                  "day": "<day_of_week>",
                  "hour": "<hour>"
              }
          }
      }
      ```


      Where:

      * `folderId`: Folder ID. You can get it from the [cloud’s folder list](../../resource-manager/operations/folder/get-id.md).
      * `name`: Cluster name.
      * `environment`: Cluster environment, `PRODUCTION` or `PRESTABLE`.
      * `networkId`: ID of the [network](../../vpc/concepts/network.md#network) the cluster will be in.

      
      * `securityGroupIds`: [Security group](../concepts/network.md#security-groups) IDs.
      * `serviceAccountId`: ID of the [service account](../../iam/concepts/users/service-accounts.md) used for cluster operations.


      * `deletionProtection`: Cluster protection from accidental deletion, `true` or `false`.

        Even with cluster deletion protection enabled, one can still delete a user or connect to the cluster manually and delete the data.

      * `configSpec`: Cluster settings:

          * `version`: {{ OS }} version.
          * `adminPassword`: `admin` user password.

            {% include [os-password-requirements.md](../../_includes/mdb/mos/os-password-requirements.md) %}

            {% include [Superuser](../../_includes/mdb/mos/superuser.md) %}

          * `opensearchSpec`: `{{ OS }}` host group settings:

              * `plugins`: List of [{{ OS }}](../concepts/plugins.md) plugins you should additionally install in the cluster.
              * `nodeGroups`: Host settings as an array of elements, one for each host group. Each element has the following structure:

                  * `name`: Host group name.
                  * `resources`: Cluster resources:

                      * `resourcePresetId`: [Host class](../concepts/instance-types.md).
                      * `diskSize`: Disk size in bytes.
                      * `diskTypeId`: [Disk type](../concepts/storage.md).

                  * `roles`: List of [host roles](../concepts/host-roles.md). A cluster must include at least one group of `DATA` hosts and one group of `MANAGER` hosts. This can be a single group with two roles or several groups with different roles.
                  * `hostsCount`: Number of hosts in the group. Minimum number of `DATA` hosts: one; minimum number of `MANAGER` hosts: three.
                  * `zoneIds`: List of availability zones the cluster hosts are located in.
                  * `subnetIds`: List of subnet IDs.

                  
                  * `assignPublicIp`: Permission to [connect](connect.md) to the host from the internet, `true` or `false`.


                  * `diskSizeAutoscaling`: Automatic storage size increase settings:

                      * `plannedUsageThreshold`: Storage utilization percentage to trigger a storage increase during the next maintenance window.

                          Use a value between `0` and `100`%. The default setting is `0` (automatic increase disabled).

                          If you set this condition, configure the maintenance window schedule in the `maintenanceWindow` parameter.

                      * `emergencyUsageThreshold`: Storage utilization percentage to trigger an immediate storage increase.

                          Use a value between `0` and `100`%. The default setting is `0` (automatic increase disabled).

                        {% note warning %}

                        If you specify both thresholds, `emergencyUsageThreshold` must not be less than `plannedUsageThreshold`.

                        {% endnote %}

                      * `diskSizeLimit`: Maximum storage size, in bytes, that can be set when utilization reaches one of the specified percentages.

                      
                      {% include [warn-storage-resize](../../_includes/mdb/mos/warn-storage-resize.md) %}


          * `dashboardsSpec`: Settings for `Dashboards` host groups. Contains the `nodeGroups` parameter of the same structure as `opensearchSpec.nodeGroups`. The `roles` parameter is the exception: the `Dashboards` hosts can only have one role, `DASHBOARDS`, so there is no need to specify it.

          
          * `access`: Settings for cluster access to the following {{ yandex-cloud }} services:

              * `dataTransfer`: [{{ data-transfer-full-name }}](../../data-transfer/index.yaml)
              * `serverless`: [{{ serverless-containers-full-name }}](../../serverless-containers/index.yaml)

              The possible setting values are `true` or `false`.


      * `maintenance_window.weeklyMaintenanceWindow`: Maintenance window schedule:

          * `day`: Day of the week, in `DDD` format, for scheduled maintenance.
          * `hour`: Hour, in `HH` format, for scheduled maintenance. The possible values range from `1` to `24`. Use the UTC time zone.

  1. Use the [Cluster.Create](../api-ref/Cluster/create.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

      ```bash
      curl \
          --request POST \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://{{ api-host-mdb }}/managed-opensearch/v1/clusters' \
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
          "network_id": "<network_ID>",
          "security_group_ids": [
              "<security_group_1_ID>",
              "<security_group_2_ID>",
              ...
              "<security_group_N_ID>"
          ],
          "service_account_id": "<service_account_ID>",
          "deletion_protection": <protect_cluster_from_deletion>,
          "config_spec": {
              "version": "<{{ OS }}_version>",
              "admin_password": "<admin_password>",
              "opensearch_spec": {
                  "plugins": [
                      "<{{ OS }}_pugin_1>",
                      "<{{ OS }}_pugin_2>",
                      ...
                      "<{{ OS }}_pugin_N>"
                  ],
                  "node_groups": [
                      {
                          "name": "<host_group_name>",
                          "resources": {
                              "resource_preset_id": "<host_class>",
                              "disk_size": "<storage_size_in_bytes>",
                              "disk_type_id": "<disk_type>"
                          },
                          "roles": ["<role_1>","<role_2>"],
                          "hosts_count": "<number_of_hosts>",
                          "zone_ids": [
                              "<availability_zone_1>",
                              "<availability_zone_2>",
                              "<availability_zone_3>"
                          ],
                          "subnet_ids": [
                              "<subnet_1_ID>",
                              "<subnet_2_ID>",
                              "<subnet_3_ID>"
                          ],
                          "assign_public_ip": <allow_public_access_to_hosts>,
                          "disk_size_autoscaling": {
                              "planned_usage_threshold": "<scheduled_increase_percentage>",
                              "emergency_usage_threshold": "<immediate_increase_percentage>",
                              "disk_size_limit": "<maximum_storage_size_in_bytes>"
                          }
                      },
                      ...
                  ]
              },
              "dashboards_spec": {
                  "node_groups": [
                      {
                          "name": "<host_group_name>",
                          "resources": {
                              "resource_preset_id": "<host_class>",
                              "disk_size": "<storage_size_in_bytes>",
                              "disk_type_id": "<disk_type>"
                          },
                          "hosts_count": "<number_of_hosts>",
                          "zone_ids": ["<availability_zone>"],
                          "subnet_ids": ["<subnet_ID>"],
                          "assign_public_ip": <allow_public_access_to_hosts>,
                          "disk_size_autoscaling": {
                              "planned_usage_threshold": "<scheduled_increase_percentage>",
                              "emergency_usage_threshold": "<immediate_increase_percentage>",
                              "disk_size_limit": "<maximum_storage_size_in_bytes>"
                          }
                      }
                  ]
              },
              "access": {
                  "data_transfer": <allow_access_from_Data_Transfer>,
                  "serverless": <allow_access_from_Serverless_Containers>
              }
          },
          "maintenance_window": {
              "weekly_maintenance_window": {
                  "day": "<day_of_week>",
                  "hour": "<hour>"
              }
          }
      }
      ```


      Where:

      * `folder_id`: Folder ID. You can request it with the [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).
      * `name`: Cluster name.
      * `environment`: Cluster environment, `PRODUCTION` or `PRESTABLE`.
      * `network_id`: ID of the [network](../../vpc/concepts/network.md#network) the cluster will be in.

      
      * `security_group_ids`: [Security group](../concepts/network.md#security-groups) IDs.
      * `service_account_id`: ID of the [service account](../../iam/concepts/users/service-accounts.md) used for cluster operations.


      * `deletion_protection`: Cluster protection from accidental deletion, `true` or `false`.

        Even with cluster deletion protection enabled, one can still delete a user or connect to the cluster manually and delete the data.

      * `config_spec`: Cluster settings:

          * `version`: {{ OS }} version.
          * `admin_password`: `admin` user password.

            {% include [os-password-requirements.md](../../_includes/mdb/mos/os-password-requirements.md) %}

            {% include [Superuser](../../_includes/mdb/mos/superuser.md) %}

          * `opensearch_spec`: `{{ OS }}` host group settings:

              * `plugins`: List of [{{ OS }}](../concepts/plugins.md) plugins you should additionally install in the cluster.
              * `node_groups`: Host settings as an array of elements, one for each host group. Each element has the following structure:

                  * `name`: Host group name.
                  * `resources`: Cluster resources:

                      * `resource_preset_id`: [Host class](../concepts/instance-types.md).
                      * `disk_size`: Disk size in bytes.
                      * `disk_type_id`: [Disk type](../concepts/storage.md).

                  * `roles`: List of [host roles](../concepts/host-roles.md). A cluster must include at least one group of `DATA` hosts and one group of `MANAGER` hosts. This can be a single group with two roles or several groups with different roles.
                  * `hosts_count`: Number of hosts in the group. Minimum number of `DATA` hosts: one; minimum number of `MANAGER` hosts: three.
                  * `zone_ids`: List of availability zones the cluster hosts are located in.
                  * `subnet_ids`: List of subnet IDs.

                  
                  * `assign_public_ip`: Permission to [connect](connect.md) to the host from the internet, `true` or `false`.


                  * `disk_size_autoscaling`: Automatic storage size increase settings:

                      * `planned_usage_threshold`: Storage utilization percentage to trigger a storage increase during the next maintenance window.

                          Use a value between `0` and `100`%. The default setting is `0` (automatic increase disabled).

                          If you set this condition, configure the maintenance window schedule in the `maintenance_window` parameter.

                      * `emergency_usage_threshold`: Storage utilization percentage to trigger an immediate storage increase.

                          Use a value between `0` and `100`%. The default setting is `0` (automatic increase disabled).

                          {% note warning %}

                          If you specify both thresholds, `emergency_usage_threshold` must not be less than `planned_usage_threshold`.

                          {% endnote %}

                      * `disk_size_limit`: Maximum storage size, in bytes, that can be set when utilization reaches one of the specified percentages.

                      
                      {% include [warn-storage-resize](../../_includes/mdb/mos/warn-storage-resize.md) %}


          * `dashboards_spec`: Settings for `Dashboards` host groups. Contains the `node_groups` parameter of the same structure as `opensearch_spec.node_groups`. The `roles` parameter is the exception: the `Dashboards` hosts can only have one role, `DASHBOARDS`, so there is no need to specify it.

          
          * `access`: Settings for cluster access to the following {{ yandex-cloud }} services:

              * `data_transfer`: [{{ data-transfer-full-name }}](../../data-transfer/index.yaml)
              * `serverless`: [{{ serverless-containers-full-name }}](../../serverless-containers/index.yaml)

              The possible setting values are `true` or `false`.


      * `maintenance_window.weekly_maintenance_window`: Maintenance window schedule:

          * `day`: Day of the week, in `DDD` format, for scheduled maintenance.
          * `hour`: Hour, in `HH` format, for scheduled maintenance. The possible values range from `1` to `24`. Use the UTC time zone.

  1. Use the [ClusterService.Create](../api-ref/grpc/Cluster/create.md) call to execute the following request, e.g., via {{ api-examples.grpc.tool }}:

      ```bash
      grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/opensearch/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d @ \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.opensearch.v1.ClusterService.Create \
          < body.json
      ```

  1. Check the [server response](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Creating a cluster copy {#duplicate}

You can create an {{ OS }} cluster with the settings of another one you previously created. To do this, import the {{ OS }} source cluster configuration to {{ TF }}. This way you can either create an identical copy or use the imported configuration as the baseline and modify it as needed. Import is convenient when the source {{ OS }} cluster has many settings and you need to create a similar cluster.

To create an {{ OS }} cluster copy:

{% list tabs group=instructions %}

- {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

    1. In your current working directory, create a `.tf` file with the following content:

        ```hcl
        resource "yandex_mdb_opensearch_cluster" "old" { }
        ```

    1. Save the ID of the original {{ OS }} cluster to an environment variable:

        ```bash
        export OPENSEARCH_CLUSTER_ID=<cluster_ID>
        ```

        You can get the ID from the [folder’s cluster list](../../managed-opensearch/operations/cluster-list.md#list-clusters).

    1. Import the original {{ OS }} cluster settings to the {{ TF }} configuration:

        ```bash
        terraform import yandex_mdb_opensearch_cluster.old ${OPENSEARCH_CLUSTER_ID}
        ```

    1. Display the imported configuration:

        ```bash
        terraform show
        ```

    1. Copy it from the terminal and paste it into the `.tf` file.
    1. Create a new directory named `imported-cluster` and move your file there.
    1. Modify the configuration so it can be used to create a new cluster:

        * Specify the new cluster name in the `resource` string and the `name` parameter.
        * Delete `created_at`, `health`, `id`, and `status`.
        * Add the `admin_password` parameter to the `config` section.
        * If the `maintenance_window` section has `type = "ANYTIME"`, delete the `hour` parameter.
        * Optionally, you can customize the configuration further if needed.

    1. [Get the authentication credentials](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials) in the `imported-cluster` directory.

    1. In the same directory, [configure and initialize a provider](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). To avoid creating the provider configuration file manually, you can download it [here](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).

    1. Move the configuration file to the `imported-cluster` directory and edit it to [include your required values](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). If you have not added your authentication credentials to the environment variables, specify them in the configuration file.

    1. Validate your {{ TF }} configuration files:

        ```bash
        terraform validate
        ```

        {{ TF }} will display any configuration errors detected in your files.

    1. Create the required infrastructure:

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

    {% include [Terraform timeouts](../../_includes/mdb/mos/terraform/timeouts.md) %}

{% endlist %}

## Examples {#examples}

{% list tabs group=instructions %}

- CLI {#cli}

    Create a {{ mos-name }} cluster with the following test specifications:

    * Name: `my-os-clstr`.
    * Description: `My OS cluster`.
    * Label: `label-key` with `label-value`.
    * Environment: `production`.
    * Network name: `{{ network-name }}`.
    * Security group ID: `{{ security-group }}`.
    * Service account name: `os-account`.
    * Deletion protection: Disabled.
    * Maintenance time: Every Monday from 13:00 till 14:00.
    * {{ OS }} version: `2.12`.
    * `admin` user password: Specified after entering the cluster create command.
    * Access to {{ data-transfer-name }}: Enabled.
    * Access to {{ serverless-containers-name }}: Enabled.
    * {{ OS }} added plugin: analysis-icu.
    * {{ OS }} additional parameter: `fielddata-cache-size=50%`.
    * `{{ OS }}` node group configuration:

        * Node group name: `os-group`.
        * Host class: `{{ host-class }}`.
        * Disk size: `10737418240` (in bytes).
        * Disk type: `network-ssd`.
        * Number of hosts: `3`.
        * Availability zone: `{{ region-id }}-a`.
        * Subnet: `{{ network-name }}-{{ region-id }}-a`.
        * Public address: Assigned.
        * Host group roles: `DATA` and `MANAGER`.

    * `Dashboards` host group configuration:

        * Host group name: `dashboard-group`.
        * Host class: `{{ host-class }}`.
        * Disk size: `10737418240` (in bytes).
        * Disk type: `network-ssd`.
        * Number of hosts: `1`.
        * Availability zone: `{{ region-id }}-a`.
        * Subnet: `{{ network-name }}-{{ region-id }}-a`.
        * Public address: Assigned.

    Run this command:

    ```bash
    {{ yc-mdb-os }} cluster create \
       --name my-os-clstr \
       --description "My OS cluster" \
       --labels label-key=label-value \
       --environment production \
       --network-name {{ network-name }} \
       --security-group-ids {{ security-group }} \
       --service-account-name os-account \
       --delete-protection \
       --maintenance schedule=weekly,`
                    `weekday=mon,`
                    `hour=14 \
       --version 2.12 \
       --read-admin-password \
       --data-transfer-access=true \
       --serverless-access=true \
       --plugins analysis-icu \
       --advanced-params fielddata-cache-size=50% \
       --opensearch-node-group name=os-group,`
                              `resource-preset-id={{ host-class }},`
                              `disk-size=10737418240,`
                              `disk-type-id=network-ssd,`
                              `hosts-count=3,`
                              `zone-ids={{ region-id }}-a,`
                              `subnet-names={{ network-name }}-{{ region-id }}-a,`
                              `assign-public-ip=true,`
                              `roles=data+manager \
       --dashboards-node-group name=dashboard-group,`
                              `resource-preset-id={{ host-class }},`
                              `disk-size=10737418240,`
                              `disk-type-id=network-ssd,`
                              `hosts-count=1,`
                              `zone-ids={{ region-id }}-a,`
                              `subnet-names={{ network-name }}-{{ region-id }}-a,`
                              `assign-public-ip=true
    ```

- {{ TF }} {#tf}

    Create a {{ mos-name }} cluster with the following test specifications:

    * Name: `my-os-clstr`.
    * Environment: `PRODUCTION`.
    * {{ OS }} version: `2.12`.
    * `admin` user password: `osAdminpwd1`.
    * `{{ OS }}` node group configuration:

      * `{{ OS }}` node group name: `os-group`.
      * Host class: `{{ host-class }}`.
      * Disk size: `10737418240` (in bytes).
      * Disk type: `{{ disk-type-example }}`.
      * Number of hosts: `3`.
      * Availability zone: `{{ region-id }}-a`.
      * Public address: Assigned.
      * Host group roles: `DATA` and `MANAGER`.
    
    * `Dashboards` host group configuration:
    
      * Host group name: `dashboard-group`.
      * Host class: `{{ host-class }}`.
      * Disk size: `10737418240` (in bytes).
      * Disk type: `network-ssd`.
      * Number of hosts: `1`.
      * Availability zone: `{{ region-id }}-a`.
      * Public address: Assigned.
    
    * Maintenance time: Every Monday from 13:00 till 14:00.
    * Network name: `mynet`.
    * Subnet name: `mysubnet`.
    * Availability zone: `{{ region-id }}-a`.
    * Address range: `10.1.0.0/16`.
    * Security group name: `os-sg`. The security group enables connecting to the cluster host from any network (including the internet) on port `9200`.

    The configuration file for this cluster looks like this:

    ```hcl
    resource "yandex_mdb_opensearch_cluster" "my-os-clstr" {
      name               = "my-os-clstr"
      environment        = "PRODUCTION"
      network_id         = yandex_vpc_network.mynet.id
      security_group_ids = [yandex_vpc_security_group.os-sg.id]

      config {

        version        = "2.12"
        admin_password = "osAdminpwd1"

        opensearch {
          node_groups {
            name             = "os-group"
            assign_public_ip = true
            hosts_count      = 3
            zone_ids         = ["{{ region-id }}-a"]
            subnet_ids       = [yandex_vpc_subnet.mysubnet.id]
            roles            = ["DATA", "MANAGER"]
            resources {
              resource_preset_id = "{{ host-class }}"
              disk_size          = 10737418240
              disk_type_id       = "{{ disk-type-example }}"
            }
          }
        }

        dashboards {
          node_groups {
            name             = "dashboard-group"
            assign_public_ip = true
            hosts_count      = 1
            zone_ids         = ["ru-central1-a"]
            subnet_ids       = [yandex_vpc_subnet.mysubnet.id]
            resources {
              resource_preset_id = "s2.micro"
              disk_size          = 10737418240
              disk_type_id       = "network-ssd"
            }
          }
        }

      }

      maintenance_window {
        type = "WEEKLY"
        day  = "MON"
        hour = 14
      }
    }

    resource "yandex_vpc_network" "mynet" {
      name = "mynet"
    }

    resource "yandex_vpc_subnet" "mysubnet" {
      name           = "mysubnet"
      zone           = "{{ region-id }}-a"
      network_id     = yandex_vpc_network.mynet.id
      v4_cidr_blocks = ["10.1.0.0/16"]
    }

    resource "yandex_vpc_security_group" "os-sg" {
      name       = "os-sg"
      network_id = yandex_vpc_network.mynet.id

      ingress {
        description    = "Allow connections to the {{ mos-name }} cluster from the Internet"
        protocol       = "TCP"
        port           = 9200
        v4_cidr_blocks = ["0.0.0.0/0"]
      }

      egress {
        description    = "The rule allows all outgoing traffic"
        protocol       = "ANY"
        v4_cidr_blocks = ["0.0.0.0/0"]
        from_port      = 0
        to_port        = 65535
      }
    }
    ```

{% endlist %}


{% include [connection-manager](../../_includes/mdb/connection-manager.md) %}
