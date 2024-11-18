---
title: How to manage topics and {{ KF }} cluster partitions in {{ mkf-full-name }}
description: Follow this guide to manage topics and partitions.
---

# Managing {{ KF }} topics

A {{ mkf-name }} cluster provides two ways for you to manage topics and partitions (which can be used separately or combined):

* Using [native {{ yandex-cloud }} interfaces](#yandex-cloud), such as the CLI, API, or management console. Choose this method if you want to manage topics using {{ mkf-name }} features.

    You can perform the following actions on {{ mkf-name }} topics:

    * [Create a topic](#create-topic).
    * [Update topic settings](#update-topic).
    * [Get a list of topics in a cluster](#list-topics).
    * [Get detailed information about a topic](#get-topic).
    * [Import a topic to {{ TF }}](#import-topic).
    * [Delete a topic](#delete-topic).

* Using the [{{ KF }} Admin API](#admin-api). Select this method if you prefer to use your existing solution to manage topics and partitions.

## Managing topics via {{ yandex-cloud }} interfaces {#yandex-cloud}

### Creating a topic {#create-topic}

Prior to creating a topic, calculate the [minimum storage size](../concepts/storage.md#minimal-storage-size).

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the relevant folder.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
  1. Click the cluster name and go to the **{{ ui-key.yacloud.kafka.label_topics }}** tab.
  1. Click **{{ ui-key.yacloud.kafka.button_create-topic }}**.
  1. Under **{{ ui-key.yacloud.mdb.forms.section_base }}**, set the basic parameters of the topic:
     * Topic name (must be unique in the {{ KF }} cluster).
     * Number of topic partitions.
     * Replication factor. This parameter value should not exceed the number of brokers in the cluster. Minimum value: `1`. Maximum value: `3`. Default value:
       * For a cluster with one or two brokers: `1`.
       * For a cluster with three or more brokers: `3`.
  1. Under **{{ ui-key.yacloud.kafka.section_topic-config }}**, specify the [topic settings](../concepts/settings-list.md#topic-settings).
  1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a topic:
  1. View a description of the CLI create topic command:

     ```bash
     {{ yc-mdb-kf }} topic create --help
     ```

  1. Create a topic:

     ```bash
     {{ yc-mdb-kf }} topic create <topic_name> \
       --cluster-name <cluster_name> \
       --partitions <number_of_partitions> \
       --replication-factor <replication_factor>
     ```

     If necessary, specify the [topic settings](../concepts/settings-list.md#topic-settings) here.

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file with an infrastructure plan.

     For more information about creating this file, see [Creating clusters](cluster-create.md).
  1. Add the `yandex_mdb_kafka_topic` resource and [configure the topic](../concepts/settings-list.md#topic-settings) under `topic_config` if required:

     ```hcl
     resource "yandex_mdb_kafka_topic" "<topic_name>" {
       cluster_id         = "<cluster_ID>"
       name               = "<topic_name>"
       partitions         = <number_of_partitions>
       replication_factor = <replication_factor>
       topic_config {
         compression_type = "<compression_type>"
         flush_messages   = <maximum_number_of_messages_in_memory>
         ...
       }
     }
     ```

  1. Make sure the settings are correct.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  For more information, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_kafka_topic).


- API {#api}

  To create a topic, use the [create](../api-ref/Topic/create.md) REST API method for the [Topic](../api-ref/Topic/index.md) resource or the [TopicService/Create](../api-ref/grpc/Topic/create.md) gRPC API call and provide the following in the request:
  * ID of the cluster where you want to create a topic, in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
  * Topic settings, in the `topicSpec` parameter.


{% endlist %}

{% note info %}

While running, {{ mkf-name }} is able to create [service topics](../concepts/topics.md#service-topics). You cannot write user data to such topics.

{% endnote %}

### Updating topic settings {#update-topic}

You cannot reduce the number of partitions in {{ mkf-name }} topics. You cannot create new partitions if there is not enough storage space.

For more information, see [{#T}](../concepts/storage.md#minimal-storage-size).

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the relevant folder.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
  1. Click the name of the cluster you need and select the **{{ ui-key.yacloud.kafka.label_topics }}** tab.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) for the topic you need and select **{{ ui-key.yacloud.common.edit }}**.
  1. Change the basic parameters of the topic:
     * Number of topic partitions.
     * Replication factor. This parameter value should not exceed the number of brokers in the cluster. Minimum value: `1`. Maximum value: `3`. Default value:
       * For a cluster with one or two brokers: `1`.
       * For a cluster with three or more brokers: `3`.
  1. Change [additional topic settings](../concepts/settings-list.md#topic-settings).
  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To update topic settings:
  1. View a description of the CLI update topic command:

     ```bash
     {{ yc-mdb-kf }} topic update --help
     ```

  1. Change [topic settings](../concepts/settings-list.md#topic-settings):

     ```bash
     {{ yc-mdb-kf }} topic update <topic_name> \
       --cluster-name <cluster_name> \
       --partitions <number_of_partitions> \
       --replication-factor <replication_factor>
     ```

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file with an infrastructure plan.

     For more information about creating this file, see [Creating clusters](cluster-create.md).
  1. Edit the parameter values in the `yandex_mdb_kafka_topic` resource description:

     ```hcl
     resource "yandex_mdb_kafka_topic" "<topic_name>" {
       cluster_id         = "<cluster_ID>"
       name               = "<topic_name>"
       partitions         = <number_of_partitions>
       replication_factor = <replication_factor>
       topic_config {
         compression_type = "<compression_type>"
         flush_messages   = <maximum_number_of_messages_in_memory>
         ...
       }
     }
     ```

  1. Make sure the settings are correct.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  For more information, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_kafka_topic).


- API {#api}

  To change topic settings, use the [update](../api-ref/Topic/update.md) REST API method for the [Topic](../api-ref/Topic/index.md) resource or the [TopicService/Update](../api-ref/grpc/Topic/update.md) gRPC API call and provide the following in the request:
  * ID of the cluster where the topic is located, in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
  * Topic name in the `topicName` parameter. To find out the name, [get a list of cluster topics](#list-topics).
  * New values for the [topic settings](../concepts/settings-list.md#topic-settings), in the `topicSpec` parameter.
  * List of settings to update in the `updateMask` parameter.

  {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}


{% endlist %}

### Getting a list of topics in a cluster {#list-topics}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the relevant folder.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
  1. Click the cluster name and go to the **{{ ui-key.yacloud.kafka.label_topics }}** tab.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get a list of topics, run the following command:

  ```bash
  {{ yc-mdb-kf }} topic list --cluster-name <cluster_name>
  ```


- API {#api}

  To get a list of topics in a cluster, use the [list](../api-ref/Topic/list.md) REST API method for the [Topic](../api-ref/Topic/index.md) resource or the [TopicService/List](../api-ref/grpc/Topic/list.md) gRPC API call, and provide the cluster ID in the `clusterId` parameter.

  To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).


{% endlist %}

### Getting detailed information about a topic {#get-topic}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the relevant folder.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
  1. Click the cluster name and go to the **{{ ui-key.yacloud.kafka.label_topics }}** tab.
  1. Click the topic name.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get detailed information about a topic, run the following command:

  ```bash
  {{ yc-mdb-kf }} topic get <topic_name> --cluster-name <cluster_name>
  ```


- API {#api}

  To get topic details, use the [get](../api-ref/Topic/get.md) REST API method for the [Topic](../api-ref/Topic/index.md) resource or the [TopicService/Get](../api-ref/grpc/Topic/get.md) gRPC API call and provide the following in the request:
  * ID of the cluster where the topic is located, in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
  * Topic name in the `topicName` parameter. To find out the name, [get a list of cluster topics](#list-topics).


{% endlist %}

### Importing topics to {{ TF }} {#import-topic}

Using import, you can bring the existing cluster topics under {{ TF }} management.

{% list tabs group=instructions %}

- {{ TF }} {#tf}

    1. In the {{ TF }} configuration file, specify the topic you want to import:

        ```hcl
        resource "yandex_mdb_kafka_topic" "<topic_name>" {}
        ```

    1. Run the following command to import the topic:

        ```hcl
        terraform import yandex_mdb_kafka_topic.<topic_name> <cluster_ID>:<topic_name>
        ```

        To learn more about importing topics, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_kafka_topic#import).

{% endlist %}

### Deleting a topic {#delete-topic}

{% include [mkf-deleted-topic-permissions-note](../../_includes/mdb/mkf-deleted-topic-permissions-note.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the relevant folder.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
  1. Click the cluster name and go to the **{{ ui-key.yacloud.kafka.label_topics }}** tab.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) for the topic and select **{{ ui-key.yacloud.kafka.button_delete-topic }}**.
  1. In the window that opens, click **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To delete a topic:
  1. View a description of the CLI update topic command:

     ```bash
     {{ yc-mdb-kf }} topic delete --help
     ```

  1. Delete a topic:

     ```bash
     {{ yc-mdb-kf }} topic delete <topic_name> --cluster-name <cluster_name>
     ```

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file with an infrastructure plan.

     For more information about creating this file, see [Creating clusters](cluster-create.md).
  1. Delete the `yandex_mdb_kafka_topic` resource with the topic description.
  1. Make sure the settings are correct.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  For more information, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_kafka_topic).


- API {#api}

  To delete a topic, use the [delete](../api-ref/Topic/delete.md) REST API method for the [Topic](../api-ref/Topic/index.md) resource or the [TopicService/Delete](../api-ref/grpc/Topic/delete.md) gRPC API call and provide the following in the request:
  * ID of the cluster where the topic is located, in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
  * Topic name in the `topicName` parameter. To find out the name, [get a list of cluster topics](#list-topics).


{% endlist %}

## Managing topics via the {{ KF }} Admin API {#admin-api}

To manage topics via the {{ KF }} Admin API:
1. [Create](cluster-accounts.md#create-account) an admin user with the `ACCESS_ROLE_ADMIN` role in the cluster.
1. Manage topics on behalf of this user by making requests to the {{ KF }} Admin API. Review your favorite programming language manual for information on working with the Admin API.

For more information about working with the Admin API and the existing limitations, see [{#T}](../concepts/topics.md#management) and the [{{ KF }} documentation](https://kafka.apache.org/documentation/#adminapi).
