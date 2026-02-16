# {{ SD }} version upgrade

You can only upgrade your {{ mmg-name }} cluster to the next sequential version, e.g., from 4.2 to 4.4. Upgrading to subsequent versions must be done incrementally. For example, upgrading {{ SD }} from version 4.2 to 8.0 is performed in the following sequence: 4.2 → 4.4 → 5.0 → 6.0 → 7.0 → 8.0. Before each cluster upgrade stage, you must update the [cluster compatibility version](#compatibility-update).


{% note alert %}

After the upgrade, it is impossible to revert the cluster to a previous version.

{% endnote %}

## Before version upgrade {#before-update}

1. Make sure the upgrade will not disrupt your applications:

1. Review the {{ MG }} release notes to learn how upgrades may affect your applications.
1. Try upgrading a test cluster. You can [deploy it from a backup](cluster-backups.md#restore) of the main cluster.
1. [Back up](cluster-backups.md#create-backup) your main cluster before upgrading.

1. Make sure the [cluster compatibility version](#compatibility-update) matches the current cluster version. If necessary, upgrade the cluster compatibility version.

## Upgrading the cluster version {#start-update}

{% list tabs group=instructions %}

- Management console {#console}

  1. Open the [folder dashboard]({{ link-console-main }}).
  1. [Navigate to](../../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}** service.
  1. Select the cluster you need from the list and click **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.
  1. Select the new version number in the **{{ ui-key.yacloud.mdb.forms.base_field_version }}** field.
  1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

  Once you launch the upgrade, the cluster status will change to **UPDATING**. Wait for the operation to complete and then check the cluster version.

- CLI {#cli}

  1. Retrieve the list of your {{ SD }} clusters using this command:

     ```bash
     {{ yc-mdb-mg }} cluster list
     ```

  1. Get the target cluster details and check the `config.version` setting for its {{ SD }} version:

     ```bash
     {{ yc-mdb-mg }} cluster get <cluster_name_or_ID>
     ```

  1. Start the {{ SD }} upgrade:

     ```bash
     {{ yc-mdb-mg }} cluster update <cluster_name_or_ID> \
        --mongodb-version=<new_version_number>
     ```

     Once you launch the upgrade, the cluster status will change to **UPDATING**. Wait for the operation to complete and then check the cluster version.

  1. After the upgrade, all non-backward-compatible {{ SD }} features will be disabled. To remove this limitation, run the following command:

     ```bash
     {{ yc-mdb-mg }} cluster update <cluster_name_or_ID> \
        --feature-compatibility-version=<new_version_number>
     ```


- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file describing your infrastructure.
  
       To learn how to create this file, see [Creating a cluster](cluster-create.md).
  
    1. Add or update the `version` field in the {{ mmg-name }} cluster description:
  
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
  
   For more information, see [this {{ TF }} provider guide]({{ tf-provider-resources-link }}/mdb_mongodb_cluster).

   {% include [Terraform timeouts](../../_includes/mdb/mmg/terraform/timeouts.md) %}

- REST API {#api}

   1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

   1. Call the [Cluster.Update](../api-ref/Cluster/update.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

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

         Here, we provide only one setting.

      * `configSpec.version`: New {{ SD }} version.

      You can get the cluster ID from the [list of clusters in your folder](cluster-list.md#list-clusters).

   1. Check the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Call the [ClusterService.Update](../api-ref/grpc/Cluster/update.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

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

        * `update_mask`: List of settings you want to update as an array of strings (`paths[]`).

          Here, we provide only one setting.

        * `version`: New {{ SD }} version.

        You can get the cluster ID from the [list of clusters in your folder](cluster-list.md#list-clusters).

    1. Check the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

{% note info %}

After the upgrade, all non-backward-compatible {{ SD }} features will be disabled. To remove this limitation, [update the cluster compatibility version](#compatibility-update).

{% endnote %}

## Updating the cluster compatibility version {#compatibility-update}

Updating the cluster compatibility version is necessary when you need to:
* Upgrade your cluster to a new version (when the compatibility version does not match the current cluster version).
* Enable the new {{ SD }} features after the cluster upgrade.

To learn more about backward compatibility, refer to the [{{ MG }} documentation](https://docs.mongodb.com/manual/reference/command/setFeatureCompatibilityVersion/).

{% note alert %}

Updating the cluster compatibility version is irreversible.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. Open the [folder dashboard]({{ link-console-main }}).
  1. [Navigate to](../../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}** service.
  1. Select the cluster you need from the list and click **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.
  1. In the **{{ ui-key.yacloud.mdb.forms.base_field_fcv }}** field, select the required version number.
  1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

  1. Retrieve the list of your {{ SD }} clusters using this command:

     ```bash
     {{ yc-mdb-mg }} cluster list
     ```

  1. Get the target cluster details and check the `config.feature_compatibility_version` setting for its {{ SD }} version:

     ```bash
     {{ yc-mdb-mg }} cluster get <cluster_name_or_ID>
     ```

  1. Run the `cluster update` command, providing the new compatibility version:

     ```bash
     {{ yc-mdb-mg }} cluster update <cluster_name_or_ID> \
        --feature-compatibility-version=<Yandex_StoreDoc_compatibility_version>
     ```

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file describing your infrastructure.
  
       To learn how to create this file, see [Creating a cluster](cluster-create.md).
  
    1. Add or update the `feature_compatibility_version` field in the {{ mmg-name }} cluster description:
  
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
  
   For more information, see [this {{ TF }} provider guide]({{ tf-provider-resources-link }}/mdb_mongodb_cluster).

   {% include [Terraform timeouts](../../_includes/mdb/mmg/terraform/timeouts.md) %}

- REST API {#api}

   1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

   1. Call the [Cluster.Update](../api-ref/Cluster/update.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

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

         Here, we provide only one setting.

      * `configSpec.featureCompatibilityVersion`: New {{ SD }} compatibility version.

      You can get the cluster ID from the [list of clusters in your folder](cluster-list.md#list-clusters).

   1. Check the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Call the [ClusterService.Update](../api-ref/grpc/Cluster/update.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

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

        * `update_mask`: List of settings you want to update as an array of strings (`paths[]`).

          Here, we provide only one setting.

        * `feature_compatibility_version`: New {{ SD }} compatibility version.

        You can get the cluster ID from the [list of clusters in your folder](cluster-list.md#list-clusters).

    1. Check the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Examples {#examples}

Suppose you need to upgrade a cluster from version 5.0 to 6.0.

{% list tabs group=instructions %}

- CLI {#cli}

   1. To get the cluster ID, retrieve a list of all clusters in your folder:

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

   1. To enable all version 6.0 capabilities in the `c9qutgkd4b2o********` cluster, run this command:

      ```bash
      {{ yc-mdb-mg }} cluster update c9qutgkd4b2o******** \
          --feature-compatibility-version=6.0
      ```

{% endlist %}
