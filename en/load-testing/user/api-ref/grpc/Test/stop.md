---
editable: false
sourcePath: en/_api-ref-grpc/loadtesting/api/v1/user/api-ref/grpc/Test/stop.md
---

# Load Testing API, gRPC: TestService.Stop

Stops the specified test.

## gRPC request

**rpc Stop ([StopTestRequest](#yandex.cloud.loadtesting.api.v1.StopTestRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## StopTestRequest {#yandex.cloud.loadtesting.api.v1.StopTestRequest}

```json
{
  "test_id": "string"
}
```

#|
||Field | Description ||
|| test_id | **string**

ID of the test to stop. ||
|#

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "created_at": "google.protobuf.Timestamp",
  "created_by": "string",
  "modified_at": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": {
    "test_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "configurations": [
      {
        "config_id": "string",
        "agent_selector": {
          // Includes only one of the fields `agent_id`, `match_by_filter`, `anonymous_agent`
          "agent_id": "string",
          "match_by_filter": "string",
          "anonymous_agent": "bool"
          // end of the list of possible fields
        },
        "files": "map<string, FilePointer>"
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
      "logging_log_group_id": "string",
      "artifact_settings": {
        // Includes only one of the fields `object_storage_bucket`
        "object_storage_bucket": "string",
        // end of the list of possible fields
        "is_archive": "bool",
        "filter_include": [
          "string"
        ],
        "filter_exclude": [
          "string"
        ]
      }
    },
    "summary": {
      "status": "Status",
      "created_at": "google.protobuf.Timestamp",
      "created_by": "string",
      "started_at": "google.protobuf.Timestamp",
      "finished_at": "google.protobuf.Timestamp",
      "is_finished": "bool",
      "error": "string",
      "imbalance_point": {
        "at": "google.protobuf.Timestamp",
        "rps": "int64",
        "comment": "string"
      },
      "assigned_agent_id": "string",
      "artifacts": {
        // Includes only one of the fields `object_storage`
        "object_storage": {
          "bucket": "string",
          "name": "string"
        }
        // end of the list of possible fields
      }
    },
    "folder_id": "string"
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
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| created_by | **string**

ID of the user or service account who initiated the operation. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[StopTestMetadata](#yandex.cloud.loadtesting.api.v1.StopTestMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**

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

## StopTestMetadata {#yandex.cloud.loadtesting.api.v1.StopTestMetadata}

#|
||Field | Description ||
|| test_id | **string**

ID of the test that is being stopped. ||
|#

## Test {#yandex.cloud.loadtesting.api.v1.test.Test}

Load Test.

In context of the service, Test represents a single testing task/job.

#|
||Field | Description ||
|| id | **string**

ID of the test. Generated at creation time. ||
|| configurations[] | **[SingleAgentConfiguration](#yandex.cloud.loadtesting.api.v1.test.SingleAgentConfiguration)**

Configuration of the test.

A test can have multiple configurations if it can be
executed on multiple agents simultaneously. For more information, see
[Load testing using multiple agents](/docs/load-testing/tutorials/loadtesting-multiply). ||
|| details | **[Details](#yandex.cloud.loadtesting.api.v1.test.Details)**

Test meta information. Name, description, etc. ||
|| summary | **[Summary](#yandex.cloud.loadtesting.api.v1.test.Summary)**

Test execution information. ||
|| folder_id | **string**

ID of the folder that the test belongs to. ||
|#

## SingleAgentConfiguration {#yandex.cloud.loadtesting.api.v1.test.SingleAgentConfiguration}

Configuration of a test.

#|
||Field | Description ||
|| config_id | **string**

ID of the config. ||
|| agent_selector | **[AgentSelector](#yandex.cloud.loadtesting.api.v1.test.AgentSelector)**

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
|| agent_id | **string**

Selection by agent ID.

Includes only one of the fields `agent_id`, `match_by_filter`, `anonymous_agent`. ||
|| match_by_filter | **string**

Selection by filter string.

Includes only one of the fields `agent_id`, `match_by_filter`, `anonymous_agent`. ||
|| anonymous_agent | **bool**

Select anonymoud (i.e. not registered) agents.

Includes only one of the fields `agent_id`, `match_by_filter`, `anonymous_agent`. ||
|#

## FilePointer {#yandex.cloud.loadtesting.api.v1.test.FilePointer}

Variant-like structure for referencing files in different sources.

#|
||Field | Description ||
|| object_storage | **[ObjectStorage](#yandex.cloud.loadtesting.api.v1.test.ObjectStorage)**

Reference to a file in Object Storage.

Includes only one of the fields `object_storage`. ||
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
|| logging_log_group_id | **string**

ID of the logging group to which test artifacts are uploaded. ||
|| artifact_settings | **[ArtifactSettings](#yandex.cloud.loadtesting.api.v1.test.ArtifactSettings)**

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
|| object_storage_bucket | **string**

Name of output object storage bucket in test's folder.

Includes only one of the fields `object_storage_bucket`. ||
|| is_archive | **bool**

Setting which defines whether artifact files should be archived prior to uploading. ||
|| filter_include[] | **string**

Filter strings defining which files should be included to artifacts. GLOB format.

Example:
- ['*'] - all files will be uploaded.
- ['*.log', '*.yaml] - all `.log` and `.yaml` files will be uploaded. ||
|| filter_exclude[] | **string**

Filter strings defining which files should be excluded from artifacts. GLOB format.

Example:
- filter_include=['*'], filter_exclude=['phout.log'] - upload all `.log` files excluding `phout.log`. ||
|#

## Summary {#yandex.cloud.loadtesting.api.v1.test.Summary}

Process of test and some results

#|
||Field | Description ||
|| status | enum **Status**

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
- `STOPPED`: Test has been stopped.
- `AUTOSTOPPED`: Test has been stopped automatically by satisfying autostop condition.
- `WAITING`: Execution stage: waiting for a trigger to start.
- `DELETING`: Test is being deleted.
- `LOST`: Test status has not been reported in a while during execution stage.

  Means that either an agent is too busy to send it, got offline, or failed without
reporting a final status. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| created_by | **string**

UA or SA that created the test. ||
|| started_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Test start timestamp.

Empty if the test has not been started yet. ||
|| finished_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Test finish timestamp.

Empty if the test has not been finished yet. ||
|| is_finished | **bool**

Indicates whether the test is finished. ||
|| error | **string**

Error message. ||
|| imbalance_point | **[ImbalancePoint](#yandex.cloud.loadtesting.api.v1.test.ImbalancePoint)**

Detected imbalance point.

Contains information about a state at the moment it has been
[auto-stopped](/docs/load-testing/concepts/auto-stop).

Empty if no auto-stop occured. ||
|| assigned_agent_id | **string**

ID of the agent that executed the test. ||
|| artifacts | **[FilePointer](#yandex.cloud.loadtesting.api.v1.test.FilePointer)**

Test output artifacts.

Link to the artifacts output target containing `.log` and other files collected
during test execution. ||
|#

## ImbalancePoint {#yandex.cloud.loadtesting.api.v1.test.ImbalancePoint}

Test imbalance point.

#|
||Field | Description ||
|| at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Imbalance moment timestamp. ||
|| rps | **int64**

Imbalance moment RPS. ||
|| comment | **string**

Imbalance reason comment. ||
|#