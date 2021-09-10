# Managing Apache Kafka® accounts

Accounts in {{ KF }} let you manage permissions of data [producers and consumers](../concepts/producers-consumers.md). A producer or consumer can only access the [topics](../concepts/topics.md) that are allowed for their accounts.

You can use the same account for multiple producers or consumers: the former get the rights to write data to certain topics and the latter get the read rights.

After [creating a {{ KF }} cluster](cluster-create.md), you can:

- [{#T}](#create-account).
- [{#T}](#update-password).
- [{#T}](#update-account).
- [{#T}](#grant-permission).
- [{#T}](#revoke-permission).
- [{#T}](#delete-account).
- [{#T}](#list-accounts).

## Creating an account {#create-account}

{% list tabs %}

- Management console

  To create an account in a cluster:

  1. Go to the folder page and select **{{ mkf-name }}**.

  1. Click the name of the cluster and go to the **Users** tab.

  1. Click **Add**.

  1. Enter the account name (username) and password.

      {% include [user-name-and-password-limits](../../_includes/mdb/mkf/note-info-user-name-and-pass-limits.md) %}

  1. [Grant permissions](#grant-permission) to the necessary topics.

  1. Click **Add**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create an account:

  1. Read the description of the CLI create account command:

     ```
     {{ yc-mdb-kf }} user create --help
     ```

  1. Create an account and grant permissions for the desired topics:

     ```
     {{ yc-mdb-kf }} user create <username> \
     --cluster-name <cluster name>
     --password <user password> \
     --permission topic=<topic name>,role=<user role: producer or consumer>
     ```

      {% include [user-name-and-password-limits](../../_includes/mdb/mkf/note-info-user-name-and-pass-limits.md) %}

- Terraform

    To create an account:

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For information about how to create this file, see [{#T}](cluster-create.md).

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

    1. [Grant permissions](#grant-permission) to the necessary topics.

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm the update of resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see the [{{ TF }} provider documentation](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/mdb_kafka_cluster).


- API

  Use the [create](../api-ref/User/create.md) API method and pass the following in the request:
  - The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
  - Account settings in the `userSpec` parameter:
    - A name for the account in the `name` parameter.
    - A password for the account in the `password` parameter.
    - Topic permissions (one or more `permissions` parameters, one for each topic):
      - The topic name in the `topicName` parameter. To find out the name, [get a list of topics in the cluster](cluster-topics.md#list-topics).
      - Topic permissions in the `role` parameter: `ACCESS_ROLE_PRODUCER` for the producer or `ACCESS_ROLE_CONSUMER` for the consumer.

  {% include [user-name-and-password-limits](../../_includes/mdb/mkf/note-info-user-name-and-pass-limits.md) %}

{% endlist %}

## Updating an account password {#update-password}

{% list tabs %}

- Management console

  To change the account password:
  1. Go to the folder page and select **{{ mkf-name }}**.
  1. Click the name of the cluster and go to the **Users** tab.
  1. Click ![image](../../_assets/horizontal-ellipsis.svg) for the desired account and select **Change password**.
  1. Set a new password and click **Edit**.

  {% include [password-limits](../../_includes/mdb/mkf/note-info-password-limits.md) %}

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To update an account password, run the command below:

  ```
  {{ yc-mdb-kf }} user update <username> \
  --cluster-name <cluster name>
  --password <new password>
  ```

  {% include [password-limits](../../_includes/mdb/mkf/note-info-password-limits.md) %}

- Terraform

    To change the account password:

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For information about how to create this file, see [{#T}](cluster-create.md).

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

    1. Confirm the update of resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see the [{{ TF }} provider documentation](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/mdb_kafka_cluster).


- API

  Use the [update](../api-ref/User/update.md) API method and pass the following in the request:
  - The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
  - The account name in the `userName` parameter. To find out the name, [get a list of accounts in the cluster](#list-accounts).
  - The name of the `password` setting in the `updateMask` parameter. If this parameter is omitted, the API method resets any account settings that aren't explicitly specified in the request to their default values.
  - The new password for the account in the `password` parameter.

  {% include [password-limits](../../_includes/mdb/mkf/note-info-password-limits.md) %}

{% endlist %}

## Updating account settings {#update-account}

{% list tabs %}

- Management console

  To change the account settings in the cluster:
  1. Go to the folder page and select **{{ mkf-name }}**.
  1. Click the name of the cluster and go to the **Users** tab.
  1. Click ![image](../../_assets/horizontal-ellipsis.svg) for the desired account and select **Configure**.
  1. [Grant](#grant-permission) or [revoke](#revoke-permission) permissions to topics, if necessary.
  1. Click **Save**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Using the CLI, you can [grant](#grant-permission) and [revoke](#revoke-permission) topic permissions.

- Terraform

    To change account settings:

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For information about how to create this file, see [{#T}](cluster-create.md).

    1. In the {{ mkf-name }} cluster description, edit the `permission` section nested in the `user` section to [grant](#grant-permission) or [revoke](#revoke-permission) topic permissions.

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm the update of resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see the [{{ TF }} provider documentation](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/mdb_kafka_cluster).


- API

  Use the [update](../api-ref/User/update.md) API method and pass the following in the request:
  - The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
  - The account name in the `userName` parameter. To find out the name, [get a list of accounts in the cluster](#list-accounts).
  - In the `updateMask` parameter, a list of settings to update (in a single line, comma-separated). If this parameter is omitted, the API method resets any account settings that aren't explicitly specified in the request to their default values.
  - A new set of permissions to topics (one or more `permissions` parameters, one for each topic).

{% endlist %}

## Granting permissions to an account {#grant-permission}

{% include [mkf-deleted-topic-permissions-note](../../_includes/mdb/mkf-deleted-topic-permissions-note.md) %}

{% list tabs %}

- Management console

  When [creating](#create-account) or [updating](#update-account) an account, you can grant permissions to the necessary topics.

  To grant permissions to a topic:

  1. Find the desired topic in the list of topics.

     If the topic isn't in the list, add it:
     1. Click **+ Add topic**. If there is no such button, it means that all existing cluster topics are added to this account.
     1. Select the desired topic from the drop-down list.

  1. Click the ![image](../../_assets/plus.svg) in the **Roles** column for the topic and select:
     - `ACCESS_ROLE_CONSUMER`: Consumers who use this account will be granted access to the topic.
     - `ACCESS_ROLE_PRODUCER`: Producers who use this account will be granted access to the topic.

     You can select both roles at the same time. In this case, the account can be used by both producers and consumers.

  1. To grant permissions to other topics, repeat the steps.

  1. (optional) If you granted permissions to a topic by mistake, [revoke them](#revoke-permission).

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To grant permissions to an account:

  1. Retrieve a list of cluster topics:

     ```
     {{ yc-mdb-kf }} topic list --cluster-name <cluster name>
     ```

  1. Grant permissions to the required topics by passing the `--permission` parameters:

     ```
     {{ yc-mdb-kf }} user update <username> \
     --cluster-name <cluster name>
     --permission topic=<topic name>,role=<user role: producer or consumer>
     ```

     The following `--permission` parameters are available:
     - **`topic`**: The name of the topic that the permissions are granted for.
     - **`role`**: User role, such as producer or consumer.

     When you update account permissions, the existing permissions are revoked and replaced with the new ones. That is, the command must always include a complete list of permissions to be assigned to the account.

     For example, to grant the `test-user` the permissions in the `kafka-cli` cluster for `topic2` with the `producer` role, but keep the existing permissions for `topic1`, run the command:

     ```
     {{ yc-mdb-kf }} user update test-user \
     --cluster-name kafka-cli \
     --permission topic=topic1,role=consumer \
     --permission topic=topic2,role=producer
     ```

- Terraform

    To grant permissions to an account:

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For information about how to create this file, see [{#T}](cluster-create.md).

    1. In the {{ mkf-name }} cluster description, add a `permission` section to the `user` section:

        ```hcl
        resource "yandex_mdb_kafka_cluster" "<cluster name>" {
           user {
             name     = "<username>"
             password = "<password>"
             permission {
               topic_name = "<topic name>"
               role       = "<user role: ACCESS_ROLE_CONSUMER, ACCESS_ROLE_PRODUCER, or ACCESS_ROLE_ADMIN>"
             }
           }
           ...
        }
        ```

        The `ACCESS_ROLE_ADMIN` role is only available in a cluster with [topic management via the Admin API](../concepts/topics.md) enabled and all topics selected (`topic_name = "*"`).

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm the update of resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see the [{{ TF }} provider documentation](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/mdb_kafka_cluster).


- API

  Use the [grantPermission](../api-ref/User/grantPermission.md) API method and pass the following in the request:
  - The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
  - The account name in the `userName` parameter. To find out the name, [get a list of accounts in the cluster](#list-accounts).
  - The new permission to the topic in the `permission` parameter.

{% endlist %}

## Revoking permissions from an account {#revoke-permission}

{% list tabs %}

- Management console

  When [creating](#create-account) or [updating](#update-account) an account, you can revoke topic permissions.

  To revoke topic permissions:
  1. Find the desired topic in the list of topics.
  1. Delete the role that you no longer need by clicking ![image](../../_assets/cross.svg) next to the role name. To revoke all permissions to a topic, delete it from the list: hover over the topic name and click ![image](../../_assets/cross.svg) at the end of the line.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To revoke permissions for certain topics, pass an updated list of the `--permission` parameters:

  ```
  {{ yc-mdb-kf }} user update <username> \
  --cluster-name <cluster name>
  --permission topic=<topic name>,role=<user role: producer or consumer>
  ```

  When you update account permissions, the existing permissions are revoked and replaced with the new ones. That is, the command must always include a complete list of permissions to be assigned to the account.

  The `--permission` flag must contain at least one topic/role pair. To revoke all the permissions from an account, use the console or delete the account.

- Terraform

    To revoke permissions from an account:

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For information about how to create this file, see [{#T}](cluster-create.md).

    1. In the {{ mkf-name }} cluster description, edit or delete the `permission` section nested in the `user` section.

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm the update of resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see the [{{ TF }} provider documentation](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/mdb_kafka_cluster).


- API

  Use the [revokePermission](../api-ref/User/revokePermission.md) API method and pass the following in the request:
  - The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
  - The account name in the `userName` parameter. To find out the name, [get a list of accounts in the cluster](#list-accounts).
  - The topic permission to be revoked in the `permission` parameter.

{% endlist %}

## Deleting an account {#delete-account}

{% list tabs %}

- Management console

  To delete an account:
  1. Go to the folder page and select **{{ mkf-name }}**.
  1. Click the name of the cluster and go to the **Users** tab.
  1. Click ![image](../../_assets/horizontal-ellipsis.svg) for the account and select **Delete**.
  1. Confirm deletion and click **Delete**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To delete an account, run the command below:

  ```
  {{ yc-mdb-kf }} user delete <username> --cluster-name <cluster name>
  ```

- Terraform

    To delete an account:

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For information about how to create this file, see [{#T}](cluster-create.md).

    1. Delete the `user` block with a description of the required user from the {{ mkf-name }} cluster description.

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm the update of resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see the [{{ TF }} provider documentation](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/mdb_kafka_cluster).


- API

  Use the [delete](../api-ref/User/delete.md) API method and pass the following in the request:
  - The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
  - The name of the account to delete in the `userName` parameter. To find out the name, [get a list of accounts in the cluster](#list-accounts).

{% endlist %}

## Getting a list of cluster accounts {#list-accounts}

{% list tabs %}

- Management console

  To get a list of accounts:
  1. Go to the folder page and select **{{ mkf-name }}**.
  1. Click the name of the cluster and go to the **Users** tab.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get a list of accounts:

  1. To get a list of accounts, run the command below:

     ```
     {{ yc-mdb-kf }} user list --cluster-name <cluster name>
     ```

  1. To get detailed information for a specific account, run the command below:

     ```
     {{ yc-mdb-kf }} user get <username> --cluster-name <cluster name>
     ```


- API

  Use the [list](../api-ref/User/list.md) API method: pass the ID of the required cluster in the `clusterId` request parameter.

  To find out the cluster ID, [get a list of clusters in the folder](#list-clusters).

{% endlist %}

