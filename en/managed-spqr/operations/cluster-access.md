---
title: Managing access to a {{ mspqr-full-name }} cluster
description: Follow this guide to configure {{ mspqr-name }} cluster access permissions.
---

# Managing access to a {{ mspqr-name }} cluster

You can assign a user or service account a [role](../security.md) that grants access to a specific [cluster](../concepts/index.md).

This allows you to issue granular roles to various users and service accounts for access to individual clusters.


{% note warning %}

Take note that apart from the role for access to the cluster, the user also needs the minimum role to view the folder's resources, e.g., [managed-spqr.viewer](../security.md#managed-spqr-viewer) (to view the info about all the folder's clusters) or the primitive [viewer](../../iam/security/index.md#viewer) (to view all the folder's resources).

For example, you can issue the [managed-spqr.viewer](../security.md#managed-spqr-viewer) role for a folder and the [managed-spqr.editor](../security.md#managed-spqr-editor) role for a specific cluster. This will enable the user to view the info about all the folder's clusters while using only one particular cluster.

To manage user view permissions for cluster lists, we recommend using different folders in your cloud.

{% endnote %}


## Getting a list of roles assigned for a cluster {#list-access-bindings}

{% list tabs group=instructions %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Cluster.ListAccessBindings](../api-ref/Cluster/listAccessBindings.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

      ```bash
      curl \
        --request GET \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://{{ api-host-mdb }}/managed-spqr/v1/clusters/<cluster_ID>:listAccessBindings'
      ```

  1. View the [server response](../api-ref/Cluster/listAccessBindings.md#yandex.cloud.access.ListAccessBindingsResponse) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Call the [ClusterService.ListAccessBindings](../api-ref/grpc/Cluster/listAccessBindings.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

      ```bash
      grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/mdb/spqr/v1/cluster_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "resource_id": "<cluster_ID>"
            }' \
        {{ api-host-mdb }}:{{ port-https }} \
        yandex.cloud.mdb.spqr.v1.ClusterService.ListAccessBindings
      ```

  1. Check the [server response](../api-ref/grpc/Cluster/listAccessBindings.md#yandex.cloud.access.ListAccessBindingsResponse) to make sure your request was successful.

{% endlist %}

## Assigning a role {#add-access-binding}

{% list tabs group=instructions %}

- {{ TF }} {#tf}

  1. Open the current configuration file with the {{ mspqr-name }} cluster description.

      For more on how to create this file, see [{#T}](cluster-create.md).

  1. Add a resource description:

      ```hcl
      resource "yandex_mdb_sharded_postgresql_cluster_iam_binding" "<local_resource_name>" {
        cluster_id = "<cluster_ID>"
        role       = "<role>"
        members    = [
          "<subject_type>:<subject_ID>"
        ]
      }
      ```

            
      Where:

      * `cluster_id`: Cluster ID.
      * `role`: [Role](../security.md#roles-list) being assigned, e.g., `managed-spqr.editor`.
      * `members`: List of [subjects](../../iam/concepts/access-control/index.md#subject) the role is assigned to in `<subject_type>:<subject_ID>` format.

          Here is an example:

          * `serviceAccount:aje6p030123a********`
          * `userAccount:ajerq94vab34********`
          * `system:allAuthenticatedUsers`

          {% include [access-control-subject](../../_includes/mdb/access-control-subject.md) %}


  1. Make sure the configuration files are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      For more information, see [this {{ TF }} provider guide]({{ tf-provider-resources-link }}/mdb_sharded_postgresql_cluster_iam_binding).

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Cluster.UpdateAccessBindings](../api-ref/Cluster/updateAccessBindings.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

      ```bash
      curl \
        --request PATCH \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://{{ api-host-mdb }}/managed-spqr/v1/clusters/<cluster_ID>:updateAccessBindings' \
        --data '{
                  "access_binding_deltas": [
                    {
                      "action": "ADD",
                      "access_binding": {
                        "role_id": "<role>",
                        "subject": {
                          "id": "<subject_ID>",
                          "type": "<subject_type>"
                        }
                      }
                    }
                  ]
                }'
      ```

      
      Where:

      * `access_binding_deltas.roleId`: [Role](../security.md#roles-list) being assigned, e.g., `managed-spqr.editor`.
      * `access_binding_deltas.subject.id`: ID of the [subject](../../iam/concepts/access-control/index.md#subject) the role is assigned to.
      * `access_binding_deltas.subject.type`: Type of subject the role is assigned to.

          {% include [access-control-subject](../../_includes/mdb/access-control-subject.md) %}



  1. Check the [server response](../api-ref/Cluster/updateAccessBindings.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Call the [ClusterService.UpdateAccessBindings](../api-ref/grpc/Cluster/updateAccessBindings.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

      ```bash
      grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/mdb/spqr/v1/cluster_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "resource_id": "<cluster_ID>",
              "access_binding_deltas": [
                {
                  "action": "ADD",
                  "access_binding": {
                    "role_id": "<role>",
                    "subject": {
                      "id": "<subject_ID>",
                      "type": "<subject_type>"
                    }
                  }
                }
              ]
            }' \
        {{ api-host-mdb }}:{{ port-https }} \
        yandex.cloud.mdb.spqr.v1.ClusterService.UpdateAccessBindings
      ```
      
      Where:

      * `resource_id`: Cluster ID.
      * `access_binding_deltas.roleId`: [Role](../security.md#roles-list) being assigned, e.g., `managed-spqr.editor`.
      * `access_binding_deltas.subject.id`: ID of the [subject](../../iam/concepts/access-control/index.md#subject) the role is assigned to.
      * `access_binding_deltas.subject.type`: Type of subject the role is assigned to.

          {% include [access-control-subject](../../_includes/mdb/access-control-subject.md) %}
      


  1. Check the [server response](../api-ref/grpc/Cluster/updateAccessBindings.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Assigning multiple roles {#set-access-bindings}

{% list tabs group=instructions %}

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file describing your infrastructure.

      For more on how to create this file, see [Creating a cluster](cluster-create.md).

  1. Add resource descriptions:

      ```hcl
      resource "yandex_mdb_sharded_postgresql_cluster_iam_binding" "<resource_1_local_name>" {
        cluster_id = "<cluster_ID>"
        role       = "<role_1>"
        members    = [
          "<subject_type>:<subject_1_ID>",
          "<subject_type>:<subject_2_ID>"
        ]
      }

      resource "yandex_mdb_sharded_postgresql_cluster_iam_binding" "<resource_2_local_name>" {
        cluster_id = "<cluster_ID>"
        role       = "<role_2>"
        members    = [
          "<subject_type>:<subject_3_ID>"
        ]
      }
      ```

      
      Where:

      * `cluster_id`: Cluster ID.
      * `role`: [Role](../security.md#roles-list) being assigned, e.g., `managed-spqr.editor`.
      * `members`: List of [subjects](../../iam/concepts/access-control/index.md#subject) the role is assigned to in `<subject_type>:<subject_ID>` format.

          Here is an example:

          * `serviceAccount:aje6p030123a********`
          * `userAccount:ajerq94vab34********`
          * `system:allAuthenticatedUsers`

          {% include [access-control-subject](../../_includes/mdb/access-control-subject.md) %}


  1. Make sure the configuration files are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      For more information, see [this {{ TF }} provider guide]({{ tf-provider-resources-link }}/mdb_sharded_postgresql_cluster_iam_binding).

- REST API {#api}

  {% note alert %}

  The `setAccessBindings` method overwrites access permissions for the resource. All roles previously assigned for this resource will be deleted.

  {% endnote %}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Cluster.SetAccessBindings](../api-ref/Cluster/setAccessBindings.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

      ```bash
      curl \
        --request POST \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://{{ api-host-mdb }}/managed-spqr/v1/clusters/<cluster_ID>:setAccessBindings' \
        --data '{
                  "accessBindings": [
                    {
                      "roleId": "<role>",
                      "subject": {
                        "id": "<subject_1_ID>",
                        "type": "<subject_type>"
                      }
                    },
                    {
                      "roleId": "<role>",
                      "subject": {
                        "id": "<subject_2_ID>",
                        "type": "<subject_type>"
                      }
                    },
                    ...
                    {
                      "roleId": "<role>",
                      "subject": {
                        "id": "<subject_N_ID>",
                        "type": "<subject_type>"
                      }
                    }
                  ]
                }'
      ```

      
      Where:

      * `accessBindings.roleId`: [Role](../security.md#roles-list) being assigned, e.g., `managed-spqr.editor`.
      * `accessBindings.subject.id`: ID of the [subject](../../iam/concepts/access-control/index.md#subject) the role is assigned to.
      * `accessBindings.subject.type`: Type of subject the role is assigned to.

          {% include [access-control-subject](../../_includes/mdb/access-control-subject.md) %}



  1. Check the [server response](../api-ref/Cluster/setAccessBindings.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  {% note alert %}

  The `ClusterService.SetAccessBindings` method completely overwrites access permissions for the resource. All roles previously assigned for this resource will be deleted.

  {% endnote %}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Call the [ClusterService.SetAccessBindings](../api-ref/grpc/Cluster/setAccessBindings.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

      ```bash
      grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/mdb/spqr/v1/cluster_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "resource_id": "<cluster_ID>",
              "accessBindings": [
                {
                  "roleId": "<role>",
                  "subject": {
                    "id": "<subject_1_ID>",
                    "type": "<subject_type>"
                  }
                },
                {
                  "roleId": "<role>",
                  "subject": {
                    "id": "<subject_2_ID>",
                    "type": "<subject_type>"
                  }
                },
                ...
                {
                  "roleId": "<role>",
                  "subject": {
                    "id": "<subject_N_ID>",
                    "type": "<subject_type>"
                  }
                }
              ]
            }' \
        {{ api-host-mdb }}:{{ port-https }} \
        yandex.cloud.mdb.spqr.v1.ClusterService.SetAccessBindings
      ```

      
      Where:

      * `resource_id`: Cluster ID.
      * `accessBindings.roleId`: [Role](../security.md#roles-list) being assigned, e.g., `managed-spqr.editor`.
      * `accessBindings.subject.id`: ID of the [subject](../../iam/concepts/access-control/index.md#subject) the role is assigned to.
      * `accessBindings.subject.type`: Type of subject the role is assigned to.

          {% include [access-control-subject](../../_includes/mdb/access-control-subject.md) %}



  1. Check the [server response](../api-ref/grpc/Cluster/setAccessBindings.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Revoking a role {#remove-access-binding}

{% list tabs group=instructions %}

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file describing your infrastructure.

      For more on how to create this file, see [Creating a cluster](cluster-create.md).

  1. Find the description of the resource with the role you want to revoke and delete this description:

      ```hcl
      resource "yandex_mdb_sharded_postgresql_cluster_iam_binding" "<local_resource_name>" {
        cluster_id = "<cluster_ID>"
        role       = "<role>"
        members    = [
          "<subject_type>:<subject_ID>"
        ]
      }
      ```

  1. Make sure the configuration files are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      For more information, see [this {{ TF }} provider guide]({{ tf-provider-resources-link }}/mdb_sharded_postgresql_cluster_iam_binding).

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Cluster.UpdateAccessBindings](../api-ref/Cluster/updateAccessBindings.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

      ```bash
      curl \
        --request PATCH \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://{{ api-host-mdb }}/managed-spqr/v1/clusters/<cluster_ID>:updateAccessBindings' \
        --data '{
                  "access_binding_deltas": [
                    {
                      "action": "REMOVE",
                      "access_binding": {
                        "role_id": "<role>",
                        "subject": {
                          "id": "<subject_ID>",
                          "type": "<subject_type>"
                        }
                      }
                    }
                  ]
                }'
      ```

      
      Where:

      * `access_binding_deltas.roleId`: [Role](../security.md#roles-list) being assigned, e.g., `managed-spqr.editor`.
      * `access_binding_deltas.subject.id`: ID of the [subject](../../iam/concepts/access-control/index.md#subject) the role is assigned to.
      * `access_binding_deltas.subject.type`: Type of subject the role is assigned to.

          {% include [access-control-subject](../../_includes/mdb/access-control-subject.md) %}


  1. Check the [server response](../api-ref/Cluster/updateAccessBindings.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Call the [ClusterService.UpdateAccessBindings](../api-ref/grpc/Cluster/updateAccessBindings.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

      ```bash
      grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/mdb/spqr/v1/cluster_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "resource_id": "<cluster_ID>",
              "access_binding_deltas": [
                {
                  "action": "REMOVE",
                  "access_binding": {
                    "role_id": "<role>",
                    "subject": {
                      "id": "<subject_ID>",
                      "type": "<subject_type>"
                    }
                  }
                }
              ]
            }' \
        {{ api-host-mdb }}:{{ port-https }} \
        yandex.cloud.mdb.spqr.v1.ClusterService.UpdateAccessBindings
      ```

      
      Where:

      * `resource_id`: Cluster ID.
      * `access_binding_deltas.roleId`: [Role](../security.md#roles-list) being assigned, e.g., `managed-spqr.editor`.
      * `access_binding_deltas.subject.id`: ID of the [subject](../../iam/concepts/access-control/index.md#subject) the role is assigned to.
      * `access_binding_deltas.subject.type`: Type of subject the role is assigned to.

          {% include [access-control-subject](../../_includes/mdb/access-control-subject.md) %}


  1. Check the [server response](../api-ref/grpc/Cluster/updateAccessBindings.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Examples {#examples}

### Granting cluster management access to a service account {#sa-cluster-control}

For a service account to be able to view the info of all {{ mspqr-name }} clusters in the folder but modify the resources in one particular cluster alone, give it the `managed-spqr.viewer` role for the folder and the `managed-spqr.editor` role for that cluster:

{% list tabs group=instructions %}

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file describing your infrastructure.

      For more on how to create this file, see [Creating a cluster](cluster-create.md).

  1. Add a resource description:

      ```hcl
      resource "yandex_mdb_sharded_postgresql_cluster_iam_binding" "spqr-cluster-editor" {
        cluster_id = "<cluster_ID>"
        role       = "managed-spqr.editor"
        members    = [
          "serviceAccount:<service_account_ID>"
        ]
      }
      ```

      
      Where:

      * `cluster_id`: Cluster ID.
      * `role`: [Role](../security.md#roles-list).
      * `members`: List of [subjects](../../iam/concepts/access-control/index.md#subject) the role is assigned to in `<subject_type>:<subject_ID>` format.


  1. Make sure the configuration files are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      For more information, see [this {{ TF }} provider guide]({{ tf-provider-resources-link }}/mdb_sharded_postgresql_cluster_iam_binding).

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Assign the role for the folder:

      ```bash
      curl \
        --request POST \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://resource-manager.{{ api-host }}/resource-manager/v1/folders/<folder_ID>:updateAccessBindings' \
        --data '{
                  "access_binding_deltas": [
                    {
                      "action": "ADD",
                      "access_binding": {
                        "role_id": "managed-spqr.viewer",
                        "subject": {
                          "id": "<service_account_ID>",
                          "type": "serviceAccount"
                        }
                      }
                    }
                  ]
                }'
      ```

      `access_binding_deltas.subject.id`: ID of the service account the role is assigned to.

  1. Call the [Cluster.UpdateAccessBindings](../api-ref/Cluster/updateAccessBindings.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

      ```bash
      curl \
        --request PATCH \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://{{ api-host-mdb }}/managed-spqr/v1/clusters/<cluster_ID>:updateAccessBindings' \
        --data '{
                  "access_binding_deltas": [
                    {
                      "action": "ADD",
                      "access_binding": {
                        "role_id": "managed-spqr.editor",
                        "subject": {
                          "id": "<service_account_ID>",
                          "type": "serviceAccount"
                        }
                      }
                    }
                  ]
                }'
      ```

      `access_binding_deltas.subject.id`: ID of the service account the role is assigned to.

  1. Check the list of roles assigned for the folder:

      ```bash
      curl \
        --request GET \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://resource-manager.{{ api-host }}/resource-manager/v1/folders/<folder_ID>:listAccessBindings'
      ```

  1. Check the list of roles assigned for the cluster:

      ```bash
      curl \
        --request GET \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://{{ api-host-mdb }}/managed-spqr/v1/clusters/<cluster_ID>:listAccessBindings'
      ```

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Assign the role for the folder:

      ```bash
      grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/resourcemanager/v1/folder_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "resource_id": "<folder_ID>",
              "access_binding_deltas": [
                {
                  "action": "ADD",
                  "access_binding": {
                    "role_id": "managed-spqr.viewer",
                    "subject": {
                      "id": "<service_account_ID>",
                      "type": "serviceAccount"
                    }
                  }
                }
              ]
            }' \
        resource-manager.{{ api-host }}:443 \
        yandex.cloud.resourcemanager.v1.FolderService.UpdateAccessBindings
      ```

      `access_binding_deltas.subject.id`: ID of the service account the role is assigned to.

  1. Assign the role for the cluster:

      ```bash
      grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/mdb/spqr/v1/cluster_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "resource_id": "<cluster_ID>",
              "access_binding_deltas": [
                {
                  "action": "ADD",
                  "access_binding": {
                    "role_id": "managed-spqr.editor",
                    "subject": {
                      "id": "<service_account_ID>",
                      "type": "serviceAccount"
                    }
                  }
                }
              ]
            }' \
        {{ api-host-mdb }}:{{ port-https }} \
        yandex.cloud.mdb.spqr.v1.ClusterService.UpdateAccessBindings
      ```

      `access_binding_deltas.subject.id`: ID of the service account the role is assigned to.

  1. Check the list of roles assigned for the folder:

      ```bash
      grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/resourcemanager/v1/folder_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "resource_id": "<folder_ID>"
            }' \
        resource-manager.{{ api-host }}:443 \
        yandex.cloud.resourcemanager.v1.FolderService.ListAccessBindings
      ```

  1. Check the list of roles assigned for the cluster:

      ```bash
      grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/mdb/spqr/v1/cluster_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "resource_id": "<cluster_ID>"
            }' \
        {{ api-host-mdb }}:{{ port-https }} \
        yandex.cloud.mdb.spqr.v1.ClusterService.ListAccessBindings
      ```

{% endlist %}
