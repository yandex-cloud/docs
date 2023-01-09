# Working with topics and partitions

A {{ mkf-name }} cluster provides two ways for you to manage topics and partitions (which can be used separately or combined):
* Using {{ yandex-cloud }} standard interfaces (CLI, API, or management console). Select this method if you wish to create, delete, and configure topics and partitions using {{ mkf-name }} service features.
* Using the {{ KF }} [Admin API](https://kafka.apache.org/documentation/#adminapi). Select this method if you wish to use your existing solution to manage topics and partitions.

## Managing topics and partitions with the {{ KF }} Admin API {#admin-api}

To manage topics via the [{{ KF }} Admin API](https://kafka.apache.org/documentation/#adminapi):
1. Enable **Manage topics via the API** when [creating a cluster](cluster-create.md) or [changing its settings](cluster-update.md).
1. [Create](cluster-accounts.md#create-user) a cluster admin user.
1. Manage topics on behalf of this user through [{{ KF }} Admin API](https://kafka.apache.org/documentation/#adminapi) calls. Review your favorite programming language manual for information on working with the Admin API.

For more information about using the Admin API and existing limitations, see [{#T}](../concepts/topics.md#management) and the [{{ KF }} documentation](https://kafka.apache.org/documentation/#adminapi).

## Creating a topic {#create-topic}

Prior to creating a topic, calculate the [minimum storage size](../concepts/storage.md#minimal-storage-size).

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the desired folder.
   1. In the list of services, select **{{ mkf-name }}**.
   1. Click the name of the cluster and go to the **Topics** tab.
   1. Click **Create topic**.
   1. Under **Basic parameters**, set the basic parameters of the topic:
      * The topic name (must be unique in the {{ KF }} cluster).
      * The number of topic partitions.
      * The replication factor. This parameter value should not exceed the number of brokers in the cluster. Minimum value: `1`. Maximum value: `3`. Default: 0.
         * For a cluster of one or two brokers: `1`.
         * For a cluster with three or more brokers: `3`.
   1. Under **Topic settings**, specify the [topic settings](../concepts/settings-list.md#topic-settings).
   1. Click **Create**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To create a topic:
   1. View a description of the CLI create topic command:

      ```bash
      {{ yc-mdb-kf }} topic create --help
      ```

   1. Create a topic:

      ```bash
      {{ yc-mdb-kf }} topic create <topic name> \
        --cluster-name <cluster name> \
        --partitions <number of partitions> \
        --replication-factor <replication factor>
      ```

      If necessary, specify the [topic settings](../concepts/settings-list.md#topic-settings) here.

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).
   1. Add the `yandex_mdb_kafka_topic` resource and [configure the topic](../concepts/settings-list.md#topic-settings) under `topic_config`, as required:

      ```hcl
      resource "yandex_mdb_kafka_topic" "<topic name>" {
        cluster_id         = "<cluster ID>"
        name               = "<topic name>"
        partitions         = <number of partitions>
        replication_factor = <replication factor>
        topic_config {
          compression_type = "<compression type>"
          flush_messages   = <maximum number of messages in memory>
          ...
        }
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-link }}/mdb_kafka_topic).


- API

   Use the [create](../api-ref/Topic/create.md) API method and pass the following information in the request:
   * In the `clusterId` parameter, the ID of the cluster where you want to create a topic. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * Topic settings in the `topicSpec` parameter.


{% endlist %}

{% note info %}

While running, {{ mkf-name }} is able to create [service topics](../concepts/topics.md#service-topics). You cannot write user data to such topics.

{% endnote %}

## Updating topic settings {#update-topic}

You cannot reduce the number of partitions in {{ mkf-name }} topics. If there isn't enough storage space, you cannot create new partitions.

For more information, see [{#T}](../concepts/storage.md#minimal-storage-size).

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the desired folder.
   1. In the list of services, select **{{ mkf-name }}**.
   1. Click on the name of the cluster and select the **Topics** tab.
   1. Click ![image](../../_assets/options.svg) for the desired topic and select **Edit**.
   1. Change the basic parameters of the topic:
      * The number of topic partitions.
      * The replication factor. This parameter value should not exceed the number of brokers in the cluster. Minimum value: `1`. Maximum value: `3`. Default: 0.
         * For a cluster of one or two brokers: `1`.
         * For a cluster with three or more brokers: `3`.
   1. Change [additional topic settings](../concepts/settings-list.md#topic-settings).
   1. Click **Save**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To change topic settings:
   1. View a description of the CLI update topic command:

      ```bash
      {{ yc-mdb-kf }} topic update --help
      ```

   1. Change [topic settings](../concepts/settings-list.md#topic-settings):

      ```bash
      {{ yc-mdb-kf }} topic create <topic name> \
        --cluster-name <cluster name> \
        --partitions <number of partitions> \
        --replication-factor <replication factor>
      ```

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).
   1. Edit the parameter values in the `yandex_mdb_kafka_topic` resource description:

      ```hcl
      resource "yandex_mdb_kafka_topic" "<topic name>" {
        cluster_id         = "<cluster ID>"
        name               = "<topic name>"
        partitions         = <number of partitions>
        replication_factor = <replication factor>
        topic_config {
          compression_type = "<compression type>"
          flush_messages   = <maximum number of messages in memory>
          ...
        }
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-link }}/mdb_kafka_topic).


- API

   Use the [update](../api-ref/Topic/update.md) API method and pass the following in the request:
   * In the `clusterId` parameter, the ID of the cluster where the topic is located. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * The topic name in the `topicName` parameter. To find out the name, [retrieve a list of cluster topics](#list-topics).
   * New values of [topic settings](../concepts/settings-list.md#topic-settings) in the `topicSpec` parameter.
   * List of settings to update in the `updateMask` parameter.

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}


{% endlist %}

## Deleting a topic {#delete-topic}

{% include [mkf-deleted-topic-permissions-note](../../_includes/mdb/mkf-deleted-topic-permissions-note.md) %}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the desired folder.
   1. In the list of services, select **{{ mkf-name }}**.
   1. Click the name of the cluster and go to the **Topics** tab.
   1. Click ![image](../../_assets/options.svg) for the desired topic and select **Delete topic**.
   1. In the window that opens, click **Delete**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To delete a topic:
   1. View a description of the CLI update topic command:

      ```bash
      {{ yc-mdb-kf }} topic delete --help
      ```

   1. Delete a topic:

      ```bash
      {{ yc-mdb-kf }} topic delete <topic name> --cluster-name <cluster name>
      ```

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).
   1. Delete the `yandex_mdb_kafka_topic` resource with the relevant topic description.
   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-link }}/mdb_kafka_topic).


- API

   Use the [delete](../api-ref/Topic/delete.md) API method and pass the following in the request:
   * In the `clusterId` parameter, the ID of the cluster where the topic is located. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * The topic name in the `topicName` parameter. To find out the name, [retrieve a list of cluster topics](#list-topics).


{% endlist %}

## Listing topics in a cluster {#list-topics}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the desired folder.
   1. In the list of services, select **{{ mkf-name }}**.
   1. Click the name of the cluster and go to the **Topics** tab.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get a list of topics, run the following command:

   ```bash
   {{ yc-mdb-kf }} topic list --cluster-name <cluster name>
   ```


- API

   Use the API [list](../api-ref/Topic/list.md) method and pass the ID of the desired cluster in the `clusterId` request parameter.

   To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).


{% endlist %}

## Getting detailed information about a topic {#get-topic}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the desired folder.
   1. In the list of services, select **{{ mkf-name }}**.
   1. Click the name of the cluster and go to the **Topics** tab.
   1. Click on the name of the topic.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get detailed information about a topic, run the following command:

   ```bash
   {{ yc-mdb-kf }} topic get <topic name> --cluster-name <cluster name>
   ```


- API

   Use the [get](../api-ref/Topic/get.md) API method and pass the following in the request:
   * In the `clusterId` parameter, the ID of the cluster where the topic is located. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * The topic name in the `topicName` parameter. To find out the name, [retrieve a list of cluster topics](#list-topics).


{% endlist %}