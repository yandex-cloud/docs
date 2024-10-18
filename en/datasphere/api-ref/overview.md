---
title: '{{ ml-platform-full-name }} API overview'
description: Managing {{ ml-platform-full-name }} resources using the API Basic methods for creating projects, uploading files, and working with notebooks
---

# {{ ml-platform-name }} API overview

In {{ ml-platform-name }}, you can perform all basic operations on resources and notebooks using both the UI and API.

The [{{ yandex-cloud }} API](https://github.com/yandex-cloud/cloudapi) manages resources using sets of [gRPC](grpc/index.md) calls and [REST](index.md) methods. For more information about their implementation and interaction specifics, see the [{{ yandex-cloud }} API documentation](../../api-design-guide/concepts/standard-methods.md).

## Working with the community {#community}

With `CommunityService` calls and `Community` methods, you can create, update, and delete a community. You can also view a list of communities in a particular organization.

| Description | gRPC | REST |
| --- | --- | --- |
| Creates a new community in the specified organization | [Create](grpc/Community/create.md) | [create](Community/create.md) |
| Updates a community | [Update](grpc/Community/update.md) | [update](Community/update.md) |
| Deletes a community | [Delete](grpc/Community/delete.md) | [delete](Community/delete.md) |
| Returns information about a community | [Get](grpc/Community/get.md) | [get](Community/get.md) |
| Returns a list of communities in the specified organization | [List](grpc/Community/list.md) | [list](Community/list.md) |

{% list tabs %}

- gRPC

   **Example**. Creating a community:

   ```bash
   grpcurl -rpc-header "Authorization: Bearer <IAM_token>" \
     -d '{"organization_id": "<organization_ID>"}' \
     datasphere.{{ api-host }}:443 \
     yandex.cloud.datasphere.v2.CommunityService/Create
   ```

   **Example**. Viewing a list of communities in an organization:

   ```bash
   grpcurl -rpc-header "Authorization: Bearer <IAM_token>" \
     -d '{"organization_id": "<organization_ID>"}' \
     datasphere.{{ api-host }}:443 \
     yandex.cloud.datasphere.v2.CommunityService/List
   ```

   For more information about the `CommunityService` calls, see the [API documentation](grpc/Community/index.md).

- REST

   **Example**. Creating a community:

   ```bash
   curl -H "Authorization: Bearer <IAM_token>" \
     -X POST "https://datasphere.{{ api-host }}/datasphere/v2/communities" \
     -d '{ "organizationId": "<organization_ID>" }'
   ```

   **Example**. Viewing a list of communities in an organization:

   ```bash
   curl -H "Authorization: Bearer <IAM_token>" \
     -X GET "https://datasphere.{{ api-host }}/datasphere/v2/communities" \
     -d '{ "organizationId": "<organization_ID>" }'
   ```

   For more information about the `Community` methods, see the [API documentation](Community/index.md).

{% endlist %}

## Working with projects {#project}

With `ProjectService` calls and `Project` methods, you can create, open, update, or delete a project. You can also view a list of projects in a particular community.

| Description | gRPC | REST |
| --- | --- | --- |
| Creates a new project in the specified community | [Create](grpc/Project/create.md) | [create](Project/create.md) |
| Updates a project | [Update](grpc/Project/update.md) | [update](Project/update.md) |
| Deletes a project | [Delete](grpc/Project/delete.md) | [delete](Project/delete.md) |
| Opens a project | [Open](grpc/Project/open.md) | [open](Project/open.md) |
| Returns information about a project | [Get](grpc/Project/get.md) | [get](Project/get.md) |
| Retrieves the list of projects in the specified community | [List](grpc/Project/list.md) | [list](Project/list.md) |

{% list tabs %}

- gRPC

   **Example**. Creating a project:

   ```bash
   grpcurl -rpc-header "Authorization: Bearer <IAM_token>" \
     -d '{"community_id": "<community_ID>"}' \
     datasphere.{{ api-host }}:443 \
     yandex.cloud.datasphere.v2.ProjectService/Create
   ```

   **Example**. Viewing a list of folder projects:

   ```bash
   grpcurl -rpc-header "Authorization: Bearer <IAM_token>" \
     -d '{"community_id": "<community_ID>"}' \
     datasphere.{{ api-host }}:443 \
     yandex.cloud.datasphere.v2.ProjectService/List
   ```

   For more information about the `ProjectService` calls, see the [API documentation](grpc/Project/index.md).

- REST

   **Example**. Creating a project:

   ```bash
   curl -H "Authorization: Bearer <IAM_token>" \
     -X POST "https://datasphere.{{ api-host }}/datasphere/v2/projects" \
     -d '{ "communityId": "<community_ID>" }'
   ```

   **Example**. Viewing a list of community projects:

   ```bash
   curl -H "Authorization: Bearer <IAM_token>" \
     -X GET "https://datasphere.{{ api-host }}/datasphere/v2/projects" \
     -d '{ "communityId": "<community_ID>" }'
   ```

   For more information about the `Project` methods, see the [API documentation](Project/index.md).

{% endlist %}

## Working with notebooks {#notebook}

To run a notebook, you can use the `Execute` call or the `execute` method in `ProjectService`.

| Description | gRPC | REST |
| --- | --- | --- |
| Runs the specified notebook | [Execute](grpc/Project/execute.md) | [execute](Project/execute.md) |


{% list tabs %}

- gRPC

   **Example**. Running the whole notebook:

   ```bash
   grpcurl -rpc-header "Authorization: Bearer <IAM_token>" \
     -d '{"project_id": "<project_ID>", "target": "notebook_id", "notebook_id": "<notebook_ID>"}' \
     datasphere.{{ api-host }}:443 \
     yandex.cloud.datasphere.v2.ProjectService/Execute
   ```

   To get the notebook ID, follow this guide: [{#T}](../operations/projects/get-notebook-cell-ids.md).

   For more information about the `ProjectService` calls, see the [API documentation](grpc/Project/index.md).

- REST

   **Example**. Running the whole notebook:

   ```bash
   curl -H "Authorization: Bearer <IAM_token>" \
     -X POST "https://datasphere.{{ api-host }}/datasphere/v2/projects/<project_ID>:execute" \
     -d '{ "notebook_id": "<notebook_ID>" }'
   ```

   To get the notebook ID, follow this guide: [{#T}](../operations/projects/get-notebook-cell-ids.md).

   For more information about the `Project` methods, see the [API documentation](Project/index.md).

{% endlist %}

## Working with resources {#resources}

### Resource activation and deactivation {#activate-deactivate}

Each resource has its own group of API methods implemented in {{ ml-platform-name }}. By calling the `Activate` and `Deactivate` methods of the corresponding group in a given project, you can activate and deactivate the resources as needed.

| Description | gRPC | REST |
| --- | --- | --- |
| Activates a dataset | [Activate](grpc/Dataset/activate.md) | [activate](Dataset/activate.md) |
| Deactivates a dataset | [Deactivate](grpc/Dataset/deactivate.md) | [deactivate](Dataset/deactivate.md) |
| Activates an S3 connector | [Activate](grpc/S3/activate.md) | [activate](S3/activate.md) |
| Deactivates an S3 connector | [Deactivate](grpc/S3/deactivate.md) | [deactivate](S3/deactivate.md) |
| Activates a Docker image | [Activate](grpc/DockerImage/activate.md) | [activate](DockerImage/activate.md) |

{% list tabs %}

- gRPC

   **Example**. Activating a dataset:

   ```bash
   grpcurl -rpc-header "Authorization: Bearer <IAM_token>" \
     -d "{\"project_id\": \"<project_ID>\", \"dataset_id\": \"<dataset_ID>\"}" \
     datasphere.{{ api-host }}:443 \
     yandex.cloud.datasphere.v2.DatasetService/Activate
   ```

   **Example**. Deactivating a dataset:

   ```bash
   grpcurl -rpc-header "Authorization: Bearer <IAM_token>" \
     -d "{\"project_id\": \"<project_ID>\", \"dataset_id\": \"<dataset_ID>\"}" \
     datasphere.{{ api-host }}:443 \
     yandex.cloud.datasphere.v2.DatasetService/Deactivate
   ```

   Learn more about the `DatasetService` calls in the [API documentation](grpc/Dataset/index.md).

- REST

   **Example**. Activating a dataset:

   ```bash
   curl -H "Authorization: Bearer <IAM_token>" \
     -X POST "https://datasphere.{{ api-host }}/datasphere/v2/dataset/activate" \
     -d "{ \"datasetId\": \"<dataset_ID>\", \"projectId\": \"<project_ID>\" }"
   ```

   **Example**. Deactivating a dataset:

   ```bash
   curl -H "Authorization: Bearer <IAM_token>" \
     -X POST "https://datasphere.{{ api-host }}/datasphere/v2/dataset/deactivate" \
     -d "{ \"datasetId\": \"<dataset_ID>\", \"projectId\": \"<project_ID>\" }"
   ```

   Learn more about the `Dataset` methods in the [API documentation](Dataset/index.md).

{% endlist %}

### Adding and deleting resources {#add-remove}

You can use the API to add and delete resources in a project (`ProjectService`, `Project`) or community (`CommunityService`, `Community`).

To enable your project to use another project's resources, you need to [share](../operations/index.md#share) the resource in a community and add it to your project.

| Description | gRPC | REST |
| --- | --- | --- |
| Adds a resource to a community | [addResource](grpc/Community/addResource.md) | [addResource](Community/addResource.md) |
| Deletes a resources from a community | [removeResource](grpc/Community/removeResource.md) | [removeResource](Community/removeResource.md) |
| Adds a resource to a project | [addResource](grpc/Project/addResource.md) | [addResource](Project/addResource.md) |
| Deletes a resource from a project | [removeResource](grpc/Project/removeResource.md) | [removeResource](Project/removeResource.md) |

{% list tabs %}

- gRPC

   **Example**. Adding a resource to a project:

   ```bash
   grpcurl -rpc-header "Authorization: Bearer <IAM_token>" \
     -d "{\"project_id\": \"<project_ID>\", \"resource_id\": \"<resource_ID>\"}" \
     datasphere.{{ api-host }}:443 \
     yandex.cloud.datasphere.v2.ProjectService/AddResource
   ```

   **Example**. Deleting a resource from a project:

   ```bash
   grpcurl -rpc-header "Authorization: Bearer <IAM_token>" \
     -d "{\"project_id\": \"<project_ID>\", \"resource_id\": \"<resource_ID>\"}" \
     datasphere.{{ api-host }}:443 \
     yandex.cloud.datasphere.v2.ProjectService/RemoveResource
   ```

   For more information about the `ProjectService` calls, see the [API documentation](grpc/Project/index.md).

- REST

   **Example**. Adding a resource to a project:

   ```bash
   curl -H "Authorization: Bearer <IAM_token>" \
     -X POST "https://datasphere.{{ api-host }}/datasphere/v2/projects/<resource_ID>:addResource" \
     -d "{ \"projectId\": \"<project_ID>\" }"
   ```

   **Example**. Deleting a resource from a project:

   ```bash
   curl -H "Authorization: Bearer <IAM_token>" \
     -X POST "https://datasphere.{{ api-host }}/datasphere/v2/projects/<resource_ID>:removeResource" \
     -d "{ \"projectId\": \"<project_ID>\" }"
   ```

   For more information about the `Project` methods, see the [API documentation](Project/index.md).

{% endlist %}

## Access management {#access}

You can use the API to set up access to a project (`ProjectService`, `Project`) or community (`CommunityService`, `Community`).

| Description | gRPC | REST |
| --- | --- | --- |
| Returns a list of access permissions for a project | [ListAccessBindings](grpc/Project/listAccessBindings.md) | [ListAccessBindings](Project/listAccessBindings.md) |
| Sets up access to a project | [SetAccessBindings](grpc/Project/setAccessBindings.md) | [SetAccessBindings](Project/setAccessBindings.md) |
| Updates access to a project | [UpdateAccessBindings](grpc/Project/updateAccessBindings.md) | [UpdateAccessBindings](Project/updateAccessBindings.md) |
| Returns a list of access permissions for a community | [ListAccessBindings](grpc/Community/listAccessBindings.md) | [ListAccessBindings](Community/listAccessBindings.md) |
| Sets up access to a community | [SetAccessBindings](grpc/Community/setAccessBindings.md) | [SetAccessBindings](Community/setAccessBindings.md) |
| Updates access to a community | [UpdateAccessBindings](grpc/Community/updateAccessBindings.md) | [UpdateAccessBindings](Community/updateAccessBindings.md) |

{% list tabs %}

- gRPC

   **Example**. Viewing a list of access permissions for a project:

   ```bash
   grpcurl -rpc-header "Authorization: Bearer <IAM_token>" \
     -d '{"resource_id": "<project_ID>"}' \
     datasphere.{{ api-host }}:443 \
     yandex.cloud.datasphere.v2.ProjectService/ListAccessBindings
   ```

   **Example**. Return a list of access permissions for a community:

   ```bash
   grpcurl -rpc-header "Authorization: Bearer <IAM_token>" \
     -d '{"resource_id": "<community_ID>"}' \
     datasphere.{{ api-host }}:443 \
     yandex.cloud.datasphere.v2.CommunityService/ListAccessBindings
   ```

   For more information about the [ProjectService](grpc/Project/index.md) and [CommunityService](grpc/Community/index.md) methods, see the API documentation.

- REST

   **Example**. Viewing a list of access permissions for a project:

   ```bash
   curl -H "Authorization: Bearer <IAM_token>" \
     -X GET "https://datasphere.{{ api-host }}/datasphere/v2/projects/<resource_ID>:accessBindings"
   ```

   **Example**. Return a list of access permissions for a community:

   ```bash
   curl -H "Authorization: Bearer <IAM_token>" \
     -X GET "https://datasphere.{{ api-host }}/datasphere/v2/communities/<resource_ID>:accessBindings"
   ```

   For more information about the [Project](Project/index.md) and [Community](Community/index.md) methods, see the API documentation.

{% endlist %}

## Managing consumption limits {#limits}

You can use the API to set up consumption limits for a project (`ProjectService`, `Project`).

| Description | gRPC | REST |
| --- | --- | --- |
| Returns a project's balance | [getUnitBalance](grpc/Project/getUnitBalance.md) | [getUnitBalance](Project/getUnitBalance.md) |
| Sets a project's balance | [setUnitBalance](grpc/Project/setUnitBalance.md) | [setUnitBalance](Project/setUnitBalance.md) |

{% list tabs %}

- gRPC

   **Example**. Getting a project's balance:

   ```bash
   grpcurl -rpc-header "Authorization: Bearer <IAM_token>" \
     -d '{"project_id": "<project_ID>"}' \
     datasphere.{{ api-host }}:443 \
     yandex.cloud.datasphere.v2.ProjectService/GetUnitBalance
   ```

   For more information about the `ProjectService` calls, see the [API documentation](grpc/Project/index.md).

- REST

   **Example**. Getting a project's balance:

   ```bash
   curl -H "Authorization: Bearer <IAM_token>" \
     -X GET "https://datasphere.{{ api-host }}/datasphere/v2/projects/<project_ID>:unitBalance"
   ```

   For more information about the `Project` methods, see the [API documentation](Project/index.md).

{% endlist %}