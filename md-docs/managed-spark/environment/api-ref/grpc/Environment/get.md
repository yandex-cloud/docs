[Документация Yandex Cloud](../../../../../index.md) > [Yandex Managed Service for Apache Spark™](../../../../index.md) > Справочник API > gRPC (англ.) > [Managed Spark Environment API](../index.md) > [Environment](index.md) > Get

# Managed Spark Environment API, gRPC: EnvironmentService.Get

Returns the specified Environment.

## gRPC request

**rpc Get ([GetEnvironmentRequest](#yandex.cloud.spark.v1.environment.GetEnvironmentRequest)) returns ([Environment](#yandex.cloud.spark.v1.environment.Environment))**

## GetEnvironmentRequest {#yandex.cloud.spark.v1.environment.GetEnvironmentRequest}

```json
{
  "environment_id": "string"
}
```

#|
||Field | Description ||
|| environment_id | **string**

Required field. ID of the Environment to return.

The maximum string length in characters is 50. ||
|#

## Environment {#yandex.cloud.spark.v1.environment.Environment}

```json
{
  "info": {
    "id": "string",
    "life_stage": "EnvironmentLifeStage",
    "name": "string",
    "description": "string",
    "labels": "map<string, string>",
    "created_at": "google.protobuf.Timestamp",
    "deleted_at": "google.protobuf.Timestamp",
    "build_revision": "int64",
    "build_base_revision": "int64",
    "build_status": "BuildStatus",
    "build_error": {
      "type": "string",
      "message": "string"
    },
    "build_created_at": "google.protobuf.Timestamp",
    "build_deleted_at": "google.protobuf.Timestamp"
  },
  "base_info": {
    "id": "string",
    "life_stage": "EnvironmentLifeStage",
    "name": "string",
    "description": "string",
    "labels": "map<string, string>",
    "created_at": "google.protobuf.Timestamp",
    "deleted_at": "google.protobuf.Timestamp",
    "build_revision": "int64",
    "build_base_revision": "int64",
    "build_status": "BuildStatus",
    "build_error": {
      "type": "string",
      "message": "string"
    },
    "build_created_at": "google.protobuf.Timestamp",
    "build_deleted_at": "google.protobuf.Timestamp"
  },
  "folder_id": "string",
  "config": {
    "pip_packages": [
      "string"
    ],
    "deb_packages": [
      "string"
    ]
  }
}
```

Environment.

#|
||Field | Description ||
|| info | **[EnvironmentInfo](#yandex.cloud.spark.v1.environment.EnvironmentInfo)**

Required field. Environment info. ||
|| base_info | **[EnvironmentInfo](#yandex.cloud.spark.v1.environment.EnvironmentInfo)**

Required field. Base Environment info. ||
|| folder_id | **string**

ID of the folder that Environment belongs to. ||
|| config | **[EnvironmentConfig](#yandex.cloud.spark.v1.environment.EnvironmentConfig)**

Environment Configuration. ||
|#

## EnvironmentInfo {#yandex.cloud.spark.v1.environment.EnvironmentInfo}

Environment Info.

#|
||Field | Description ||
|| id | **string**

Required field. Unique ID of the Environment. This ID is assigned in the process of creating an Environment.

The maximum string length in characters is 50. ||
|| life_stage | enum **EnvironmentLifeStage**

Environment life stage.

- `ENVIRONMENT_LIFESTAGE_UNKNOWN`: Environment life stage is unknown.
- `ENVIRONMENT_LIFESTAGE_UNSTABLE`: Environment unstable.
- `ENVIRONMENT_LIFESTAGE_STABLE`: Environment stable.
- `ENVIRONMENT_LIFESTAGE_DEPRECATED`: Environment deprecated.
- `ENVIRONMENT_LIFESTAGE_DELETED`: Environment deleted. ||
|| name | **string**

Required field. Name of the Environment. The name of the user environment is unique within the folder. 1-63 characters long.

The maximum string length in characters is 63. Value must match the regular expression ` ^[a-z][-a-z0-9]{1,61}[a-z0-9]$ `. ||
|| description | **string**

Description of the Environment. 0-256 characters long. ||
|| labels | **object** (map<**string**, **string**>)

Environment labels.

The maximum string length in characters for each value is 63. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `. Each value must match the regular expression ` [-_0-9a-z]* `. No more than 64 per resource. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Environment was created. ||
|| deleted_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Environment was deleted. ||
|| build_revision | **int64**

Actual build revision number.

Value must be greater than 0. ||
|| build_base_revision | **int64**

Base environment actual build revision number. ||
|| build_status | enum **BuildStatus**

Actual build status.

- `BUILD_STATUS_UNKNOWN`: Build status is unknown.
- `BUILD_STATUS_NEW`: Build pending.
- `BUILD_STATUS_BUILDING`: Build creating.
- `BUILD_STATUS_BUILT`: Build created successfully.
- `BUILD_STATUS_VALIDATING`: Build validating.
- `BUILD_STATUS_READY`: Build ready to use.
- `BUILD_STATUS_STABLE`: Build stable.
- `BUILD_STATUS_ERROR`: Build creation failed.
- `BUILD_STATUS_DELETING`: Build deleting.
- `BUILD_STATUS_DELETED`: Build deleted. ||
|| build_error | **[BuildError](#yandex.cloud.spark.v1.environment.BuildError)**

Actual build creation error. ||
|| build_created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the actual build was created. ||
|| build_deleted_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the actual build was deleted. ||
|#

## BuildError {#yandex.cloud.spark.v1.environment.BuildError}

Environment Build Error.

#|
||Field | Description ||
|| type | **string**

Error Type.

The maximum string length in characters is 100. ||
|| message | **string**

Error Message.

The maximum string length in characters is 2000. ||
|#

## EnvironmentConfig {#yandex.cloud.spark.v1.environment.EnvironmentConfig}

Spark Environment Configuration.

#|
||Field | Description ||
|| pip_packages[] | **string**

Environment pip packages.

The maximum string length in characters for each value is 256. The maximum number of elements is 100. ||
|| deb_packages[] | **string**

Environment deb packages.

The maximum string length in characters for each value is 256. The maximum number of elements is 100. ||
|#