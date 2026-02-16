---
editable: false
sourcePath: en/_api-ref-grpc/loadtesting/api/v1/user/api-ref/grpc/Test/list.md
---

# Load Testing API, gRPC: TestService.List

Retrieves the list of test in the specified folder.

## gRPC request

**rpc List ([ListTestsRequest](#yandex.cloud.loadtesting.api.v1.ListTestsRequest)) returns ([ListTestsResponse](#yandex.cloud.loadtesting.api.v1.ListTestsResponse))**

## ListTestsRequest {#yandex.cloud.loadtesting.api.v1.ListTestsRequest}

```json
{
  "folder_id": "string",
  "page_size": "int64",
  "page_token": "string",
  "filter": "string"
}
```

#|
||Field | Description ||
|| folder_id | **string**

ID of the folder to list tests in. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`, the service returns a [ListTestsResponse.next_page_token](#yandex.cloud.loadtesting.api.v1.ListTestsResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token` to the
[ListTestsResponse.next_page_token](#yandex.cloud.loadtesting.api.v1.ListTestsResponse) returned by a previous list request. ||
|| filter | **string**

A filter expression that filters tests listed in the response.

The filter expression may contain multiple field expressions joined by `AND`.
The field expression must specify:
1. The field name.
2. An operator:
- `=`, `!=`, `<`, `<=`, `>`, `>=`, `CONTAINS`, `:` for single values.
- `IN` or `NOT IN` for lists of values.
3. The value. String values must be encosed in `"`, boolean values are {`true`, `false`}, timestamp values in ISO-8601.

Currently supported fields:
- `id` [yandex.cloud.loadtesting.api.v1.test.Test.id](#yandex.cloud.loadtesting.api.v1.test.Test)
- operators: `=`, `!=`, `IN`, `NOT IN`
- `details.name` [yandex.cloud.loadtesting.api.v1.test.Details.name](#yandex.cloud.loadtesting.api.v1.test.Details)
- operators: `=`, `!=`, `IN`, `NOT IN`, `CONTAINS`
- `details.tags.<TAG_NAME>` [yandex.cloud.loadtesting.api.v1.test.Details.tags](#yandex.cloud.loadtesting.api.v1.test.Details)
- operators: `:`
- `summary.status` [yandex.cloud.loadtesting.api.v1.test.Summary.status](#yandex.cloud.loadtesting.api.v1.test.Summary)
- operators: `=`, `!=`, `IN`, `NOT IN`
- `summary.is_finished` [yandex.cloud.loadtesting.api.v1.test.Summary.is_finished](#yandex.cloud.loadtesting.api.v1.test.Summary)
- operators: `=`
- `summary.created_at` [yandex.cloud.loadtesting.api.v1.test.Summary.created_at](#yandex.cloud.loadtesting.api.v1.test.Summary)
- operators: `<`, `<=`, `>`, `>=`
- `summary.created_by` [yandex.cloud.loadtesting.api.v1.test.Summary.created_by](#yandex.cloud.loadtesting.api.v1.test.Summary)
- operators: `=`, `!=`, `IN`, `NOT IN`

Examples:
- `summary.status IN ("DONE", "ERROR") AND details.tags.author:"yandex"`
- `summary.is_finished = true AND details.name CONTAINS "nightly-test"` ||
|#

## ListTestsResponse {#yandex.cloud.loadtesting.api.v1.ListTestsResponse}

```json
{
  "tests": [
    {
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
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| tests[] | **[Test](#yandex.cloud.loadtesting.api.v1.test.Test)**

List of tests in the specified folder. ||
|| next_page_token | **string**

Token for getting the next page of the list. If the number of results is greater than
the specified [ListTestsRequest.page_size](#yandex.cloud.loadtesting.api.v1.ListTestsRequest), use `next_page_token` as the value
for the [ListTestsRequest.page_token](#yandex.cloud.loadtesting.api.v1.ListTestsRequest) parameter in the next list request.

Each subsequent page will have its own `next_page_token` to continue paging through the results. ||
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
- `STOPPED`: Test has been stopped by user.
- `AUTOSTOPPED`: Test has been stopped automatically by satisfying autostop condition.
- `WAITING`: Execution stage: waiting for a trigger to start.
- `DELETING`: Test is being deleted.
- `LOST`: Test status has not been reported in a while during execution stage.

  Means that either an agent is too busy to send it, got offline, or failed without
reporting a final status.
- `CANCELLED`: Test has been cancelled. ||
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