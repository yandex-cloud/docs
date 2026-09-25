---
title: Creating a {{ AF }} cluster
description: Every {{ maf-name }} cluster consists of a set of {{ AF }} components, each of which may have multiple instances. These instances may reside in different availability zones.
keywords:
  - creating an {{ AF }} cluster
  - '{{ AF }} cluster'
  - '{{ AF }}'
  - Airflow
---

# Creating an {{ AF }} cluster

Every {{ maf-name }} cluster consists of a set of {{ AF }} components, each of which may have multiple instances. These instances may reside in different availability zones.

## Roles for creating a cluster {#roles}

To create and use a {{ maf-name }} cluster, your {{ yandex-cloud }} account needs the following roles:

* {% include [roles-maf-editor](../../_includes/mdb/maf/roles-maf-editor.md) %}
* {% include [roles-vpc-user](../../_includes/mdb/roles-vpc-user.md) %}
* {% include [roles-sa-user](../../_includes/mdb/roles-sa-user.md) %}
* {% include [roles-mdb-viewer](../../_includes/mdb/roles-mdb-viewer-create-cluster.md) %}

Make sure to grant the `managed-airflow.integrationProvider` role to the cluster service account. The cluster will thus get the permissions it needs to work with user resources. For more information, see [Impersonation](../concepts/impersonation.md).

For more information about assigning roles, see [this {{ iam-full-name }} guide](../../iam/operations/roles/grant.md).

## Set up a NAT gateway for internet access {#nat-routing}

