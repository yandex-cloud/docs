# Managing Apache Kafka® users

Users in {{ KF }}:
* Keep the access permissions of data [producers and consumers](../concepts/producers-consumers.md) separate.

   A producer or consumer can only access [topics](../concepts/topics.md) that are allowed for their users. You can use the same user for multiple producers or consumers: the former get the rights to write data to certain topics and the latter get the read rights.
* [Manage topics](cluster-topics.md#admin-api) if you enabled the **Manage topics via the API** setting when [creating a cluster](cluster-create.md). For more information, see [{#T}](../concepts/topics.md).

After [creating an {{ KF }} cluster](cluster-create.md), you can:
* [{#T}](#create-user).
* [{#T}](#update-password).
* [{#T}](#update-account).
* [{#T}](#grant-permission).
* [{#T}](#revoke-permission).
* [{#T}](#delete-account).
* [{#T}](#list-accounts).

## Creating a user {#create-user}

{% note info %}

If a {{ mkf-name }} cluster has **Manage topics via the API** enabled, use the CLI, API, or {{ TF }} to create an admin user.

{% endnote %}

{% list tabs %}

- Management console

   To create a user for a producer or consumer in a cluster:
   1. In the [management console]({{ link-console-main }}), go to the desired folder.
   1. In the list of services, select **{{ mkf-name }}**.
   1. Click the name of the cluster and go to the **Users** tab.
   1. Click **Add**.
   1. Enter your username and password.

      {% include [user-name-and-password-limits](../../_includes/mdb/mkf/note-info-user-name-and-pass-limits.md) %}

   1. [Grant permissions](#grant-permission) for relevant topics.
   1. Click **Add**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To create a user:
   1. View a description of the CLI create user command:

      ```bash
      {{ yc-mdb-kf }} user create --help
      ```

   1. Create a user and grant permissions for the desired topics:

      ```bash
      {{ yc-mdb-kf }} user create <username> \
        --cluster-name <cluster name> \
        --password <password of at least 8 characters> \
        --permission topic=<topic name>,role=<user role: producer or consumer>
      ```

   To create an [admin user](../concepts/topics.md#management) to manage topics in a cluster with **Manage topics via the API** enabled:
   1. See the description of the CLI's create user command:

      ```bash
      {{ yc-mdb-kf }} user create --help
      ```

   1. Create a user with the `admin` role applicable to all (`*`) cluster topics:

      ```bash
      {{ yc-mdb-kf }} user create <username> \
        --cluster-name <cluster name> \
        --password <password of at least 8 characters> \
        --permission topic=*,role=admin
      ```

   {% include [user-name-and-password-limits](../../_includes/mdb/mkf/note-info-user-name-and-pass-limits.md) %}

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).
   1. Add a `user` section to the {{ mkf-name }} cluster description:

      ```hcl
      resource "yandex_mdb_kafka_cluster" "<cluster name>" {
         user {
           name     = "<username>"
           password = "<password>"
           ...
         }
         ...
      }
      ```

      {% include [user-name-and-password-limits](../../_includes/mdb/mkf/note-info-user-name-and-pass-limits.md) %}

   1. [Grant permissions](#grant-permission) for relevant topics.
   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the resources have been updated.

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
         * The topic name in the `topicName` parameter. To find out the name, [retrieve a list of cluster topics](cluster-topics.md#list-topics).
         * Topic permissions in the `role` parameter: `ACCESS_ROLE_PRODUCER` for the producer or `ACCESS_ROLE_CONSUMER` for the consumer.

   To create an [admin user](../concepts/topics.md#management) to manage topics in a cluster with **Manage topics via the API** enabled, when creating a user, pass a `permission` block in the `userSpec` parameter with the following values:
   * `topicName`: `*`.
   * `role`: `ACCESS_ROLE_ADMIN`.

   {% include [user-name-and-password-limits](../../_includes/mdb/mkf/note-info-user-name-and-pass-limits.md) %}


{% endlist %}

## Changing a user's password {#update-password}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the desired folder.
   1. In the list of services, select **{{ mkf-name }}**.
   1. Click the name of the cluster and go to the **Users** tab.
   1. Click ![image](../../_assets/horizontal-ellipsis.svg) for the desired user and select **Change password**.
   1. Set a new password and click **Edit**.

   {% include [password-limits](../../_includes/mdb/mkf/note-info-password-limits.md) %}

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To change the user password, run the command:

   ```bash
   {{ yc-mdb-kf }} user update <username> \
     --cluster-name <cluster name> \
     --password <new password>
   ```

   {% include [password-limits](../../_includes/mdb/mkf/note-info-password-limits.md) %}

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).
   1. In the {{ mkf-name }} cluster description, find the `user` block for the required user.
   1. Change the value of the `password` field:

      ```hcl
      resource "yandex_mdb_kafka_cluster" "<cluster name>" {
         user {
           ...
           password = "<password>"
         }
         ...
      }
      ```

      {% include [password-limits](../../_includes/mdb/mkf/note-info-password-limits.md) %}

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the resources have been updated.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_kafka_cluster).

   {% include [Terraform timeouts](../../_includes/mdb/mkf/terraform/cluster-timeouts.md) %}


- API

   To update a user's password, use the [update](../api-ref/User/update.md) REST API method for the [User](../api-ref/User/index.md) resource or the [UserService/Update](../api-ref/grpc/user_service.md#Update) gRPC API call and provide the following in the request:
   * Cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * Username in the `userName` parameter. To find out the name, [get a list of users in the cluster](#list-accounts).
   * The name of the `password` setting in the `updateMask` parameter. If this parameter is omitted, the API method resets any user settings that aren't explicitly specified in the request to their default values.
   * New user password, in the `password` parameter.

      {% include [password-limits](../../_includes/mdb/mkf/note-info-password-limits.md) %}

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}


{% endlist %}

## Changing user settings {#update-account}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the desired folder.
   1. In the list of services, select **{{ mkf-name }}**.
   1. Click the name of the cluster and go to the **Users** tab.
   1. Click ![image](../../_assets/horizontal-ellipsis.svg) for the desired user and select **Configure**.
   1. [Grant](#grant-permission) or [revoke](#revoke-permission) permissions for topics, if necessary.
   1. Click **Save**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   Using the CLI, you can [grant](#grant-permission) and [revoke](#revoke-permission) topic permissions.

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).
   1. In the {{ mkf-name }} cluster description, edit the `permission` section in the `user` section to [grant](#grant-permission) or [revoke](#revoke-permission) topic permissions.
   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the resources have been updated.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_kafka_cluster).

   {% include [Terraform timeouts](../../_includes/mdb/mkf/terraform/cluster-timeouts.md) %}


- API

   To update user settings, use the [update](../api-ref/User/update.md) REST API method for the [User](../api-ref/User/index.md) resource or the [UserService/Update](../api-ref/grpc/user_service.md#Update) gRPC API call and provide the following in the request:
   * Cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * Username in the `userName` parameter. To find out the name, [get a list of users in the cluster](#list-accounts).
   * In the `updateMask` parameter, a list of settings to update (in a single line, comma-separated). If this parameter is omitted, the API method resets any user settings that aren't explicitly specified in the request to their default values.
   * A new set of permissions to topics (one or more `permissions` parameters, one for each topic).

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}


{% endlist %}

## Granting user permissions {#grant-permission}

{% include [mkf-deleted-topic-permissions-note](../../_includes/mdb/mkf-deleted-topic-permissions-note.md) %}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the desired folder.
   1. In the list of services, select **{{ mkf-name }}**.
   1. Select the cluster.
   1. Go to the **Users** tab.
   1. Click ![image](../../_assets/horizontal-ellipsis.svg) for the desired user and select **Configure**.
   1. Find the desired topic in the list of topics.

      If the topic isn't in the list, add it:
      1. Click **+ Add topic**. If there is no such button, it means that all existing cluster topics are added to this user.
      1. Select the desired topic from the drop-down list.

         {% note info %}

         If you enabled the **Manage topics via the API** setting when creating a cluster, you should enter the topic name manually. To grant access to all topics, enter a `*` in the **Topic** field.

         {% endnote %}

   1. Click the ![image](../../_assets/plus.svg) icon in the **Roles** column for the topic and select:
      * `ACCESS_ROLE_CONSUMER`: Consumers using this user will be granted access to the topic.
      * `ACCESS_ROLE_PRODUCER`: Producers using this user will be granted access to the topic.

      You can select the `ACCESS_ROLE_CONSUMER` and `ACCESS_ROLE_PRODUCER` roles at the same time to make a user suitable for both producers and consumers.
   1. To grant permissions to other topics, repeat the steps.
   1. (optional) If you granted permissions for a topic accidentally, [revoke them](#revoke-permission).

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To grant user permissions:
   1. Retrieve a list of cluster topics:

      ```bash
      {{ yc-mdb-kf }} topic list --cluster-name <cluster name>
      ```

   1. Grant permissions to the required topics by passing the `--permission` parameters:

      ```bash
      {{ yc-mdb-kf }} user update <username> \
        --cluster-name <cluster name> \
        --permission topic=<topic name>,role=<user role: producer, consumer or admin>
      ```

      The following `--permission` parameters are available:
      * `topic`: The name of the topic that the permissions are granted for.
      * `role`: The user role, such as `producer`, `consumer`, or `admin`.

         The `admin` role is only available in a cluster with [Manage topics via Admin API](../concepts/topics.md#management) enabled if all topics are selected (`topic=*`).

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
   1. In the {{ mkf-name }} cluster description, add a `permission` section to the `user` block:

      ```hcl
      resource "yandex_mdb_kafka_cluster" "<cluster name>" {
         user {
           name     = "<username>"
           password = "<password>"
           permission {
             topic_name = "<topic name>"
             role       = "<user role: ACCESS_ROLE_CONSUMER, ACCESS_ROLE_PRODUCER or ACCESS_ROLE_ADMIN>"
           }
         }
         ...
      }
      ```

      The `ACCESS_ROLE_ADMIN` is only available in a cluster with [Manage topics via Admin API](../concepts/topics.md) enabled with all topics selected (`topic_name = "*"`).
   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the resources have been updated.

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

If, in a cluster with **Manage topics via the API** enabled, you revoke the `ACCESS_ROLE_ADMIN` role from the [admin user](../concepts/topics.md#management), you will no longer be able to manage topics. Do not revoke this role without first granting it to another user.

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the desired folder.
   1. In the list of services, select **{{ mkf-name }}**.
   1. Select the cluster.
   1. Go to the **Users** tab.
   1. Click ![image](../../_assets/horizontal-ellipsis.svg) for the desired user and select **Configure**.
   1. Find the desired topic in the list of topics.
   1. Delete the role you no longer need: click the ![image](../../_assets/cross.svg) icon next to the role name. To revoke all permissions for a topic, delete it from the list: hover over the topic name and click ![image](../../_assets/cross.svg) at the end of the line.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To revoke access permissions to certain topics, pass an updated list of `--permission` parameters:

   ```bash
   {{ yc-mdb-kf }} user update <username> \
     --cluster-name <cluster name> \
     --permission topic=<topic name>,role=<user role: producer, consumer or admin>
   ```

   When you update user permissions, the existing permissions are revoked and replaced with the new ones. This means the command must always include a complete list of permissions to be assigned to the user.

   The `--permission` flag must contain at least one topic/role pair. To revoke all the permissions granted to the user, use the console or delete the user.

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).
   1. In the {{ mkf-name }} cluster description, edit or delete the `permission` section in the `user` block.
   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the resources have been updated.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_kafka_cluster).

   {% include [Terraform timeouts](../../_includes/mdb/mkf/terraform/cluster-timeouts.md) %}


- API

   To revoke user permissions, use the [revokePermission](../api-ref/User/revokePermission.md) REST API method for the [User](../api-ref/User/index.md) resource or the [UserService/RevokePermission](../api-ref/grpc/user_service.md#RevokePermission) gRPC API call and provide the following in the request:
   * Cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * Username in the `userName` parameter. To find out the name, [get a list of users in the cluster](#list-accounts).
   * The topic permission to be revoked in the `permission` parameter.


{% endlist %}

## Deleting a user {#delete-account}

If, in a cluster with **Manage topics via the API** enabled, you delete the [admin user](../concepts/topics.md#management) with the `ACCESS_ROLE_ADMIN` role, you will no longer be able to manage topics. Assign this role to another user before deleting it.

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the desired folder.
   1. In the list of services, select **{{ mkf-name }}**.
   1. Click the name of the cluster and go to the **Users** tab.
   1. Click ![image](../../_assets/horizontal-ellipsis.svg) for the appropriate user and select **Delete**.
   1. In the window that opens, click **Delete**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To remove a user, run:

   ```bash
   {{ yc-mdb-kf }} user delete <username> --cluster-name <cluster name>
   ```

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).
   1. Delete the user block with a description of the required `user` from the {{ mkf-name }} cluster description.
   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the resources have been updated.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_kafka_cluster).

   {% include [Terraform timeouts](../../_includes/mdb/mkf/terraform/cluster-timeouts.md) %}


- API

   To delete a user, use the [delete](../api-ref/User/delete.md) REST API method for the [User](../api-ref/User/index.md) resource or the [UserService/Delete](../api-ref/grpc/user_service.md#Delete) gRPC API call and provide the following in the request:
   * Cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * The name of the user to delete in the `userName` parameter. To find out the name, [get a list of users in the cluster](#list-accounts).


{% endlist %}

## Getting a list of users in a cluster {#list-accounts}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the desired folder.
   1. In the list of services, select **{{ mkf-name }}**.
   1. Click the name of the cluster and go to the **Users** tab.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get a list of users:
   1. To get a list of users, run the following command:

      ```bash
      {{ yc-mdb-kf }} user list --cluster-name <cluster name>
      ```

   1. To get detailed information for a specific user, run this command:

      ```bash
      {{ yc-mdb-kf }} user get <username> --cluster-name <cluster name>
      ```


- API

   To get a list of users, use the [list](../api-ref/User/list.md) REST API method for the [User](../api-ref/User/index.md) resource or the [UserService/List](../api-ref/grpc/user_service.md#List) gRPC API call and provide the cluster ID in the `clusterId` request parameter.

   To find out the cluster ID, [get a list of clusters in the folder](#list-clusters).


{% endlist %}