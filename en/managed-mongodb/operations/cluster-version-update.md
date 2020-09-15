# Version update {{ MG }}

You can update {{ mmg-name }} clusters to versions 4.0 and 4.2.

## Before updating {#before-update}

Prior to updating the cluster, make sure this doesn't affect your apps:

1. View the revision history for versions [4.0](https://docs.mongodb.com/v4.0/release-notes/4.0/) and [4.2](https://docs.mongodb.com/v4.0/release-notes/) {{ MG }} and check if any of the revisions may affect how the app works.
1. Try updating a test cluster (you can try deploying it from a backup of the main cluster).
1. [Make a backup ](cluster-backups.md#create-backup) of the main cluster before updating.

## Updating a cluster {#start-update}

To update a {{ mmg-name }} cluster:

{% list tabs %}

- Management console
  1. Open the **{{ mmg-name }}** page in the folder with the cluster to be updated.
  1. Select the cluster from the list and click **Edit cluster**.
  1. In the **Version** field, click *4.0* or *4.2*.
  1. Click **Save changes**.

  When the update starts, the cluster status switches to `UPDATING`. Wait for the operation to complete and then check the cluster version.

- CLI

  1. Get a list of your {{ MG }} clusters using the command:

     ```
     yc managed-mongodb cluster list
     ```

  1. Get information about a cluster and check the {{ MG }} version in the `config.version` parameter:

     ```
     yc managed-mongodb cluster get <cluster ID>
     ```

  1. Start the {{ MG }} update:

     ```
     yc managed-mongodb cluster update <cluster ID> --mongodb-version=<new version ID>
     ```

     When the update starts, the cluster status switches to `UPDATING`. Wait for the operation to complete and then check the cluster version.

  1. After the update, all the MongoDB features that are not backward-compatible with the previous version are disabled. To remove this restriction, run the command:

     ```
     yc managed-mongodb cluster update <cluster ID> --feature-compatibility-version=<new version ID>
     ```

     Learn more about backward compatibility in the [MongoDB documentation](https://docs.mongodb.com/manual/reference/command/setFeatureCompatibilityVersion/).

- API

  You can update the {{ MG }} version for a cluster using the [update](../api-ref/Cluster/update.md) API method: pass the appropriate value in the `configSpec.poolerConfig.poolingMode` request parameter.

  After the update, all the MongoDB features that are not backward-compatible with the previous version are disabled. To remove this restriction, use the API [update](../api-ref/Cluster/update.md) method: pass the new version number in the request using the `configSpec.featureCompatibilityVersion` property.

  Learn more about backward compatibility in the [MongoDB documentation](https://docs.mongodb.com/manual/reference/command/setFeatureCompatibilityVersion/).

{% endlist %}

## Examples {#examples}

Let's say you need to update the cluster from version 3.6 to version 4.0.

{% list tabs %}

- CLI

   1. To get a list of clusters and find out the cluster ID, run the command:

      ```
      $ yc managed-mongodb cluster list
      +----------------------+---------------+---------------------+--------+---------+
      |          ID          |     NAME      |     CREATED AT      | HEALTH | STATUS  |
      +----------------------+---------------+---------------------+--------+---------+
      | c9q8p8j2gaih8iti42mh |   mongodb406  | 2019-04-23 12:44:17 | ALIVE  | RUNNING |
      +----------------------+---------------+---------------------+--------+---------+
      ```

   1. To get information about the `c9qut3k64b2o9umqogr7` cluster, run the command:

      ```
      $ yc managed-mongodb cluster get c9qut3k64b2o9umqogr7
        id: c9qut3k64b2o9umqogr7
        folder_id: b1g0itj57rbjk9thrinv
        created_at: "2019-07-16T09:43:50.393231Z"
        name: mongodb406
        environment: PRODUCTION
        monitoring:
        - name: Console
          description: Console charts
          link: https://console.cloud.yandex.com/folders/b1g0itj57rbjk9thrinv/managed-mongodb/cluster/c9qut3k64b2o9umqogr7?section=monitoring
        config:
          version: "3.6"
          feature_compatibility_version: "3.6"
          ...
      ```

   1. To update the `c9qutgkd4b2o9umqog97` cluster to version 4.0, run the command:

      ```
      $ yc managed-mongodb cluster update c9qutgkd4b2o9umqog97 --mongodb-version=4.0
      ```

   1. To enable all 4.0 features in the `c9qutgkd4b2o9umqog97` cluster, run the command:

      ```
      $ yc managed-mongodb cluster update c9qutgkd4b2o9umqog97 --feature-compatibility-version=4.0
      ```

{% endlist %}

