# Managing Apache Kafka® accounts

{{ KF }} accounts:

* Keep the access permissions of data [producers and consumers](../concepts/producers-consumers.md) separate.
A producer or consumer can only access the [topics](../concepts/topics.md) that are allowed for their accounts. You can use the same account for multiple producers or consumers: the former get the rights to write data to certain topics and the latter get the read rights.
* [Manage topics](./cluster-topics.md#admin-api) if you enabled the **Manage topics via the API** setting when [creating a cluster](./cluster-create.md). For more information, see [{#T}](../concepts/topics.md).

After [creating a {{ KF }} cluster](cluster-create.md), you can:

* [{#T}](#create-account).
* [{#T}](#update-password).
* [{#T}](#update-account).
* [{#T}](#grant-permission).
* [{#T}](#revoke-permission).
* [{#T}](#delete-account).
* [{#T}](#list-accounts).

## Creating an account {#create-account}

{% list tabs %}

- Management console

  To create an account for a producer or a consumer in a cluster:

  1. Go to the folder page and select **{{ mkf-name }}**.

  1. Click the name of the cluster and go to the **Users** tab.

  1. Click **Add**.

  1. Enter the account name (username) and password.

      {% include [user-name-and-password-limits](../../_includes/mdb/mkf/note-info-user-name-and-pass-limits.md) %}

  1. [Grant permissions](#grant-permission) to the necessary topics.

  1. Click **Add**.

  To create an [administrator account](../concepts/topics.md#management) to manage topics in a cluster with **Manage topics via the API** enabled:
  1. Go to the folder page and select **{{ mkf-name }}**.
  1. Click the name of the cluster and go to the **Users** tab.
  1. Click **Add**.
  1. Enter a name for the account (username) and password (from 8 to 128 characters).
  1. In the **Topic** field, enter `*`.
  1. Click **Add topic**.
  1. Click ![plus](../../_assets/plus.svg) in the **Roles** column.
  1. Select the `ACCESS_ROLE_ADMIN` role.
  1. Click **Add**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create an account:

  1. Review the description of the CLI command to create accounts:

      ```bash
      {{ yc-mdb-kf }} user create --help
      ```

  1. Create an account and grant permissions for the desired topics:

      ```bash
      {{ yc-mdb-kf }} user create <username> \
         --cluster-name <cluster name>
         --password <password of at least 8 characters> \
         --permission topic=<topic name>,role=<user role: producer or consumer>
      ```

  To create an [administrator account](../concepts/topics.md#management) to manage topics in a cluster with **Manage topics via the API** enabled:

  1. Review the description of the CLI command to create accounts:

      ```bash
      {{ yc-mdb-kf }} user-create --help
      ```

  1. Create an account with the `admin` role applicable to all (`*`) cluster topics:

      ```bash
      {{ yc-mdb-kf }} user create <username> \
         --cluster-name <cluster name> \
         --password <password of at least 8 characters> \
         --permission topic=*,role=admin
      ```

  {% include [user-name-and-password-limits](../../_includes/mdb/mkf/note-info-user-name-and-pass-limits.md) %}

- Terraform

    To create an account:

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For information about how to create this file, see [{#T}](cluster-create.md).

    1. In the {{ mkf-name }} cluster description, add a `user` section:

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

{% if api != "noshow" %}

- API

  Use the [create](../api-ref/User/create.md) API method and pass the following in the request:
  - The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
  - Account settings in the `userSpec` parameter:
    - A name for the account in the `name` parameter.
    - A password for the account in the `password` parameter.
    - Topic permissions (one or more `permissions` parameters, one for each topic):
      - The topic name in the `topicName` parameter. To find out the name, [get a list of topics in the cluster](cluster-topics.md#list-topics).
      - Topic permissions in the `role` parameter: `ACCESS_ROLE_PRODUCER` for the producer or `ACCESS_ROLE_CONSUMER` for the consumer.

  To create an [administrator account](../concepts/topics.md#management) to manage topics in a cluster with **Manage topics via the API** enabled, when creating a user, pass a `permission` block in the `userSpec` parameter with the following values:
  * `topicName`: `*`
  * `role`: `ACCESS_ROLE_ADMIN`

  {% include [user-name-and-password-limits](../../_includes/mdb/mkf/note-info-user-name-and-pass-limits.md) %}

{% endif %}

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

  To update an account password, run the following command:

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

{% if api != "noshow" %}

- API

  Use the [update](../api-ref/User/update.md) API method and pass the following in the request:
  - The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
  - The account name in the `userName` parameter. To find out the name, [get a list of accounts in the cluster](#list-accounts).
  - The name of the `password` setting in the `updateMask` parameter. If this parameter is omitted, the API method resets any account settings that aren't explicitly specified in the request to their default values.
  - The new password for the account in the `password` parameter.

  {% include [password-limits](../../_includes/mdb/mkf/note-info-password-limits.md) %}

{% endif %}

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

    1. In the {{ mkf-name }} cluster description, edit the `permission` section in the `user` block to [grant](#grant-permission) or [revoke](#revoke-permission) topic permissions.

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm the update of resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see the [{{ TF }} provider documentation](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/mdb_kafka_cluster).

{% if api != "noshow" %}

- API

  Use the [update](../api-ref/User/update.md) API method and pass the following in the request:
  - The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
  - The account name in the `userName` parameter. To find out the name, [get a list of accounts in the cluster](#list-accounts).
  - In the `updateMask` parameter, a list of settings to update (in a single line, comma-separated). If this parameter is omitted, the API method resets any account settings that aren't explicitly specified in the request to their default values.
  - A new set of permissions to topics (one or more `permissions` parameters, one for each topic).

{% endif %}

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

        {% note info %}

         If you enabled the **Manage topics via the API** setting when creating a cluster, you should enter the topic name manually. To grant access to all topics, enter a `*` in the **Topic** field.

         {% endnote %}

  1. Click the ![image](../../_assets/plus.svg) in the **Roles** column for the topic and select:

     - `ACCESS_ROLE_CONSUMER`: Consumers who use this account will be granted access to the topic.

     - `ACCESS_ROLE_PRODUCER`: Producers who use this account will be granted access to the topic.

     - `ACCESS_ROLE_ADMIN`: The account is granted [topic management](../concepts/topics.md#management) access. This role is available if:
         * A cluster has topic management via the API enabled.
         * The role is assigned for all topics (`*`).

     You can select the `ACCESS_ROLE_CONSUMER` and `ACCESS_ROLE_PRODUCER` roles at the same time to make an account suitable for both producers and consumers.

  1. To grant permissions to other topics, repeat the steps.

  1. (optional) If you granted permissions to a topic by mistake, [revoke them](#revoke-permission).

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To grant an account permissions:

  1. Retrieve a list of cluster topics:

     ```bash
     {{ yc-mdb-kf }} topic list --cluster-name <cluster name>
     ```

  1. Grant permissions to the required topics by passing the `--permission` parameters:

     ```bash
     {{ yc-mdb-kf }} user update <username> \
        --cluster-name <cluster name> \
        --permission topic=<topic name>,role=<user role: producer, consumer, or admin>
     ```

     The following `--permission` parameters are available:

     * `topic`: The name of the topic to grant permissions to.

     * `role`: The user role, such as `producer`, `consumer`, or `admin`.

         The`admin` role is only available in a cluster with [Manage topics via Admin API](../concepts/topics.md#management) enabled if all topics are selected (`topic=*`).

     When account permissions are modified, the existing permissions are revoked and replaced with the new ones. That is, a command must always contain a complete list of permissions that an account should have.

     For example, to grant user `test-user` permissions in cluster `kafka-cli` to topic `topic2` with the `producer` role while keeping existing `topic1` permissions, run the command:

     ```bash
     {{ yc-mdb-kf }} user update test-user \
        --cluster-name kafka-cli \
        --permission topic=topic1,role=consumer \
        --permission topic=topic2,role=producer
     ```

- Terraform

    To grant an account access permissions:

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For information about how to create this file, see [{#T}](cluster-create.md).

    1. In the {{ mkf-name }} cluster description, add a `permission` section to the `user` block:

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

        The `ACCESS_ROLE_ADMIN` is only available in a cluster with [Manage topics via Admin API](../concepts/topics.md) enabled with all topics selected (`topic_name = "*"`).

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm the update of resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see the [{{ TF }} provider documentation](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/mdb_kafka_cluster).

{% if api != "noshow" %}

- API

  Use the [grantPermission](../api-ref/User/grantPermission.md) API method and pass the following in the request:
  - The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
  - The account name in the `userName` parameter. To find out the name, [get a list of accounts in the cluster](#list-accounts).
  - The new permission to the topic in the `permission` parameter.

{% endif %}

{% endlist %}

## Revoking account permissions {#revoke-permission}

{% note warning %}

If, in a cluster with **Manage topics via the API** enabled, you revoke the `ACCESS_ROLE_ADMIN` role from the [administrator account](../concepts/topics.md#management), you will no longer be able to manage topics. Do not revoke this role without first granting it to another account.

{% endnote %}

{% list tabs %}

- Management console

  When [creating](#create-account) or [updating](#update-account) an account, you can revoke topic permissions.

  To revoke topic permissions:
  1. Find the desired topic in the list of topics.
  1. Delete the role that you no longer need by clicking ![image](../../_assets/cross.svg) next to the role name. To revoke all permissions to a topic, delete it from the list: hover over the topic name and click ![image](../../_assets/cross.svg) at the end of the line.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To revoke access permissions to certain topics, pass an updated list of `--permission` parameters:

  ```
  {{ yc-mdb-kf }} user update <username> \
  --cluster-name <cluster name> \
  --permission topic=<topic name>,role=<user role: producer, consumer, or admin>
  ```

  When account permissions are modified, the existing permissions are revoked and replaced with the new ones. That is, a command must always contain a complete list of permissions that an account should have.

  The `--permission` flag must contain at least one topic/role pair. To revoke all the account's existing permissions, use the console or delete the account.

- Terraform

    To revoke an account's access permissions:

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For information about how to create this file, see [{#T}](cluster-create.md).

    1. In the {{ mkf-name }} cluster description, edit or delete the `permission` section in the `user` block.

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm the update of resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see the [{{ TF }} provider documentation](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/mdb_kafka_cluster).

{% if api != "noshow" %}

- API

  Use the [revokePermission](../api-ref/User/revokePermission.md) API method and pass the following in the request:
  - The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
  - The account name in the `userName` parameter. To find out the name, [get a list of accounts in the cluster](#list-accounts).
  - The topic permission to be revoked in the `permission` parameter.

{% endif %}

{% endlist %}

## Deleting an account {#delete-account}

{% note warning %}

If, in a cluster with **Manage topics via the API** enabled, you delete the [administrator account](../concepts/topics.md#management) with the `ACCESS_ROLE_ADMIN` role, you will no longer be able to manage topics. Assign this role to another account before deleting it.

{% endnote %}

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

  To delete an account, run the command:

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

{% if api != "noshow" %}

- API

  Use the [delete](../api-ref/User/delete.md) API method and pass the following in the request:
  - The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
  - The name of the account to delete in the `userName` parameter. To find out the name, [get a list of accounts in the cluster](#list-accounts).

{% endif %}

{% endlist %}

## Retrieving a list of cluster accounts {#list-accounts}

{% list tabs %}

- Management console

  To get a list of accounts:
  1. Go to the folder page and select **{{ mkf-name }}**.
  1. Click the name of the cluster and go to the **Users** tab.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get a list of accounts:

  1. To retrieve a list of accounts, run the command:

     ```
     {{ yc-mdb-kf }} user list --cluster-name <cluster name>
     ```

  1. To get detailed information for a specific account, run the command:

     ```
     {{ yc-mdb-kf }} user get <username> --cluster-name <cluster name>
     ```

{% if api != "noshow" %}

- API

  Use the [list](../api-ref/User/list.md) API method: pass the ID of the required cluster in the `clusterId` request parameter.

  To find out the cluster ID, [get a list of clusters in the folder](#list-clusters).

{% endif %}

{% endlist %}

