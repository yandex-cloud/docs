---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Managing Apache Kafka® accounts

Accounts in {{ KF }} let you manage permissions of data [producers and consumers](../concepts/producers-consumers.md). A producer or consumer can only access the [topics](../concepts/topics.md) that are allowed for their accounts.

You can use the same account for multiple producers or consumers: the former get the rights to write data to certain topics and the latter get the read rights.

After [creating a {{ KF }} cluster](cluster-create.md), you can:

- [Create an account](#create-account).
- [Update the account password](#update-password).
- [Update account settings](#update-account).
- [Grant account permissions](#grant-permission).
- [Revoke account permissions](#revoke-permission).
- [Delete an account](#delete-account).
- [Get a list of cluster accounts](#list-accounts).

## Create an account {#create-account}

{% list tabs %}

- Management console

  To create an account in a cluster:
  1. Go to the folder page and select **{{ mkf-name }}**.
  1. Click the name of the cluster and go to the **Users** tab.
  1. Click **Add**.
  1. Enter a name for the account (username) and password (from 8 to 128 characters).
  1. [Grant permissions](#grant-permission) to the necessary topics.
  1. Click **Add**.


- API

  Use the [create](../api-ref/User/create.md) API method and pass the following in the request:
  - The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
  - Account settings in the `userSpec` parameter:
    - A name for the account in the `name` parameter.
    - A password for the account in the `password` parameter.
    - Topic permissions (one or more `permissions` parameters, one for each topic):
      - The topic name in the `topicName` parameter. To find out the name, [get a list of topics in the cluster](cluster-topics.md#list-topics).
      - Topic permissions in the `role` parameter: `ACCESS_ROLE_PRODUCER` for the producer or `ACCESS_ROLE_CONSUMER` for the consumer.

{% endlist %}

## Update the account password {#update-password}

{% list tabs %}

- Management console

  To change the account password:
  1. Go to the folder page and select **{{ mkf-name }}**.
  1. Click the name of the cluster and go to the **Users** tab.
  1. Click ![image](../../_assets/horizontal-ellipsis.svg) for the desired account and select **Change password**.
  1. Set a new password and click **Edit**.


- API

  Use the [update](../api-ref/User/update.md) API method and pass the following in the request:
  - The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
  - The account name in the `userName` parameter. To find out the name, [get a list of accounts in the cluster](#list-accounts).
  - The name of the `password` setting in the `updateMask` parameter. If this parameter is omitted, the API method resets any account settings that aren't explicitly specified in the request to their default values.
  - The new password for the account in the `password` parameter.

{% endlist %}

## Update account settings {#update-account}

{% list tabs %}

- Management console

  To change the account settings in the cluster:
  1. Go to the folder page and select **{{ mkf-name }}**.
  1. Click the name of the cluster and go to the **Users** tab.
  1. Click ![image](../../_assets/horizontal-ellipsis.svg) for the desired account and select **Configure**.
  1. [Grant](#grant-permission) or [revoke](#revoke-permission) permissions to topics, if necessary.
  1. Click **Save**.


- API

  Use the [update](../api-ref/User/update.md) API method and pass the following in the request:
  - The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
  - The account name in the `userName` parameter. To find out the name, [get a list of accounts in the cluster](#list-accounts).
  - In the `updateMask` parameter, a list of settings to update (in a single line, comma-separated). If this parameter is omitted, the API method resets any account settings that aren't explicitly specified in the request to their default values.
  - A new set of permissions to topics (one or more `permissions` parameters, one for each topic).

{% endlist %}

## Grant account permissions {#grant-permission}

{% include [mkf-deleted-topic-permissions-note](../../_includes/mdb/mkf-deleted-topic-permissions-note.md) %}

{% list tabs %}

- Management console

  When [creating](#create-account) or [updating](#update-account) an account, you can grant permissions to the necessary topics.

  To grant permissions to a topic:

  1. Find the desired topic in the list of topics.

     If the topic isn't in the list, add it:
     1. Click **+ Add topic**. If there is no such button, it means that all existing cluster topics are added to this account.
     1. Select the desired topic from the drop-down list.

  1. Click ![image](../../_assets/plus.svg) in the **Roles** column for the topic and select:
     - `ACCESS_ROLE_CONSUMER`: Consumers who use this account will be granted access to the topic.
     - `ACCESS_ROLE_PRODUCER`: Producers who use this account will be granted access to the topic.

     You can select both roles at the same time. In this case, the account can be used by both producers and consumers.

  1. To grant permissions to other topics, repeat the steps.

  1. (optional) If you granted permissions to a topic by mistake, [revoke them](#revoke-permission).


- API

  Use the [grantPermission](../api-ref/User/grantPermission.md) API method and pass the following in the request:
  - The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
  - The account name in the `userName` parameter. To find out the name, [get a list of accounts in the cluster](#list-accounts).
  - The new permission to the topic in the `permission` parameter.

{% endlist %}

## Revoke account permissions {#revoke-permission}

{% list tabs %}

- Management console

  When [creating](#create-account) or [updating](#update-account) an account, you can revoke topic permissions.

  To revoke topic permissions:
  1. Find the desired topic in the list of topics.
  1. Delete the role that you no longer need by clicking ![image](../../_assets/cross.svg) next to the role name. To revoke all permissions to a topic, delete it from the list: hover over the topic name and click ![image](../../_assets/cross.svg) at the end of the line.


- API

  Use the [revokePermission](../api-ref/User/revokePermission.md) API method and pass the following in the request:
  - The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
  - The account name in the `userName` parameter. To find out the name, [get a list of accounts in the cluster](#list-accounts).
  - The topic permission to be revoked in the `permission` parameter.

{% endlist %}

## Delete an account {#delete-account}

{% list tabs %}

- Management console

  To delete an account:
  1. Go to the folder page and select **{{ mkf-name }}**.
  1. Click the name of the cluster and go to the **Users** tab.
  1. Click ![image](../../_assets/horizontal-ellipsis.svg) for the account and select **Delete**.
  1. Confirm deletion and click **Delete**.


- API

  Use the [delete](../api-ref/User/delete.md) API method and pass the following in the request:
  - The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
  - The name of the account to delete in the `userName` parameter. To find out the name, [get a list of accounts in the cluster](#list-accounts).

{% endlist %}

## Get a list of cluster accounts {#list-accounts}

{% list tabs %}

- Management console

  To get a list of accounts:
  1. Go to the folder page and select **{{ mkf-name }}**.
  1. Click the name of the cluster and go to the **Users** tab.


- API

  Use the [list](../api-ref/User/list.md) API method: pass the ID of the required cluster in the `clusterId` request parameter.

  To find out the cluster ID, [get a list of clusters in the folder](#list-clusters).

{% endlist %}
