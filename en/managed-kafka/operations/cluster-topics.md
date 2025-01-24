---
title: How to manage topics and {{ KF }} cluster partitions in {{ mkf-full-name }}
description: 'Follow this guide to manage topics and partitions: create a topic, update topic settings, get a list of topics in a cluster, get detailed information about a topic, import a topic to {{ TF }}, delete a topic.'
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
  1. In the services list, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
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

  For more information, see the [{{ TF }}]({{ tf-provider-resources-link }}/mdb_kafka_topic) provider documentation.

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Use the [Topic.create](../api-ref/Topic/create.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

     ```bash
     curl \
       --request POST \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://{{ api-host-mdb }}/managed-kafka/v1/clusters/<cluster_ID>/topics' \
       --data '{
                 "topicSpec": {
                  "name": "<topic_name>",
                  "partitions": "<number_of_partitions>",
                  "replicationFactor": "<replication_factor>"
               }'
     ```

     Where:

     * `topicSpec` stands for topic settings:

        {% include [rest-topic-specs](../../_includes/mdb/mkf/api/rest-topic-specs.md) %}

     You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/Topic/create.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Use the [TopicService/Create](../api-ref/grpc/Topic/create.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/kafka/v1/topic_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<cluster_ID>",
             "topic_spec": {
                  "name": "<topic_name>",
                  "partitions": {
                    "value": "<number_of_partitions>"
                  },
                  "replication_factor": {
                    "value": "<replication_factor>"
                  }
             }
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.kafka.v1.TopicService.Create
     ```

     Where:

     * `topic_spec` stands for topic settings:

        {% include [grpc-topic-specs](../../_includes/mdb/mkf/api/grpc-topic-specs.md) %}

     You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/grpc/Topic/create.md#yandex.cloud.operation.Operation) to make sure the request was successful.

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
  1. In the services list, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
  1. Click the name of the cluster you need and select the **{{ ui-key.yacloud.kafka.label_topics }}** tab.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) for the topic you need and select **{{ ui-key.yacloud.common.edit }}**.
  1. Change the basic parameters of the topic:
     * Number of topic partitions.
     * Replication factor. This parameter value should not exceed the number of brokers in the cluster. Minimum value: `1`. Maximum value: `3`. Default:
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

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Use the [Topic.update](../api-ref/Topic/update.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

     {% include [note-rest-updatemask](../../_includes/note-api-updatemask.md) %}

     ```bash
     curl \
       --request PATCH \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://{{ api-host-mdb }}/managed-kafka/v1/clusters/<cluster_ID>/topics/<topic_name>' \
       --data '{
                 "clusterId": "<cluster_ID>",
                 "updateMask": "topicSpec.partitions,topicSpec.replicationFactor,topicSpec.topicConfig_2_8.<setting_1>,...,topicSpec.topicConfig_2_8.<setting_N>,topicSpec.topicConfig_3.<setting_1>,...,topicSpec.topicConfig_3.<setting_N>",
                 "topicSpec": {
                   "partitions": "<number_of_partitions>",
                   "replicationFactor": "<replication_factor>",
                   "topicConfig_2_8": {
                     "<setting_1_for_{{ KF }}_2.8_topic>": "<value_1>",
                     "<setting_2_for_{{ KF }}_2.8_topic>": "<value_2>",
                     ...
                     "<setting_N_for_{{ KF }}_2.8_topic>": "<value_N>"
                   },
                   "topicConfig_3": {
                     "<setting_1_for_{{ KF }}_3.x_topic>": "<value_1>",
                     "<setting_2_for_{{ KF }}_3.x_topic>": "<value_2>",
                     ...
                     "<setting_N_for_{{ KF }}_3.x_topic>": "<value_N>"
                   }
                 } 
               }'
     ```

     Where:

     * `updateMask`: List of parameters to update as a single string, separated by commas.

       In this case, list all the topic settings to update.

     * `topic_spec` stands for new topic settings:

        {% include [rest-topic-specs](../../_includes/mdb/mkf/api/rest-topic-specs-update.md) %}

     You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/Topic/update.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Use the [TopicService/Update](../api-ref/grpc/Topic/update.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

     {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/kafka/v1/topic_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<cluster_ID>",
             "topic_name": "<topic_name>",
             "update_mask": {
               "paths": [
                 "topic_spec.partitions",
                 "topic_spec.replication_factor",
                 "topic_spec.topic_config_2_8.<setting_1>",
                 ...,
                 "topic_spec.topic_config_2_8.<setting_N>",
                 "topic_spec.topic_config_3.<setting_1>",
                 ...,
                 "topic_spec.topic_config_3.<setting_N>"
               ]
             },
             "topic_spec": {
                  "partitions": {
                    "value": "<number_of_partitions>"
                  },
                  "replication_factor": {
                    "value": "<replication_factor>"
                  },
                  "topic_сonfig_2_8": {
                     "<setting_1_for_{{ KF }}_2.8_topic>": "<value_1>",
                     "<setting_2_for_{{ KF }}_2.8_topic>": "<value_2>",
                     ...
                     "<setting_N_for_{{ KF }}_2.8_topic>": "<value_N>"
                   },
                   "topic_сonfig_3": {
                     "<setting_1_for_{{ KF }}_3.x_topic>": "<value_1>",
                     "<setting_2_for_{{ KF }}_3.x_topic>": "<value_2>",
                     ...
                     "<setting_N_for_{{ KF }}_3.x_topic>": "<value_N>"
                   }
             }
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.kafka.v1.TopicService.Update
     ```

     Where:

     * `update_mask`: List of parameters to update as an array of `paths[]` strings.

       In this case, list all the topic settings to update.

     * `topic_spec` stands for new topic settings:

        {% include [grpc-topic-specs](../../_includes/mdb/mkf/api/grpc-topic-specs-update.md) %}

     You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/grpc/Topic/update.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}

