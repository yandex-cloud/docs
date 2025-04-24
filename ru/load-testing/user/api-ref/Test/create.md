---
editable: false
sourcePath: en/_api-ref/loadtesting/api/v1/user/api-ref/Test/create.md
---

# Load Testing API, REST: Test.Create

Creates (runs) a test in the specified folder.

## HTTP request

```
POST https://loadtesting.{{ api-host }}/loadtesting/api/v1/tests
```

## Body parameters {#yandex.cloud.loadtesting.api.v1.CreateTestRequest}

```json
{
  "folderId": "string",
  "configurations": [
    {
      "configId": "string",
      "agentSelector": {
        // Includes only one of the fields `agentId`, `matchByFilter`, `anonymousAgent`
        "agentId": "string",
        "matchByFilter": "string",
        "anonymousAgent": "boolean"
        // end of the list of possible fields
      },
      "files": "object"
    }
  ],
  "testDetails": {
    "name": "string",
    "description": "string",
    "tags": [
      {
        "key": "string",
        "value": "string"
      }
    ],
    "loggingLogGroupId": "string",
    "artifactSettings": {
      // Includes only one of the fields `objectStorageBucket`
      "objectStorageBucket": "string",
      // end of the list of possible fields
      "isArchive": "boolean",
      "filterInclude": [
        "string"
      ],
      "filterExclude": [
        "string"
      ]
    }
  }
}
```

#|
||Field | Description ||
|| folderId | **string**

