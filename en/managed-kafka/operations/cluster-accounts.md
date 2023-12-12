---
title: "How to manage {{ KF }} cluster users in {{ mkf-full-name }}"
description: "Follow this guide to manage {{ KF }} cluster users."
---

# Managing Apache Kafka® users

Users in {{ KF }}:
* Keep the access permissions of data [producers and consumers](../concepts/producers-consumers.md) separate.

   A producer or consumer can only access [topics](../concepts/topics.md) that are allowed for their users. You can use the same user for multiple producers or consumers: the former get the rights to write data to certain topics and the latter get the read rights.
* [Manage topics](cluster-topics.md#admin-api). For more information, see [{#T}](../concepts/topics.md).

After [creating an {{ KF }} cluster](cluster-create.md), you can:
* [{#T}](#create-user).
* [{#T}](#update-password).
* [{#T}](#update-account).
* [{#T}](#grant-permission).
* [{#T}](#revoke-permission).
* [{#T}](#list-accounts).
* [{#T}](#import-account).
* [{#T}](#delete-account).

## Creating a user {#create-user}

{% note info %}

Use the CLI, API, or {{ TF }} to create an admin user.

{% endnote %}

{% list tabs %}

- Management console

   To create a user for a producer or consumer in a cluster:
   1. In the [management console]({{ link-console-main }}), go to the appropriate folder.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
   1. Click the cluster name and go to the **{{ ui-key.yacloud.mdb.cluster.switch_users }}** tab.
   1. Click **{{ ui-key.yacloud.mdb.cluster.users.button_add }}**.
   1. Enter your username and password.

      {% include [user-name-and-password-limits](../../_includes/mdb/mkf/note-info-user-name-and-pass-limits.md) %}

   1. [Grant permissions](#grant-permission) for relevant topics.
   1. Click **{{ ui-key.yacloud.mdb.cluster.users.popup-button_add }}**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To create a user:
   1. View a description of the CLI create user command:

      ```bash
      {{ yc-mdb-kf }} user create --help
      ```

   1. Create a user with the `producer` role for the producer or `consumer` role for the consumer and grant permissions for relevant topics:

      ```bash
      {{ yc-mdb-kf }} user create <username> \
        --cluster-name <cluster_name> \
        --password <password> \
        --permission topic=<topic_name>,role=<user_role>
      ```

   To create an [admin user](../concepts/topics.md#management) to manage topics in a cluster:
   1. See the description of the create user CLI command:

      ```bash
      {{ yc-mdb-kf }} user create --help
      ```

   1. Create a user with the `admin` role applicable to all (`*`) cluster topics:

      ```bash
      {{ yc-mdb-kf }} user create <username> \
        --cluster-name <cluster_name> \
        --password <password> \
        --permission topic=*,role=admin
      ```

   {% include [user-name-and-password-limits](../../_includes/mdb/mkf/note-info-user-name-and-pass-limits.md) %}

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).
   1. Add the `yandex_mdb_kafka_user` resource:

      ```hcl
      resource "yandex_mdb_kafka_user" "<username>" {
        cluster_id = "<cluster_ID>"
        name       = "<username>"
        password   = "<password>"
        ...
      }
      ```

      {% include [user-name-and-password-limits](../../_includes/mdb/mkf/note-info-user-name-and-pass-limits.md) %}

   1. [Grant permissions](#grant-permission) for relevant topics.
   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_kafka_cluster).

   {% include [Terraform timeouts](../../_includes/mdb/mkf/terraform/cluster-timeouts.md) %}


- API

   To create a user, use the [create](../api-ref/User/create.md) REST API method for the [User](../api-ref/User/index.md) resource or the [UserService/Create](../api-ref/grpc/user_service.md#Create) gRPC API call and provide the following in the request:
   * Cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * User settings in the `userSpec` parameter:
      * Username in the `name` parameter.
      * User password in the `password` parameter.
      * Topic permissions (one or more `permissions` parameters, one for each topic):
         * Topic name in the `topicName` parameter. To find out the name, [retrieve a list of cluster topics](cluster-topics.md#list-topics).
         * Topic permissions in the `role` parameter: `ACCESS_ROLE_PRODUCER` for the producer or `ACCESS_ROLE_CONSUMER` for the consumer.

   To create an [admin user](../concepts/topics.md#management) to manage topics in a cluster, provide the following values under `permission` in the `userSpec` parameter:
   * `topicName`: `*`
   * `role`: `ACCESS_ROLE_ADMIN`

   {% include [user-name-and-password-limits](../../_includes/mdb/mkf/note-info-user-name-and-pass-limits.md) %}


{% endlist %}

## Changing a user password {#update-password}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the appropriate folder.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
   1. Click the cluster name and go to the **{{ ui-key.yacloud.mdb.cluster.switch_users }}** tab.
   1. Click ![image](../../_assets/horizontal-ellipsis.svg) for the appropriate user and select **{{ ui-key.yacloud.mdb.cluster.users.button_action-password }}**.
   1. Set a new password and click **{{ ui-key.yacloud.mdb.cluster.users.popup-password_button_change }}**.

   {% include [password-limits](../../_includes/mdb/mkf/note-info-password-limits.md) %}

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To change the user password, run the command:

   ```bash
   {{ yc-mdb-kf }} user update <username> \
     --cluster-name <cluster_name> \
     --password <new_password>
   ```

   {% include [password-limits](../../_includes/mdb/mkf/note-info-password-limits.md) %}

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).
   1. In the file, find the `yandex_mdb_kafka_user` resource for the required user.
   1. Change the value of the `password` field:

      ```hcl
      resource "yandex_mdb_kafka_user" "<username>" {
        ...
        password = "<password>"
        ...
      }
      ```

      {% include [password-limits](../../_includes/mdb/mkf/note-info-password-limits.md) %}

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_kafka_cluster).

   {% include [Terraform timeouts](../../_includes/mdb/mkf/terraform/cluster-timeouts.md) %}


- API

   To update a user's password, use the [update](../api-ref/User/update.md) REST API method for the [User](../api-ref/User/index.md) resource or the [UserService/Update](../api-ref/grpc/user_service.md#Update) gRPC API call and provide the following in the request:
   * Cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * Username in the `userName` parameter. To find out the name, [get a list of users in the cluster](#list-accounts).
   * The name of the `password` setting in the `updateMask` parameter. If this parameter is omitted, the API method resets any user settings that are not explicitly specified in the request to their default values.
   * New user password, in the `password` parameter.

      {% include [password-limits](../../_includes/mdb/mkf/note-info-password-limits.md) %}

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}


{% endlist %}

## Changing user settings {#update-account}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the appropriate folder.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
   1. Click the cluster name and go to the **{{ ui-key.yacloud.mdb.cluster.switch_users }}** tab.
   1. Click ![image](../../_assets/horizontal-ellipsis.svg) for the appropriate user and select **{{ ui-key.yacloud.mdb.cluster.users.button_action-update }}**.
   1. [Grant](#grant-permission) or [revoke](#revoke-permission) permissions for topics, if necessary.
   1. Click **{{ ui-key.yacloud.mdb.cluster.users.popup-button_save }}**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   Using the CLI, you can [grant](#grant-permission) and [revoke](#revoke-permission) topic permissions.

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).
   1. In the file, find the `yandex_mdb_kafka_user` resource for the required user.
   1. Edit the `permission` section to [grant](#grant-permission) or [revoke](#revoke-permission) topic permissions:

      ```hcl
      resource "yandex_mdb_kafka_user" "<username>" {
        cluster_id = "<cluster_ID>"
        name       = "<username>"
        password   = "<password>"
        ...
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_kafka_cluster).

   {% include [Terraform timeouts](../../_includes/mdb/mkf/terraform/cluster-timeouts.md) %}


- API

   To update user settings, use the [update](../api-ref/User/update.md) REST API method for the [User](../api-ref/User/index.md) resource or the [UserService/Update](../api-ref/grpc/user_service.md#Update) gRPC API call and provide the following in the request:
   * Cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * Username in the `userName` parameter. To find out the name, [get a list of users in the cluster](#list-accounts).
   * In the `updateMask` parameter, a list of settings to update (in a single line, comma-separated). If this parameter is omitted, the API method resets any user settings that are not explicitly specified in the request to their default values.
   * New set of permissions to topics (one or more `permissions` parameters, one for each topic).

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}


{% endlist %}

## Granting user permissions {#grant-permission}

{% include [mkf-deleted-topic-permissions-note](../../_includes/mdb/mkf-deleted-topic-permissions-note.md) %}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the appropriate folder.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
   1. Select the cluster.
   1. Go to the **{{ ui-key.yacloud.mdb.cluster.switch_users }}** tab.
   1. Click ![image](../../_assets/horizontal-ellipsis.svg) for the user to grant topic permissions to and select **{{ ui-key.yacloud.mdb.cluster.users.button_action-update }}**.
   1. Click **+ {{ ui-key.yacloud.kafka.button_add-topic }}**. If you do not see this button, it means that the user is granted permissions to all existing cluster topics.

      If the user does not need permissions to certain topics, you can [revoke them](#revoke-permission).

   1. Select the appropriate topic from the drop-down list or enter its name:

      1. Specify the following in the **{{ ui-key.yacloud.kafka.label_topic }}** field:

         * `*` to allow access to any topics.
         * Full topic name to allow access to a specific topic.
         * `<prefix>*` to grant access to topics whose names start with the specified prefix. For example, if you have topics named `topic_a1`, `topic_a2`, and `a3`, and you set the `topic*` value, access will be granted to `topic_a1` and `topic_a2`.

      1. Click **{{ ui-key.yacloud.kafka.button_add-topic }}**.

   1.  Click the ![image](../../_assets/plus.svg) icon in the **{{ ui-key.yacloud.mdb.dialogs.popup_field_roles }}** column for the topic and select:
      * `ACCESS_ROLE_CONSUMER`: Consumers using this user will be granted access to the topic.
      * `ACCESS_ROLE_PRODUCER`: Producers using this user will be granted access to the topic.
      * `ACCESS_ROLE_ADMIN`: Only available if access to any topics is selected.

      You can select the `ACCESS_ROLE_CONSUMER` and `ACCESS_ROLE_PRODUCER` roles at the same time to make a user suitable for both producers and consumers.
   1. To grant permissions to other topics, repeat the steps.
   1. (Optional) If you granted permissions for a topic accidentally, [revoke them](#revoke-permission).

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To grant user permissions:
   1. Retrieve a list of cluster topics:

      ```bash
      {{ yc-mdb-kf }} topic list --cluster-name <cluster_name>
      ```

   1. Grant permissions to the required topics by providing the `--permission` parameters:

      ```bash
      {{ yc-mdb-kf }} user update <username> \
        --cluster-name <cluster_name> \
        --permission topic=<topic_name>,role=<user_role>
      ```

      The following `--permission` parameters are available:
      * `topic`: Name of the topic the permissions are granted for.

         If the user does not need permissions to certain topics, you can [revoke them](#revoke-permission).

      * `role`: User role, such as `producer`, `consumer`, or `admin`.

         The `admin` role is only available with all topics selected (`topic=*`).

      When you update user permissions, the existing permissions are revoked and replaced with the new ones. This means the command must always include a complete list of permissions to be assigned to the user.

      For example, to grant user `test-user` permissions in cluster `kafka-cli` to topic `topic2` with the `producer` role while keeping existing `topic1` permissions, run the command:

      ```bash
      {{ yc-mdb-kf }} user update test-user \
        --cluster-name kafka-cli \
        --permission topic=topic1,role=consumer \
        --permission topic=topic2,role=producer
      ```

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).
   1. In the file, find the `yandex_mdb_kafka_cluster` resource for the required user.
   1. Add a `permission` section:

      ```hcl
      resource "yandex_mdb_kafka_user" "<username>" {
        ...
        permission {
          topic_name = "<topic>"
          role       = "<user_role>"
        }
      }
      ```

      Where:

      * `topic_name`: Topic name. Specify the following:

        * `*` to allow access to any topics.
        * Full topic name to allow access to a specific topic.
        * `<prefix>*` to grant access to topics whose names start with the specified prefix. For example, if you have topics named `topic_a1`, `topic_a2`, and `a3`, and you set the `topic*` value, access will be granted to `topic_a1` and `topic_a2`.

      * `role`: User role: `ACCESS_ROLE_CONSUMER`, `ACCESS_ROLE_PRODUCER` or `ACCESS_ROLE_ADMIN`. The `ACCESS_ROLE_ADMIN` is only available with all topics selected (`topic_name = "*"`).

      If the user does not need permissions to certain topics, you can [revoke them](#revoke-permission).

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_kafka_cluster).

   {% include [Terraform timeouts](../../_includes/mdb/mkf/terraform/cluster-timeouts.md) %}


- API

   To grant user permissions, use the [grantPermission](../api-ref/User/grantPermission.md) REST API method for the [User](../api-ref/User/index.md) resource or the [UserService/GrantPermission](../api-ref/grpc/user_service.md#GrantPermission) gRPC API call and provide the following in the request:
   * Cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * Username in the `userName` parameter. To find out the name, [get a list of users in the cluster](#list-accounts).
   * The new permission to the topic in the `permission` parameter.


{% endlist %}

## Revoking user permissions {#revoke-permission}

If you revoke the `ACCESS_ROLE_ADMIN` role from the [admin user](../concepts/topics.md#management) in a cluster, you will no longer be able to manage topics. Do not revoke this role without first granting it to another user.

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the appropriate folder.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
   1. Select the cluster.
   1. Go to the **{{ ui-key.yacloud.mdb.cluster.switch_users }}** tab.
   1. Click ![image](../../_assets/horizontal-ellipsis.svg) for the appropriate user and select **{{ ui-key.yacloud.mdb.cluster.users.button_action-update }}**.
   1. Find the appropriate topic in the list of topics.
   1. Delete the role you no longer need: click the ![image](../../_assets/cross.svg) icon next to the role name. To revoke all permissions for a topic, delete it from the list: hover over the topic name and click ![image](../../_assets/cross.svg) at the end of the line.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To revoke access permissions to certain topics, provide an updated list of `--permission` parameters:

   ```bash
   {{ yc-mdb-kf }} user update <username> \
     --cluster-name <cluster_name> \
     --permission topic=<topic_name>,role=<user_role>
   ```

   When you update user permissions, the existing permissions are revoked and replaced with the new ones. This means the command must always include a complete list of permissions to be assigned to the user.

   The `--permission` flag must include at least one topic/role pair, where:

   * `topic`: Topic name.
   * `role`: User role, such as `producer`, `consumer`, or `admin`.

   To revoke all the permissions granted to the user, use the console or delete the user.

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).
   1. In the file, find the `yandex_mdb_kafka_user` resource for the required user.
   1. Edit or delete the `permission` section.
   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_kafka_cluster).

   {% include [Terraform timeouts](../../_includes/mdb/mkf/terraform/cluster-timeouts.md) %}


- API

   To revoke user permissions, use the [revokePermission](../api-ref/User/revokePermission.md) REST API method for the [User](../api-ref/User/index.md) resource or the [UserService/RevokePermission](../api-ref/grpc/user_service.md#RevokePermission) gRPC API call and provide the following in the request:
   * Cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * Username in the `userName` parameter. To find out the name, [get a list of users in the cluster](#list-accounts).
   * The topic permission to be revoked in the `permission` parameter.


{% endlist %}

## Getting a list of users in a cluster {#list-accounts}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the appropriate folder.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
   1. Click the cluster name and go to the **{{ ui-key.yacloud.mdb.cluster.switch_users }}** tab.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get a list of users:
   1. To get a list of users, run the following command:

      ```bash
      {{ yc-mdb-kf }} user list --cluster-name <cluster_name>
      ```

   1. To get detailed information for a specific user, run this command:

      ```bash
      {{ yc-mdb-kf }} user get <username> --cluster-name <cluster_name>
      ```


- API

   To get a list of users, use the [list](../api-ref/User/list.md) REST API method for the [User](../api-ref/User/index.md) resource or the [UserService/List](../api-ref/grpc/user_service.md#List) gRPC API call and provide the cluster ID in the `clusterId` request parameter.

   To find out the cluster ID, [get a list of clusters in the folder](#list-clusters).


{% endlist %}

## Importing users to {{ TF }} {#import-account}

Using import, you can bring the existing cluster users under {{ TF }} management.

{% list tabs %}

- {{ TF }}

   1. In the {{ TF }} configuration file, specify the user you want to import:

      ```hcl
      resource "yandex_mdb_kafka_user" "<username>" {}
      ```

   1. Run the following command to import the user:

      ```hcl
      terraform import yandex_mdb_kafka_user.<username> <cluster_ID>:<username>
      ```

      To learn more about importing users, see the [{{ TF }} provider documentation](https://github.com/yandex-cloud/terraform-provider-yandex/blob/v0.96.1/website/docs/r/mdb_kafka_user.html.markdown#import).

{% endlist %}

## Deleting a user {#delete-account}

If you delete the [admin user](../concepts/topics.md#management) with the `ACCESS_ROLE_ADMIN` role in a cluster, you will no longer be able to manage topics. To avoid this, assign this role to another user before deleting the admin user.

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the appropriate folder.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
   1. Click the cluster name and go to the **{{ ui-key.yacloud.mdb.cluster.switch_users }}** tab.
   1. Click ![image](../../_assets/horizontal-ellipsis.svg) for the appropriate user and select **{{ ui-key.yacloud.mdb.cluster.users.button_action-remove }}**.
   1. In the window that opens, click **{{ ui-key.yacloud.common.delete }}**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To remove a user, run:

   ```bash
   {{ yc-mdb-kf }} user delete <username> --cluster-name <cluster_name>
   ```

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).
   1. Delete the `yandex_mdb_kafka_user` resource for the appropriate user.
   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_kafka_cluster).

   {% include [Terraform timeouts](../../_includes/mdb/mkf/terraform/cluster-timeouts.md) %}


- API

   To delete a user, use the [delete](../api-ref/User/delete.md) REST API method for the [User](../api-ref/User/index.md) resource or the [UserService/Delete](../api-ref/grpc/user_service.md#Delete) gRPC API call and provide the following in the request:
   * Cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * Username to delete in the `userName` parameter. To find out the name, [get a list of users in the cluster](#list-accounts).


{% endlist %}
