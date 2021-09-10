# Working with topics and partitions

In {{ mkf-name }} clusters, you can:

- [{#T}](#create-topic).
- [{#T}](#update-topic).
- [{#T}](#delete-topic).
- [{#T}](#list-topics).
- [{#T}](#get-topic).

## Creating a topic {#create-topic}

{% list tabs %}

- Management console

  To create a topic, follow these steps:
  1. Go to the folder page and select **{{ mkf-name }}**.
  1. Click the name of the cluster and go to the **Topics** tab.
  1. Click **Create topic**.
  1. Under **Basic parameters**, set the basic parameters of the topic:
     - The topic name (must be unique in the {{ KF }} cluster).
     - The number of topic partitions.
     - The replication factor. This parameter value should not exceed the number of brokers in the cluster. Minimum value: `1`. Default:
       - For a cluster with one or two brokers: `1`.
       - For a cluster with three or more brokers: `3`.
  1. Under **Topic settings**, specify the [topic settings](../concepts/settings-list.md#topic-settings).
  1. Click **Create**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a topic:

  1. View a description of the CLI create topic command:

     ```
     {{ yc-mdb-kf }} topic create --help
     ```

  1. Create a topic:

     ```bash
     {{ yc-mdb-kf }} topic create <topic name> \
        --cluster-name <cluster name>
        --partitions <number of partitions> \
        --replication-factor <replication factor>
     ```

     If necessary, specify the [topic settings](../concepts/settings-list.md#topic-settings) here.

- Terraform

    To create a topic:

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For information about how to create this file, see [{#T}](cluster-create.md).

    1. In the {{ mkf-name }} cluster description, add a `topic` section:

        ```hcl
        resource "yandex_mdb_kafka_cluster" "<cluster name>" {
           topic {
             name               = "<topic name>"
             partitions         = <number of partitions>
             replication_factor = <replication factor>
           }
           ...
        }
        ```

    1. If required, specify the [topic settings](../concepts/settings-list.md#topic-settings) in the `topic_config` section:

        ```hcl
        resource "yandex_mdb_kafka_cluster" "<cluster name>" {
           topic {
             name               = "<topic name>"
             partitions         = <number of partitions>
             replication_factor = <replication factor>
        
             topic_config {
               compression_type = "<compression type>"
               flush_messages   = <maximum number of messages in memory>
               ...
             }
           }
           ...
        }
        ```

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm the update of resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see the [{{ TF }} provider documentation](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/mdb_kafka_cluster).

{% if api != "noshow" %}

- API

  Use the [create](../api-ref/Topic/create.md) API method and pass the following in the request:
  - In the `clusterId` parameter, the ID of the cluster where you want to create a topic. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
  - Topic settings in the `topicSpec` parameter.

{% endif %}

{% endlist %}

## Updating topic settings {#update-topic}

{% note warning %}

The number of {{ KF }} topic partitions can only be increased.

{% endnote %}

{% list tabs %}

- Management console

  To change topic settings, follow these steps:
  1. Go to the folder page and select **{{ mkf-name }}**.
  1. Click on the name of the cluster and select the **Topics** tab.
  1. Click ![image](../../_assets/options.svg) for the necessary topic and select **Edit**.
  1. Change the basic parameters of the topic:
     - The number of topic partitions.
     - The replication factor. This parameter value should not exceed the number of brokers in the cluster. Minimum value: `1`. Default:
       - For a cluster with one or two brokers: `1`.
       - For a cluster with three or more brokers: `3`.
  1. Change [additional topic settings](../concepts/settings-list.md#topic-settings).
  1. Click **Save**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To change topic settings:

  1. View a description of the CLI update topic command:

     ```
     {{ yc-mdb-kf }} topic update --help
     ```

  1. Change [topic settings](../concepts/settings-list.md#topic-settings):

     ```
     {{ yc-mdb-kf }} topic update <topic name> \
     --cluster-name <cluster name>
     --partitions <number of partitions> \
     --replication-factor <replication factor>
     ```

- Terraform

    To update the [topic settings](../concepts/settings-list.md#dbms-settings):

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For information about how to create this file, see [{#T}](cluster-create.md).

    1. In the {{ mkf-name }} cluster description, edit the parameters in the `topic` or `topic_config` sections:

        ```hcl
        resource "yandex_mdb_kafka_cluster" "<cluster name>" {
          topic {
            name               = "<topic name>"
            partitions         = <number of partitions>
            replication_factor = <replication factor>
        
            topic_config {
              compression_type = "<compression type>"
              flush_messages   = <maximum number of messages in memory>
              ...
            }
          }
          ...
        }
        ```

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm the update of resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see the [{{ TF }} provider documentation](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/mdb_kafka_cluster).

{% if api != "noshow" %}

- API

  Use the [update](../api-ref/Topic/update.md) API method and pass the following in the request:
  - In the `clusterId` parameter, the ID of the cluster where the topic is located. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
  - The topic name in the `topicName` parameter. To find out the name, [get a list of topics in the cluster](#list-topics).
  - In the `updateMask` parameter, a list of settings to update (in a single line, comma-separated). If this parameter is omitted, the API method resets any topic settings that aren't explicitly specified in the request to their default values.
  - New values of [topic settings](../concepts/settings-list.md#topic-settings) in the `topicSpec` parameter.

{% endif %}

{% endlist %}

## Deleting a topic {#delete-topic}

{% include [mkf-deleted-topic-permissions-note](../../_includes/mdb/mkf-deleted-topic-permissions-note.md) %}

{% list tabs %}

- Management console

  To delete a topic, follow these steps:
  1. Go to the folder page and select **{{ mkf-name }}**.
  1. Click the name of the cluster and go to the **Topics** tab.
  1. Click ![image](../../_assets/options.svg) for the necessary topic and select **Delete topic**.
  1. Confirm topic deletion and click **Delete**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To delete a topic:

  1. View a description of the CLI update topic command:

     ```
     {{ yc-mdb-kf }} topic delete --help
     ```

  1. Delete a topic:

     ```
     {{ yc-mdb-kf }} topic delete <topic name> --cluster-name <cluster name>
     ```

- Terraform

    To delete a topic:

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For information about how to create this file, see [{#T}](cluster-create.md).

    1. In the {{ mkf-name }} cluster description, delete the `topic` section that describes the topic.

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm the update of resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see the [{{ TF }} provider documentation](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/mdb_kafka_cluster).

{% if api != "noshow" %}

- API

  Use the [delete](../api-ref/Topic/delete.md) API method and pass the following in the request:
  - In the `clusterId` parameter, the ID of the cluster where the topic is located. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
  - The topic name in the `topicName` parameter. To find out the name, [get a list of topics in the cluster](#list-topics).

{% endif %}

{% endlist %}

## Listing topics in a cluster {#list-topics}

{% list tabs %}

- Management console

  To get a list of topics, follow these steps:
  1. Go to the folder page and select **{{ mkf-name }}**.
  1. Click the name of the cluster and go to the **Topics** tab.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get a list of topics, run the following command:

  ```
  {{ yc-mdb-kf }} topic list --cluster-name <cluster name>
  ```

{% if api != "noshow" %}

- API

  Use the [list](../api-ref/Topic/list.md) API method: pass the ID of the required cluster in the `clusterId` request parameter.

  To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).

{% endif %}

{% endlist %}

## Getting detailed information about a topic {#get-topic}

{% list tabs %}

- Management console

  To get detailed information about a topic, follow these steps:
  1. Go to the folder page and select **{{ mkf-name }}**.
  1. Click the name of the cluster and go to the **Topics** tab.
  1. Click on the name of the topic.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get detailed information about a topic, run the following command:

  ```
  {{ yc-mdb-kf }} topic get <topic name> --cluster-name <cluster name>
  ```

{% if api != "noshow" %}

- API

  To get detailed information about a topic, use the [get](../api-ref/Topic/get.md) API method and pass the following in the request:
  - In the `clusterId` parameter, the ID of the cluster where the topic is located. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
  - The topic name in the `topicName` parameter. To find out the name, [get a list of topics in the cluster](#list-topics).

{% endif %}

{% endlist %}