The minimum roles required to create and configure a [NAT gateway](*nat) are [vpc.admin](../../vpc/security/index.md#vpc-admin) and [vpc.gateways.user](../../vpc/security/index.md#vpc-gw-user).

Use a NAT gateway to set up internet access from all subnets to which the {{ maf-name }} cluster will be connected. This is a requirement if you need to do the following:

- Install pip and deb packages from public repositories into the cluster.
- Use external Git storage for DAG files.

{% cut "Create and set up a NAT gateway" %}

{% list tabs group=instructions %}

- Management console {#console}
  
  1. In the [management console]({{ link-console-main }}), select the folder where you want to create your {{ maf-name }} cluster.
  1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. In the left-hand panel, select **{{ ui-key.yacloud.vpc.switch_gateways }}**.
  1. Click **{{ ui-key.yacloud.vpc.gateways.button_create-gateway }}**, and in the window that opens:
     1. In the **{{ ui-key.yacloud.vpc.gateways.field_name }}** field, enter a name for your NAT gateway.
     1. In the **{{ ui-key.yacloud.vpc.gateways.field_type }}** field, select `{{ ui-key.yacloud.vpc.gateways.value_gateway-type-egress-nat }}`.
     1. Click **{{ ui-key.yacloud.common.create }}**.
  
- CLI {#cli}

  1. See the description of the CLI command for creating a NAT gateway:

     ```bash
     yc vpc gateway create --help
     ```
  
  1. Create a gateway in the default folder:

     ```bash
     yc vpc gateway create \
     --name <NAT_gateway_name>
     ```

     For more information about the `yc vpc gateway create` command, see the [CLI reference](../../cli/cli-ref/vpc/cli-ref/gateway/create.md).

     Save the NAT gateway `id`. You will need it when creating a route table.

- {{ TF }} {#tf}

  To create a NAT gateway, use the `yandex_vpc_gateway` resource in the configuration file:

  ```hcl
  // ...
  // Create a new VPC NAT Gateway.
  resource "yandex_vpc_gateway" "nat_gateway" {
    folder_id      = "<folder_ID>"
    name = "<NAT_gateway_name>"
    shared_egress_gateway {}
  }
  // ...
  ```

  Where `folder_id` is the ID of the folder housing the subnets.

  For more on the properties of the `yandex_vpc_gateway` in {{ TF }}, see [this provider guide]({{ tf-provider-resources-link }}/vpc_gateway).

- API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Use the [create](../../vpc/api-ref/Gateway/create.md) REST API method for the [Gateway](../../vpc/api-ref/Gateway/index.md) resource, and provide the following in the request:

     * ID of the folder the gateway will reside in, in the `folderId` parameter.
     * Gateaway name in the `name` parameter.
  
{% endlist %}

{% endcut %}

{% cut "Create and associate a route table" %}

{% list tabs group=instructions %}
  
- Management console {#console}

  1. In the left-hand panel, select **{{ ui-key.yacloud.vpc.network.switch_route-table }}**.
  1. Click **{{ ui-key.yacloud.vpc.network.overview.button_create_route-table }}** and specify the route table parameters:
      1. Enter a name for the table.
      1. Select a network to host the route table and your new {{ maf-name }} cluster.
      1. Click **{{ ui-key.yacloud.vpc.route-table-form.label_add-static-route }}**.
          * In the **{{ ui-key.yacloud.vpc.route-table-form.label_next-hop-address }}** field, select `{{ ui-key.yacloud.vpc.add-static-route.value_gateway }}`.
          * In the **{{ ui-key.yacloud.vpc.add-static-route.value_gateway }}** field, select the NAT gateway you created. The destination prefix will apply automatically.
      1. Click **{{ ui-key.yacloud.vpc.add-static-route.button_add }}**.
  1. Click **{{ ui-key.yacloud.vpc.route-table.create.button_create }}**.

  Next, associate the [route table](*routing-table) with **all subnets of your new cluster** to route traffic from them through the NAT gateway:

  1. In the left-hand panel, select ![image](../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.vpc.switch_networks }}**.
  1. In the row with the subnet, click ![image](../../_assets/console-icons/ellipsis.svg).
  1. In the menu that opens, select **{{ ui-key.yacloud.vpc.subnetworks.button_action-add-route-table }}**.
  1. In the window that opens, select your route table from the list.
  1. Click **{{ ui-key.yacloud.vpc.subnet.add-route-table.button_add }}**.
  1. Repeat these steps for all subnets of your new cluster.
  
- CLI {#cli}

  1. Create a route table with the gateway as the next hop and the `0.0.0.0/0` destination prefix:

     ```bash
     yc vpc route-table create \
       --name=<route_table_name> \
       --network-name=<network_name> \
       --route destination=0.0.0.0/0,gateway-id=<NAT_gateway_ID>
     ```
    
     Where `--network-name` is the name of the network to host the table and the {{ maf-name }} cluster.

  1. Associate the table with all subnets of your new cluster:
    
     ```bash
     yc vpc subnet update <subnet_name> \
       --route-table-name=<route_table_name>
     ```

- {{ TF }} {#tf}

  To create a route table and associate it with all subnets of your new cluster, use the `yandex_vpc_route_table` resource in the configuration file:

  ```hcl
  // ...
  resource "yandex_vpc_subnet" "subnet-a" {
    ...
    route_table_id = yandex_vpc_route_table.rt.id
  }

  resource "yandex_vpc_subnet" "subnet-d" {
    ...
    route_table_id = yandex_vpc_route_table.rt.id
  }

  resource "yandex_vpc_gateway" "nat_gateway" {
    // ...
  }

  // ...
  // Create a new VPC Route Table.
  //
  resource "yandex_vpc_route_table" "rt" {
    folder_id      = "<folder_ID>"
    name       = "<route_table_name>"
    network_id = "<network_ID>"

    static_route {
      destination_prefix = "0.0.0.0/0"
      gateway_id         = yandex_vpc_gateway.nat_gateway.id
    }
  }
  ```

  Where:
  * `folder_id`: ID of the folder housing the subnets.
  * `route_table_id`: ID of the route table you need to associate with each cluster subnet.

  For more on the properties of the `yandex_vpc_route_table` in {{ TF }}, see [this provider guide]({{ tf-provider-resources-link }}/vpc_route_table).

- API {#api}

  1. Create a route table.
  
     1. Create a file named `body.json` and paste the following code into it:

        ```json
        {
          "folderId": "<folder_ID>",
          "name": "<route_table_name>",
          "networkId": "<network_ID>",
          "staticRoutes": [
            {
              "destinationPrefix": "0.0.0.0/0",
              "gatewayId": "<NAT_gateway_ID>"
            }
          ]
        }
        ```

        Where:
        * `folderId`: ID of the folder housing the subnets. You can get it with the [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).
        * `name`: Route table name.
        * `networkId`: ID of the network the route table will reside in.
        * `staticRoutes.destinationPrefix`: Destination subnet prefix.
        * `staticRoutes.gatewayId`: ID of the NAT gateway to use for traffic routing.
  
     1. Call the [create](../../vpc/api-ref/RouteTable/create.md) REST API method for the [RouteTable](../../vpc/api-ref/RouteTable/index.md) resource, e.g., via the following {{ api-examples.rest.tool }} request:

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
           --url 'https://vpc.api.cloud.yandex.net/vpc/v1/routeTables' \
           --data '@body.json'
        ```
  
  1. Associate the route table with all subnets of your new cluster.

     1. Call the [update](../../vpc/api-ref/Subnet/update.md) REST API method for the [Subnet](../../vpc/api-ref/Subnet/index.md) resource, e.g., via the following {{ api-examples.rest.tool }} request:

        {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://vpc.api.cloud.yandex.net/vpc/v1/subnets/<subnet_ID>' \
            --data '{
                      "updateMask": "routeTableId",
                      "routeTableId": "<route_table_ID>"
                   }'
        ```
  
{% endlist %}

{% endcut %}

## Create a cluster {#create-cluster}



{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create a cluster.
  1. [Navigate]({{ link-console-main }}/link/managed-airflow) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-airflow }}**.
  1. Click **{{ ui-key.yacloud.airflow.button_create-cluster }}**.
  1. Under **{{ ui-key.yacloud.mdb.forms.section_base }}**:

        1. Enter a name for the cluster. The name must be unique within the folder.
        1. Optionally, enter a description for the cluster.
        1. Select the [{{ AF }} and Python versions](../concepts/versions.md).
        1. Optionally, create [labels](../../resource-manager/concepts/labels.md):
            1. Click **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
            1. Enter a label in `key: value` format.
            1. Press **Enter**.

  1. Under **{{ ui-key.yacloud.airflow.section_accesses }}**:

        * Set a password for the admin user. The password must be not less than 8 characters long and contain at least:
            * One uppercase letter
            * One lowercase letter
            * One number
            * One special character

           {% note info %}

           Save the password locally or memorize it. {{ maf-name }} does not show passwords after they are created.

           {% endnote %}

        * Select an existing service account or create a new one.

           Make sure to assign the `{{ roles.maf.integrationProvider }}` [role](../../iam/concepts/access-control/roles.md) to this service account:

  1. Under **{{ ui-key.yacloud.mdb.forms.section_network-settings }}**, select:

      * [Availability zones](../../overview/concepts/geo-scope.md) for the cluster.
      * Cloud network.
      * Subnet in each of the selected availability zones.

        {% include [choose-subnet](../../_includes/mdb/maf/choose-subnet.md) %}

      * [Security group](../concepts/network.md#security-groups) for the cluster network traffic.

        {% include [sg-ui-access](../../_includes/mdb/maf/note-sg-ui-access.md) %}

  1. Set the number of instances and a [computing resource configuration](../concepts/instance-types.md) for the {{ maf-name }} [components](../concepts/index.md#components):

      * Web server
      * Scheduler
      * Workers

        {% note info %}

        If the task queue is empty, the number of workers will be the minimum value. When tasks appear, the number of workers will increase up to the maximum value.

        {% endnote %}

      * DAG processor

        {% include [dag-processor](../../_includes/mdb/maf/dag-processor.md) %}

      * Triggerer services (optional)

  1. Optionally, under **{{ ui-key.yacloud.mdb.forms.section_dependencies }}**, specify space-separated pip and deb package names to install additional libraries and applications in the cluster to run DAG files.

      You can set version restrictions for the installed packages, e.g.:

      ```text
      pandas==2.0.2 scikit-learn>=1.0.0 clickhouse-driver~=0.2.0
      ```

      The package name format and version are defined by the install command: `pip install` for pip packages and `apt install` for deb packages.

      {% note warning %}

      To install pip and deb packages from public repositories, specify a network with configured [egress NAT](#nat-routing) under **{{ ui-key.yacloud.mdb.forms.section_network-settings }}**.

      {% endnote %}

  1. Under **{{ ui-key.yacloud.airflow.section_storage }}**, select **{{ ui-key.yacloud.airflow.ClusterForm.StorageSection.storage_source_type_7Jvgw }}** and specify its settings:
     * **{{ ui-key.yacloud.airflow.ClusterForm.StorageSection.source_s3_t1FCM }}**: Select an existing bucket or create a new one. This bucket will store DAG files.

        Make sure to [grant the `READ` permission](../../storage/operations/buckets/edit-acl.md) for this bucket to the cluster service account.

     * **{{ ui-key.yacloud.airflow.ClusterForm.StorageSection.source_git_pgAeB }}**:
        * **{{ ui-key.yacloud.airflow.ClusterForm.StorageSection.storage_git_repo_pKzRo }}**: Repository address in `git@github.com:<user>/<path_to_git_repo>.git` format.
        * **{{ ui-key.yacloud.airflow.ClusterForm.StorageSection.storage_git_branch_5sU67 }}**: Repository branch name, e.g., `main`.
        * **{{ ui-key.yacloud.airflow.ClusterForm.StorageSection.storage_git_subpath_rbaX6 }}**: Path to the directory with DAG files relative to the repository, in `/<path-to-DAG-files>` format.
        * **{{ ui-key.yacloud.airflow.ClusterForm.StorageSection.storage_git_ssh_key_ewdAh }}**: Contents of the private SSH repository access key.

           {% cut "Key example" %}

           ```bash
           -----BEGIN OPENSSH PRIVATE KEY-----
           XXxxxxxxxD...DDXXXXXXXXXXXX
           -----END OPENSSH PRIVATE KEY-----
           ```
           
           {% endcut %}

       {% include [warn-git](../../_includes/mdb/maf/note-git-sync.md) %}

  1. Optionally, under **{{ ui-key.yacloud.mdb.forms.section_additional }}**:

      * Select cluster [maintenance](../concepts/maintenance.md) time:

        {% include [Maintenance window](../../_includes/mdb/console/maintenance-window-description.md) %}

      * Enable cluster deletion protection.

  1. Optionally, under **{{ ui-key.yacloud.airflow.section_airflow-configuration }}**:
  
      * Specify [{{ AF }} additional properties](https://airflow.apache.org/docs/apache-airflow/2.2.4/configurations-ref.html), e.g., `api.maximum_page_limit` as a key and `150` as its value.

        Fill out the fields manually or import a configuration from a file (see this [configuration file example](https://{{ s3-storage-host }}/doc-files/managed-airflow/airflow.cfg)).

      * Enable the **{{ ui-key.yacloud.airflow.field_lockbox }}** option to use secrets in [{{ lockbox-full-name }}](../../lockbox/concepts/index.md) to [store {{ AF }} configuration data, variables, and connection parameters](../concepts/impersonation.md#lockbox-integration).

        {% include [sa-roles-for-lockbox](../../_includes/managed-airflow/sa-roles-for-lockbox.md) %}

  1. Optionally, under **Log settings**, enable logging. Logs generated by {{ AF }} components will be sent to {{ cloud-logging-full-name }}. Configure logging:

      * In the **Destination** field, specify the logging destination:
          * **Folder**: Select the folder. Logs will be written to the default [log group](../../logging/concepts/log-group.md) for this folder.
          * **Log group**: Select a custom log group or create a new one.

      * Select the minimum logging level: `TRACE`, `DEBUG`, `INFO` (default), `WARN`, `ERROR`, or `FATAL`.

  1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To create a {{ maf-name }} cluster:

    1. View the description of the CLI command for creating a cluster:

        ```bash
        {{ yc-mdb-af }} cluster create --help
        ```

    1. Specify the cluster properties in this command (the example does not show all that are available):

        ```bash
        {{ yc-mdb-af }} cluster create \
           --name <cluster_name> \
           --description <cluster_description> \
           --labels <label_list> \
           --airflow-version <Apache_Airflow™_version> \
           --python-version <Python_version> \
           --admin-password <admin_password> \
           --service-account-id <service_account_ID> \
           --subnet-ids <subnet_IDs> \
           --security-group-ids <security_group_IDs> \
           --webserver count=<number_of_instances>,`
                      `resource-preset-id=<resource_ID> \
           --scheduler count=<number_of_instances>,`
                      `resource-preset-id=<resource_ID> \
           --worker min-count=<minimum_number_of_instances>,`
                   `max-count=<maximum_number_of_instances>,`
                   `resource-preset-id=<resource_ID> \
           --triggerer count=<number_of_instances>,`
                      `resource-preset-id=<resource_ID> \
           --dag-processor count=<number_of_instances>,`
                      `resource-preset-id=<resource_ID> \         
           --deb-packages <list_of_deb_packages> \
           --pip-packages <list_of_pip_packages> \
           --dags-bucket <bucket_name> \
           --gitsync repo=<repository_SSH_address>,`
                     `branch=<working_branch>,`
                     `subpath=<path_to_DAG_file_folder>,`
                     `ssh-key=<private_SSH_key>,`
                     `ssh-key-path=<path_to_private_SSH_key_file> \
           --maintenance-window type=<maintenance_type>,`
                                `day=<day_of_week>,`
                                `hour=<sequence_number_of_hour_interval> \
           --deletion-protection \                   
           --lockbox-secrets-backend \
           --airflow-config <list_of_properties> \
           --log-enabled \
           --log-folder-id <folder_ID> \
           --log-min-level <logging_level>
        ```

        {% include [CLI cluster parameters description](../../_includes/mdb/maf/cli/cluster-parameters.md) %}

        * `--subnet-ids`: List of subnet IDs.

            {% include [choose-subnet](../../_includes/mdb/maf/choose-subnet.md) %}

        {% include [CLI cluster parameters description](../../_includes/mdb/maf/cli/cluster-parameters-part-2.md) %}

- {{ TF }} {#tf}

    {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

    {% include [terraform-install](../../_includes/terraform-install.md) %}

    To create a {{ maf-name }} cluster:

    1. In the configuration file, describe the resources you are creating:

        * {{ maf-name }} cluster: Cluster description.

        * {% include [Terraform network description](../../_includes/mdb/terraform/network.md) %}

        * {% include [Terraform subnet description](../../_includes/mdb/terraform/subnet.md) %}

        {% include [Terraform cluster parameters description](../../_includes/mdb/maf/terraform/cluster-parameters.md) %}

        * `subnet_ids`: List of subnet IDs.

            {% include [choose-subnet](../../_includes/mdb/maf/choose-subnet.md) %}

        {% include [Terraform cluster parameters description](../../_includes/mdb/maf/terraform/cluster-parameters-part-2.md) %}

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Create a {{ maf-name }} cluster.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        This will create all the resources you need in the specified folder. You can check the new resources and their settings in the [management console]({{ link-console-main }}).

    For more information, see [this {{ TF }} provider guide]({{ tf-provider-maf }}).

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Create a file named `body.json` and paste the following code into it:

        ```json
        {
          "folderId": "<folder_ID>",
          "name": "<cluster_name>",
          "description": "<cluster_description>",
          "labels": { <label_list> },
          "config": {
            "airflowVersion": "<{{ AF }}_version>",
            "pythonVersion": "<Python_version>",
            "airflow": {
              "config": { <list_of_properties> }
            },
            "webserver": {
              "count": "<number_of_instances>",
              "resources": {
                "resourcePresetId": "<resource_ID>"
              }
            },
            "scheduler": {
              "count": "<number_of_instances>",
              "resources": {
                "resourcePresetId": "<resource_ID>"
              }
            },
            "triggerer": {
              "count": "<number_of_instances>",
              "resources": {
                "resourcePresetId": "<resource_ID>"
              }
            },
            "worker": {
              "minCount": "<minimum_number_of_instances>",
              "maxCount": "<maximum_number_of_instances>",
              "resources": {
                "resourcePresetId": "<resource_ID>"
              }
            },
            "dependencies": {
              "pipPackages": [ <list_of_pip_packages> ],
              "debPackages": [ <list_of_deb_packages> ]
            },
            "lockbox": {
              "enabled": <usage_of_secrets>
            },
            "dagProcessor": {
              "count": "<number_of_instances>",
              "resources": {
                "resourcePresetId": "<resource_ID>"
              }
            }
          },
          "network": {
            "subnetIds": [ <list_of_subnet_IDs> ],
            "securityGroupIds": [ <list_of_security_group_IDs> ]
          },
          "codeSync": {
            "s3": {
              "bucket": "<bucket_name>"
            },
            "gitSync": {
              "repo": "<repository_SSH_address>",
              "branch": "<working_branch>",
              "subPath": "<path_to_DAG_file_folder>",
              "sshKey": "<private_SSH_key>"
            }
          },
          "maintenanceWindow": {
            "weeklyMaintenanceWindow": {
              "day": "<day_of_week>",
              "hour": "<sequence_number_of_hour_interval>"
            }
          },
          "deletionProtection": <deletion_protection>,
          "serviceAccountId": "<service_account_ID>",
          "logging": {
            "enabled": <use_of_logging>,
            "minLevel": "<logging_level>",
            "folderId": "<folder_ID>"
          },
          "adminPassword": "<admin_password>"
        }
        ```

        Where:

        * `folderId`: Folder ID. You can get it with the [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).
        * `name`: Cluster name.
        * `description`: Cluster description.
        * `labels`: List of labels provided in `"<key>": "<value>"` format.
        * `config`: Cluster configuration:

            * `airflowVersion`: [{{ AF }} version](../concepts/versions.md).
            * `pythonVersion`: Python version.
            * `airflow.config`: [Advanced {{ AF }} properties](https://airflow.apache.org/docs/apache-airflow/2.2.4/configurations-ref.html) provided in `"<configuration_section>.<key>": "<value>"` format, e.g.:

                ```json
                "airflow": {
                  "config": {
                    "core.load_examples": "False"
                  }
                }
                ```

            * `webserver`, `scheduler`, `triggerer`, `worker`, `dagProcessor`: {{ maf-name }} [component](../concepts/index.md#components) configuration:

                * `count`: Number of instances in the cluster for the web server, scheduler, DAG processor, and Triggerer.
                * `minCount`, `maxCount`: Minimum and maximum number of instances in the cluster for the worker.
                * `resources.resourcePresetId`: ID of the computing resources of the web server, scheduler, DAG processor, worker, and Triggerer. The possible values are:

                    * `c1-m2`: 1 vCPU, 2 GB RAM
                    * `c1-m4`: 1 vCPU, 4 GB RAM
                    * `c2-m4`: 2 vCPUs, 4 GB RAM
                    * `c2-m8`: 2 vCPUs, 8 GB RAM
                    * `c4-m8`: 4 vCPUs, 8 GB RAM
                    * `c4-m16`: 4 vCPUs, 16 GB RAM
                    * `c8-m16`: 8 vCPUs, 16 GB RAM
                    * `c8-m32`: 8 vCPUs, 32 GB RAM

                {% include notitle [dag-processor](../../_includes/mdb/maf/dag-processor.md) %}

            * `dependencies`: Lists of packages enabling you to install additional libraries and applications for running DAG files in the cluster:

                * `pipPackages`: List of pip packages.
                * `debPackages`: List of deb packages.

                You can set version restrictions for the installed packages, e.g.:

                ```bash
                "dependencies": {
                  "pipPackages": [
                    "pandas==2.0.2",
                    "scikit-learn>=1.0.0",
                    "clickhouse-driver~=0.2.0"
                  ]
                }
                ```

                The package name format and version are defined by the install command: `pip install` for pip packages and `apt install` for deb packages.

            * `lockbox.enabled`: Enables using secrets in [{{ lockbox-full-name }}](../../lockbox/concepts/index.md) to [store {{ AF }} configuration data, variables, and connection parameters](../concepts/impersonation.md#lockbox-integration). The possible values are `true` or `false`.

        * `network`: Network settings:

            * `subnetIds`: List of subnet IDs.

                {% include [choose-subnet](../../_includes/mdb/maf/choose-subnet.md) %}

            * `securityGroupIds`: List of [security group](../concepts/network.md#security-groups) IDs.

        * `codeSync`: DAG file source type and parameters.

            * `s3.bucket`: Bucket name.

            * `gitSync`: Git repo parameters:

              * `repo`: Repository address in `git@github.com:<user>/<path_to_git_repo>.git` format.
              * `branch`: Repository branch name, e.g., `main`.
              * `subPath`: Path to the directory with DAG files relative to the repository, in `/<path-to-DAG-files>` format.
              * `sshKey`: Private SSH repository access key, single-line with new line characters `\n`.

              {% include [warn-git](../../_includes/mdb/maf/note-git-sync.md) %}

            Specify either `s3` or `gitSync`.

        * {% include [maintenance](../../_includes/mdb/maf/maintenance-window-rest.md) %}

        * `deletionProtection`: Enables cluster protection against accidental deletion. The possible values are `true` or `false`.

            Even with deletion protection on, one can still connect to the cluster manually and delete it.

        * `serviceAccountId`: Service account ID.

        * `logging`: Logging parameters:

            * `enabled`: Enables logging. Logs generated by {{ AF }} components will be sent to {{ cloud-logging-full-name }}. The possible values are `true` or `false`.
            * `minLevel`: Minimum logging level. The possible values are `TRACE`, `DEBUG`, `INFO`, `WARN`, `ERROR`, and `FATAL`.
            * `folderId`: Folder ID. Logs will be written to the default [log group](../../logging/concepts/log-group.md) for this folder.
            * `logGroupId`: Custom log group ID. Logs will be written to this group.

                Specify either `folderId` or `logGroupId`.

        * `adminPassword`: Admin user password. The password must be not less than 8 characters long and contain at least:

            * One uppercase letter
            * One lowercase letter
            * One number
            * One special character

            {% note info %}

            Save the password locally or memorize it. {{ maf-name }} does not show passwords after they are created.

            {% endnote %}

    1. Call the [Cluster.Create](../api-ref/Cluster/create.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://airflow.api.cloud.yandex.net/managed-airflow/v1/clusters' \
            --data '@body.json'
        ```

    1. View the [server response](../api-ref/Cluster/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Create a file named `body.json` and paste the following code into it:

        ```json
        {
          "folder_id": "<folder_ID>",
          "name": "<cluster_name>",
          "description": "<cluster_description>",
          "labels": { <label_list> },
          "config": {
            "version_airflow": "<{{ AF }}_version>",
            "python_version": "<Python_version>",
            "airflow": {
              "config": { <list_of_properties> }
            },
            "webserver": {
              "count": "<number_of_instances>",
              "resources": {
                "resource_preset_id": "<resource_ID>"
              }
            },
            "scheduler": {
              "count": "<number_of_instances>",
              "resources": {
                "resource_preset_id": "<resource_ID>"
              }
            },
            "triggerer": {
              "count": "<number_of_instances>",
              "resources": {
                "resource_preset_id": "<resource_ID>"
              }
            },
            "worker": {
              "min_count": "<minimum_number_of_instances>",
              "max_count": "<maximum_number_of_instances>",
              "resources": {
                "resource_preset_id": "<resource_ID>"
              }
            },
            "dependencies": {
              "pip_packages": [ <list_of_pip_packages> ],
              "deb_packages": [ <list_of_deb_packages> ]
            },
            "lockbox": {
              "enabled": <usage_of_secrets>
            },
            "dag_processor": {
              "count": "<number_of_instances>",
              "resources": {
                "resource_preset_id": "<resource_ID>"
              }
            }
          },
          "network": {
            "subnet_ids": [ <list_of_subnet_IDs> ],
            "security_group_ids": [ <list_of_security_group_IDs> ]
          },
          "code_sync": {
            "s3": {
              "bucket": "<bucket_name>"
            },
            "git_sync": {
              "repo": "<repository_SSH_address>",
              "branch": "<working_branch>",
              "sub_path": "<path_to_DAG_file_folder>",
              "ssh_key": "<private_SSH_key>"
            }
          },
          "maintenance_window": {
            "weekly_maintenance_window": {
              "day": "<day_of_week>",
              "hour": "<sequence_number_of_hour_interval>"
            }
          },
          "deletion_protection": <deletion_protection>,
          "service_account_id": "<service_account_ID>",
          "logging": {
            "enabled": <use_of_logging>,
            "min_level": "<logging_level>",
            "folder_id": "<folder_ID>"
          },
          "admin_password": "<admin_password>"
        }
        ```

        Where:

        * `folder_id`: Folder ID. You can get it with the [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).
        * `name`: Cluster name.
        * `description`: Cluster description.
        * `labels`: List of labels provided in `"<key>": "<value>"` format.
        * `config`: Cluster configuration:

            * `version_airflow`: [{{ AF }} version](../concepts/versions.md).
            * `python_version`: Python version.
            * `airflow.config`: [Advanced {{ AF }} properties](https://airflow.apache.org/docs/apache-airflow/2.2.4/configurations-ref.html) provided in `"<configuration_section>.<key>": "<value>"` format, e.g.:

                ```json
                "airflow": {
                  "config": {
                    "core.load_examples": "False"
                  }
                }
                ```

            * `webserver`, `scheduler`, `triggerer`, `worker`, `dag_processor`: {{ maf-name }} [component](../concepts/index.md#components) configuration:

                * `count`: Number of instances in the cluster for the web server, scheduler, DAG processor, and Triggerer.
                * `min_count`, `max_count`: Minimum and maximum number of instances in the cluster for the worker.
                * `resources.resource_preset_id`: ID of the computing resources of the web server, scheduler, DAG processor, worker, and Triggerer. The possible values are:

                    * `c1-m2`: 1 vCPU, 2 GB RAM
                    * `c1-m4`: 1 vCPU, 4 GB RAM
                    * `c2-m4`: 2 vCPUs, 4 GB RAM
                    * `c2-m8`: 2 vCPUs, 8 GB RAM
                    * `c4-m8`: 4 vCPUs, 8 GB RAM
                    * `c4-m16`: 4 vCPUs, 16 GB RAM
                    * `c8-m16`: 8 vCPUs, 16 GB RAM
                    * `c8-m32`: 8 vCPUs, 32 GB RAM
                
                {% include notitle [dag-processor](../../_includes/mdb/maf/dag-processor.md) %}

            * `dependencies`: Lists of packages enabling you to install additional libraries and applications for running DAG files in the cluster:

                * `pip_packages`: List of pip packages.
                * `deb_packages`: List of deb packages.

                You can set version restrictions for the installed packages, e.g.:

                ```bash
                "dependencies": {
                  "pip_packages": [
                    "pandas==2.0.2",
                    "scikit-learn>=1.0.0",
                    "clickhouse-driver~=0.2.0"
                  ]
                }
                ```

                The package name format and version are defined by the install command: `pip install` for pip packages and `apt install` for deb packages.

            * `lockbox.enabled`: Enables using secrets in [{{ lockbox-full-name }}](../../lockbox/concepts/index.md) to [store {{ AF }} configuration data, variables, and connection parameters](../concepts/impersonation.md#lockbox-integration). The possible values are `true` or `false`.

        * `network`: Network settings:

            * `subnet_ids`: List of subnet IDs.

                {% include [choose-subnet](../../_includes/mdb/maf/choose-subnet.md) %}

            * `security_group_ids`: List of [security group](../concepts/network.md#security-groups) IDs.

        * `code_sync`: DAG file source type and parameters.

            * `s3.bucket`: Bucket name.

            * `git_sync`: Git repo parameters:

              * `repo`: Repository address in `git@github.com:<user>/<path_to_git_repo>.git` format.
              * `branch`: Repository branch name, e.g., `main`.
              * `sub_path`: Path to the directory with DAG files relative to the repository, in `/<path-to-DAG-files>` format.
              * `ssh_key`: Private SSH repository access key, single-line with new line characters `\n`.

              {% include [warn-git](../../_includes/mdb/maf/note-git-sync.md) %}

            Specify either `s3` or `git_sync`.

        * {% include [maintenance](../../_includes/mdb/maf/maintenance-window-grpc.md) %}

        * `deletion_protection`: Enables cluster protection against accidental deletion. The possible values are `true` or `false`.

            Even with deletion protection on, one can still connect to the cluster manually and delete it.

        * `service_account_id`: Service account ID.

        * `logging`: Logging parameters:

            * `enabled`: Enables logging. Logs generated by {{ AF }} components will be sent to {{ cloud-logging-full-name }}. The possible values are `true` or `false`.
            * `min_level`: Minimum logging level. The possible values are `TRACE`, `DEBUG`, `INFO`, `WARN`, `ERROR`, and `FATAL`.
            * `folder_id`: Folder ID. Logs will be written to the default [log group](../../logging/concepts/log-group.md) for this folder.
            * `log_group_id`: Custom log group ID. Logs will be written to this group.

                Specify either `folder_id` or `log_group_id`.

        * `admin_password`: Admin user password. The password must be not less than 8 characters long and contain at least:

            * One uppercase letter
            * One lowercase letter
            * One number
            * One special character

            {% note info %}

            Save the password locally or memorize it. {{ maf-name }} does not show passwords after they are created.

            {% endnote %}

    1. Call the [ClusterService.Create](../api-ref/grpc/Cluster/create.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/airflow/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d @ \
            {{ api-host-airflow }}:{{ port-https }} \
            yandex.cloud.airflow.v1.ClusterService.Create \
            < body.json
        ```

    1. Check the [server response](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Examples {#examples}

* [{#T}](#without-nat-gateway)
* [{#T}](#with-nat-gateway)

### Creating a cluster without a NAT gateway {#without-nat-gateway}

{% list tabs group=instructions %}

- CLI {#cli}

    Create a {{ maf-name }} cluster with the following test specifications:

    * Name: `myaf`.
    * {{ AF }} version: `3.0`.
    * Python version: `3.12`.
    * Admin password: `Password*1`.
    * Service account ID: `aje8r2rp7fkl********`.
    * Subnet IDs:
      
      * `e9bhbia2scnk********`
      * `e2lfqbm5nt9r********`
      * `fl8beqmjckv8********`

    * One web server to host the {{ AF }} instance with the `c1-m2` host class.
    * One scheduler with the `c1-m2` host class.
    * Jobs are performed by `c1-m2` host class workers; from `1` to `4` in number.
    * One DAG processor with the `c1-m2` host class.
    * Bucket of any name for DAG files.

    Run this command:

    ```bash
    {{ yc-mdb-af }} cluster create \
      --name myaf \
      --airflow-version 3.0 \
      --python-version 3.12 \
      --admin-password Password*1 \
      --service-account-id aje8r2rp7fkl******** \
      --subnet-ids e9bhbia2scnk********,e2lfqbm5nt9r********,fl8beqmjckv8******** \
      --security-group-ids enp68jq81uun******** \
      --webserver count=1,resource-preset-id=c1-m2 \
      --scheduler count=1,resource-preset-id=c1-m2 \
      --worker min-count=1,max-count=4,resource-preset-id=c1-m2 \
      --dag-processor count=1,resource-preset-id=c1-m2 \
      --dags-bucket <bucket_name>
    ```

- {{ TF }} {#tf}

    Create a {{ maf-name }} cluster with the following test specifications:

    * Folder ID: `b1g4unjqq856********`.
    * Name: `myaf`.
    * {{ AF }} version: `3.0`.
    * Python version: `3.12`.
    * Admin password: `Password*1`.
    * New service account, `af-sa`, with the following roles:
      
      * `managed-airflow.integrationProvider`
      * `storage.editor`
      * `monitoring.editor`
    
    * New network named `af-net` with the following subnets:
      
      * `af-subnet-a` in the `ru-central1-a` availability zone, with the `10.1.0.0/24` address range.
      * `af-subnet-b` in the `ru-central1-b` availability zone, with the `10.2.0.0/24` address range.
      * `af-subnet-d` in the `ru-central1-d` availability zone, with the `10.3.0.0/24` address range.
    
    * New security group, `af-sg`, allowing all incoming and outgoing traffic.
    
    * One web server to host the {{ AF }} instance with the `c1-m2` host class.
    * One scheduler with the `c1-m2` host class.
    * Jobs are performed by `c1-m2` host class workers; from `1` to `4` in number.
    * One DAG processor with the `c1-m2` host class.
    * New bucket of any name for DAG files.

    The configuration file for this cluster is as follows:

    ```hcl
    locals {
      folder_id = "b1g4unjqq856********"
    }
    
    resource "yandex_airflow_cluster" "myaf" {
      name               = "myaf"
      airflow_version    = "3.0"
      python_version     = "3.12"
      admin_password     = "Password*1"
      service_account_id = yandex_iam_service_account.af-sa.id
      subnet_ids         = [yandex_vpc_subnet.af-subnet-a.id,yandex_vpc_subnet.af-subnet-b.id,yandex_vpc_subnet.af-subnet-d.id]
      security_group_ids = [yandex_vpc_security_group.af-sg.id]

      webserver = {
        count              = 1
        resource_preset_id = "c1-m2"
      }

      scheduler = {
        count              = 1
        resource_preset_id = "c1-m2"
      }

      worker = {
        min_count          = 1
        max_count          = 4
        resource_preset_id = "c1-m2"
      }

      dag_processor = {
        count              = 1
        resource_preset_id = "c1-m2"
      }

      code_sync = {
        s3 = {
          bucket = yandex_storage_bucket.af-bucket.bucket
        }
      }
    }

    resource "yandex_vpc_network" "af-net" {
      name = "af-net"
    }

    resource "yandex_vpc_subnet" "af-subnet-a" {
      name           = "af-subnet-a"
      zone           = "ru-central1-a"
      network_id     = yandex_vpc_network.af-net.id
      v4_cidr_blocks = ["10.1.0.0/24"]
    }

    resource "yandex_vpc_subnet" "af-subnet-b" {
      name           = "af-subnet-b"
      zone           = "ru-central1-b"
      network_id     = yandex_vpc_network.af-net.id
      v4_cidr_blocks = ["10.2.0.0/24"]
    }

    resource "yandex_vpc_subnet" "af-subnet-d" {
      name           = "af-subnet-d"
      zone           = "ru-central1-d"
      network_id     = yandex_vpc_network.af-net.id
      v4_cidr_blocks = ["10.3.0.0/24"]
    }

    resource "yandex_vpc_security_group" "af-sg" {
      name       = "af-sg"
      network_id = yandex_vpc_network.af-net.id
  
      ingress {
        protocol       = "ANY"
        v4_cidr_blocks = ["0.0.0.0/0"]
      }

      egress {
        protocol       = "ANY"
        v4_cidr_blocks = ["0.0.0.0/0"]
      }
    }

    resource "yandex_iam_service_account" "af-sa" {
      name = "af-sa"
    }

    resource "yandex_resourcemanager_folder_iam_member" "sa-role-af" {
      folder_id = local.folder_id
      role      = "managed-airflow.integrationProvider"
      member    = "serviceAccount:${yandex_iam_service_account.af-sa.id}"
    }

    resource "yandex_resourcemanager_folder_iam_member" "sa-role-storage" {
      folder_id = local.folder_id
      role      = "storage.editor"
      member    = "serviceAccount:${yandex_iam_service_account.af-sa.id}"
    }

    resource "yandex_resourcemanager_folder_iam_member" "sa-role-monitoring" {
      folder_id = local.folder_id
      role      = "monitoring.editor"
      member    = "serviceAccount:${yandex_iam_service_account.af-sa.id}"
    }

    resource "yandex_storage_bucket" "af-bucket" {
      bucket    = "<bucket_name>"
      folder_id = local.folder_id
    }
    ```

{% endlist %}

### Creating a cluster with a NAT gateway and a Git repository {#with-nat-gateway}

{% list tabs group=instructions %}

- CLI {#cli}

    Create a NAT gateway and a {{ maf-name }} cluster with the following test specifications:

    * Cluster name: `myaf-nat`.
    * {{ AF }} version: `3.0`.
    * Python version: `3.12`.
    * Service account ID: `aje8r2rp7fkl********`.
    * `af-net` network with the following subnets:

      * `af-subnet-a`, with ID `e9bhbia2scnk********`.
      * `af-subnet-b`, with ID `e2lfqbm5nt9r********`.
      * `af-subnet-d`, with ID `fl8beqmjckv8********`.

    * NAT gateway named `af-nat-gateway`.
    * Route table named `af-route-table` and associated with all cluster subnets.
    * Security group ID: `enp68jq81uun********`.
    * One web server to host the {{ AF }} instance with the `c1-m2` host class.
    * One scheduler with the `c1-m2` host class.
    * Jobs are performed by `c1-m2` host class workers; from `1` to `4` in number.
    * One DAG processor with the `c1-m2` host class.
    * Git repository named `git@github.com:<user_name>/<repository_name>.git` with DAG files in the `/dags` directory of the `main` branch.

    Create a NAT gateway:

    ```bash
    yc vpc gateway create \
      --name af-nat-gateway
    ```

    Get the NAT gateway ID:

    ```bash
    yc vpc gateway get af-nat-gateway
    ```

    Create a route table:

    ```bash
    yc vpc route-table create \
      --name af-route-table \
      --network-name af-net \
      --route destination=0.0.0.0/0,gateway-id=<NAT_gateway_ID>
    ```

    Associate the route table with all subnets of your new cluster:

    ```bash
    yc vpc subnet update af-subnet-a \
      --route-table-name af-route-table

    yc vpc subnet update af-subnet-b \
      --route-table-name af-route-table

    yc vpc subnet update af-subnet-d \
      --route-table-name af-route-table
    ```

    Create a cluster:

    ```bash
    {{ yc-mdb-af }} cluster create \
      --name myaf-nat \
      --airflow-version 3.0 \
      --python-version 3.12 \
      --admin-password Password*1 \
      --service-account-id aje8r2rp7fkl******** \
      --subnet-ids e9bhbia2scnk********,e2lfqbm5nt9r********,fl8beqmjckv8******** \
      --security-group-ids enp68jq81uun******** \
      --webserver count=1,resource-preset-id=c1-m2 \
      --scheduler count=1,resource-preset-id=c1-m2 \
      --worker min-count=1,max-count=4,resource-preset-id=c1-m2 \
      --dag-processor count=1,resource-preset-id=c1-m2 \
      --gitsync repo=git@github.com:<username>/<repository_name>.git,`
                `branch=main,`
                `subpath=/dags,`
                `ssh-key-path=<path_to_private_SSH_key>
    ```

- {{ TF }} {#tf}

    Create a NAT gateway and a {{ maf-name }} cluster with the following test specifications:

    * Folder ID: `b1g4unjqq856********`.
    * Cluster name: `myaf-nat`.
    * {{ AF }} version: `3.0`.
    * Python version: `3.12`.
    * Admin password: `Password*1`.
    * New service account named `af-sa` with the `managed-airflow.integrationProvider` and `monitoring.editor` roles.
    * New network named `af-net` with the following subnets:

      * `af-subnet-a` in the `ru-central1-a` availability zone, with the `10.1.0.0/24` address range.
      * `af-subnet-b` in the `ru-central1-b` availability zone, with the `10.2.0.0/24` address range.
      * `af-subnet-d` in the `ru-central1-d` availability zone, with the `10.3.0.0/24` address range.

    * New NAT gateway named `af-nat-gateway`.
    * New route table named `af-route-table` and associated with all cluster subnets.
    * New security group, `af-sg`, allowing all incoming and outgoing traffic.
    * One web server to host the {{ AF }} instance with the `c1-m2` host class.
    * One scheduler with the `c1-m2` host class.
    * Jobs are performed by `c1-m2` host class workers; from `1` to `4` in number.
    * One DAG processor with the `c1-m2` host class.
    * Git repository named `git@github.com:<user_name>/<repository_name>.git` with DAG files in the `/dags` directory of the `main` branch.

    The configuration file for this cluster is as follows:

    ```hcl
    locals {
      folder_id = "b1g4unjqq856********"
    }

    resource "yandex_airflow_cluster" "myaf-nat" {
      name               = "myaf-nat"
      airflow_version    = "3.0"
      python_version     = "3.12"
      admin_password     = "Password*1"
      service_account_id = yandex_iam_service_account.af-sa.id
      subnet_ids         = [yandex_vpc_subnet.af-subnet-a.id,yandex_vpc_subnet.af-subnet-b.id,yandex_vpc_subnet.af-subnet-d.id]
      security_group_ids = [yandex_vpc_security_group.af-sg.id]

      webserver = {
        count              = 1
        resource_preset_id = "c1-m2"
      }

      scheduler = {
        count              = 1
        resource_preset_id = "c1-m2"
      }

      worker = {
        min_count          = 1
        max_count          = 4
        resource_preset_id = "c1-m2"
      }

      dag_processor = {
        count              = 1
        resource_preset_id = "c1-m2"
      }

      code_sync = {
        git_sync = {
          repo     = "git@github.com:<username>/<repository_name>.git"
          branch   = "main"
          sub_path = "/dags"
          ssh_key  = file("<path_to_private_SSH_key>")
        }
      }
    }

    resource "yandex_vpc_network" "af-net" {
      name = "af-net"
    }

    resource "yandex_vpc_subnet" "af-subnet-a" {
      name           = "af-subnet-a"
      zone           = "ru-central1-a"
      network_id     = yandex_vpc_network.af-net.id
      v4_cidr_blocks = ["10.1.0.0/24"]
      route_table_id = yandex_vpc_route_table.af-route-table.id
    }

    resource "yandex_vpc_subnet" "af-subnet-b" {
      name           = "af-subnet-b"
      zone           = "ru-central1-b"
      network_id     = yandex_vpc_network.af-net.id
      v4_cidr_blocks = ["10.2.0.0/24"]
      route_table_id = yandex_vpc_route_table.af-route-table.id
    }

    resource "yandex_vpc_subnet" "af-subnet-d" {
      name           = "af-subnet-d"
      zone           = "ru-central1-d"
      network_id     = yandex_vpc_network.af-net.id
      v4_cidr_blocks = ["10.3.0.0/24"]
      route_table_id = yandex_vpc_route_table.af-route-table.id
    }

    resource "yandex_vpc_gateway" "af-nat-gateway" {
      folder_id = local.folder_id
      name      = "af-nat-gateway"

      shared_egress_gateway {}
    }

    resource "yandex_vpc_route_table" "af-route-table" {
      folder_id = local.folder_id
      name       = "af-route-table"
      network_id = yandex_vpc_network.af-net.id

      static_route {
        destination_prefix = "0.0.0.0/0"
        gateway_id         = yandex_vpc_gateway.af-nat-gateway.id
      }
    }

    resource "yandex_vpc_security_group" "af-sg" {
      name       = "af-sg"
      network_id = yandex_vpc_network.af-net.id

      ingress {
        protocol       = "ANY"
        v4_cidr_blocks = ["0.0.0.0/0"]
      }

      egress {
        protocol       = "ANY"
        v4_cidr_blocks = ["0.0.0.0/0"]
      }
    }

    resource "yandex_iam_service_account" "af-sa" {
      name = "af-sa"
    }

    resource "yandex_resourcemanager_folder_iam_member" "sa-role-af" {
      folder_id = local.folder_id
      role      = "managed-airflow.integrationProvider"
      member    = "serviceAccount:${yandex_iam_service_account.af-sa.id}"
    }

    resource "yandex_resourcemanager_folder_iam_member" "sa-role-monitoring" {
      folder_id = local.folder_id
      role      = "monitoring.editor"
      member    = "serviceAccount:${yandex_iam_service_account.af-sa.id}"
    }
    ```

{% endlist %}

[*nat]: {% include notitle [nat](../../_popups/vpc/nat.md#nat-gateway) %}

[*routing-table]: {% include notitle [route-table](../../_popups/vpc/route-table.md) %}
