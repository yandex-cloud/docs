---
title: "Overview"
description: "Managing Yandex DataSphere resources using the API Basic methods for creating projects, uploading files, and working with notebooks"
---

# {{ ml-platform-name }} API overview

{% include [link-on-new-ui-datasphere-in-old-ui](../../_includes/datasphere/datasphere-old-note.md) %}

In {{ ml-platform-name }}, you can perform all basic operations on resources and notebooks using both the UI and API.

The [{{ yandex-cloud }} API](https://github.com/yandex-cloud/cloudapi) uses a set of [gRPC](grpc/index) methods for resource management. For more information about their implementation and interaction specifics, see the [{{ yandex-cloud }} API documentation](../../api-design-guide/concepts/standard-methods).

## Working with projects {#project}

With `ProjectService` methods, you can create, open, update, and delete a project. You can also view a list of projects in a particular folder.

| Method | Description |
------------ |--------------------------------------------
| [Create](grpc/project_service#Create) | Creates a new project in the specified folder. |
| [Update](grpc/project_service#Update) | Updates a project. |
| [Delete](grpc/project_service#Delete) | Deletes a project. |
| [Open](grpc/project_service#Open) | Opens a project. |
| [Get](grpc/project_service#Get) | Returns information about a project. |
| [List](grpc/project_service#List) | Retrieves the list of projects in the specified folder. |

**Example**. Creating a project:

```bash
grpcurl -rpc-header "Authorization: Bearer <IAM token>" \
    -d '{"folder_id": "<folder_id>"}' \
    datasphere.api.cloud.yandex.net:443 \
    yandex.cloud.datasphere.v1.ProjectService/Create
```

**Example**. Getting a list of folder projects:

```bash
grpcurl -rpc-header "Authorization: Bearer <IAM token>" \
    -d '{"folder_id": "<folder_id>"}' \
    datasphere.api.cloud.yandex.net:443 \
    yandex.cloud.datasphere.v1.ProjectService/List
```

For more information about the `ProjectService` methods, see the [API documentation](grpc/project_service).

## Working with project data {#data}

Use `ProjectDataService` methods to export/import files to/from a project.

| Method | Description |
------------ |--------------------------------------------
| [UploadFile](grpc/project_data_service#UploadFile) | Uploads a file to the specified project. |
| [DownloadFile](grpc/project_data_service#DownloadFile) | Downloads a file from the specified project. |

**Example**. Downloading a project's file:

```bash
grpcurl -rpc-header "Authorization: Bearer <IAM token>" \
    -d '{"project_id": "<project_id>", "file_path": "<file_path>"}' \
    datasphere.api.cloud.yandex.net:443 \
    yandex.cloud.datasphere.v1.ProjectDataService/DownloadFile
```
For more information about the `ProjectDataService` methods, see the [API documentation](grpc/project_data_service).

## Working with notebooks {#notebook}

Use `ProjectService` methods to run a notebook or a specific cell, get the results of cell execution or the values of notebook state variables or metadata.

| Method | Description |
------------ |--------------------------------------------
| [Execute](grpc/project_service#Execute) | Runs the specified cell or notebook. |
| [GetCellOutputs](grpc/project_service#GetCellOutputs) | Returns cell execution results. |
| [GetStateVariables](grpc/project_service#GetStateVariables) | Returns the values of notebook state variables. |
| [GetNotebookMetadata](grpc/project_service#GetNotebookMetadata) | Returns notebook metadata. |

**Example**. Running a notebook cell:

```bash
grpcurl -rpc-header "Authorization: Bearer <IAM token>" \
    -d '{"project_id": "<project_id>", "target": "cell_id", "cell_id": "<cell_id>"}' \
    datasphere.api.cloud.yandex.net:443 \
    yandex.cloud.datasphere.v1.ProjectService/Execute
```

**Example**. Outputting notebook cell execution results:

```bash
grpcurl -rpc-header "Authorization: Bearer <IAM token>" \
    -d '{"project_id": "<project_id>", "cell_id": "<cell_id>"}' \
    datasphere.api.cloud.yandex.net:443 \
    yandex.cloud.datasphere.v1.ProjectService/GetCellOutputs
```

For more information about the `ProjectService` methods, see the [API documentation](grpc/project_service).

## Managing consumption limits {#limits}

You can use API methods to set up consumption limits for a project (`ProjectService`) or folder (`FolderBudgetService`).

| Method | Description |
------------ |--------------------------------------------
| [GetUnitBalance](grpc/project_service#GetUnitBalance) | Returns a project's balance. |
| [SetUnitBalance](grpc/project_service#SetUnitBalance) | Sets a project's balance. |
| [Get](grpc/folder_budget_service#Get) | Returns a folder's balance. |
| [Set](grpc/folder_budget_service#Set) | Sets a folder's balance. |

**Example**. Getting a project's balance:

```bash
grpcurl -rpc-header "Authorization: Bearer <IAM token>" \
    -d '{"project_id": "<project_id>"}' \
    datasphere.api.cloud.yandex.net:443 \
    yandex.cloud.datasphere.v1.ProjectService/GetUnitBalance
```

**Example**. Getting a folder's balance:

```bash
grpcurl -rpc-header "Authorization: Bearer <IAM token>" \
    -d '{"folder_id": "<folder_id>"}' \
    datasphere.api.cloud.yandex.net:443 \
    yandex.cloud.datasphere.v1.FolderBudgetService/Get
```

See more examples in the following step-by-step instructions:

* [Setting up consumption limits for a project](../operations/projects/custom-limits)
* [Setting up consumption limits for a folder](../operations/projects/set-ds-budget)

For more information about the [ProjectService](grpc/project_service) and [FolderBudgetService](grpc/folder_budget_service) methods, see the API documentation.

In addition to the methods listed above, you can use other service methods for performing operations and managing nodes and tokens, such as:

* [AppTokenService/Validate](grpc/app_token_service)
* [OperationService/Get](grpc/operation_service#Get)
* [OperationService/Cancel](grpc/operation_service#Cancel)
* [NodeService/Execute](grpc/app_token_service)