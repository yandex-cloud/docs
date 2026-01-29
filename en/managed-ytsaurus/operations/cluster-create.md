---
title: Creating a {{ ytsaurus-name }} cluster
description: Every {{ mtr-name }} cluster consists of a set of {{ ytsaurus-name }} components, each of which may have multiple instances. These instances may reside in different availability zones.
keywords:
  - creating an {{ ytsaurus-name }} cluster
  - '{{ ytsaurus-name }} cluster'
  - '{{ ytsaurus-name }}'
---

# Creating a {{ ytsaurus-name }} cluster

Each {{ myt-name }} cluster consists of a number of {{ ytsaurus-name }} components.

Configurable components:
* Exec and tablet nodes
* Storages
* HTTP and RPC proxies

Non-configurable service components:
* Master nodes
* Storage nodes
* System nodes

## Roles for creating a cluster {#roles}

To create a {{ myt-name }} cluster, your {{ yandex-cloud }} account needs the following roles:

* [managed-ytsaurus.editor](../security/index.md#managed-ytsaurus-editor): To create a cluster.
* [{{ roles-vpc-user }}](../../vpc/security/index.md#vpc-user): To use the cluster [network](../../vpc/concepts/network.md#network).

For more information about assigning roles, see [this {{ iam-full-name }} guide](../../iam/operations/roles/grant.md).

## Creating a cluster {#create-cluster}

{% note info %}

Creating a {{ ytsaurus-name }} cluster takes a while, e.g., an hour or more depending on the selected configuration.

{% endnote %}

In {{ myt-name }}, you can create a [{{ ui-key.yacloud.managed-ytsaurus.clusters.YTSaurusClusterCreatePage.cluster-kind-card_demo_title_4B7zu }}](#demo-cluster) with the minimum operational configuration to test the service or a [{{ ui-key.yacloud.managed-ytsaurus.clusters.YTSaurusClusterCreatePage.cluster-kind-card_production_title_dVEmq }}](#production-cluster) supporting manual cluster setup. 

### Demo cluster {#demo-cluster}

{% list tabs group=instructions %}

- Management console {#console}

    {% include notitle [demo-cluster-create](../../_includes/managed-ytsaurus/demo-cluster-create.md) %}

- {{ TF }} {#tf}

    {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

    {% include [terraform-install](../../_includes/terraform-install.md) %}

    To create a {{ ytsaurus-name }} cluster:

    1. In the configuration file, describe the resources you are creating:

        * {{ ytsaurus-name }} cluster: Cluster description.

        * {% include [Terraform network description](../../_includes/mdb/terraform/network.md) %}

        * {% include [Terraform subnet description](../../_includes/mdb/terraform/subnet.md) %}

        Here is an example of the configuration file structure:

        ```hcl
        resource "yandex_ytsaurus_cluster" "<cluster_name>" {

          description        = "<cluster_description>"
          name               = "<cluster_name>"
          zone_id            = yandex_vpc_subnet.<subnet_name>.zone
          subnet_id          = yandex_vpc_subnet.<subnet_name>.id
          security_group_ids = [<list_of_security_group_IDs>]

          spec = {
            storage = {
              hdd = {
                size_gb = 2048
                count   = 3
              }
              ssd = {
                size_gb = 465
                type    = "network-ssd-nonreplicated"
                count   = 3
              }
            }
            compute = [
              {
                preset = "c8-m32"
                disks = [
                  {
                    size_gb   = 93
                    type      = "network-ssd-nonreplicated"
                  }
                ]
                scale_policy = {
                  fixed = {
                    size = 3
                  }
                }
              }
            ]
            tablet = {
              preset = "c8-m16"
              count  = 3
            }
            proxy = {
              http = {
                count = 2
              }
              rpc = {
                count = 2
              }
            }
          }
        }

        resource "yandex_vpc_network" "<network_name>" { name = "<network_name>" }

        resource "yandex_vpc_subnet" "<subnet_name>" {
          name           = "<subnet_name>"
          zone           = "<availability_zone>"
          network_id     = yandex_vpc_network.<network_name>.id
          v4_cidr_blocks = ["<range>"]
        }
        ```

        Where:

        * `description`: Cluster description.
        * `name`: Cluster name.
        * `zone_id`: [Availability zone](../../overview/concepts/geo-scope.md).
        * `subnet_id`: [Subnet ID](../../vpc/concepts/network.md#subnet).
        * `security_group_ids`: List of [security group](../../vpc/concepts/security-groups.md) IDs.

            {% note warning %}

            You cannot edit any network settings after you create a cluster.

            {% endnote %}

        * `spec`: Configuration of {{ ytsaurus-name }} cluster components:

            * `storage`: Storage parameters:

                * `hdd`: HDD parameters:

                    * `size_gb`: Disk size in GB.
                    * `count`: Number of disks.

                * `ssd`: SSD parameters:

                    * `size_gb`: Disk size in GB.
                    * `type`: Disk type.
                    * `count`: Number of disks.

                {% note warning %}

                You cannot change the disk type or size for a {{ ytsaurus-name }} cluster once you create it.

                {% endnote %}

            * `compute`: Configuration of exec nodes:

                * `preset`: [Computing resource configuration](../concepts/component-types.md#exec-node).
                * `disks`: Parameters of the storage you will use to run jobs.

                    * `size_gb`: Disk size in GB.
                    * `type`: Disk type.

                * `scale_policy.fixed.size`: Number of exec nodes for the fixed scaling policy.

            * `tablet`: Configuration of tablet nodes:

                * `preset`: [Computing resource configuration](../concepts/component-types.md#tablet-node).
                * `count`: Number of tablet nodes.

                To use tablet nodes, make sure to specify the SSD storage parameters (`spec.storage.ssd`).

                {% note warning %}

                You cannot edit the number of tablet nodes after you create a cluster.

                {% endnote %}

            * `proxy`: Proxy parameters:

                * `http.count`: Number of HTTP proxies.
                * `rpc.count`: Number of RPC proxies.

        For more information about the resources you can create with {{ TF }}, see [this provider guide]({{ tf-provider-ytsaurus }}).

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Create a {{ ytsaurus-name }} cluster.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        This will create all the resources you need in the specified folder. You can verify that the new resources have appeared and check their configuration in the [management console]({{ link-console-main }}).

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it in an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Create a file named `body.json` and paste the following code into it:

        ```json
        {
          "folderId": "<folder_ID>",
          "name": "<cluster_name>",
          "description": "<cluster_description>",
          "zoneId": "<availability_zone>",
          "subnetId": "<subnet_ID>",
          "securityGroupIds": [ <list_of_security_group_IDs> ],
          "spec": {
            "storage": {
              "hdd": {
                "sizeGb": "2048",
                "count": "3"
              },
              "ssd": {
                "sizeGb": "465",
                "type": "network-ssd-nonreplicated",
                "count": "3"
              }
            },
            "compute": [
              {
                "preset": "c8-m32",
                "disks": [
                  {
                    "type": "network-ssd-nonreplicated",
                    "sizeGb": "93"
                  }
                ],
                "scalePolicy": {
                  "fixed": {
                    "size": "3"
                  }
                }
              }
            ],
            "tablet": {
              "preset": "c8-m16",
              "count": "3"
            },
            "proxy": {
              "http": {
                "count": "2"
              },
              "rpc": {
                "count": "2"
              }
            }
          }
        }
        ```

        Where:

        * `folderId`: Folder ID. You can get it with the [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).
        * `name`: Cluster name.
        * `description`: Cluster description.
        * `zoneId`: [Availability zone](../../overview/concepts/geo-scope.md).
        * `subnetId`: [Subnet ID](../../vpc/concepts/network.md#subnet).
        * `securityGroupIds`: List of [security group](../../vpc/concepts/security-groups.md) IDs.

            {% note warning %}

            You cannot edit any network settings after you create a cluster.

            {% endnote %}

        * `spec`: Configuration of {{ ytsaurus-name }} cluster components:

            * `storage`: Storage parameters:

                * `hdd`: HDD parameters:

                    * `sizeGb`: Disk size in GB.
                    * `count`: Number of disks.

                * `ssd`: SSD parameters:

                    * `sizeGb`: Disk size in GB.
                    * `type`: Disk type.
                    * `count`: Number of disks.

                {% note warning %}

                You cannot change the disk type or size for a {{ ytsaurus-name }} cluster once you create it.

                {% endnote %}

            * `compute`: Configuration of exec nodes:

                * `preset`: [Computing resource configuration](../concepts/component-types.md#exec-node).
                * `disks`: Parameters of the storage you will use to run jobs.

                    * `type`: Disk type.
                    * `sizeGb`: Disk size in GB.

                * `scalePolicy.fixed.size`: Number of exec nodes for the fixed scaling policy.

            * `tablet`: Configuration of tablet nodes:

                * `preset`: [Computing resource configuration](../concepts/component-types.md#tablet-node).
                * `count`: Number of tablet nodes.

                To use tablet nodes, make sure to specify the SSD storage parameters (`spec.storage.ssd`).

                {% note warning %}

                You cannot edit the number of tablet nodes after you create a cluster.

                {% endnote %}

            * `proxy`: Proxy parameters:

                * `http.count`: Number of HTTP proxies.
                * `rpc.count`: Number of RPC proxies.

    1. Call the [Cluster.Create](../api-ref/Cluster/create.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-ytsaurus }}/ytsaurus/v1/clusters'
            --data '@body.json'
        ```

    1. View the [server response](../api-ref/Cluster/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it in an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Create a file named `body.json` and paste the following code into it:

        ```json
        {
          "folder_id": "<folder_ID>",
          "name": "<cluster_name>",
          "description": "<cluster_description>",
          "zone_id": "<availability_zone>",
          "subnet_id": "<subnet_ID>",
          "security_group_ids": [ <list_of_security_group_IDs> ],
          "spec": {
            "storage": {
              "hdd": {
                "size_gb": "2048",
                "count": "3"
              },
              "ssd": {
                "size_gb": "465",
                "type": "network-ssd-nonreplicated",
                "count": "3"
              }
            },
            "compute": [
              {
                "preset": "c8-m32",
                "disks": [
                  {
                    "type": "network-ssd-nonreplicated",
                    "size_gb": "93"
                  }
                ],
                "scale_policy": {
                  "fixed": {
                    "size": "3"
                  }
                }
              }
            ],
            "tablet": {
              "preset": "c8-m16",
              "count": "3"
            },
            "proxy": {
              "http": {
                "count": "2"
              },
              "rpc": {
                "count": "2"
              }
            }
          }
        }
        ```

        Where:

        * `folder_id`: Folder ID. You can get it with the [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).
        * `name`: Cluster name.
        * `description`: Cluster description.
        * `zone_id`: [Availability zone](../../overview/concepts/geo-scope.md).
        * `subnet_id`: [Subnet ID](../../vpc/concepts/network.md#subnet).
        * `security_group_ids`: List of [security group](../../vpc/concepts/security-groups.md) IDs.

            {% note warning %}

            You cannot edit any network settings after you create a cluster.

            {% endnote %}

        * `spec`: Configuration of {{ ytsaurus-name }} cluster components:

            * `storage`: Storage parameters:

                * `hdd`: HDD parameters:

                    * `size_gb`: Disk size in GB.
                    * `count`: Number of disks.

                * `ssd`: SSD parameters:

                    * `size_gb`: Disk size in GB.
                    * `type`: Disk type.
                    * `count`: Number of disks.

                {% note warning %}

                You cannot change the disk type or size for a {{ ytsaurus-name }} cluster once you create it.

                {% endnote %}

            * `compute`: Configuration of exec nodes:

                * `preset`: [Computing resource configuration](../concepts/component-types.md#exec-node).
                * `disks`: Parameters of the storage you will use to run jobs.

                    * `type`: Disk type.
                    * `size_gb`: Disk size in GB.

                * `scale_policy.fixed.size`: Number of exec nodes for the fixed scaling policy.

            * `tablet`: Configuration of tablet nodes:

                * `preset`: [Computing resource configuration](../concepts/component-types.md#tablet-node).
                * `count`: Number of tablet nodes.

                To use tablet nodes, make sure to specify the SSD storage parameters (`spec.storage.ssd`).

                {% note warning %}

                You cannot edit the number of tablet nodes after you create a cluster.

                {% endnote %}

            * `proxy`: Proxy parameters:

                * `http.count`: Number of HTTP proxies.
                * `rpc.count`: Number of RPC proxies.

    1. Call the [ClusterService.Create](../api-ref/grpc/Cluster/create.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/ytsaurus/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d @ \
            {{ api-host-ytsaurus }}:{{ port-https }} \
            yandex.cloud.ytsaurus.v1.ClusterService.Create \
            < body.json
        ```

    1. Check the [server response](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

### Production cluster {#production-cluster}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder where you want to create a {{ myt-name }} cluster.
    1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-ytsaurus }}**.
    1. Click **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
    1. Select **{{ ui-key.yacloud.managed-ytsaurus.clusters.YTSaurusClusterCreatePage.cluster-kind-card_production_title_dVEmq }}** to create a cluster with manual setup.
    1. Under **{{ ui-key.yacloud.managed-ytsaurus.clusters.YTSaurusClusterCreatePage.base-params-section_title_nfKo2 }}**:
        1. Give the cluster a name. The name must be unique within the folder.
        1. Optionally, enter a description for the cluster.
        1. Optionally, create [labels](../../resource-manager/concepts/labels.md):
            1. Click **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
            1. Enter a label in `key: value` format.
            1. Press **Enter**.

    1. Under **{{ ui-key.yacloud.managed-ytsaurus.clusters.YTSaurusClusterCreatePage.net-settings-section_title_wo42X }}**, select:
       * [Availability zone](../../overview/concepts/geo-scope.md) for the cluster.
       * [Subnet](../../vpc/operations/subnet-create.md).
       * [Security group](../../vpc/concepts/security-groups.md) for the cluster’s network traffic. This is an optional setting.

       {% note warning %}
       
       You cannot edit any network settings after you create a cluster.
       
       {% endnote %}

    1. Under **{{ ui-key.yacloud.managed-ytsaurus.clusters.YTSaurusClusterCreatePage.filestore-section_title_tYMR7 }}**, click **{{ ui-key.yacloud.common.add }}** and select the disk type, size, and number.

       The type you select determines the increments for changing the disk size:
          * Network HDD and SSD storage: In increments of 1 GB.
          * Non-replicated SSD storage: In increments of 93 GB.

       The `HDD` storage is required and added by default. Edit the disk number and size as appropriate.

       {% note warning %}
       
       You cannot change the disk type or size for a {{ ytsaurus-name }} cluster once you create it.
       
       {% endnote %}
    
    1. Under **{{ ui-key.yacloud.managed-ytsaurus.clusters.YTSaurusClusterCreatePage.exec-node-configuration-section_title_mfa54 }}**, specify:
       * Number of nodes.
       * [Computing resource configuration](../concepts/component-types.md#exec-node).
       * Type and size of the storage you will use to run jobs.

    1. Under **{{ ui-key.yacloud.managed-ytsaurus.clusters.YTSaurusClusterCreatePage.tablet-node-configuration-section_title_fHZeX }}**, specify:
       * Number of nodes.
       * [Computing resource configuration](../concepts/component-types.md#tablet-node).

       To use tablet nodes, add an `SSD` or `non-replicated SSD` storage.

       {% note warning %}
       
       You cannot edit the number of tablet nodes after you create a cluster.
       
       {% endnote %}
    
    1. Under **{{ ui-key.yacloud.managed-ytsaurus.clusters.YTSaurusClusterCreatePage.http-config-section_title_kMdci }}** and **{{ ui-key.yacloud.managed-ytsaurus.clusters.YTSaurusClusterCreatePage.rpc-config-section_title_tGACF }}**, set the number of proxies.

       {% note warning %}
       
       You cannot edit the number of proxy nodes after you create a cluster.
       
       {% endnote %}

    1. Click **{{ ui-key.yacloud.common.create }}**.
    1. Wait until the cluster is ready: its status on the {{ myt-name }} dashboard will change to **Running**. This may take a while.

- {{ TF }} {#tf}

    {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

    {% include [terraform-install](../../_includes/terraform-install.md) %}

    To create a {{ ytsaurus-name }} cluster:

    1. In the configuration file, describe the resources you are creating:

        * {{ ytsaurus-name }} cluster: Cluster description.

        * {% include [Terraform network description](../../_includes/mdb/terraform/network.md) %}

        * {% include [Terraform subnet description](../../_includes/mdb/terraform/subnet.md) %}

        Here is an example of the configuration file structure:

        ```hcl
        resource "yandex_ytsaurus_cluster" "<cluster_name>" {

          description        = "<cluster_description>"
          name               = "<cluster_name>"
          zone_id            = yandex_vpc_subnet.<subnet_name>.zone
          subnet_id          = yandex_vpc_subnet.<subnet_name>.id
          security_group_ids = [<list_of_security_group_IDs>]

          labels = {
            <label_list>
          }

          spec = {
            storage = {
              hdd = {
                size_gb = <disk_size_in_GB>
                count   = <number_of_disks>
              }
              ssd = {
                size_gb = <disk_size_in_GB>
                type    = "<disk_type>"
                count   = <number_of_disks>
              }
            }
            compute = [
              {
                preset = "<computing_resource_configuration>"
                disks = [
                  {
                    size_gb   = <disk_size_in_GB>
                    type      = "<disk_type>"
                  }
                ]
                scale_policy = {
                  fixed = {
                    size = <number_of_exec_nodes>
                  }
                }
                name = "default"
              }
            ]
            tablet = {
              preset = "<computing_resource_configuration>"
              count  = <number_of_tablet_nodes>
            }
            proxy = {
              http = {
                count = <number_of_HTTP_proxies>
              }
              rpc = {
                count = <number_of_RPC_proxies>
              }
            },
            odin = {
              checks_ttl = "<frequency_of_checks>"
            }
          }
        }

        resource "yandex_vpc_network" "<network_name>" { name = "<network_name>" }

        resource "yandex_vpc_subnet" "<subnet_name>" {
          name           = "<subnet_name>"
          zone           = "<availability_zone>"
          network_id     = yandex_vpc_network.<network_name>.id
          v4_cidr_blocks = ["<range>"]
        }
        ```

        Where:

        * `description`: Cluster description.
        * `name`: Cluster name.
        * `zone_id`: [Availability zone](../../overview/concepts/geo-scope.md).
        * `subnet_id`: [Subnet ID](../../vpc/concepts/network.md#subnet).
        * `security_group_ids`: List of [security group](../../vpc/concepts/security-groups.md) IDs.

            {% note warning %}

            You cannot edit any network settings after you create a cluster.

            {% endnote %}

        * `labels`: List of labels Provide labels in `<key> = "<value>"` format.
        * `spec`: Configuration of {{ ytsaurus-name }} cluster components:

            * `storage`: Storage parameters:

                * `hdd`: HDD parameters:

                    * `size_gb`: Disk size in GB.
                    * `count`: Number of disks.

                * `ssd`: SSD parameters:

                    * `size_gb`: Disk size in GB.
                    * `type`: Disk type, `network-ssd` or `network-ssd-nonreplicated`.
                    * `count`: Number of disks.

                The selected type determines the increments in which you can set your disk size when creating a cluster:

                * Network HDD and SSD storage: In increments of 1 GB.
                * Non-replicated SSD storage: In increments of 93 GB.

                An HDD is required.

                {% note warning %}

                You cannot change the disk type or size for a {{ ytsaurus-name }} cluster once you create it.

                {% endnote %}

            * `compute`: Configuration of exec nodes:

                * `preset`: [Computing resource configuration](../concepts/component-types.md#exec-node).
                * `disks`: Parameters of the storage you will use to run jobs.

                    * `size_gb`: Disk size in GB.
                    * `type`: Disk type, `network-hdd`, `network-ssd`, or `network-ssd-nonreplicated`.

                    The selected type determines the increments in which you can set your disk size when creating a cluster:

                    * Network HDD and SSD storage: In increments of 1 GB.
                    * Non-replicated SSD storage: In increments of 93 GB.

                * `scale_policy.fixed.size`: Number of exec nodes for the fixed scaling policy.
                * `name`: Exec pool name.

            * `tablet`: Configuration of tablet nodes:

                * `preset`: [Computing resource configuration](../concepts/component-types.md#tablet-node).
                * `count`: Number of tablet nodes.

                To use tablet nodes, make sure to specify the SSD storage parameters (`spec.storage.ssd`).

                {% note warning %}

                You cannot edit the number of tablet nodes after you create a cluster.

                {% endnote %}

            * `proxy`: Proxy parameters:

                * `http.count`: Number of HTTP proxies.
                * `rpc.count`: Number of RPC proxies.

            * `odin.checks_ttl`: Frequency of checks by Odin, an internal monitoring tool. Provide with units of measurement: `h` (hours), `m` (minutes), `s` (seconds). Here is an example: `336h0m0s` (2 weeks).

        For more information about the resources you can create with {{ TF }}, see [this provider guide]({{ tf-provider-ytsaurus }}).

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Create a {{ myt-name }} cluster.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        This will create all the resources you need in the specified folder. You can verify that the new resources have appeared and check their configuration in the [management console]({{ link-console-main }}).

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it in an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Create a file named `body.json` and paste the following code into it:

        ```json
        {
          "folderId": "<folder_ID>",
          "name": "<cluster_name>",
          "description": "<cluster_description>",
          "labels": { <label_list> },
          "zoneId": "<availability_zone>",
          "subnetId": "<subnet_ID>",
          "securityGroupIds": [ <list_of_security_group_IDs> ],
          "spec": {
            "storage": {
              "hdd": {
                "sizeGb": "<disk_size_in_GB>",
                "count": "<number_of_disks>"
              },
              "ssd": {
                "sizeGb": "<disk_size_in_GB>",
                "type": "<disk_type>",
                "count": "<number_of_disks>"
              }
            },
            "compute": [
              {
                "preset": "<computing_resource_configuration>",
                "disks": [
                  {
                    "type": "<disk_type>",
                    "sizeGb": "<disk_size_in_GB>"
                  }
                ],
                "scalePolicy": {
                  "fixed": {
                    "size": "<number_of_exec_nodes>"
                  }
                },
                "name": "default"
              }
            ],
            "tablet": {
              "preset": "<computing_resource_configuration>",
              "count": "<number_of_tablet_nodes>"
            },
            "proxy": {
              "http": {
                "count": "<number_of_HTTP_proxies>"
              },
              "rpc": {
                "count": "<number_of_RPC_proxies>"
              }
            },
            "odin": {
              "checksTtl": "<frequency_of_checks_in_seconds>"
            }
          }
        }
        ```

        Where:

        * `folderId`: Folder ID. You can get it with the [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).
        * `name`: Cluster name.
        * `description`: Cluster description.
        * `labels`: List of labels provided in `"<key>": "<value>"` format.
        * `zoneId`: [Availability zone](../../overview/concepts/geo-scope.md).
        * `subnetId`: [Subnet ID](../../vpc/concepts/network.md#subnet).
        * `securityGroupIds`: List of [security group](../../vpc/concepts/security-groups.md) IDs.

            {% note warning %}

            You cannot edit any network settings after you create a cluster.

            {% endnote %}

        * `spec`: Configuration of {{ ytsaurus-name }} cluster components:

            * `storage`: Storage parameters:

                * `hdd`: HDD parameters:

                    * `sizeGb`: Disk size in GB.
                    * `count`: Number of disks.

                * `ssd`: SSD parameters:

                    * `sizeGb`: Disk size in GB.
                    * `type`: Disk type, `network-ssd` or `network-ssd-nonreplicated`.
                    * `count`: Number of disks.

                The selected type determines the increments in which you can set your disk size when creating a cluster:

                * Network HDD and SSD storage: In increments of 1 GB.
                * Non-replicated SSD storage: In increments of 93 GB.

                An HDD is required.

                {% note warning %}

                You cannot change the disk type or size for a {{ ytsaurus-name }} cluster once you create it.

                {% endnote %}

            * `compute`: Configuration of exec nodes:

                * `preset`: [Computing resource configuration](../concepts/component-types.md#exec-node).
                * `disks`: Parameters of the storage you will use to run jobs.

                    * `type`: Disk type, `network-hdd`, `network-ssd`, or `network-ssd-nonreplicated`.
                    * `sizeGb`: Disk size in GB.

                    The selected type determines the increments in which you can set your disk size when creating a cluster:

                    * Network HDD and SSD storage: In increments of 1 GB.
                    * Non-replicated SSD storage: In increments of 93 GB.

                * `scalePolicy.fixed.size`: Number of exec nodes for the fixed scaling policy.
                * `name`: Exec pool name.

            * `tablet`: Configuration of tablet nodes:

                * `preset`: [Computing resource configuration](../concepts/component-types.md#tablet-node).
                * `count`: Number of tablet nodes.

                To use tablet nodes, make sure to specify the SSD storage parameters (`spec.storage.ssd`).

                {% note warning %}

                You cannot edit the number of tablet nodes after you create a cluster.

                {% endnote %}

            * `proxy`: Proxy parameters:

                * `http.count`: Number of HTTP proxies.
                * `rpc.count`: Number of RPC proxies.

            * `odin.checksTtl`: Frequency of checks by Odin, an internal monitoring tool. Specify it in seconds (`s`), e.g., `1209600s` (2 weeks).

    1. Call the [Cluster.Create](../api-ref/Cluster/create.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-ytsaurus }}/ytsaurus/v1/clusters' \
            --data '@body.json'
        ```

    1. View the [server response](../api-ref/Cluster/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it in an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Create a file named `body.json` and paste the following code into it:

        ```json
        {
          "folder_id": "<folder_ID>",
          "name": "<cluster_name>",
          "description": "<cluster_description>",
          "labels": { <label_list> },
          "zone_id": "<availability_zone>",
          "subnet_id": "<subnet_ID>",
          "security_group_ids": [ <list_of_security_group_IDs> ],
          "spec": {
            "storage": {
              "hdd": {
                "size_gb": "<disk_size_in_GB>",
                "count": "<number_of_disks>"
              },
              "ssd": {
                "size_gb": "<disk_size_in_GB>",
                "type": "<disk_type>",
                "count": "<number_of_disks>"
              }
            },
            "compute": [
              {
                "preset": "<computing_resource_configuration>",
                "disks": [
                  {
                    "type": "<disk_type>",
                    "size_gb": "<disk_size_in_GB>"
                  }
                ],
                "scale_policy": {
                  "fixed": {
                    "size": "<number_of_exec_nodes>"
                  }
                },
                "name": "default"
              }
            ],
            "tablet": {
              "preset": "<computing_resource_configuration>",
              "count": "<number_of_tablet_nodes>"
            },
            "proxy": {
              "http": {
                "count": "<number_of_HTTP_proxies>"
              },
              "rpc": {
                "count": "<number_of_RPC_proxies>"
              }
            },
            "odin": {
              "checks_ttl": "<frequency_of_checks_in_seconds>"
            }
          }
        }
        ```

        Where:

        * `folderId`: Folder ID. You can get it with the [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).
        * `name`: Cluster name.
        * `description`: Cluster description.
        * `labels`: List of labels provided in `"<key>": "<value>"` format.
        * `zone_id`: [Availability zone](../../overview/concepts/geo-scope.md).
        * `subnet_id`: [Subnet ID](../../vpc/concepts/network.md#subnet).
        * `security_group_ids`: List of [security group](../../vpc/concepts/security-groups.md) IDs.

            {% note warning %}

            You cannot edit any network settings after you create a cluster.

            {% endnote %}

        * `spec`: Configuration of {{ ytsaurus-name }} cluster components:

            * `storage`: Storage parameters:

                * `hdd`: HDD parameters:

                    * `size_gb`: Disk size in GB.
                    * `count`: Number of disks.

                * `ssd`: SSD parameters:

                    * `size_gb`: Disk size in GB.
                    * `type`: Disk type, `network-ssd` or `network-ssd-nonreplicated`.
                    * `count`: Number of disks.

                The selected type determines the increments in which you can set your disk size when creating a cluster:

                * Network HDD and SSD storage: In increments of 1 GB.
                * Non-replicated SSD storage: In increments of 93 GB.

                An HDD is required.

                {% note warning %}

                You cannot change the disk type or size for a {{ ytsaurus-name }} cluster once you create it.

                {% endnote %}

            * `compute`: Configuration of exec nodes:

                * `preset`: [Computing resource configuration](../concepts/component-types.md#exec-node).
                * `disks`: Parameters of the storage you will use to run jobs.

                    * `type`: Disk type, `network-hdd`, `network-ssd`, or `network-ssd-nonreplicated`.
                    * `size_gb`: Disk size in GB.

                    The selected type determines the increments in which you can set your disk size when creating a cluster:

                    * Network HDD and SSD storage: In increments of 1 GB.
                    * Non-replicated SSD storage: In increments of 93 GB.

                * `scale_policy.fixed.size`: Number of exec nodes for the fixed scaling policy.
                * `name`: Exec pool name.

            * `tablet`: Configuration of tablet nodes:

                * `preset`: [Computing resource configuration](../concepts/component-types.md#tablet-node).
                * `count`: Number of tablet nodes.

                To use tablet nodes, make sure to specify the SSD storage parameters (`spec.storage.ssd`).

                {% note warning %}

                You cannot edit the number of tablet nodes after you create a cluster.

                {% endnote %}

            * `proxy`: Proxy parameters:

                * `http.count`: Number of HTTP proxies.
                * `rpc.count`: Number of RPC proxies.

            * `odin.checks_ttl`: Frequency of checks by Odin, an internal monitoring tool. Specify it in seconds (`s`), e.g., `1209600s` (2 weeks).

    1. Call the [ClusterService.Create](../api-ref/grpc/Cluster/create.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/ytsaurus/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d @ \
            {{ api-host-ytsaurus }}:{{ port-https }} \
            yandex.cloud.ytsaurus.v1.ClusterService.Create \
            < body.json
        ```

    1. Check the [server response](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Examples {#examples}

{% list tabs group=instructions %}

- {{ TF }} {#tf}

    Create a {{ myt-name }} cluster and its supporting network, using the following test specifications:

    * Name: `my-ytsaurus-cluster`.
    * Network: `my-network`.
    * Subnet: `my-subnet`. The subnet availability zone is `ru-central1-a`; the range is `10.1.0.0/16`.
    * Storage:

        * `4` HDDs, size: `4096` GB.
        * `3` `network-ssd` SSDs, size: `512` GB.

    * Exec nodes:

        * Number of nodes: `5`.
        * [Computing resource configuration](../concepts/component-types.md#exec-node): `c8-m32`.
        * Disk type: `network-ssd`, size: `512` GB.

    * Tablet nodes:

        * Number of nodes: `3`.
        * [Computing resource configuration](../concepts/component-types.md#tablet-node): `c8-m16`.

    * HTTP and RPC proxies: `5` of each type.

    The configuration file for this cluster is as follows:

    ```hcl
    resource "yandex_ytsaurus_cluster" "my-ytsaurus-cluster" {

      name               = "my-ytsaurus-cluster"
      zone_id            = yandex_vpc_subnet.my-subnet.zone
      subnet_id          = yandex_vpc_subnet.my-subnet.id

      spec = {
        storage = {
          hdd = {
            size_gb = 4096
            count   = 4
          }
          ssd = {
            size_gb = 512
            type    = "network-ssd"
            count   = 3
          }
        }
        compute = [
          {
            preset = "c8-m32"
            disks = [
              {
                size_gb   = 512
                type      = "network-ssd"
              }
            ]
            scale_policy = {
              fixed = {
                size = 5
              }
            }
          }
        ]
        tablet = {
          preset = "c8-m16"
          count  = 3
        }
        proxy = {
          http = {
            count = 5
          }
          rpc = {
            count = 5
          }
        }
      }
    }

    resource "yandex_vpc_network" "my-network" { name = "my-network" }

    resource "yandex_vpc_subnet" "my-subnet" {
      name           = "my-subnet"
      zone           = "ru-central1-a"
      network_id     = yandex_vpc_network.my-network.id
      v4_cidr_blocks = ["10.1.0.0/16"]
    }
    ```

{% endlist %}
