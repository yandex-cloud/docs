# Upgrading {{ SD }} version

You can only upgrade your {{ mmg-name }} cluster to a version that immediately follows the current one, such as 4.2 to 4.4. Upgrading to later versions is performed in stages. For example, for {{ SD }}, the upgrade sequence from version 4.2 to 8.0 is: 4.2 → 4.4 → 5.0 → 6.0 → 7.0 → 8.0. Before each cluster upgrade step, you must update the [cluster compatibility version](#compatibility-update).


{% note alert %}

After upgrading, you cannot roll your cluster back to the previous version.

{% endnote %}

## Before a version upgrade {#before-update}

1. Make sure the upgrade will not disrupt your applications:

1. See the {{ MG }} release notes to learn how upgrades may affect your applications.
1. Try upgrading a test cluster. You can [deploy it from a backup](cluster-backups.md#restore) of the main cluster.
1. [Backup](cluster-backups.md#create-backup) the main cluster immediately before upgrading.

1. Make sure the [cluster compatibility version](#compatibility-update) matches the current cluster version. If required, upgrade the cluster compatibility version.

## Upgrading the cluster version {#start-update}

{% list tabs group=instructions %}

- Management console {#console}

  1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **Yandex StoreDoc**.
  1. Select the cluster from the list and click **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.
  1. In the **{{ ui-key.yacloud.mdb.forms.base_field_version }}** field, select the new version number.
  1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

  As soon as you run the upgrade, the cluster status will change to **UPDATING**. Wait for the operation to complete and then check the cluster version.

- CLI {#cli}

  1. Get a list of your {{ SD }} clusters using this command:

     ```bash
     {{ yc-mdb-mg }} cluster list
     ```

  1. Get the target cluster details and check its {{ SD }} version in the `config.version` setting:

     ```bash
     {{ yc-mdb-mg }} cluster get <cluster_name_or_ID>
     ```

  1. Run the {{ SD }} upgrade:

     ```bash
     {{ yc-mdb-mg }} cluster update <cluster_name_or_ID> \
        --mongodb-version=<new_version_number>
     ```

     Once you run the upgrade, the cluster status will change to **UPDATING**. Wait for the operation to complete and then check the cluster version.

  1. After the upgrade, all {{ SD }} features that are not backward-compatible with the previous version will be disabled. To remove this restriction, run this command:

     ```bash
     {{ yc-mdb-mg }} cluster update <cluster_name_or_ID> \
        --feature-compatibility-version=<new_version_number>
     ```


- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file describing your infrastructure.
  
       For more information about creating this file, see [this guide](cluster-create.md).
  
    1. Add the `version` field to the {{ mmg-name }} cluster description or edit its value if it is already there:
  
       ```hcl
       resource "yandex_mdb_mongodb_cluster" "<cluster_name>" {
         ...
         cluster_config {
           version = "<Yandex_StoreDoc_version>"
         }
       }
       ```

    1. Validate your configuration.
  
         {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}
  
    1. Confirm resource changes.
  
         {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}
  
   For more information, see this [{{ TF }} provider guide]({{ tf-provider-resources-link }}/mdb_mongodb_cluster).

   {% include [Terraform timeouts](../../_includes/mdb/mmg/terraform/timeouts.md) %}

- REST API {#api}

   1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

   1. Use the [Cluster.Update](../api-ref/Cluster/update.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

      {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

      ```bash
      curl \
         --request PATCH \
         --header "Authorization: Bearer $IAM_TOKEN" \
         --header "Content-Type: application/json" \
         --url 'https://{{ api-host-mdb }}/managed-mongodb/v1/clusters/<cluster_ID>' \
         --data '{
                  "updateMask": "configSpec.version",
                  "configSpec": {
                    "version": "<Yandex_StoreDoc_new_version>"
                  }
                }'
      ```

      Where:

      * `updateMask`: Comma-separated list of settings you want to update.

         In this case, one parameter is provided.

      * `configSpec.version`: New {{ SD }} version.

      You can get the cluster ID from the [folder’s cluster list](cluster-list.md#list-clusters).

   1. Check the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Use the [ClusterService.Update](../api-ref/grpc/Cluster/update.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

        {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/mongodb/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<cluster_ID>",
                  "update_mask": {
                    "paths": [ 
                      "config_spec.version"
                    ]
                  },  
                  "config_spec": {
                    "version": "<Yandex_StoreDoc_version>"
                  }
               }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.mongodb.v1.ClusterService.Update
        ```

        Where:

        * `update_mask`: List of settings you want to update as an array of `paths[]` strings.

          In this case, one parameter is provided.

        * `version`: New {{ SD }} version.

        You can get the cluster ID from the [folder’s cluster list](cluster-list.md#list-clusters).

    1. Check the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

{% note info %}

After the upgrade, all {{ SD }} features that are not backward-compatible with the previous version will be disabled. To remove this limitation, [upgrade the cluster compatibility version](#compatibility-update).

{% endnote %}

## Upgrading the compatibility version {#compatibility-update}

Upgrading the cluster compatibility version is required if you need to:
* Upgrade your cluster to a new version, but the compatibility version does not match the current cluster version.
* Make new {{ SD }} features available after a cluster upgrade.

Learn more about backward compatibility in the [{{ MG }} guide](https://docs.mongodb.com/manual/reference/command/setFeatureCompatibilityVersion/).

{% note alert %}

Upgrading the cluster compatibility version is irreversible.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ SD }}**.
  1. Select the cluster from the list and click **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.
  1. In the **{{ ui-key.yacloud.mdb.forms.base_field_fcv }}** field, select the required version number.
  1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

  1. Get a list of your {{ SD }} clusters using this command:

     ```bash
     {{ yc-mdb-mg }} cluster list
     ```

  1. Get the target cluster details and check its {{ SD }} version in the `config.feature_compatibility_version` setting:

     ```bash
     {{ yc-mdb-mg }} cluster get <cluster_name_or_ID>
     ```

  1. Run the cluster update command by specifying the new compatibility version:

     ```bash
     {{ yc-mdb-mg }} cluster update <cluster_name_or_ID> \
        --feature-compatibility-version=<Yandex_StoreDoc_compatibility_version>
     ```

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file describing your infrastructure.
  
       For more information about creating this file, see [this guide](cluster-create.md).
  
    1. Add the `feature_compatibility_version` field to the {{ mmg-name }} cluster description or edit its value if it is already there:
  
       ```hcl
       resource "yandex_mdb_mongodb_cluster" "<cluster_name>" {
         ...
         cluster_config {
           feature_compatibility_version = "<Yandex_StoreDoc_compatibility_version>"
         }
       }
       ```

    1. Validate your configuration.
  
         {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}
  
    1. Confirm resource changes.
  
         {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}
  
   For more information, see this [{{ TF }} provider guide]({{ tf-provider-resources-link }}/mdb_mongodb_cluster).

   {% include [Terraform timeouts](../../_includes/mdb/mmg/terraform/timeouts.md) %}

- REST API {#api}

   1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

   1. Use the [Cluster.Update](../api-ref/Cluster/update.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

      {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

      ```bash
      curl \
         --request PATCH \
         --header "Authorization: Bearer $IAM_TOKEN" \
         --header "Content-Type: application/json" \
         --url 'https://{{ api-host-mdb }}/managed-mongodb/v1/clusters/<cluster_ID>' \
         --data '{
                  "updateMask": "configSpec.featureCompatibilityVersion",
                  "configSpec": {
                    "featureCompatibilityVersion": "<Yandex_StoreDoc_compatibility_version>"
                  }
                }'
      ```

      Where:

      * `updateMask`: Comma-separated list of settings you want to update.

         In this case, one parameter is provided.

      * `configSpec.featureCompatibilityVersion`: New {{ SD }} compatibility version.

      You can get the cluster ID from the [folder’s cluster list](cluster-list.md#list-clusters).

   1. Check the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Use the [ClusterService.Update](../api-ref/grpc/Cluster/update.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

        {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/mongodb/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<cluster_ID>",
                  "update_mask": {
                    "paths": [ 
                      "config_spec.feature_compatibility_version"
                    ]
                  },  
                  "config_spec": {
                    "feature_compatibility_version": "<Yandex_StoreDoc_compatibility_version>"
                  }
               }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.mongodb.v1.ClusterService.Update
        ```

        Where:

        * `update_mask`: List of settings you want to update as an array of `paths[]` strings.

          In this case, one parameter is provided.

        * `feature_compatibility_version`: New {{ SD }} compatibility version.

        You can get the cluster ID from the [folder’s cluster list](cluster-list.md#list-clusters).

    1. Check the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Examples {#examples}

Let's assume that you need to upgrade your cluster from version 5.0 to version 6.0.

{% list tabs group=instructions %}

- CLI {#cli}

   1. To find out the cluster ID, get a list of all clusters in the folder:

      ```bash
      {{ yc-mdb-mg }} cluster list
      ```

      Result:

      ```text
      +----------------------+---------------+---------------------+--------+---------+
      |          ID          |     NAME      |     CREATED AT      | HEALTH | STATUS  |
      +----------------------+---------------+---------------------+--------+---------+
      | c9q8p8j2gaih******** |   storedoc406  | 2019-04-23 12:44:17 | ALIVE  | RUNNING |
      +----------------------+---------------+---------------------+--------+---------+
      ```

   1. To get `c9qut3k64b2o********` cluster details, run the following command:

      ```bash
      {{ yc-mdb-mg }} cluster get c9qut3k64b2o********
      ```

      Result:

      ```text
      id: c9qut3k64b2o********
      folder_id: b1g0itj57rbj********
      created_at: "2019-07-16T09:43:50.393231Z"
      name: storedoc406
      environment: PRODUCTION
      monitoring:
      - name: Console
        description: Console charts
        link: {{ link-console-main }}/folders/b1g0itj57rbj********/managed-mongodb/cluster/c9qut3k64b2o********?section=monitoring
      config:
        version: "5.0"
        feature_compatibility_version: "5.0"
        ...
      ```

   1. To upgrade the `c9qutgkd4b2o********` cluster to version 6.0, run this command:

      ```bash
      {{ yc-mdb-mg }} cluster update c9qutgkd4b2o******** \
          --mongodb-version=6.0
      ```

   1. To enable all 6.0 features in the `c9qutgkd4b2o********` cluster, run this command:

      ```bash
      {{ yc-mdb-mg }} cluster update c9qutgkd4b2o******** \
          --feature-compatibility-version=6.0
      ```

{% endlist %}