Required field. ID of the folder to create a test in. ||
|| configurations[] | **[SingleAgentConfiguration](#yandex.cloud.loadtesting.api.v1.test.SingleAgentConfiguration)**

Test configuration associated with agents on which they will be executed.
In case of multiple configurations, a multitest will be created. ||
|| testDetails | **[Details](#yandex.cloud.loadtesting.api.v1.test.Details)**

Test details. Name, tags etc. ||
|#

## SingleAgentConfiguration {#yandex.cloud.loadtesting.api.v1.test.SingleAgentConfiguration}

Configuration of a test.

#|
||Field | Description ||
|| configId | **string**

ID of the config. ||
|| agentSelector | **[AgentSelector](#yandex.cloud.loadtesting.api.v1.test.AgentSelector)**

Agent selection criterion. ||
|| files | **object** (map<**string**, **[FilePointer](#yandex.cloud.loadtesting.api.v1.test.FilePointer)**>)

Additional files to be used during test execution, represented as `rel_path:file` pairs.

`rel_path` can be either a simple file name, a relative path, or absolute path. Files are
downloaded by the agent to appropriate location.

Use cases include:
- [Test Data files](/docs/load-testing/concepts/payload).
- Custom Pandora executable.
- JMeter executable or ".jmx" scenario.
- etc. ||
|#

## AgentSelector {#yandex.cloud.loadtesting.api.v1.test.AgentSelector}

Agent selection criterion.

The structure is used by service to determine on which agents a specific test should be executed.

#|
||Field | Description ||
|| agentId | **string**

Selection by agent ID.

Includes only one of the fields `agentId`, `matchByFilter`, `anonymousAgent`. ||
|| matchByFilter | **string**

Selection by filter string.

Includes only one of the fields `agentId`, `matchByFilter`, `anonymousAgent`. ||
|| anonymousAgent | **boolean**

Select anonymoud (i.e. not registered) agents.

Includes only one of the fields `agentId`, `matchByFilter`, `anonymousAgent`. ||
|#

## FilePointer {#yandex.cloud.loadtesting.api.v1.test.FilePointer}

Variant-like structure for referencing files in different sources.

#|
||Field | Description ||
|| objectStorage | **[ObjectStorage](#yandex.cloud.loadtesting.api.v1.test.ObjectStorage)**

Reference to a file in Object Storage.

Includes only one of the fields `objectStorage`. ||
|#

## ObjectStorage {#yandex.cloud.loadtesting.api.v1.test.ObjectStorage}

Reference to a file stored in Object Storage.

#|
||Field | Description ||
|| bucket | **string**

Bucket name. ||
|| name | **string**

File name. ||
|#

## Details {#yandex.cloud.loadtesting.api.v1.test.Details}

Test meta information.

#|
||Field | Description ||
|| name | **string**

Name of the test. ||
|| description | **string**

Description of the test. ||
|| tags[] | **[Tag](#yandex.cloud.loadtesting.api.v1.common.Tag)**

Tags assigned to the test. ||
|| loggingLogGroupId | **string**

ID of the logging group to which test artifacts are uploaded. ||
|| artifactSettings | **[ArtifactSettings](#yandex.cloud.loadtesting.api.v1.test.ArtifactSettings)**

Settings which define where to upload test artifacts and which files should be included. ||
|#

## Tag {#yandex.cloud.loadtesting.api.v1.common.Tag}

Tag attached to some entity.

#|
||Field | Description ||
|| key | **string**

Key of the tag. ||
|| value | **string**

Value of the tag. ||
|#

## ArtifactSettings {#yandex.cloud.loadtesting.api.v1.test.ArtifactSettings}

Artifact upload settings.

Defines where to upload test artifacts and which files should be included.

#|
||Field | Description ||
|| objectStorageBucket | **string**

Name of output object storage bucket in test's folder.

Includes only one of the fields `objectStorageBucket`. ||
|| isArchive | **boolean**

Setting which defines whether artifact files should be archived prior to uploading. ||
|| filterInclude[] | **string**

Filter strings defining which files should be included to artifacts. GLOB format.

Example:
- ['*'] - all files will be uploaded.
- ['*.log', '*.yaml] - all `.log` and `.yaml` files will be uploaded. ||
|| filterExclude[] | **string**

Filter strings defining which files should be excluded from artifacts. GLOB format.

Example:
- filter_include=['*'], filter_exclude=['phout.log'] - upload all `.log` files excluding `phout.log`. ||
|#

## Response {#yandex.cloud.operation.Operation}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": "boolean",
  "metadata": {
    "testId": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": {
    "id": "string",
    "configurations": [
      {
        "configId": "string",
        "agentSelector": {
          // Includes only one of the fields `agentId`, `matchByFilter`, `anonymousAgent`
          "agentId": "string",
          "matchByFilter": "string",
          "anonymousAgent": "boolean"
          // end of the list of possible fields
        },
        "files": "object"
      }
    ],
    "details": {
      "name": "string",
      "description": "string",
      "tags": [
        {
          "key": "string",
          "value": "string"
        }
      ],
      "loggingLogGroupId": "string",
      "artifactSettings": {
        // Includes only one of the fields `objectStorageBucket`
        "objectStorageBucket": "string",
        // end of the list of possible fields
        "isArchive": "boolean",
        "filterInclude": [
          "string"
        ],
        "filterExclude": [
          "string"
        ]
      }
    },
    "summary": {
      "status": "string",
      "createdAt": "string",
      "createdBy": "string",
      "startedAt": "string",
      "finishedAt": "string",
      "isFinished": "boolean",
      "error": "string",
      "imbalancePoint": {
        "at": "string",
        "rps": "string",
        "comment": "string"
      },
      "assignedAgentId": "string",
      "artifacts": {
        // Includes only one of the fields `objectStorage`
        "objectStorage": {
          "bucket": "string",
          "name": "string"
        }
        // end of the list of possible fields
      }
    },
    "folderId": "string"
  }
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **string** (date-time)

The time when the Operation resource was last modified.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| done | **boolean**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[CreateTestMetadata](#yandex.cloud.loadtesting.api.v1.CreateTestMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[Status](#google.rpc.Status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **[Test](#yandex.cloud.loadtesting.api.v1.test.Test)**

The normal response of the operation in case of success.
If the original method returns no data on success, such as Delete,
the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty).
If the original method is the standard Create/Update,
the response should be the target resource of the operation.
Any method that returns a long-running operation should document the response type, if any.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|#

## CreateTestMetadata {#yandex.cloud.loadtesting.api.v1.CreateTestMetadata}

#|
||Field | Description ||
|| testId | **string**

ID of the test that is being created. ||
|#

## Status {#google.rpc.Status}

The error result of the operation in case of failure or cancellation.

#|
||Field | Description ||
|| code | **integer** (int32)

Error code. An enum value of [google.rpc.Code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto). ||
|| message | **string**

An error message. ||
|| details[] | **object**

A list of messages that carry the error details. ||
|#

## Test {#yandex.cloud.loadtesting.api.v1.test.Test}

Load Test.

In context of the service, Test represents a single testing task/job.

#|
||Field | Description ||
|| id | **string**

ID of the test. Generated at creation time. ||
|| configurations[] | **[SingleAgentConfiguration](#yandex.cloud.loadtesting.api.v1.test.SingleAgentConfiguration2)**

Configuration of the test.

A test can have multiple configurations if it can be
executed on multiple agents simultaneously. For more information, see
[Load testing using multiple agents](/docs/load-testing/tutorials/loadtesting-multiply). ||
|| details | **[Details](#yandex.cloud.loadtesting.api.v1.test.Details2)**

Test meta information. Name, description, etc. ||
|| summary | **[Summary](#yandex.cloud.loadtesting.api.v1.test.Summary)**

Test execution information. ||
|| folderId | **string**

ID of the folder that the test belongs to. ||
|#

## SingleAgentConfiguration {#yandex.cloud.loadtesting.api.v1.test.SingleAgentConfiguration2}

Configuration of a test.

#|
||Field | Description ||
|| configId | **string**

ID of the config. ||
|| agentSelector | **[AgentSelector](#yandex.cloud.loadtesting.api.v1.test.AgentSelector2)**

Agent selection criterion. ||
|| files | **object** (map<**string**, **[FilePointer](#yandex.cloud.loadtesting.api.v1.test.FilePointer2)**>)

Additional files to be used during test execution, represented as `rel_path:file` pairs.

`rel_path` can be either a simple file name, a relative path, or absolute path. Files are
downloaded by the agent to appropriate location.

Use cases include:
- [Test Data files](/docs/load-testing/concepts/payload).
- Custom Pandora executable.
- JMeter executable or ".jmx" scenario.
- etc. ||
|#

## AgentSelector {#yandex.cloud.loadtesting.api.v1.test.AgentSelector2}

Agent selection criterion.

The structure is used by service to determine on which agents a specific test should be executed.

#|
||Field | Description ||
|| agentId | **string**

Selection by agent ID.

Includes only one of the fields `agentId`, `matchByFilter`, `anonymousAgent`. ||
|| matchByFilter | **string**

Selection by filter string.

Includes only one of the fields `agentId`, `matchByFilter`, `anonymousAgent`. ||
|| anonymousAgent | **boolean**

Select anonymoud (i.e. not registered) agents.

Includes only one of the fields `agentId`, `matchByFilter`, `anonymousAgent`. ||
|#

## FilePointer {#yandex.cloud.loadtesting.api.v1.test.FilePointer2}

Variant-like structure for referencing files in different sources.

#|
||Field | Description ||
|| objectStorage | **[ObjectStorage](#yandex.cloud.loadtesting.api.v1.test.ObjectStorage2)**

Reference to a file in Object Storage.

Includes only one of the fields `objectStorage`. ||
|#

## ObjectStorage {#yandex.cloud.loadtesting.api.v1.test.ObjectStorage2}

Reference to a file stored in Object Storage.

#|
||Field | Description ||
|| bucket | **string**

Bucket name. ||
|| name | **string**

File name. ||
|#

## Details {#yandex.cloud.loadtesting.api.v1.test.Details2}

Test meta information.

#|
||Field | Description ||
|| name | **string**

Name of the test. ||
|| description | **string**

Description of the test. ||
|| tags[] | **[Tag](#yandex.cloud.loadtesting.api.v1.common.Tag2)**

Tags assigned to the test. ||
|| loggingLogGroupId | **string**

ID of the logging group to which test artifacts are uploaded. ||
|| artifactSettings | **[ArtifactSettings](#yandex.cloud.loadtesting.api.v1.test.ArtifactSettings2)**

Settings which define where to upload test artifacts and which files should be included. ||
|#

## Tag {#yandex.cloud.loadtesting.api.v1.common.Tag2}

Tag attached to some entity.

#|
||Field | Description ||
|| key | **string**

Key of the tag. ||
|| value | **string**

Value of the tag. ||
|#

## ArtifactSettings {#yandex.cloud.loadtesting.api.v1.test.ArtifactSettings2}

Artifact upload settings.

Defines where to upload test artifacts and which files should be included.

#|
||Field | Description ||
|| objectStorageBucket | **string**

Name of output object storage bucket in test's folder.

Includes only one of the fields `objectStorageBucket`. ||
|| isArchive | **boolean**

Setting which defines whether artifact files should be archived prior to uploading. ||
|| filterInclude[] | **string**

Filter strings defining which files should be included to artifacts. GLOB format.

Example:
- ['*'] - all files will be uploaded.
- ['*.log', '*.yaml] - all `.log` and `.yaml` files will be uploaded. ||
|| filterExclude[] | **string**

Filter strings defining which files should be excluded from artifacts. GLOB format.

Example:
- filter_include=['*'], filter_exclude=['phout.log'] - upload all `.log` files excluding `phout.log`. ||
|#

## Summary {#yandex.cloud.loadtesting.api.v1.test.Summary}

Process of test and some results

#|
||Field | Description ||
|| status | **enum** (Status)

Status of the test.

- `STATUS_UNSPECIFIED`: Status is unspecified.
- `CREATED`: Test has been created, but not started by any agent.
- `INITIATED`: Execution stage: initialization.
- `PREPARING`: Execution stage: data preparation and warm-up.
- `RUNNING`: Execution stage: load generation.
- `FINISHING`: Execution stage: termination.
- `DONE`: Test is done.
- `POST_PROCESSING`: Execution stage: results post-processing.
- `FAILED`: Test has failed due to some error.
- `STOPPING`: Test is being stopped.
- `STOPPED`: Test has been stopped by user.
- `AUTOSTOPPED`: Test has been stopped automatically by satisfying autostop condition.
- `WAITING`: Execution stage: waiting for a trigger to start.
- `DELETING`: Test is being deleted.
- `LOST`: Test status has not been reported in a while during execution stage.

  Means that either an agent is too busy to send it, got offline, or failed without
reporting a final status.
- `CANCELLED`: Test has been cancelled. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdBy | **string**

UA or SA that created the test. ||
|| startedAt | **string** (date-time)

Test start timestamp.

Empty if the test has not been started yet.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| finishedAt | **string** (date-time)

Test finish timestamp.

Empty if the test has not been finished yet.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| isFinished | **boolean**

Indicates whether the test is finished. ||
|| error | **string**

Error message. ||
|| imbalancePoint | **[ImbalancePoint](#yandex.cloud.loadtesting.api.v1.test.ImbalancePoint)**

Detected imbalance point.

Contains information about a state at the moment it has been
[auto-stopped](/docs/load-testing/concepts/auto-stop).

Empty if no auto-stop occured. ||
|| assignedAgentId | **string**

ID of the agent that executed the test. ||
|| artifacts | **[FilePointer](#yandex.cloud.loadtesting.api.v1.test.FilePointer2)**

Test output artifacts.

Link to the artifacts output target containing `.log` and other files collected
during test execution. ||
|#

## ImbalancePoint {#yandex.cloud.loadtesting.api.v1.test.ImbalancePoint}

Test imbalance point.

#|
||Field | Description ||
|| at | **string** (date-time)

Imbalance moment timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| rps | **string** (int64)

Imbalance moment RPS. ||
|| comment | **string**

Imbalance reason comment. ||
|#