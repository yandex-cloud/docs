---
title: Managing access to a {{ mgp-full-name }} cluster
description: Follow this guide to configure {{ mgp-name }} cluster access permissions.
---

# Managing access to a {{ mgp-name }} cluster

You can grant a [role](../security/index.md) for access to a specific [cluster](../concepts/index.md) to a user or service account.

Thus, you can granularly assign different roles for particular clusters to different users and service accounts.


## Getting a list of roles assigned for a cluster {#list-access-bindings}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. To get a list of clusters in the default [folder](../../resource-manager/concepts/resources-hierarchy.md#folder), run this command:

      ```bash
      {{ yc-mdb-gp }} cluster list
      ```

  1. To get a list of roles assigned for the cluster, run this command:

      ```bash
      {{ yc-mdb-gp }} cluster list-access-bindings <cluster_name_or_ID>
      ```

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Cluster.ListAccessBindings](../api-ref/Cluster/listAccessBindings.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

      ```bash
      curl \
        --request GET \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://{{ api-host-mdb }}/managed-greenplum/v1/clusters/<cluster_ID>:listAccessBindings'
      ```

  1. View the [server response](../api-ref/Cluster/listAccessBindings.md#yandex.cloud.access.ListAccessBindingsResponse) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Call the [ClusterService.ListAccessBindings](../api-ref/grpc/Cluster/listAccessBindings.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

      ```bash
      grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/mdb/greenplum/v1/cluster_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "resource_id": "<cluster_ID>"
            }' \
        {{ api-host-mdb }}:{{ port-https }} \
        yandex.cloud.mdb.greenplum.v1.ClusterService.ListAccessBindings
      ```

  1. Check the [server response](../api-ref/grpc/Cluster/listAccessBindings.md#yandex.cloud.access.ListAccessBindingsResponse) to make sure your request was successful.

{% endlist %}


## Assigning a role {#add-access-binding}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. View the description of the CLI command for assigning a role for a cluster:

      ```bash
      {{ yc-mdb-gp }} cluster add-access-binding --help
      ```

  1. Use this command to assign a role:

      ```bash
      {{ yc-mdb-gp }} cluster add-access-binding <cluster_name_or_ID> \
        --role <role> \
        --subject <subject_type>:<subject_ID>
      ```

      Where:

      * `--role`: [Role](../security/index.md#roles-list) being assigned, e.g., `managed-greenplum.editor`.
      * `--subject`: Type and ID of the [subject](../../iam/concepts/access-control/index.md#subject) you are assigning the role to, in `<subject_type>:<subject_ID>` format.

          For example:

          * `serviceAccount:aje6p030************`
          * `userAccount:aje8tj79************`
          * `system:allAuthenticatedUsers`

          {% include [access-control-subject](../../_includes/mdb/access-control-subject.md) %}

  1. To view a list of roles assigned for the cluster, run this command:

      ```bash
      {{ yc-mdb-gp }} cluster list-access-bindings <cluster_name_or_ID>
      ```

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Cluster.UpdateAccessBindings](../api-ref/Cluster/updateAccessBindings.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

      ```bash
      curl \
        --request PATCH \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://{{ api-host-mdb }}/managed-greenplum/v1/clusters/<cluster_ID>:updateAccessBindings' \
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

      * `access_binding_deltas.roleId`: [Role](../security/index.md#roles-list) being assigned, e.g., `managed-greenplum.editor`.
      * `access_binding_deltas.subject.id`: ID of the [subject](../../iam/concepts/access-control/index.md#subject) the role is assigned to.
      * `access_binding_deltas.subject.type`: Type of subject the role is assigned to.

          {% include [access-control-subject](../../_includes/mdb/access-control-subject.md) %}

  1. Check the [server response](../api-ref/Cluster/updateAccessBindings.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Call the [ClusterService.UpdateAccessBindings](../api-ref/grpc/Cluster/updateAccessBindings.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

      ```bash
      grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/mdb/greenplum/v1/cluster_service.proto \
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
        yandex.cloud.mdb.greenplum.v1.ClusterService.UpdateAccessBindings
      ```

      Where:

      * `resource_id`: Cluster ID.
      * `access_binding_deltas.roleId`: [Role](../security/index.md#roles-list) being assigned, e.g., `managed-greenplum.editor`.
      * `access_binding_deltas.subject.id`: ID of the [subject](../../iam/concepts/access-control/index.md#subject) the role is assigned to.
      * `access_binding_deltas.subject.type`: Type of subject the role is assigned to.

          {% include [access-control-subject](../../_includes/mdb/access-control-subject.md) %}

  1. Check the [server response](../api-ref/grpc/Cluster/updateAccessBindings.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Assigning multiple roles {#set-access-bindings}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  {% note alert %}

  The `set-access-bindings` command deletes all roles assigned for the cluster and assigns new ones.

  {% endnote %}

  1. To view a list of roles assigned for the cluster, run this command:

      ```bash
      {{ yc-mdb-gp }} cluster list-access-bindings <cluster_name_or_ID>
      ```

  1. View the description of the CLI command for assigning roles for a cluster:

      ```bash
      {{ yc-mdb-gp }} cluster set-access-bindings --help
      ```

  1. To assign roles, run this command:

      ```bash
      {{ yc-mdb-gp }} cluster set-access-bindings <cluster_name_or_ID> \
        --access-binding role=<role>,subject=<subject_type>:<subject_1_ID> \
        --access-binding role=<role>,subject=<subject_type>:<subject_2_ID>
      ```

      Where `--access-binding` assigns a role to a subject. You can assign multiple roles at once by describing each of them in a separate `--access-binding` parameter.

      * `role`: [Role](../security/index.md#roles-list) being assigned, e.g., `managed-greenplum.editor`.
      * `subject`: Type and ID of the [subject](../../iam/concepts/access-control/index.md#subject) you are assigning the role to, in `<subject_type>:<subject_ID>` format.

          For example:

          * `serviceAccount:aje6p030************`
          * `userAccount:aje8tj79************`
          * `system:allAuthenticatedUsers`

          {% include [access-control-subject](../../_includes/mdb/access-control-subject.md) %}

- REST API {#api}

  {% note alert %}

  The `setAccessBindings` method overwrites access permissions for the resource. All roles previously assigned for this resource will be deleted.

  {% endnote %}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Cluster.SetAccessBindings](../api-ref/Cluster/setAccessBindings.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

      ```bash
      curl \
        --request POST \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://{{ api-host-mdb }}/managed-greenplum/v1/clusters/<cluster_ID>:setAccessBindings' \
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

      * `accessBindings.roleId`: [Role](../security/index.md#roles-list) being assigned, e.g., `managed-greenplum.editor`.
      * `accessBindings.subject.id`: ID of the [subject](../../iam/concepts/access-control/index.md#subject) the role is assigned to.
      * `accessBindings.subject.type`: Type of subject the role is assigned to.

          {% include [access-control-subject](../../_includes/mdb/access-control-subject.md) %}

  1. Check the [server response](../api-ref/Cluster/setAccessBindings.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  {% note alert %}

  The `ClusterService.SetAccessBindings` method completely overwrites access permissions for the resource. All roles previously assigned for this resource will be deleted.

  {% endnote %}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Call the [ClusterService.SetAccessBindings](../api-ref/grpc/Cluster/setAccessBindings.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

      ```bash
      grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/mdb/greenplum/v1/cluster_service.proto \
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
        yandex.cloud.mdb.greenplum.v1.ClusterService.SetAccessBindings
      ```

      Where:

      * `resource_id`: Cluster ID.
      * `accessBindings.roleId`: [Role](../security/index.md#roles-list) being assigned, e.g., `managed-greenplum.editor`.
      * `accessBindings.subject.id`: ID of the [subject](../../iam/concepts/access-control/index.md#subject) the role is assigned to.
      * `accessBindings.subject.type`: Type of subject the role is assigned to.

          {% include [access-control-subject](../../_includes/mdb/access-control-subject.md) %}

  1. Check the [server response](../api-ref/grpc/Cluster/setAccessBindings.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Revoking a role {#remove-access-binding}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. To view a list of roles assigned for the cluster, run this command:

      ```bash
      {{ yc-mdb-gp }} cluster list-access-bindings <cluster_name_or_ID>
      ```

  1. View the description of the CLI command for revoking a role for a cluster:

      ```bash
      {{ yc-mdb-gp }} cluster remove-access-binding --help
      ```
  1. To revoke a role, run this command:

      ```bash
      {{ yc-mdb-gp }} cluster remove-access-binding <cluster_name_or_ID> \
        --role <role> \
        --subject <subject_type>:<subject_ID>
      ```

      Where:

      * `--role`: [Role](../security/index.md#roles-list) being revoked, e.g., `managed-greenplum.editor`.
      * `--subject`: Type and ID of the [subject](../../iam/concepts/access-control/index.md#subject) the role is assigned to, in `<subject_type>:<subject_ID>` format.

          For example:

          * `serviceAccount:aje6p030************`
          * `userAccount:aje8tj79************`
          * `system:allAuthenticatedUsers`

          {% include [access-control-subject](../../_includes/mdb/access-control-subject.md) %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Cluster.UpdateAccessBindings](../api-ref/Cluster/updateAccessBindings.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

      ```bash
      curl \
        --request PATCH \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://{{ api-host-mdb }}/managed-greenplum/v1/clusters/<cluster_ID>:updateAccessBindings' \
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

      * `access_binding_deltas.roleId`: [Role](../security/index.md#roles-list) being assigned, e.g., `managed-greenplum.editor`.
      * `access_binding_deltas.subject.id`: ID of the [subject](../../iam/concepts/access-control/index.md#subject) the role is assigned to.
      * `access_binding_deltas.subject.type`: Type of subject the role is assigned to.

          {% include [access-control-subject](../../_includes/mdb/access-control-subject.md) %}

  1. Check the [server response](../api-ref/Cluster/updateAccessBindings.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Call the [ClusterService.UpdateAccessBindings](../api-ref/grpc/Cluster/updateAccessBindings.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

      ```bash
      grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/mdb/greenplum/v1/cluster_service.proto \
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
        yandex.cloud.mdb.greenplum.v1.ClusterService.UpdateAccessBindings
      ```

      Where:

      * `resource_id`: Cluster ID.
      * `access_binding_deltas.roleId`: [Role](../security/index.md#roles-list) being assigned, e.g., `managed-greenplum.editor`.
      * `access_binding_deltas.subject.id`: ID of the [subject](../../iam/concepts/access-control/index.md#subject) the role is assigned to.
      * `access_binding_deltas.subject.type`: Type of subject the role is assigned to.

          {% include [access-control-subject](../../_includes/mdb/access-control-subject.md) %}

  1. Check the [server response](../api-ref/grpc/Cluster/updateAccessBindings.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Examples {#examples}

### Granting cluster management access to a service account {#sa-cluster-control}

For a service account to be able to view the info of all {{ mgp-name }} clusters in the folder but modify the resources in one particular cluster alone, give it the `managed-greenplum.viewer` role for the folder and the `managed-greenplum.editor` role for that cluster:

{% list tabs group=instructions %}

- CLI {#cli}

  1. Assign the role for the folder:

      ```bash
      yc resource-manager folder add-access-binding <folder_name_or_ID> \
        --role managed-greenplum.viewer \
        --subject=serviceAccount:<service_account_ID>
      ```

  1. Assign the roles for the cluster:

      ```bash
      {{ yc-mdb-gp }} cluster add-access-bindings <cluster_name_or_ID> \
        --access-binding role=managed-greenplum.editor,subject=serviceAccount:<service_account_ID>
      ```

  1. Check the list of roles assigned for the cluster:

      ```bash
      {{ yc-mdb-gp }} cluster list-access-bindings <cluster_name_or_ID>
      ```

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

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
                        "role_id": "managed-greenplum.viewer",
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
        --url 'https://{{ api-host-mdb }}/managed-greenplum/v1/clusters/<cluster_ID>:updateAccessBindings' \
        --data '{
                  "access_binding_deltas": [
                    {
                      "action": "ADD",
                      "access_binding": {
                        "role_id": "managed-greenplum.editor",
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
        --url 'https://resource-manager.{{ api-host }}/resource-manager/v1/folders/<folder_ID>:updateAccessBindings'
      ```

  1. Check the list of roles assigned for the cluster:

      ```bash
      curl \
        --request GET \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://{{ api-host-mdb }}/managed-greenplum/v1/clusters/<cluster_ID>:listAccessBindings'
      ```

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

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
              "resource_id": "<cluster_ID>",
              "access_binding_deltas": [
                {
                  "action": "ADD",
                  "access_binding": {
                    "role_id": "managed-greenplum.viewer",
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
        -proto ~/cloudapi/yandex/cloud/mdb/greenplum/v1/cluster_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "resource_id": "<cluster_ID>",
              "access_binding_deltas": [
                {
                  "action": "ADD",
                  "access_binding": {
                    "role_id": "managed-greenplum.editor",
                    "subject": {
                      "id": "<service_account_ID>",
                      "type": "serviceAccount"
                    }
                  }
                }
              ]
            }' \
        {{ api-host-mdb }}:{{ port-https }} \
        yandex.cloud.mdb.greenplum.v1.ClusterService.UpdateAccessBindings
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
        -proto ~/cloudapi/yandex/cloud/mdb/greenplum/v1/cluster_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "resource_id": "<cluster_ID>"
            }' \
        {{ api-host-mdb }}:{{ port-https }} \
        yandex.cloud.mdb.greenplum.v1.ClusterService.ListAccessBindings
      ```

{% endlist %}