### Getting a list of topics in a cluster {#list-topics}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the relevant folder.
  1. In the services list, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
  1. Click the cluster name and go to the **{{ ui-key.yacloud.kafka.label_topics }}** tab.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get a list of topics, run the following command:

  ```bash
  {{ yc-mdb-kf }} topic list --cluster-name <cluster_name>
  ```

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Use the [Topic.list](../api-ref/Topic/list.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

     ```bash
     curl \
       --request GET \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-kafka/v1/clusters/<cluster_ID>/topics'
     ```

     You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/Topic/list.md#yandex.cloud.mdb.kafka.v1.ListTopicsResponse) to make sure the request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Use the [TopicService/List](../api-ref/grpc/Topic/list.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/kafka/v1/topic_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<cluster_ID>"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.kafka.v1.TopicService.List
     ```

     You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/grpc/Topic/list.md#yandex.cloud.mdb.kafka.v1.ListTopicsResponse) to make sure the request was successful.

{% endlist %}

### Getting detailed information about a topic {#get-topic}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the relevant folder.
  1. In the services list, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
  1. Click the cluster name and go to the **{{ ui-key.yacloud.kafka.label_topics }}** tab.
  1. Click the topic name.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get detailed information about a topic, run the following command:

  ```bash
  {{ yc-mdb-kf }} topic get <topic_name> --cluster-name <cluster_name>
  ```

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Use the [Topic.list](../api-ref/Topic/get.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

     ```bash
     curl \
       --request GET \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-kafka/v1/clusters/<cluster_ID>/topics/<topic_name>'
     ```

     You can request the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters) and the topic name with a [list of topics in the cluster](#list-topics).

  1. View the [server response](../api-ref/Topic/get.md#yandex.cloud.mdb.kafka.v1.Topic) to make sure the request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Use the [TopicService/Get](../api-ref/grpc/Topic/get.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/kafka/v1/topic_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<cluster_ID>",
             "topic_name": "<topic_name>"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.kafka.v1.TopicService.Get
     ```

     You can request the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters) and the topic name with a [list of topics in the cluster](#list-topics).

  1. View the [server response](../api-ref/grpc/Topic/list.md#yandex.cloud.mdb.kafka.v1.Topic) to make sure the request was successful.

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
  1. In the services list, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
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

  For more information, see the [{{ TF }}]({{ tf-provider-resources-link }}/mdb_kafka_topic) provider documentation.

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Use the [Topic.delete](../api-ref/Topic/delete.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

     ```bash
     curl \
       --request DELETE \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-kafka/v1/clusters/<cluster_ID>/topics/<topic_name>'
     ```

     You can request the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters) and the topic name with a [list of topics in the cluster](#list-topics).

  1. View the [server response](../api-ref/Topic/delete.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Use the [TopicService/Delete](../api-ref/grpc/Topic/delete.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/kafka/v1/topic_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<cluster_ID>",
             "topic_name": "<topic_name>"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.kafka.v1.TopicService.Delete
     ```

     You can request the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters) and the topic name with a [list of topics in the cluster](#list-topics).

  1. View the [server response](../api-ref/grpc/Topic/delete.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}

## Managing topics via the {{ KF }} Admin API {#admin-api}

To manage topics via the {{ KF }} Admin API:
1. [Create](cluster-accounts.md#create-account) an admin user with the `ACCESS_ROLE_ADMIN` role in the cluster.
1. Manage topics on behalf of this user by making requests to the {{ KF }} Admin API. Review your favorite programming language manual for information on working with the Admin API.

For more information about working with the Admin API and the existing limitations, see [{#T}](../concepts/topics.md#management) and the [{{ KF }} documentation](https://kafka.apache.org/documentation/#adminapi).
