---
editable: false
---

# Yandex Cloud Registry API, gRPC: MigrationService.GetCloudMigrationStatusDashboard

Returns migration status dashboard for the specified cloud.

## gRPC request

**rpc GetCloudMigrationStatusDashboard ([GetCloudMigrationStatusDashboardRequest](#yandex.cloud.cloudregistry.v1.GetCloudMigrationStatusDashboardRequest)) returns ([CloudMigrationStatusDashboard](#yandex.cloud.cloudregistry.v1.CloudMigrationStatusDashboard))**

## GetCloudMigrationStatusDashboardRequest {#yandex.cloud.cloudregistry.v1.GetCloudMigrationStatusDashboardRequest}

```json
{
  "cloud_id": "string",
  "failed_registries_limit": "int64",
  "in_progress_registries_limit": "int64",
  "failed_repositories_limit": "int64",
  "failed_tags_limit": "int64",
  "in_progress_repositories_limit": "int64"
}
```

Request for getting migration status dashboard for the specified cloud.

#|
||Field | Description ||
|| cloud_id | **string**

Required field. ID of the cloud.

The maximum string length in characters is 50. ||
|| failed_registries_limit | **int64**

Maximum number of failed registry dashboards to return.

Acceptable values are 0 to 100, inclusive. ||
|| in_progress_registries_limit | **int64**

Maximum number of in-progress registry dashboards to return.

Acceptable values are 0 to 100, inclusive. ||
|| failed_repositories_limit | **int64**

Maximum number of failed repositories to return for each registry dashboard.

Acceptable values are 0 to 100, inclusive. ||
|| failed_tags_limit | **int64**

Maximum number of failed tags to return for each registry dashboard.

Acceptable values are 0 to 100, inclusive. ||
|| in_progress_repositories_limit | **int64**

Maximum number of in-progress repositories to return for each registry dashboard.

Acceptable values are 0 to 100, inclusive. ||
|#

## CloudMigrationStatusDashboard {#yandex.cloud.cloudregistry.v1.CloudMigrationStatusDashboard}

```json
{
  "cloud_id": "string",
  "status": "MigrationStatus",
  "progress": {
    "registries": {
      "total": "int64",
      "completed": "int64",
      "in_progress": "int64",
      "created": "int64",
      "scheduled": "int64",
      "failed": "int64"
    },
    "repositories": {
      "total": "int64",
      "completed": "int64",
      "in_progress": "int64",
      "created": "int64",
      "scheduled": "int64",
      "failed": "int64"
    },
    "tags": {
      "total": "int64",
      "completed": "int64",
      "in_progress": "int64",
      "created": "int64",
      "scheduled": "int64",
      "failed": "int64"
    }
  },
  "top_failed_registries": [
    {
      "registry_id": "string",
      "status": "MigrationStatus",
      "progress": {
        "repositories": {
          "total": "int64",
          "completed": "int64",
          "in_progress": "int64",
          "created": "int64",
          "scheduled": "int64",
          "failed": "int64"
        },
        "tags": {
          "total": "int64",
          "completed": "int64",
          "in_progress": "int64",
          "created": "int64",
          "scheduled": "int64",
          "failed": "int64"
        }
      },
      "top_failed_repositories": [
        {
          "repository_name": "string",
          "status": "MigrationStatus",
          "error_code": "string",
          "error_message": "string"
        }
      ],
      "top_failed_tags": [
        {
          "repository_name": "string",
          "tag": "string",
          "status": "MigrationStatus",
          "error_code": "string",
          "error_message": "string"
        }
      ],
      "top_in_progress_repositories": [
        {
          "repository_name": "string",
          "status": "MigrationStatus",
          "error_code": "string",
          "error_message": "string"
        }
      ]
    }
  ],
  "top_in_progress_registries": [
    {
      "registry_id": "string",
      "status": "MigrationStatus",
      "progress": {
        "repositories": {
          "total": "int64",
          "completed": "int64",
          "in_progress": "int64",
          "created": "int64",
          "scheduled": "int64",
          "failed": "int64"
        },
        "tags": {
          "total": "int64",
          "completed": "int64",
          "in_progress": "int64",
          "created": "int64",
          "scheduled": "int64",
          "failed": "int64"
        }
      },
      "top_failed_repositories": [
        {
          "repository_name": "string",
          "status": "MigrationStatus",
          "error_code": "string",
          "error_message": "string"
        }
      ],
      "top_failed_tags": [
        {
          "repository_name": "string",
          "tag": "string",
          "status": "MigrationStatus",
          "error_code": "string",
          "error_message": "string"
        }
      ],
      "top_in_progress_repositories": [
        {
          "repository_name": "string",
          "status": "MigrationStatus",
          "error_code": "string",
          "error_message": "string"
        }
      ]
    }
  ]
}
```

Migration status dashboard for the specified cloud.

#|
||Field | Description ||
|| cloud_id | **string**

ID of the cloud. ||
|| status | enum **MigrationStatus**

Overall migration status of the cloud.

- `CREATED`: Migration record was created.
- `SCHEDULED`: Migration was scheduled.
- `IN_PROGRESS`: Migration is currently in progress.
- `COMPLETED`: Migration completed successfully.
- `FAILED`: Migration failed. ||
|| progress | **[CloudMigrationProgressCounters](#yandex.cloud.cloudregistry.v1.CloudMigrationProgressCounters)**

Migration progress counters grouped by resource type. ||
|| top_failed_registries[] | **[MigrationStatusDashboard](#yandex.cloud.cloudregistry.v1.MigrationStatusDashboard)**

Top registry dashboards that failed during migration. ||
|| top_in_progress_registries[] | **[MigrationStatusDashboard](#yandex.cloud.cloudregistry.v1.MigrationStatusDashboard)**

Top registry dashboards that are currently being migrated. ||
|#

## CloudMigrationProgressCounters {#yandex.cloud.cloudregistry.v1.CloudMigrationProgressCounters}

Cloud migration progress counters.

#|
||Field | Description ||
|| registries | **[MigrationCounters](#yandex.cloud.cloudregistry.v1.MigrationCounters)**

Registry migration counters. ||
|| repositories | **[MigrationCounters](#yandex.cloud.cloudregistry.v1.MigrationCounters)**

Repository migration counters. ||
|| tags | **[MigrationCounters](#yandex.cloud.cloudregistry.v1.MigrationCounters)**

Tag migration counters. ||
|#

## MigrationCounters {#yandex.cloud.cloudregistry.v1.MigrationCounters}

Migration counters grouped by status.

#|
||Field | Description ||
|| total | **int64**

Total number of migration records. ||
|| completed | **int64**

Number of completed migration records. ||
|| in_progress | **int64**

Number of migration records currently in progress. ||
|| created | **int64**

Number of created migration records. ||
|| scheduled | **int64**

Number of scheduled migration records. ||
|| failed | **int64**

Number of failed migration records. ||
|#

## MigrationStatusDashboard {#yandex.cloud.cloudregistry.v1.MigrationStatusDashboard}

Migration status dashboard for the specified registry.

#|
||Field | Description ||
|| registry_id | **string**

ID of the registry. ||
|| status | enum **MigrationStatus**

Overall migration status of the registry.

- `CREATED`: Migration record was created.
- `SCHEDULED`: Migration was scheduled.
- `IN_PROGRESS`: Migration is currently in progress.
- `COMPLETED`: Migration completed successfully.
- `FAILED`: Migration failed. ||
|| progress | **[MigrationProgressCounters](#yandex.cloud.cloudregistry.v1.MigrationProgressCounters)**

Migration progress counters grouped by resource type. ||
|| top_failed_repositories[] | **[RepositoryMigrationStatus](#yandex.cloud.cloudregistry.v1.RepositoryMigrationStatus)**

Top repositories that failed during migration. ||
|| top_failed_tags[] | **[TagMigrationStatus](#yandex.cloud.cloudregistry.v1.TagMigrationStatus)**

Top tags that failed during migration. ||
|| top_in_progress_repositories[] | **[RepositoryMigrationStatus](#yandex.cloud.cloudregistry.v1.RepositoryMigrationStatus)**

Top repositories that are currently being migrated. ||
|#

## MigrationProgressCounters {#yandex.cloud.cloudregistry.v1.MigrationProgressCounters}

Migration progress counters for repositories and tags.

#|
||Field | Description ||
|| repositories | **[MigrationCounters](#yandex.cloud.cloudregistry.v1.MigrationCounters)**

Repository migration counters. ||
|| tags | **[MigrationCounters](#yandex.cloud.cloudregistry.v1.MigrationCounters)**

Tag migration counters. ||
|#

## RepositoryMigrationStatus {#yandex.cloud.cloudregistry.v1.RepositoryMigrationStatus}

Repository migration status.

#|
||Field | Description ||
|| repository_name | **string**

Repository name. ||
|| status | enum **MigrationStatus**

Migration status.

- `CREATED`: Migration record was created.
- `SCHEDULED`: Migration was scheduled.
- `IN_PROGRESS`: Migration is currently in progress.
- `COMPLETED`: Migration completed successfully.
- `FAILED`: Migration failed. ||
|| error_code | **string**

Error code if migration failed. ||
|| error_message | **string**

Error message if migration failed. ||
|#

## TagMigrationStatus {#yandex.cloud.cloudregistry.v1.TagMigrationStatus}

Tag migration status.

#|
||Field | Description ||
|| repository_name | **string**

Repository name. ||
|| tag | **string**

Tag name. ||
|| status | enum **MigrationStatus**

Migration status.

- `CREATED`: Migration record was created.
- `SCHEDULED`: Migration was scheduled.
- `IN_PROGRESS`: Migration is currently in progress.
- `COMPLETED`: Migration completed successfully.
- `FAILED`: Migration failed. ||
|| error_code | **string**

Error code if migration failed. ||
|| error_message | **string**

Error message if migration failed. ||
|#