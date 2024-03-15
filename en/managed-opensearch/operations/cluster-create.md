---
title: "Creating an {{ OS }} cluster"
description: "A cluster of Yandex Managed Service for {{ OS }} is a group of multiple linked {{ OS }} hosts."
keywords:
  - Creating an OpenSearch cluster
  - OpenSearch cluster
  - OpenSearch
---

# Creating an {{ OS }} cluster

A {{ mos-name }} cluster is a group of multiple linked {{ OS }} hosts and [dashboards]({{ os.docs }}/dashboards/index/). A cluster provides high search performance by distributing search and indexing tasks across all cluster hosts with the `DATA` role. To learn more about roles in the cluster, see [Host roles](../concepts/host-roles.md).

Available disk types [depend](../concepts/storage.md) on the selected [host class](../concepts/instance-types.md).

For more information, see [{#T}](../concepts/index.md).

## Creating a cluster {#create-cluster}

When creating a cluster, you need to specify individual parameters for each [host group](../concepts/host-groups.md).

{% list tabs group=instructions %}

- Management console {#console}

   To create a cluster:

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create a cluster.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
   1. Click **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
   1. Under **{{ ui-key.yacloud.mdb.forms.section_base }}**:

      1. Enter a name for the cluster. It must be unique within the folder.
      1. (Optional) Enter a cluster description.
      1. Select the environment where you want to create the cluster (you cannot change the environment once the cluster is created):

         * `PRODUCTION`: For stable versions of your apps.
         * `PRESTABLE`: For testing purposes. The prestable environment is similar to the production environment and likewise covered by the SLA, but it is the first to get new functionalities, improvements, and bug fixes. In the prestable environment, you can test compatibility of new versions with your application.

      1. Select the {{ OS }} version.
      1. Select the [plugins](plugins.md#supported-plugins) you want to install in the cluster.

   
   1. Under **{{ ui-key.yacloud.mdb.forms.section_network-settings }}**, select the cloud network to host the cluster in and security groups for cluster network traffic. You may also need to [set up security groups](connect.md#security-groups) to connect to the cluster.


   1. Under **{{ ui-key.yacloud.opensearch.cluster.node-groups.title_virtual-node-group }} 1**, configure the [`{{ OS }}` host group](../concepts/host-groups.md):

      1. Select the host group type: `{{ OS }}`

      1. Enter a name for the host group, which must be unique within the cluster.

      1. Select the [host roles](../concepts/host-roles.md) `DATA` and `MANAGER`.

      1. Select the platform, host type, and host class.

         The host class defines the technical characteristics of virtual machines that {{ OS }} nodes are deployed on. All available options are listed under [Host classes](../concepts/instance-types.md).

      1. Select the [disk type](../concepts/storage.md) and data storage size.

         {% include [storages-step-settings](../../_includes/mdb/settings-storages-no-broadwell.md) %}

      1. Specify how hosts should be distributed across availability zones and subnets.

      1. Select the number of hosts to create.

      
      1. Enable **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}** if you want to allow [connecting](connect.md) to hosts over the internet.

         {% note tip %}

         It is not recommended to enable public access for hosts with the `MANAGER` role, because this might be unsafe.

         {% endnote %}


      {% note warning %}

      After creating your cluster, you can only change the host configuration using the API. However, you can also create a new host group with a different configuration if needed.

      {% endnote %}

   1. If needed, configure the `Dashboards` [host group](../concepts/host-groups.md) under **{{ ui-key.yacloud.opensearch.cluster.node-groups.title_virtual-node-group }} 2**:

      1. Select the platform, host type, and host class.
      1. Set up storage in the same way as for `{{ OS }}` hosts.
      1. Specify how hosts should be distributed across availability zones and subnets.
      1. Select the number of hosts to create.

      
      1. Enable **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}** if you want to allow [connecting](connect.md) to hosts over the internet.

         {% include [mos-tip-public-dashboards](../../_includes/mdb/mos/public-dashboards.md) %}


   1. If required, click **{{ ui-key.yacloud.opensearch.cluster.node-groups.action_add-virtual-node-group }}** to add another host group or more.

   1. Under **{{ ui-key.yacloud.mdb.forms.section_service-settings }}**:

      1. Enter the password for the `admin` user.

         {% include [Superuser](../../_includes/mdb/mos/superuser.md) %}

      1. Configure additional cluster settings, if required:

         {% include [Extra settings](../../_includes/mdb/mos/extra-settings.md) %}

   1. Click **{{ ui-key.yacloud.mdb.forms.button_create }}**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To create a cluster:

   1. View a description of the create cluster CLI command:

      ```bash
      {{ yc-mdb-os }} cluster create --help
      ```

   1. Specify cluster parameters in the create command (the list of supported parameters in the example is not exhaustive):

      ```bash
      {{ yc-mdb-os }} cluster create \
         --name <cluster_name> \
         --description <cluster_description> \
         --labels <labels> \
         --environment <environment:_production_or_prestable> \
         --network-name <network_name> \
         --security-group-ids <security_group_IDs> \
         --service-account-name <service_account_name> \
         --delete-protection <deletion_protection:_true_or_false> \
         --maintenance schedule=<maintenance_type>,`
                      `weekday=<day_of_week>,`
                      `hour=<hour_of_day> \
         --version <{{ OS }}_version> \
         --read-admin-password \
         --data-transfer-access=<true_or_false> \
         --serverless-access=<true_or_false> \
         --plugins <{{ OS }}_plugins> \
         --advanced-params <advanced_parameters> \
         --opensearch-node-group name=<name_of_{{ OS }}_host_group>,`
                                `resource-preset-id=<host_class>,`
                                `disk-size=<disk_size_in_bytes>,`
                                `disk-type-id=<disk_type>,`
                                `hosts-count=<number_of_hosts_per_group>,`
                                `zone-ids=<availability_zones>,`
                                `subnet-names=<subnet_names>,`
                                `assign-public-ip=<assign_public_IP:_true_or_false>,`
                                `roles=<host_roles> \
         --dashboards-node-group name=<name_of_Dashboards_host_group>,`
                                `resource-preset-id=<host_class>,`
                                `disk-size=<disk_size_in_bytes>,`
                                `disk-type-id=<disk_type>,`
                                `hosts-count=<number_of_hosts_per_group>,`
                                `zone-ids=<availability_zones>,`
                                `subnet-names=<subnet_names>,`
                                `assign-public-ip=<assign_public_IP:_true_or_false>
      ```

      Where:

      * `--labels`: [{{ yandex-cloud }} labels](../../resource-manager/concepts/labels.md) in `<key>=<value>` format. You can use them to logically separate resources.
      * `--environment`: Environment:

         * `production`: For stable versions of your applications.
         * `prestable`: For testing purposes. The prestable environment is similar to the production environment and likewise covered by the SLA, but it is the first to get new functionalities, improvements, and bug fixes. In the prestable environment, you can test compatibility of new versions with your application.

      * `--service-account-name`: Name of the service account.

      * `--delete-protection`: Cluster protection against accidental deletion by a user, `true` or `false`. Cluster deletion protection will not prevent a manual connection to a cluster to delete data.

      * `--maintenance`: Maintenance time settings:

         * To allow maintenance at any time, do not specify the `--maintenance` parameter in the command (default configuration) or specify `--maintenance schedule=anytime`.
         * To specify the preferred start time for maintenance, specify the `--maintenance schedule=weekly,weekday=<day_of_week>,hour=<hour_in_UTC>` parameter in the command. In this case, maintenance will take place every week on a specified day at a specified time.

         Both enabled and disabled clusters undergo maintenance. Maintenance may involve such operations as applying patches or updating DBMS's.

      * `--read-admin-password`: `admin` user password. If you specify this parameter in the command, it will prompt you to enter a password.
      * `--data-transfer-access`: Access from [{{ data-transfer-full-name }}](../../data-transfer/index.yaml), `true` or `false`.
      * `--serverless-access`: Access from [{{ serverless-containers-full-name }}](../../serverless-containers/index.yaml), `true` or `false`.
      * `--plugins`: [{{ OS }} plugins](../concepts/plugins.md) you want to install in the cluster.
      * `--advanced-params`: Additional cluster parameters. The possible values include:

         * `max-clause-count`: Maximum allowed number of boolean clauses per query. See more in the [{{ OS }} documentation]({{ os.docs }}/query-dsl/compound/bool/).
         * `fielddata-cache-size`: Amount of JVM heap memory allocated for the fielddata data structure. You can specify either an absolute value or percentage, e.g., `512mb` or `50%`. For more details, see the [{{ OS }} documentation]({{ os.docs }}/install-and-configure/configuring-opensearch/index-settings/#cluster-level-index-settings).
         * `reindex-remote-whitelist`: List of remote hosts whose indexes contain documents to copy for reindexing. Specify the parameter value as `<host_address>:<port>`. If you need to specify more than one host, list values separated by commas. For more details, see the [{{ OS }} documentation]({{ os.docs }}/im-plugin/reindex-data/#reindex-from-a-remote-cluster).

      {% include [cli-for-os-and-dashboards-groups](../../_includes/managed-opensearch/cli-for-os-and-dashboards-groups.md) %}

- {{ TF }} {#tf}

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   {% include [terraform-install](../../_includes/terraform-install.md) %}

   To create a {{ mos-name }} cluster:

   1. In the configuration file, describe the parameters of the resources you want to create:

      * DB cluster: Description of the {{ mos-name }} cluster and its hosts

      * {% include [Terraform network description](../../_includes/mdb/terraform/network.md) %}

      * {% include [Terraform subnet description](../../_includes/mdb/terraform/subnet.md) %}

      Here is an example of the configuration file structure:

      ```hcl
      resource "yandex_mdb_opensearch_cluster" "<cluster_name>" {
        name                = "<cluster_name>"
        environment         = "<environment>"
        network_id          = "<network_ID>"
        security_group_ids  = ["<list_of_security_group_IDs>"]
        deletion_protection = "<deletion_protection>"

        config {

          version        = "<{{ OS }}_version>"
          admin_password = "<admin_user_password>"

          opensearch {
            node_groups {
              name             = "<virtual_host_group_name>"
              assign_public_ip = <public_access>
              hosts_count      = <number_of_hosts>
              zone_ids         = ["<list_of_availability_zones>"]
              subnet_ids       = ["<list_of_subnet_IDs>"]
              roles            = ["<list_of_roles>"]
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
              assign_public_ip = <public_access>
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
      * `deletion_protection`: Deletion protection, `true` or `false`.
      * `assign_public_ip`: Public access to the host, `true` or `false`.
      * `roles`: `DATA` and `MANAGER` host roles.

      {% include [cluster-create](../../_includes/mdb/deletion-protection-limits-db.md) %}

      {% include [Maintenance window](../../_includes/mdb/mos/terraform/maintenance-window.md) %}

      For a complete list of available {{ mos-name }} cluster configuration fields, see the [{{ TF }} provider documentation]({{ tf-provider-mos }}).

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Create a cluster.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [Terraform timeouts](../../_includes/mdb/mos/terraform/timeouts.md) %}

- API {#api}

   To create a cluster, use the [create](../api-ref/Cluster/create.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Create](../api-ref/grpc/cluster_service.md#Create) gRPC API call and provide the following in the request:

   * ID of the folder where the cluster should be placed, in the `folderId` parameter.
   * Cluster name in the `name` parameter.
   * {{ OS }} version in the `configSpec.version` parameter.
   * `admin` user password in the `configSpec.adminPassword` parameter.
   * Configuration of one or more groups of hosts with the `DATA` and `MANAGER` (optional) [roles](../concepts/host-roles.md) in the `configSpec.opensearchSpec.nodeGroups` parameter.
   * Configuration of one or more groups of hosts with the `DASHBOARDS` [role](../concepts/host-roles.md#dashboards) in the `configSpec.dashboardsSpec.nodeGroups` parameter.
   * List of plugins in the `configSpec.opensearchSpec.plugins` parameter.
   * Settings for access from other services in the `configSpec.access` parameter.
   * Network ID in the `networkId` parameter.

   
   * Security group identifiers in the `securityGroupIds` parameter. You may also need to [set up security groups](connect.md#security-groups) to connect to the cluster.
   * ID of the [service account](../../iam/concepts/users/service-accounts.md) used for cluster operations in the `serviceAccountId` parameter.


   * Cluster deletion protection settings in the `deletionProtection` parameter.

      {% include [Deletion protection limits](../../_includes/mdb/deletion-protection-limits-db.md) %}

   * Settings for the [maintenance window](../concepts/maintenance.md) (including those for disabled clusters) in the `maintenanceWindow` parameter.

{% endlist %}

## Importing clusters to {{ TF }} {#import-cluster}

Using import, you can bring the existing clusters under the {{ TF }} management.

{% list tabs group=instructions %}

- {{ TF }} {#tf}

   1. In the {{ TF }} configuration file, specify the cluster you want to import:

       ```hcl
       resource "yandex_mdb_opensearch_cluster" "<cluster_name>" {}
       ```

   1. Run the following command to import the cluster:

       ```hcl
       terraform import yandex_mdb_opensearch_cluster.<cluster_name> <cluster_ID>
       ```

       To learn more about importing clusters, see the [{{ TF }} provider documentation]({{ tf-provider-mos }}#import).

{% endlist %}

## Examples {#examples}

{% list tabs group=instructions %}

- CLI {#cli}

    Create a {{ mos-name }} cluster with the following test characteristics:

    * Name: `my-os-clstr`.
    * Description: `My OS cluster`.
    * Label: `label-key` with the `label-value` value.
    * Environment: `production`.
    * Network name: `{{ network-name }}`.
    * Security group ID: `{{ security-group }}`.
    * Service account name: `os-account`.
    * Cluster deletion protection: Disabled.
    * Maintenance time: Every Monday from 13:00 till 14:00.
    * {{ OS }} version: `2.8`.
    * `admin` user password: To be set after entering the cluster creation command.
    * Access to {{ data-transfer-name }}: Enabled.
    * Access to {{ serverless-containers-name }}: Enabled.
    * {{ OS }} added plugin: analysis-icu.
    * {{ OS }} advanced parameter: `fielddata-cache-size=50%`.
    * `{{ OS }}` node group configuration:

        * Group name: `os-group`
        * Host class: `{{ host-class }}`
        * Disk size: `10737418240` (in bytes)
        * Disk type: `network-ssd`
        * Number of hosts: Three
        * Availability zone: `{{ region-id }}-b`
        * Subnet: `{{ network-name }}-{{ region-id }}-b`
        * Public address: Assigned
        * Host group roles: `DATA` and `MANAGER`

    * Configuration of the `Dashboards` host group:

        * Group name: `dashboard-group`
        * Host class: `{{ host-class }}`
        * Disk size: `10737418240` (in bytes)
        * Disk type: `network-ssd`
        * Number of hosts: One
        * Availability zone: `{{ region-id }}-b`
        * Subnet: `{{ network-name }}-{{ region-id }}-b`
        * Public address: Assigned

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
       --delete-protection=false \
       --maintenance schedule=weekly,`
                    `weekday=mon,`
                    `hour=14 \
       --version 2.8 \
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
                              `zone-ids={{ region-id }}-b,`
                              `subnet-names={{ network-name }}-{{ region-id }}-b,`
                              `assign-public-ip=true,`
                              `roles=data+manager \
       --dashboards-node-group name=dashboard-group,`
                              `resource-preset-id={{ host-class }},`
                              `disk-size=10737418240,`
                              `disk-type-id=network-ssd,`
                              `hosts-count=1,`
                              `zone-ids={{ region-id }}-b,`
                              `subnet-names={{ network-name }}-{{ region-id }}-b,`
                              `assign-public-ip=true
    ```

- {{ TF }} {#tf}

    Create a {{ mos-name }} cluster with the following test characteristics:

    * Name: `my-os-clstr`.
    * Environment: `PRODUCTION`.
    * {{ OS }} version: `2.8`.
    * `admin` password: `osadminpwd`.
    * `{{ OS }}` node group name: `os-group`.
    * Host class: `{{ host-class }}`.
    * Disk size: `10737418240` (in bytes).
    * Disk type: `{{ disk-type-example }}`.
    * Number of hosts: `1`.
    * Public address: Assigned.
    * Host group roles: `DATA` and `MANAGER`.
    * Network name: `mynet`.
    * Subnet name: `mysubnet`.
    * Availability zone: `{{ region-id }}-a`.
    * Address range: `10.1.0.0/16`.
    * Security group name: `os-sg`. The security group allows connecting to the cluster host from any network (including the internet) on port `9200`.

    The configuration file for this cluster is as follows:

    ```hcl
    resource "yandex_mdb_opensearch_cluster" "my-os-clstr" {
      name               = "my-os-clstr"
      environment        = "PRODUCTION"
      network_id         = yandex_vpc_network.mynet.id
      security_group_ids = [yandex_vpc_security_group.os-sg.id]

      config {

        version        = "2.8"
        admin_password = "osadminpwd"

        opensearch {
          node_groups {
            name             = "os-group"
            assign_public_ip = true
            hosts_count      = 1
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
