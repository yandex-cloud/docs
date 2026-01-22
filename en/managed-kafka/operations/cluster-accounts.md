---
title: How to manage {{ KF }} cluster users in {{ mkf-full-name }}
description: Follow this guide to manage {{ KF }} cluster users.
---

# Managing Apache Kafka® users

Users in {{ KF }}:
* Keep the access permissions of data [producers and consumers](../concepts/producers-consumers.md) separate. Learn more about the permissions granted by each role [here](../concepts/account-roles.md).

  A producer or consumer can only access [topics](../concepts/topics.md) allowed for their users. You can assign one user to multiple producers or consumers: the former get write access to specific topics, and the latter get read access.
* [Manage topics](cluster-topics.md#admin-api). For more information, see [{#T}](../concepts/topics.md).

After [creating an {{ KF }} cluster](cluster-create.md), you can:
* [Get the list of users in the cluster](#list-accounts)
* [Create a user](#create-account)
* [Change user settings](#update-account):
    * [Change the password](#update-password)
    * [Grant permissions](#grant-permission)
    * [Revoke permissions](#revoke-permission)
* [Import a user to {{ TF }}](#import-account)
* [Delete a user](#delete-account)

## Getting a list of users in a cluster {#list-accounts}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the relevant folder.
  1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
  1. Click the cluster name and go to the **{{ ui-key.yacloud.mdb.cluster.switch_users }}** tab.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. To get a list of users, run the following command:

     ```bash
     {{ yc-mdb-kf }} user list --cluster-name <cluster_name>
     ```

  1. To get detailed information for a specific user, run this command:

     ```bash
     {{ yc-mdb-kf }} user get <username> --cluster-name <cluster_name>
     ```

  To find out the cluster name, [get the list of clusters in the folder](cluster-list.md#list-clusters).

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [User.list](../api-ref/User/list.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

     ```bash
     curl \
       --request GET \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-kafka/v1/clusters/<cluster_ID>/users'
     ```

     You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/User/list.md#yandex.cloud.mdb.kafka.v1.ListUsersResponse) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Call the [UserService/List](../api-ref/grpc/User/list.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/kafka/v1/user_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<cluster_ID>"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.kafka.v1.UserService.List
     ```

     You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/grpc/User/list.md#yandex.cloud.mdb.kafka.v1.ListUsersResponse) to make sure your request was successful.

{% endlist %}

## Creating a user {#create-account}

{% note info %}

Use the CLI, API, or {{ TF }} to create an admin user.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  To create a user for a producer or consumer in a cluster:
  1. In the [management console]({{ link-console-main }}), navigate to the relevant folder.
  1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
  1. Click the cluster name and go to the **{{ ui-key.yacloud.mdb.cluster.switch_users }}** tab.
  1. Click **{{ ui-key.yacloud.mdb.cluster.users.action_add-user }}**.
  1. Enter the username and password.

     {% include [user-name-and-password-limits](../../_includes/mdb/mkf/note-info-user-name-and-pass-limits.md) %}

  1. [Grant access permissions](#grant-permission) for the relevant topics.
  1. Click **{{ ui-key.yacloud.mdb.cluster.users.popup-button_add }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a user:

  1. See the description of the CLI command for creating users:

     ```bash
     {{ yc-mdb-kf }} user create --help
     ```

  1. Create a user with the `producer` role for the producer or the `consumer` role for the consumer and grant access permissions for the relevant topics:

     ```bash
     {{ yc-mdb-kf }} user create <username> \
       --cluster-name <cluster_name> \
       --password <password> \
       --permission topic=<topic_name>,role=<user's_role>,allow_host=<allowed_IP_address_1>,allow_host=<allowed_IP_address_2>,...,allow_host=<allowed_IP_address_N>
     ```

     The `--permission` parameter must include at least one topic-role pair, where:
       * `topic`: Topic name.
       * `role`: User’s role, `producer`, `consumer`, `admin`, or `topic_admin`. Learn more about the permissions granted by each role [here](../concepts/account-roles.md).
       * `allow_host`: (Optional) Allowed source IP address for this user. To specify multiple addresses, add the required number of `allow_host` options separated by commas.

  To create an [admin user](../concepts/topics.md#management) to manage cluster topics:

  1. See the description of the CLI command for creating a user:

     ```bash
     {{ yc-mdb-kf }} user create --help
     ```

  1. Create a user with the `admin` role for all (`*`) cluster topics:

     ```bash
     {{ yc-mdb-kf }} user create <username> \
       --cluster-name <cluster_name> \
       --password <password> \
       --permission topic=*,role=admin,allow_host=<allowed_IP_address_1>,allow_host=<allowed_IP_address_2>,...,allow_host=<allowed_IP_address_N>
     ```

  1. Create a user with the `topic_admin` role for all cluster topics prefixed with `pref`:

     ```bash
     {{ yc-mdb-kf }} user create <username> \
       --cluster-name <cluster_name> \
       --password <password> \
       --permission topic=pref*,role=topic_admin
     ```

  {% include [user-name-and-password-limits](../../_includes/mdb/mkf/note-info-user-name-and-pass-limits.md) %}

  To find out the cluster name, [get the list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file describing your infrastructure.

     To learn how to create this file, see [Creating a cluster](cluster-create.md).
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

  1. [Grant access permissions](#grant-permission) for the relevant topics.
  1. Make sure the settings are correct.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  For more information, see [this {{ TF }} provider guide]({{ tf-provider-resources-link }}/mdb_kafka_cluster).

  {% include [Terraform timeouts](../../_includes/mdb/mkf/terraform/cluster-timeouts.md) %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [User.create](../api-ref/User/create.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

     ```bash
     curl \
       --request POST \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://{{ api-host-mdb }}/managed-kafka/v1/clusters/<cluster_ID>/users' \
       --data '{
                 "userSpec": {
                   "name": "<username>",
                   "password": "<user_password>",
                   "permissions": [
                     {
                       "topicName": "<topic_name>",
                       "role": "<level_of_topic_access_permissions>",
                       "allowHosts": [
                         <list_of_IP_addresses>
                       ]
                     }
                   ]
                 }
               }'
     ```

     Where `userSpec` stands for the new {{ KF }} user settings:

     * `name`: Username.
     * `password`: User password.

       {% include [username-and-password-limits](../../_includes/mdb/mkf/note-info-user-name-and-pass-limits.md) %}

     * `permissions`: Topic access permissions. Each array element is for a separate topic and has the following structure:
       * `topicName`: Topic name or name pattern:
         * `*`: To allow access to all topics.
         * Full topic name: To allow access to a specific topic. To find out the name, [get a list of cluster topics](cluster-topics.md#list-topics).
         * `<prefix>*` to grant access to topics whose names start with the prefix. Let's assume you have topics named `topic_a1`, `topic_a2`, and `a3`. If you put `topic*`, access will be granted to `topic_a1` and `topic_a2`. To include all the cluster's topics, use the `*` mask.
       * `role`: User’s role, `ACCESS_ROLE_CONSUMER`, `ACCESS_ROLE_PRODUCER`, `ACCESS_ROLE_TOPIC_ADMIN`, or `ACCESS_ROLE_ADMIN`. The `ACCESS_ROLE_ADMIN` role is only available if all topics are selected (`topicName: "*"`). [Learn more](../concepts/account-roles.md) about the permissions you get with each role.
       * `allowHosts`: (Optional) List of IP addresses the user is allowed to access the topic from.

     You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/User/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Call the [UserService/Create](../api-ref/grpc/User/create.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/kafka/v1/user_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<cluster_ID>",
             "user_spec": {
               "name": "<username>",
               "password": "<user_password>",
               "permissions": [
                  {
                    "topic_name": "<topic_name>",
                    "role": "<level_of_topic_access_permissions>",
                    "allow_hosts": [
                      <list_of_IP_addresses>
                    ]
                  }
               ]
             }
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.kafka.v1.UserService.Create
     ```

     Where `user_spec` represents the new DB user settings:

     * `name`: Username.
     * `password`: User password.

       {% include [username-and-password-limits](../../_includes/mdb/mkf/note-info-user-name-and-pass-limits.md) %}

     * `permissions`: Topic access permissions. Each array element is for a separate topic and has the following structure:
       * `topic_name`: Topic name or name pattern:
         * `*`: To allow access to all topics.
         * Full topic name: To allow access to a specific topic. To find out the name, [get a list of cluster topics](cluster-topics.md#list-topics).
         * `<prefix>*` to grant access to topics whose names start with the prefix. Let's assume you have topics named `topic_a1`, `topic_a2`, and `a3`. If you specify `topic*`, access will be granted to `topic_a1` and `topic_a2`.
       * `role`: User’s role, `ACCESS_ROLE_CONSUMER`, `ACCESS_ROLE_PRODUCER`, `ACCESS_ROLE_TOPIC_ADMIN`, or `ACCESS_ROLE_ADMIN`. The `ACCESS_ROLE_ADMIN` role is only available if all topics are selected (`topicName: "*"`). [Learn more](../concepts/account-roles.md) about the permissions you get with each role.
       * `allow_hosts`: (Optional) List of IP addresses the user is allowed to access the topic from.

     You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/grpc/User/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Changing user settings {#update-account}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the relevant folder.
  1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
  1. Click the cluster name and go to the **{{ ui-key.yacloud.mdb.cluster.switch_users }}** tab.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) for the appropriate user and select:

     * **{{ ui-key.yacloud.mdb.cluster.users.button_action-password }}** to [enter another password](#update-password) for the user.
     * **{{ ui-key.yacloud.mdb.cluster.users.button_action-update }}** to [grant](#grant-permission) or [revoke](#revoke-permission) topic access permissions.

  1. Click **{{ ui-key.yacloud.mdb.cluster.users.popup-button_save }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Using the CLI, you can [change a user's password](#update-password), [grant](#grant-permission) or [revoke](#revoke-permission) topic access permissions.

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file describing your infrastructure.

     To learn how to create this file, see [Creating a cluster](cluster-create.md).

  1. In this file, locate the `yandex_mdb_kafka_user` resource for the user and make the changes.

     Using {{ TF }}, you can [change a user's password](#update-password), [grant](#grant-permission) or [revoke](#revoke-permission) topic access permissions.

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [User.update](../api-ref/User/update.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

     {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

     ```bash
     curl \
       --request PATCH \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://{{ api-host-mdb }}/managed-kafka/v1/clusters/<cluster_ID>/users/<username>' \
       --data '{
                 "updateMask": "permissions",
                 "permissions": [
                   {
                    "topicName": "<topic_name>",
                    "role": "<level_of_topic_access_permissions>",
                    "allowHosts": [
                      <list_of_IP_addresses>
                    ]
                  }
                 ]
               }'
     ```

     Where:

     * `updateMask`: Comma-separated string of settings you want to update.

        Here, we only specified a single setting, `permissions`.

     * `permissions`: New set of access permissions for topics. Each array element is for a separate topic and has the following structure:
       * `topicName`: Topic name or name template. To find out the name, [get a list of cluster topics](cluster-topics.md#list-topics). To include all the cluster's topics, use the `*` mask.
       * `role`: User’s new role, `ACCESS_ROLE_CONSUMER`, `ACCESS_ROLE_PRODUCER`, `ACCESS_ROLE_TOPIC_ADMIN`, or `ACCESS_ROLE_ADMIN`. The `ACCESS_ROLE_ADMIN` role is only available if all topics are selected (`topicName: "*"`). [Learn more](../concepts/account-roles.md) about the permissions you get with each role.
       * `allowHosts`: (Optional) New list of IP addresses the user is allowed to access the topic from.

     You can get the cluster ID from the [folder’s cluster list](cluster-list.md#list-clusters), and the username from the [list of cluster users](#list-accounts).

  1. Check the [server response](../api-ref/User/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

  You can also use the `User.update` method to [change a user's password](#update-password), and the `grantPermission` and `revokePermission` methods to [grant](#grant-permission) or [revoke](#revoke-permission) topic access permissions.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Call the [UserService/Update](../api-ref/grpc/User/update.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

     {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/kafka/v1/user_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<cluster_ID>",
             "user_name": "<username>",
             "update_mask": {
               "paths": [
                 "permissions"
               ]
             },
             "permissions": [
               {
                 "topic_name": "<topic_name>",
                 "role": "<level_of_topic_access_permissions>",
                 "allow_hosts": [
                   <list_of_IP_addresses>
                 ]
               }
             ]
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.kafka.v1.UserService.Update
     ```

     Where:

     * `update_mask`: List of settings you want to update as an array of strings (`paths[]`).

        In this case, the array consists of only one string, `permissions`.

     * `permissions`: New set of access permissions for topics. Each array element is for a separate topic and has the following structure:
       * `topic_name`: Topic name or name template. To find out the name, [get a list of cluster topics](cluster-topics.md#list-topics). To include all the cluster's topics, use the `*` mask.
       * `role`: User’s new role, `ACCESS_ROLE_CONSUMER`, `ACCESS_ROLE_PRODUCER`, `ACCESS_ROLE_TOPIC_ADMIN`, or `ACCESS_ROLE_ADMIN`. The `ACCESS_ROLE_ADMIN` role is only available if all topics are selected (`topicName: "*"`). [Learn more](../concepts/account-roles.md) about the permissions you get with each role.
       * `allow_hosts`: (Optional) New list of IP addresses the user is allowed to access the topic from.

     You can get the cluster ID from the [folder’s cluster list](cluster-list.md#list-clusters), and the username from the [list of cluster users](#list-accounts).

  1. Check the [server response](../api-ref/grpc/User/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

  You can also use the `UserService/Update` call to [change a user’s password](#update-password), and the `grantPermission` and `revokePermission` methods to [grant](#grant-permission) or [revoke](#revoke-permission) topic access permissions.

{% endlist %}

### Changing a user password {#update-password}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the relevant folder.
  1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
  1. Click the cluster name and go to the **{{ ui-key.yacloud.mdb.cluster.switch_users }}** tab.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) for the appropriate user and select **{{ ui-key.yacloud.mdb.cluster.users.button_action-password }}**.
  1. Set a new password and click **{{ ui-key.yacloud.mdb.cluster.users.popup-password_button_change }}**.

  {% include [password-limits](../../_includes/mdb/mkf/note-info-password-limits.md) %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To change the user password, run this command:

  ```bash
  {{ yc-mdb-kf }} user update <username> \
    --cluster-name <cluster_name> \
    --password <new_password>
  ```

  {% include [password-limits](../../_includes/mdb/mkf/note-info-password-limits.md) %}

  To find out the cluster name, [get the list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file describing your infrastructure.

     To learn how to create this file, see [Creating a cluster](cluster-create.md).
  1. Locate the user's `yandex_mdb_kafka_user` resource in the file.
  1. Edit the `password` field value:

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

  For more information, see [this {{ TF }} provider guide]({{ tf-provider-resources-link }}/mdb_kafka_cluster).

  {% include [Terraform timeouts](../../_includes/mdb/mkf/terraform/cluster-timeouts.md) %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [User.update](../api-ref/User/update.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

     {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

     ```bash
     curl \
       --request PATCH \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://{{ api-host-mdb }}/managed-kafka/v1/clusters/<cluster_ID>/users/<username>' \
       --data '{
                 "updateMask": "password",
                 "password": "<new_user_password>"
               }'
     ```

     Where:

     * `updateMask`: Comma-separated string of settings you want to update.

        Here, we only specified a single setting, `password`.

     * `password`: New user password.

       {% include [password-limits](../../_includes/mdb/mkf/note-info-password-limits.md) %}

     You can get the cluster ID from the [folder’s cluster list](cluster-list.md#list-clusters), and the username from the [list of cluster users](#list-accounts).

  1. Check the [server response](../api-ref/User/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Call the [UserService/Update](../api-ref/grpc/User/update.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

     {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/kafka/v1/user_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<cluster_ID>",
             "user_name": "<username>",
             "update_mask": {
               "paths": [
                 "password"
               ]
             },
             "password": "<new_user_password>"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.kafka.v1.UserService.Update
     ```

     Where:

     * `update_mask`: List of settings you want to update as an array of strings (`paths[]`).

        In this case, the array consists of only one string, `password`.

     * `password`: New user password.

       {% include [password-limits](../../_includes/mdb/mkf/note-info-password-limits.md) %}

     You can get the cluster ID from the [folder’s cluster list](cluster-list.md#list-clusters), and the username from the [list of cluster users](#list-accounts).

  1. Check the [server response](../api-ref/grpc/User/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

### Granting user permissions {#grant-permission}

{% include [mkf-deleted-topic-permissions-note](../../_includes/mdb/mkf-deleted-topic-permissions-note.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the relevant folder.
  1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
  1. Select the cluster.
  1. Navigate to the **{{ ui-key.yacloud.mdb.cluster.switch_users }}** tab.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) for the user you need to issue topic permissions to and select **{{ ui-key.yacloud.mdb.cluster.users.button_action-update }}**.
  1. Click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.kafka.button_add-topic }}**. If there is no such button, it means that the user got permissions for all existing cluster topics.

     If the user does not need permissions to certain topics, you can [revoke them](#revoke-permission).

  1. Select the appropriate topic from the drop-down list or enter its name:

     1. Specify the following in the **{{ ui-key.yacloud.kafka.label_topic }}** field:

        * `*` to allow access to any topics.
        * Full topic name: To allow access to a specific topic.
        * `<prefix>*` to grant access to topics whose names start with the prefix. Let's assume you have topics named `topic_a1`, `topic_a2`, and `a3`. If you specify `topic*`, access will be granted to `topic_a1` and `topic_a2`.

     1. Click **{{ ui-key.yacloud.kafka.button_add-topic }}**.

  1. Click the ![image](../../_assets/console-icons/plus.svg) icon in the **{{ ui-key.yacloud.mdb.dialogs.popup_field_roles }}** column for the topic you need and select a role:
     * `ACCESS_ROLE_CONSUMER`: Access to the topic will be allowed to consumers logged in as this user.
     * `ACCESS_ROLE_PRODUCER`: Access to the topic will be allowed to producers logged in as this user.
     * `ACCESS_ROLE_ADMIN`: Only available if access to all topics is selected.
     * `ACCESS_ROLE_TOPIC_ADMIN`: Role with full permissions to manage topics via the [{{ KF }} Admin API](https://kafka.apache.org/documentation/#adminapi).

     You can select the `ACCESS_ROLE_CONSUMER` and `ACCESS_ROLE_PRODUCER` roles at the same time to make the user suitable for both producers and consumers.

     [Learn more](../concepts/account-roles.md) about the permissions you get with each role.

     The user also gains access to data schema subjects. The availability of subjects depends on the specified roles and topics. For more information, see [{#T}](../concepts/managed-schema-registry.md#subjects).

  1. To grant permissions to other topics, repeat the steps.
  1. (Optional) If you granted permissions for a topic accidentally, [revoke them](#revoke-permission).

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To grant user permissions:
  1. Retrieve a list of cluster topics:

     ```bash
     {{ yc-mdb-kf }} topic list --cluster-name <cluster_name>
     ```

  1. Grant access permissions for required topics by providing the `--permission` parameters:

     ```bash
     {{ yc-mdb-kf }} user update <username> \
       --cluster-name <cluster_name> \
       --permission topic=<topic_name>,role=<user's_role>,allow_host=<allowed_IP_address_1>,allow_host=<allowed_IP_address_2>,...,allow_host=<allowed_IP_address_N>
     ```

     The following `--permission` parameters are available:
     * `topic`: Name of the topic to issue permissions for.

        If the user does not need permissions to certain topics, you can [revoke them](#revoke-permission).

     * `role`: User’s role, `producer`, `consumer`, `admin`, or `topic_admin`. [Learn more](../concepts/account-roles.md) about the permissions you get with each role.

       The `admin` role is only available if all topics are selected (`topic=*`).

     * `allow_host`: (Optional) Allowed source IP address for this user. To specify multiple addresses, add the required number of `allow_host` options separated by commas.

     When you update user permissions, existing permissions get revoked and replaced with new ones. This means the command must always include a complete list of permissions to be assigned to the user.

     For example, to grant permissions to a user named `test-user` in the `kafka-cli` cluster for the `topic2` topic with the `producer` role, while keeping the existing `topic1` permissions, run this command:

     ```bash
     {{ yc-mdb-kf }} user update test-user \
       --cluster-name kafka-cli \
       --permission topic=topic1,role=consumer \
       --permission topic=topic2,role=producer
     ```

     Along with access to the topic, users also gain access to data schema subjects. The availability of subjects depends on the specified roles and topics. For more information, see [{#T}](../concepts/managed-schema-registry.md#subjects).

  To find out the cluster name, [get the list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file describing your infrastructure.

     To learn how to create this file, see [Creating a cluster](cluster-create.md).
  1. Locate the user's `yandex_mdb_kafka_cluster` resource in the file.
  1. Add the `permission` section:

     ```hcl
     resource "yandex_mdb_kafka_user" "<username>" {
       ...
       permission {
         topic_name  = "<topic>"
         role        = "<user's_role>"
         allow_hosts = [ <list_of_allowed_IP_addresses> ] 
       }
     }
     ```

     Where:

     * `topic_name`: Topic name. Specify the following:

       * `*`: To allow access to all topics.
       * Full topic name: To allow access to a specific topic.
       * `<prefix>*` to grant access to topics whose names start with the prefix. Let's assume you have topics named `topic_a1`, `topic_a2`, and `a3`. If you specify `topic*`, access will be granted to `topic_a1` and `topic_a2`.

     * `role`: User’s role, `ACCESS_ROLE_CONSUMER`, `ACCESS_ROLE_PRODUCER`, `ACCESS_ROLE_TOPIC_ADMIN`, or `ACCESS_ROLE_ADMIN`. The `ACCESS_ROLE_ADMIN` role is only available if all topics are selected (`topicName: "*"`). [Learn more](../concepts/account-roles.md) about the permissions you get with each role.

     * `allow_hosts`: List of IP addresses the user is allowed to access the topic from.

     Along with access to the topic, users also gain access to data schema subjects. The list of available of subjects depends on the roles and topics you specify. For more information, see [Subjects in {{ mkf-msr }}](../concepts/managed-schema-registry.md#subjects).

    If the user does not need permissions to certain topics, you can [revoke them](#revoke-permission).

  1. Make sure the settings are correct.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  For more information, see [this {{ TF }} provider guide]({{ tf-provider-resources-link }}/mdb_kafka_cluster).

  {% include [Terraform timeouts](../../_includes/mdb/mkf/terraform/cluster-timeouts.md) %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [User.grantPermission](../api-ref/User/grantPermission.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

     ```bash
     curl \
       --request POST \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://{{ api-host-mdb }}/managed-kafka/v1/clusters/<cluster_ID>/users/<username>:grantPermission' \
       --data '{
                 "permission": [
                   {
                    "topicName": "<topic_name>",
                    "role": "<user's_role>",
                    "allowHosts": [
                      <list_of_IP_addresses>
                    ]
                  }
                 ]
               }'
     ```

     Where:

     * `permission`: New access permission for the topic.
       * `topicName`: Topic name. To find out the name, [get a list of cluster topics](cluster-topics.md#list-topics).
       * `role`: User’s role, `ACCESS_ROLE_CONSUMER`, `ACCESS_ROLE_PRODUCER`, `ACCESS_ROLE_TOPIC_ADMIN`, or `ACCESS_ROLE_ADMIN`. The `ACCESS_ROLE_ADMIN` role is only available if all topics are selected (`topicName: "*"`). [Learn more](../concepts/account-roles.md) about the permissions you get with each role.
       * `allowHosts`: (Optional) List of IP addresses the user is allowed to access the topic from.

     You can get the cluster ID from the [folder’s cluster list](cluster-list.md#list-clusters), and the username from the [list of cluster users](#list-accounts).

  1. Check the [server response](../api-ref/User/grantPermission.md#yandex.cloud.operation.Operation) to make sure your request was successful.

  Along with access to the topic, users also gain access to data schema subjects. The availability of subjects depends on the specified roles and topics. For more information, see [{#T}](../concepts/managed-schema-registry.md#subjects).

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Call the [UserService/GrantPermission](../api-ref/grpc/User/grantPermission.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/kafka/v1/user_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<cluster_ID>",
             "user_name": "<username>",
             "permission": [
               {
                 "topic_name": "<topic_name>",
                 "role": "<user's_role>",
                 "allow_hosts": [
                   <list_of_IP_addresses>
                 ]
               }
             ]
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.kafka.v1.UserService.GrantPermission
     ```

     Where:

     * `permission`: New access permission for the topic.
       * `topic_name`: Topic name or name template. To find out the name, [get a list of cluster topics](cluster-topics.md#list-topics). To include all the cluster's topics, use the `*` mask.
       * `role`: User’s role, `ACCESS_ROLE_CONSUMER`, `ACCESS_ROLE_PRODUCER`, `ACCESS_ROLE_TOPIC_ADMIN`, or `ACCESS_ROLE_ADMIN`. The `ACCESS_ROLE_ADMIN` role is only available if all topics are selected (`topicName: "*"`). [Learn more](../concepts/account-roles.md) about the permissions you get with each role.
       * `allow_hosts`: (Optional) List of IP addresses the user is allowed to access the topic from.

     You can get the cluster ID from the [folder’s cluster list](cluster-list.md#list-clusters), and the username from the [list of cluster users](#list-accounts).

  1. Check the [server response](../api-ref/grpc/User/grantPermission.md#yandex.cloud.operation.Operation) to make sure your request was successful.

  Along with access to the topic, users also gain access to data schema subjects. The availability of subjects depends on the specified roles and topics. For more information, see [{#T}](../concepts/managed-schema-registry.md#subjects).

{% endlist %}

### Revoking user permissions {#revoke-permission}

If you revoke the `ACCESS_ROLE_ADMIN` role from the [admin user](../concepts/topics.md#management) in a cluster, you will no longer be able to manage topics. Do not revoke this role without first granting it to another user.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the relevant folder.
  1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
  1. Select the cluster.
  1. Navigate to the **{{ ui-key.yacloud.mdb.cluster.switch_users }}** tab.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) for the appropriate user and select **{{ ui-key.yacloud.mdb.cluster.users.button_action-update }}**.
  1. Find the appropriate topic in the list of topics.
  1. Delete the role you no longer need: click the ![image](../../_assets/console-icons/xmark.svg) icon next to its name. To revoke all permissions for a topic, delete it from the list: hover over the topic name and click ![image](../../_assets/console-icons/xmark.svg) at the end of the line.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To revoke access permissions for specific topics, provide an updated list of `--permission` parameters:

  ```bash
  {{ yc-mdb-kf }} user update <username> \
    --cluster-name <cluster_name> \
    --permission topic=<topic_name>,role=<user's_role>,allow_host=<allowed_IP_address_1>,allow_host=<allowed_IP_address_2>,...,allow_host=<allowed_IP_address_N>
  ```

  When you update user permissions, existing permissions get revoked and replaced with new ones. This means the command must always include a complete list of permissions to be assigned to the user.

  The `--permission` parameter must include at least one topic-role pair, where:

  * `topic`: Topic name.
  * `role`: User’s role, `producer`, `consumer`, `admin`, or `topic_admin`. Learn more about the permissions granted by each role [here](../concepts/account-roles.md).
  * `allow_host`: (Optional) Allowed source IP address for this user. To specify multiple addresses, add the required number of `allow_host` options separated by commas.

  To find out the cluster name, [get the list of clusters in the folder](cluster-list.md#list-clusters).

  To revoke all the permissions granted to the user, use the console or delete the user.

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file describing your infrastructure.

     To learn how to create this file, see [Creating a cluster](cluster-create.md).
  1. Locate the user's `yandex_mdb_kafka_user` resource in the file.
  1. Edit or delete the `permission` section.
  1. Make sure the settings are correct.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  For more information, see [this {{ TF }} provider guide]({{ tf-provider-resources-link }}/mdb_kafka_cluster).

  {% include [Terraform timeouts](../../_includes/mdb/mkf/terraform/cluster-timeouts.md) %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [User.revokePermission](../api-ref/User/revokePermission.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

     ```bash
     curl \
       --request POST \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://{{ api-host-mdb }}/managed-kafka/v1/clusters/<cluster_ID>/users/<username>:revokePermission' \
       --data '{
                 "permission": [
                   {
                    "topicName": "<topic_name>",
                    "role": "<user's_role>",
                    "allowHosts": [
                      <list_of_IP_addresses>
                    ]
                  }
                 ]
               }'
     ```

     Where:

     * `permission`: Access permission for the topic to be revoked:
       * `topicName`: Topic name. To find out the name, [get a list of cluster topics](cluster-topics.md#list-topics).
       * `role`: User’s role to revoke, `ACCESS_ROLE_PRODUCER`, `ACCESS_ROLE_CONSUMER`, `ACCESS_ROLE_ADMIN`, or `ACCESS_ROLE_TOPIC_ADMIN`.
       * `allow_hosts`: (Optional) List of IP addresses for which the user’s access permissions to the topic will be revoked.

     You can get the cluster ID from the [folder’s cluster list](cluster-list.md#list-clusters), and the username from the [list of cluster users](#list-accounts).

  1. Check the [server response](../api-ref/User/revokePermission.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Call the [UserService/RevokePermission](../api-ref/grpc/User/revokePermission.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/kafka/v1/user_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<cluster_ID>",
             "user_name": "<username>",
             "permission": [
               {
                 "topic_name": "<topic_name>",
                 "role": "<user's_role>",
                 "allow_hosts": [
                   <list_of_IP_addresses>
                 ]
               }
             ]
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.kafka.v1.UserService.RevokePermission
     ```

     Where:

     * `permission`: Access permission for the topic to be revoked:
       * `topic_name`: Topic name or name template. To find out the name, [get a list of cluster topics](cluster-topics.md#list-topics).
       * `role`: User’s role to revoke, `ACCESS_ROLE_PRODUCER`, `ACCESS_ROLE_CONSUMER`, `ACCESS_ROLE_ADMIN`, or `ACCESS_ROLE_TOPIC_ADMIN`.
       * `allow_hosts`: (Optional) List of IP addresses for which the user’s access to the topic will be revoked.

     You can get the cluster ID from the [folder’s cluster list](cluster-list.md#list-clusters), and the username from the [list of cluster users](#list-accounts).

  1. Check the [server response](../api-ref/grpc/User/revokePermission.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Importing users to {{ TF }} {#import-account}

Using import, you can bring the existing cluster users under {{ TF }} management.

{% list tabs group=instructions %}

- {{ TF }} {#tf}

    1. In the {{ TF }} configuration file, specify the user you want to import:

        ```hcl
        resource "yandex_mdb_kafka_user" "<username>" {}
        ```

    1. Run the following command to import the user:

        ```hcl
        terraform import yandex_mdb_kafka_user.<username> <cluster_ID>:<username>
        ```

        To learn more about importing users, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_kafka_user#import).

{% endlist %}

## Deleting a user {#delete-account}

If you delete the [admin user](../concepts/topics.md#management) with the `ACCESS_ROLE_ADMIN` role in a cluster, you will no longer be able to manage topics. To avoid this, assign this role to another user before deleting the admin user.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the relevant folder.
  1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
  1. Click the cluster name and go to the **{{ ui-key.yacloud.mdb.cluster.switch_users }}** tab.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) for the appropriate user and select **{{ ui-key.yacloud.mdb.clusters.button_action-delete }}**.
  1. In the window that opens, click **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To delete a user, run this command:

  ```bash
  {{ yc-mdb-kf }} user delete <username> --cluster-name <cluster_name>
  ```

  To find out the cluster name, [get the list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file describing your infrastructure.

     To learn how to create this file, see [Creating a cluster](cluster-create.md).
  1. Delete the user's `yandex_mdb_kafka_user` resource.
  1. Make sure the settings are correct.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  For more information, see [this {{ TF }} provider guide]({{ tf-provider-resources-link }}/mdb_kafka_cluster).

  {% include [Terraform timeouts](../../_includes/mdb/mkf/terraform/cluster-timeouts.md) %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [User.delete](../api-ref/User/delete.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

     ```bash
     curl \
       --request DELETE \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-kafka/v1/clusters/<cluster_ID>/users/<username>'
     ```

     You can get the cluster ID from the [folder’s cluster list](cluster-list.md#list-clusters), and the username from the [list of cluster users](#list-accounts).

  1. Check the [server response](../api-ref/User/delete.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Call the [UserService/Delete](../api-ref/grpc/User/delete.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/kafka/v1/user_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<cluster_ID>",
             "user_name": "<username>"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.kafka.v1.UserService.Delete
     ```

     You can get the cluster ID from the [folder’s cluster list](cluster-list.md#list-clusters), and the username from the [list of cluster users](#list-accounts).

  1. Check the [server response](../api-ref/grpc/User/delete.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}
