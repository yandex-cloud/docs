# Creating clusters

A cluster in {{ mkf-name }} is one or more broker hosts where topics and their partitions are located. Producers and consumers can work with these topics by connecting to cluster hosts.

The number of broker hosts that can be created together with a {{ KF }} cluster depends on the selected [type of storage](../concepts/storage.md):

* With **local SSD** or **non-replicated SSD** storage, you can create a cluster with three or more broker hosts (a minimum of three broker hosts is required for fault tolerance).
* With **HDD network** or **SSD network** storage, you can add any number of broker hosts within the [current quota](../concepts/limits.md).

After creating a cluster, you can add extra broker hosts to it if there are enough available [folder resources](../concepts/limits.md).

{% include [mkf-zk-hosts](../../_includes/mdb/mkf-zk-hosts.md) %}

## How to create a {{ mkf-name }} cluster {#create-cluster}

{% list tabs %}

- Management console

  1. Go to the folder page and select **{{ mkf-name }}**.
  1. Click **Create cluster**.
  1. Under **Basic parameters**:
     1. Enter a name for the cluster and, if necessary, a description. The cluster name must be unique within the folder.
     1. Select the environment where you want to create the cluster (you can't change the environment once the cluster is created):
        * `PRODUCTION`: For stable versions of your apps.
        * `PRESTABLE`: For testing, including the {{ mkf-name }} service itself. The Prestable environment is first updated with new features, improvements, and bug fixes. However, not every update ensures backward compatibility.
     1. Select the {{ KF }} version.
     1. To manage topics via the {{ KF }} Admin API:

         {% include [mkf-admin-api-alert](../../_includes/mdb/mkf/admin-api-alert.md) %}

         1. Enable **Manage topics via the API**.
         1. After creating a cluster, [create an administrator account](./cluster-accounts.md#create-account).
     1. To manage data schemas using [{{ mkf-msr }}](../concepts/managed-schema-registry.md), enable the **Data Schema Registry** setting.

         {% include [mkf-schema-registry-alert](../../_includes/mdb/mkf/schema-registry-alert.md) %}

     1. To manage data schemas using [{{ mkf-msr }}](../concepts/managed-schema-registry.md), enable the **Data Schema Registry** setting.

         {% include [mkf-schema-registry-alert](../../_includes/mdb/mkf/schema-registry-alert.md) %}

  1. Under **Host class**, select the platform, host type, and host class.

     The host class defines the technical specifications of the VMs where the [{{ KF }} brokers](../concepts/brokers.md) will be deployed. All available options are listed in [Host classes](../concepts/instance-types.md).

     By [changing the host class](cluster-update.md#change-resource-preset) for a cluster, you also change the characteristics of all the existing instances.

  1. Under **Storage**:

     * Select one of the following [storage types](../concepts/storage.md):
       * Either more flexible storage on network HDDs (`network-hdd`), network SSDs (`network-ssd`), or non-replicated SSDs (`network-ssd-nonreplicated`).
       * Or faster local SSD storage (`local-ssd`).

        {% include [storages-step-settings](../../_includes/mdb/settings-storages-no-broadwell.md) %}

     * Select the size of storage to be used for data.

  1. Under **Network settings**:
     {% if audience != "internal" %}

     1. Select one or more [availability zones](../../overview/concepts/geo-scope.md) where the {{ KF }} brokers will reside.
     1. Select the [network](../../vpc/concepts/network.md).
     1. Select subnets in each availability zone for this network. To [create a new subnet](../../vpc/operations/subnet-create.md), click **Create new subnet** next to the desired availability zone.

     {% else %}

     1. Select one or more availability zones to host {{ KF }} brokers.
     1. Select a network.
     1. Select subnets in each availability zone for this network. To create a new subnet, click **Create new subnet** next to the desired availability zone.

     {% endif %}

        {% note info %}

        For a cluster with multiple broker hosts, you need to specify subnets in each availability zone even if you plan to host brokers only in some of them. These subnets are required to host three {{ ZK }} hosts — one in each availability zone. For more information, see [Resource relationships in {{ mkf-name }}](../concepts/index.md).

        {% endnote %}

     1. Select security groups to control the cluster's network traffic.

     1. To access broker hosts from the internet, select **Public access**. In this case, you can only connect to them over an SSL connection. For more information, see [{#T}](connect.md).

        {% note warning %}

        You can't request public access after creating a cluster.

        {% endnote %}

     1. Select security groups to control the cluster's network traffic.

  1. Under **Hosts**:

     1. Specify the number of {{ KF }} [broker hosts](../concepts/brokers.md) to be located in each of the selected availability zones.

         When choosing the number of hosts, keep in mind that:
         * The {{ KF }} cluster hosts will be evenly deployed in the selected availability zones. Decide on the number of zones and hosts per zone based on the required fault tolerance model and cluster load.
         * Replication is possible if there are at least two hosts in the cluster.
         * If you selected `local-ssd` or `network-ssd-nonreplicated` under **Storage**, you need to add at least 3 hosts to the cluster.
         * Adding more than one host to the cluster automatically adds three {{ ZK }} hosts.
     {% if audience != "internal" %}
     1. (Optional) Select groups of [dedicated hosts](../../compute/concepts/dedicated-host.md) to host the cluster on.

         {% include [Dedicated hosts note](../../_includes/mdb/mkf/note-dedicated-hosts.md) %}
     {% endif %}

  1. If you specify two or more broker hosts, under **Host class {{ ZK }}**, specify the characteristics of the [{{ ZK }} hosts](../concepts/index.md) to be located in each of the selected availability zones.

  1. If necessary, configure additional cluster settings:

      {% include [extra-settings](../../_includes/mdb/mkf/extra-settings.md) %}

  1. If necessary, configure the [{{ KF }} settings](../concepts/settings-list.md#cluster-settings).

  1. Click **Create cluster**.

  1. Wait until the cluster is ready: its status on the {{ mkf-short-name }} dashboard changes to **Running** and its state to **Alive**. This may take some time.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. View a description of the CLI create cluster command:

      ```bash
      {{ yc-mdb-kf }} cluster create --help
      ```

  1. Specify the cluster parameters in the create command (only some of the supported parameters are given in the example):

      ```bash
      {{ yc-mdb-kf }} cluster create \
         --name <cluster name> \
         --environment <prestable or production> \
         --version <version: 2.1, 2.6, or 2.8> \
         --network-name <network name> \
         --brokers-count <number of brokers in the zone> \
         --resource-preset <host class> \
         --disk-type <network-hdd | network-ssd | local-ssd | network-ssd-nonreplicated> \
         --disk-size <storage size in GB> \
         --assign-public-ip <public access> \
         --security-group-ids <list of security group IDs> \
         --deletion-protection=<protect cluster from deletion: true or false>
      ```

      {% include [deletion-protection-limits-data](../../_includes/mdb/deletion-protection-limits-data.md) %}

      If necessary, you can also configure the [{{ KF }} settings](../concepts/settings-list.md#cluster-settings) here.

  1. To manage topics via the {{ KF }} Admin API:

      {% include [mkf-topic-api-alert](../../_includes/mdb/mkf/admin-api-alert.md) %}

      1. When creating a cluster, set the `--unmanaged-topics` parameter to `true`:

          ```bash
          {{ yc-mdb-kf }} cluster create \
             ...
             --unmanaged-topics true
          ```

      1. After creating a cluster, [create an administrator account](./cluster-accounts.md#create-account).

  {% if audience != "internal" %}

  1. To create a cluster hosted using groups of [dedicated hosts](../../compute/concepts/dedicated-host.md), list their IDs separated by commas in the `--host-group-ids` parameter when creating a cluster:

      ```bash
      {{ yc-mdb-kf }} cluster create \
         ...
         --host-group-ids <IDs of dedicated host groups>
      ```

      {% include [Dedicated hosts note](../../_includes/mdb/mkf/note-dedicated-hosts.md) %}

{% endif %}

- Terraform

    {% include [terraform-definition](../../_includes/tutorials/terraform-definition.md) %}

    {% if audience != "internal" %}

    If you don't have Terraform, [install it and configure the provider](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

    {% else %}

    If you don't have Terraform, install it and configure the provider.

    {% endif %}

    To create a cluster:

    1. In the configuration file, describe the parameters of resources that you want to create:

        {% include [terraform-create-cluster-step-1](../../_includes/mdb/terraform-create-cluster-step-1.md) %}

        If necessary, you can also configure the [{{ KF }} settings](../concepts/settings-list.md#cluster-settings) here.

        Example configuration file structure:

        ```hcl
        terraform {
          required_providers {
            yandex = {
             source = "yandex-cloud/yandex"
            }
          }
        }
        
        provider "yandex" {
          token     = "<OAuth or static key of service account>"
          cloud_id  = "<cloud ID>"
          folder_id = "<folder ID>"
          zone      = "<availability zone>"
        }
        
        resource "yandex_mdb_kafka_cluster" "<cluster name>" {
          environment         = "<environment: PRESTABLE or PRODUCTION>"
          name                = "<cluster name>"
          network_id          = "<network ID>"
          security_group_ids  = ["<list of cluster security group IDs>"]
          deletion_protection = <protect cluster from deletion: true or false>
        
          config {
            assign_public_ip = "<public access to the cluster: true or false>"
            brokers_count    = <number of brokers>
            version          = "<Apache Kafka version: 2.1, 2.6 or 2.8>"
            schema_registry  = "<data schema management: true or false>"
            kafka {
              resources {
                disk_size          = <storage size in GB>
                disk_type_id       = "<storage type: network-ssd, network-hdd, network-ssd-nonreplicated, or local-ssd>"
                resource_preset_id = "<host class>"
              }
            }
        
            zones = [
              "<availability zones>"
            ]
          }
        }
        
        resource "yandex_vpc_network" "<network name>" {
          name = "<network name>"
        }
        
        resource "yandex_vpc_subnet" "<subnet name>" {
          name           = "<subnet name>"
          zone           = "<availability zone>"
          network_id     = "<network ID>"
          v4_cidr_blocks = ["<range>"]
        }
        ```

        {% include [deletion-protection-limits-data](../../_includes/mdb/deletion-protection-limits-data.md) %}

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Create a cluster.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        After this, all the necessary resources will be created in the specified folder and the IP addresses of the VMs will be displayed in the terminal. You can check resource availability and their settings in the [management console]({{ link-console-main }}).

    For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mkf }}).

- API

    Use the [create](../api-ref/Cluster/create.md) API method and pass the following information in the request:

    * The ID of the folder where the cluster should be placed in the `folderId` parameter.
    * The cluster name in the `name` parameter.
    * Security group IDs in the parameter `securityGroupIds`.
    * Cluster deletion protection settings in the `deletionProtection` parameter.

        {% include [deletion-protection-limits-data](../../_includes/mdb/deletion-protection-limits-data.md) %}

    To manage topics via the {{ KF }} Admin API:

    {% include [mkf-topic-api-alert](../../_includes/mdb/mkf/admin-api-alert.md) %}

    1. Pass `true` for the `unmanagedTopics` parameter.
    1. After creating a cluster, [create an administrator account](./cluster-accounts.md#create-account).

    To manage data schemas using [{{ mkf-msr }}](../concepts/managed-schema-registry.md), pass the `true` value for the `configSpec.schemaRegistry` parameter.

    {% include [mkf-schema-registry-alert](../../_includes/mdb/mkf/schema-registry-alert.md) %}

    {% if audience != "internal" %}
    
    To create a cluster hosted using groups of [dedicated hosts](../../compute/concepts/dedicated-host.md), pass their IDs in the `hostGroupIds` parameter.
    
    {% endif %}

    {% include [Dedicated hosts note](../../_includes/mdb/mkf/note-dedicated-hosts.md) %}

    To manage data schemas using [{{ mkf-msr }}](../concepts/managed-schema-registry.md), pass the `true` value for the `configSpec.schemaRegistry` parameter.
  
    {% include [mkf-schema-registry-alert](../../_includes/mdb/mkf/schema-registry-alert.md) %}


{% endlist %}

{% note warning %}

If you specified security group IDs when creating a cluster, you may also need to [re-configure security groups](connect.md#configuring-security-groups) to connect to the cluster.

{% endnote %}

## Examples {#examples}

### Creating a single-host cluster {#creating-a-single-host-cluster}

{% list tabs %}

- CLI

  Let's say we need to create a {{ mkf-name }} cluster with the following characteristics:

  {% if audience != "internal" %}

  * With the name `mykf`.
  * In the `production` environment.
  * With {{ KF }} version `2.6`.
  * In the `{{ network-name }}` network.
  * In the security group `{{ security-group }}`.
  * With one `{{ host-class }}` host in the `{{ zone-id }}` availability zone.
  * With one broker.
  * With 10 GB of SSD network storage (`{{ disk-type-example }}`).
  * With public access.
  * With accidental cluster deletion protection.

  {% else %}

  * With the name `mykf`.
  * In the `production` environment.
  * With {{ KF }} version `2.6`.
  * In the `{{ network-name }}` network.
  * In the security group `{{ security-group }}`.
  * With one `{{ host-class }}` host in the `{{ zone-id }}` availability zone.
  * With one broker.
  * With 10 GB of local SSD storage (`{{ disk-type-example }}`).
  * With public access.
  * With accidental cluster deletion protection.

  {% endif %}

  Run the command:

  {% if audience != "internal" %}

  ```bash
  {{ yc-mdb-kf }} cluster create \
  --name mykf \
  --environment production \
  --version 2.6 \
  --network-name {{ network-name }} \
  --zone-ids {{ zone-id }} \
  --brokers-count 1 \
  --resource-preset {{ host-class }} \
  --disk-size 10 \
  --disk-type {{ disk-type-example }} \
  --assign-public-ip \
  --security-group-ids {{ security-group }} \
  --deletion-protection=true
  ```

  {% else %}

  ```bash
  {{ yc-mdb-kf }} cluster create \
     --name mykf \
     --environment production \
     --version 2.6 \
     --network-name {{ network-name }} \
     --zone-ids {{ zone-id }} \
     --brokers-count 1 \
     --resource-preset {{ host-class }} \
     --disk-size 10 \
     --disk-type {{ disk-type-example }} \
     --assign-public-ip \
     --security-group-ids {{ security-group }} \
     --deletion-protection=true
  ```

  {% endif %}

- Terraform

  Let's say we need to create a {{ mkf-name }} cluster with the following characteristics:

    * In the cloud with the ID `{{ tf-cloud-id }}`.
    * In the folder with the ID `{{ tf-folder-id }}`.
    * With the name `mykf`.
    * In the `PRODUCTION` environment.
    * With {{ KF }} version `2.6`.
    * In the new `mynet` network with the subnet `mysubnet`.
    * In the new security group `mykf-sg` allowing connection to the cluster from the Internet via port `9091`.
    * With one `{{ host-class }}` host in the `{{ zone-id }}` availability zone.
    * With one broker.
    * With 10 GB of SSD network storage (`{{ disk-type-example }}`).
    * With public access.
    * With accidental cluster deletion protection.

  The configuration file for the cluster looks like this:

    ```hcl
    terraform {
      required_providers {
        yandex = {
          source = "yandex-cloud/yandex"
        }
      }
    }
    
    provider "yandex" {
      token     = "<OAuth or static key of service account>"
      cloud_id  = "{{ tf-cloud-id }}"
      folder_id = "{{ tf-folder-id }}"
      zone      = "{{ zone-id }}"
    }
    
    resource "yandex_mdb_kafka_cluster" "mykf" {
      environment         = "PRODUCTION"
      name                = "mykf"
      network_id          = yandex_vpc_network.mynet.id
      security_group_ids  = [ yandex_vpc_security_group.mykf-sg.id ]
      deletion_protection = true
    
      config {
        assign_public_ip = true
        brokers_count    = 1
        version          = "2.6"
        kafka {
          resources {
            disk_size          = 10
            disk_type_id       = "{{ disk-type-example }}"
            resource_preset_id = "{{ host-class }}"
          }
        }
    
        zones = [
          "{{ zone-id }}"
        ]
      }
    }
    
    resource "yandex_vpc_network" "mynet" {
      name = "mynet"
    }
    
    resource "yandex_vpc_subnet" "mysubnet" {
      name           = "mysubnet"
      zone           = "{{ zone-id }}"
      network_id     = yandex_vpc_network.mynet.id
      v4_cidr_blocks = ["10.5.0.0/24"]
    }
    
    resource "yandex_vpc_security_group" "mykf-sg" {
      name       = "mykf-sg"
      network_id = yandex_vpc_network.mynet.id
    
      ingress {
        description    = "Kafka"
        port           = 9091
        protocol       = "TCP"
        v4_cidr_blocks = [ "0.0.0.0/0" ]
      }
    }
    ```

{% endlist %}
