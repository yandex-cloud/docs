---
title: Creating an {{ AF }} cluster
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

To create a {{ maf-name }} cluster, your {{ yandex-cloud }} account needs the following roles:

* [{{ roles.maf.editor }}](../security/index.md#managed-airflow-editor) to create a cluster.
* [{{ roles-vpc-user }}](../../vpc/security/index.md#vpc-user) to use the cluster [network](../../vpc/concepts/network.md#network).
* [iam.serviceAccounts.user](../../iam/security/index.md#iam-serviceAccounts-user) to attach a service account to a cluster.

Make sure to grant the `managed-airflow.integrationProvider` role to the cluster service account. The cluster will thus get the permissions it needs to work with user resources. For more information, see [Impersonation](../concepts/impersonation.md).

For more information about assigning roles, see the [{{ iam-full-name }} documentation](../../iam/operations/roles/grant.md).

## Creating a cluster {#create-cluster}

{% list tabs group=instructions %}

- Management console {#console}



  1. In the [management console]({{ link-console-main }}), select the folder where you want to create a cluster.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-airflow }}**.
  1. Click **{{ ui-key.yacloud.airflow.button_create-cluster }}**.
  1. Under **{{ ui-key.yacloud.mdb.forms.section_base }}**:

        1. Enter a name for the cluster. The name must be unique within the folder.
        1. Optionally, enter a description for the cluster.
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

  1. Set the number of instances and a [computing resource configuration](../concepts/index.md#presets) for the {{ maf-name }} [components](../concepts/index.md#components):

      * Web server
      * Scheduler
      * Workers

        {% note info %}

        If the task queue is empty, the number of workers will be the minimum value. When tasks appear, the number of workers will increase up to the maximum value.

        {% endnote %}

      * DAG processor
        
        {% include [dag-processor](../../_includes/mdb/maf/dag-processor.md) %}

      * (Optional) Triggerer services

  1. Optionally, under **{{ ui-key.yacloud.mdb.forms.section_dependencies }}**, specify pip and deb package names to install additional libraries and applications in the cluster to run DAG files.

      To specify multiples packages, click **{{ ui-key.yacloud.common.add }}**.

      You can set version restrictions for the installed packages, e.g.:

      ```text
      pandas==2.0.2
      scikit-learn>=1.0.0
      clickhouse-driver~=0.2.0
      ```

      The package name format and version are defined by the install command: `pip install` for pip packages and `apt install` for deb packages.

      {% note warning %}

      To install pip and deb packages from public repositories, specify a network with configured [egress NAT](../../vpc/operations/create-nat-gateway.md) under **{{ ui-key.yacloud.mdb.forms.section_network-settings }}**.

      {% endnote %}

  1. Under **{{ ui-key.yacloud.airflow.section_storage }}**, select a bucket or create a new one. This bucket will store DAG files.

      Make sure to [grant the `READ` permission](../../storage/operations/buckets/edit-acl.md) for this bucket to the cluster service account.

  1. Optionally, under **{{ ui-key.yacloud.mdb.forms.section_additional }}**:
      
      * Select cluster [maintenance](../concepts/maintenance.md) time:

        {% include [Maintenance window](../../_includes/mdb/console/maintenance-window-description.md) %}

      * Enable cluster deletion protection.

  1. Optionally, under **{{ ui-key.yacloud.airflow.section_airflow-configuration }}**:
  
      * Specify [{{ AF }} additional properties](https://airflow.apache.org/docs/apache-airflow/2.2.4/configurations-ref.html), e.g., `api.maximum_page_limit` as a key and `150` as its value.

        Fill in the fields manually or import the settings from a configuration file (see [configuration file example](https://{{ s3-storage-host }}/doc-files/managed-airflow/airflow.cfg)).

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

    1. View the description of the CLI command to create a cluster:

        ```bash
        {{ yc-mdb-af }} cluster create --help
        ```

    1. Specify cluster parameters in that command (our example does not use all available parameters):

        ```bash
        {{ yc-mdb-af }} cluster create \
           --name <cluster_name> \
           --description <cluster_description> \
           --labels <label_list> \
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
           --maintenance-window type=<maintenance_type>,`
                                `day=<day_of_week>,`
                                `hour=<hour> \
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

        This will create all the resources you need in the specified folder. You can check the new resources and their configuration using the [management console]({{ link-console-main }}).

    For more information, see this [{{ TF }} provider guide]({{ tf-provider-maf }}).

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and save it as an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Create a file named `body.json` and paste the following code into it:

        ```json
        {
          "folderId": "<folder_ID>",
          "name": "<cluster_name>",
          "description": "<cluster_description>",
          "labels": { <label_list> },
          "config": {
            "versionId": "<{{ AF }}_version>",
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
            }
          },
          "maintenanceWindow": {
            "weeklyMaintenanceWindow": {
              "day": "<day_of_week>",
              "hour": "<hour>"
            }
          },
          "deletionProtection": <deletion_protection>,
          "serviceAccountId": "<service_account_ID>",
          "logging": {
            "enabled": <use_of_logging>,
            "minLevel": "<logging_level>",
            "folderId": "<folder_ID>"
          },
          "adminPassword": "<administrator_password>"
        }
        ```

        Where:

        * `folderId`: Folder ID. You can get it with the [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).
        * `name`: Cluster name.
        * `description`: Cluster description.
        * `labels`: List of labels provided in `"<key>": "<value>"` format.
        * `config`: Cluster configuration:

            * `versionId`: {{ AF }} version.
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

        * `codeSync.s3.bucket`: Name of the bucket to store DAG files in.

        * {% include [maintenance](../../_includes/mdb/maf/maintenance-window-rest.md) %}

        * `deletionProtection`: Enables cluster protection against accidental deletion. The possible values are `true` or `false`.

            Even if it is enabled, one can still connect to the cluster manually and delete it.

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

    1. Use the [Cluster.Create](../api-ref/Cluster/create.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://airflow.api.cloud.yandex.net/managed-airflow/v1/clusters' \
            --data '@body.json'
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
          "description": "<cluster_description>",
          "labels": { <label_list> },
          "config": {
            "version_id": "<{{ AF }}_version>",
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
            }
          },
          "maintenance_window": {
            "weekly_maintenance_window": {
              "day": "<day_of_week>",
              "hour": "<hour>"
            }
          },
          "deletion_protection": <deletion_protection>,
          "service_account_id": "<service_account_ID>",
          "logging": {
            "enabled": <use_of_logging>,
            "min_level": "<logging_level>",
            "folder_id": "<folder_ID>"
          },
          "admin_password": "<administrator_password>"
        }
        ```

        Where:

        * `folder_id`: Folder ID. You can get it with the [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).
        * `name`: Cluster name.
        * `description`: Cluster description.
        * `labels`: List of labels provided in `"<key>": "<value>"` format.
        * `config`: Cluster configuration:

            * `version_id`: {{ AF }} version.
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

        * `code_sync.s3.bucket`: Name of the bucket to store DAG files in.

        * {% include [maintenance](../../_includes/mdb/maf/maintenance-window-grpc.md) %}

        * `deletion_protection`: Enables cluster protection against accidental deletion. The possible values are `true` or `false`.

            Even if it is enabled, one can still connect to the cluster manually and delete it.

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

    1. Use the [ClusterService.Create](../api-ref/grpc/Cluster/create.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

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

    1. View the [server response](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}
