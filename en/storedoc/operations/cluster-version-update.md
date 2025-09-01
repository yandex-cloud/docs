# {{ SD }} version upgrade

You can only upgrade your {{ mmg-name }} cluster to a version that immediately follows the current one, such as 4.2 to 4.4. Upgrades to higher versions are performed in steps. For example, for {{ SD }}, the upgrade sequence from version 4.2 to 6.0 is: 4.2 → 4.4 → 5.0 → 6.0.


{% note alert %}

After upgrading, you cannot roll a cluster back to the previous version.

{% endnote %}

## Before a version upgrade {#before-update}

Make sure this does not affect your applications:

1. See {{ MG }} [changelog](https://docs.mongodb.com/manual/release-notes/) for how upgrades may affect your applications.
1. Try a version upgrade on a test cluster. You can [deploy it from a backup](cluster-backups.md#restore) of the main cluster.
1. [Create a backup](cluster-backups.md#create-backup) of the main cluster directly before the version upgrade.

## Upgrading a cluster {#start-update}

{% list tabs group=instructions %}

- Management console {#console}

  1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **Yandex StoreDoc**.
  1. Select the cluster from the list and click **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.
  1. In the **{{ ui-key.yacloud.mdb.forms.base_field_version }}** field, select a new version number.
  1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

  As soon as you run the upgrade, the cluster status will change to **UPDATING**. Wait for the operation to complete and then check the cluster version.

- CLI {#cli}

  1. Get a list of your {{ SD }} clusters using this command:

     ```bash
     {{ yc-mdb-mg }} cluster list
     ```

  1. Get information about the cluster you need and check the {{ SD }} version in the `config.version` parameter:

     ```bash
     {{ yc-mdb-mg }} cluster get <cluster_name_or_ID>
     ```

  1. Run the {{ SD }} upgrade:

     ```bash
     {{ yc-mdb-mg }} cluster update <cluster_name_or_ID> \
        --mongodb-version=<new_version_number>
     ```

     As soon as you run the upgrade, the cluster status will change to **UPDATING**. Wait for the operation to complete and then check the cluster version.

  1. After the upgrade, all {{ SD }} features that are not backward-compatible with the previous version will be disabled. To remove this restriction, run this command:

     ```bash
     {{ yc-mdb-mg }} cluster update <cluster_name_or_ID> \
        --feature-compatibility-version=<new_version_number>
     ```

     Learn more about backward compatibility in the [{{ MG }} documentation](https://docs.mongodb.com/manual/reference/command/setFeatureCompatibilityVersion/).

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file that defines your infrastructure.
  
       For more information about creating this file, see [Creating clusters](cluster-create.md).
  
    1. To the {{ mmg-name }} cluster description, add the `version` field or change its value if it is already there:
  
       ```hcl
       resource "yandex_mdb_mongodb_cluster" "<cluster_name>" {
         ...
         cluster_config {
           version = "<Yandex_StoreDoc_version>"
         }
       }
       ```

    1. Make sure the settings are correct.
  
         {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}
  
    1. Confirm updating the resources.
  
         {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}
  
   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_mongodb_cluster).

   {% include [Terraform timeouts](../../_includes/mdb/mmg/terraform/timeouts.md) %}

- REST API {#api}

   1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

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
                    "version": "<new_Yandex_StoreDoc_version>"
                  }
                }'
      ```

      Where:

      * `updateMask`: List of parameters to update as a single string, separated by commas.

         In this case, one parameter is provided.

      * `configSpec.version`: New {{ SD }} version.

      You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

   1. View the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure the request was successful.

   1. After the upgrade, all {{ SD }} features that are not backward-compatible with the previous version will be disabled. To remove this restriction, send one more request and provide the new {{ SD }} version number in the `configSpec.featureCompatibilityVersion` property.

      ```bash
      curl \
         --request PATCH \
         --header "Authorization: Bearer $IAM_TOKEN" \
         --header "Content-Type: application/json" \
         --url 'https://{{ api-host-mdb }}/managed-mongodb/v1/clusters/<cluster_ID>' \
         --data '{
                  "updateMask": "configSpec.featureCompatibilityVersion",
                  "configSpec": {
                    "featureCompatibilityVersion": "<new_Yandex_StoreDoc_version>"
                  }
                }'
      ```

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

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

        * `update_mask`: List of parameters to update as an array of `paths[]` strings.

          In this case, one parameter is provided.

        * `version`: New {{ SD }} version.

        You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure the request was successful.

    1. After the upgrade, all {{ SD }} features that are not backward-compatible with the previous version will be disabled. To remove this restriction, send one more request and provide the new {{ SD }} version number in the `config_spec.feature_compatibility_version` property.

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
                    "feature_compatibility_version": "<new_Yandex_StoreDoc_version>"
                  }
               }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.mongodb.v1.ClusterService.Update
        ```

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
      | c9q8p8j2gaih******** |   mongodb406  | 2019-04-23 12:44:17 | ALIVE  | RUNNING |
      +----------------------+---------------+---------------------+--------+---------+
      ```

   1. To get information about the `c9qut3k64b2o********` cluster, run the following command:

      ```bash
      {{ yc-mdb-mg }} cluster get c9qut3k64b2o********
      ```

      Result:

      ```text
      id: c9qut3k64b2o********
      folder_id: b1g0itj57rbj********
      created_at: "2019-07-16T09:43:50.393231Z"
      name: mongodb406
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
