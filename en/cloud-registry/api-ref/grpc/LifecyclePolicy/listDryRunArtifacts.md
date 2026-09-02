---
editable: false
---

# Yandex Cloud Registry API, gRPC: LifecyclePolicyService.ListDryRunArtifacts

Returns the list of artifacts that the dry run would delete.

## gRPC request

**rpc ListDryRunArtifacts ([ListDryRunLifecyclePolicyArtifactsRequest](#yandex.cloud.cloudregistry.v1.ListDryRunLifecyclePolicyArtifactsRequest)) returns ([ListDryRunLifecyclePolicyArtifactsResponse](#yandex.cloud.cloudregistry.v1.ListDryRunLifecyclePolicyArtifactsResponse))**

## ListDryRunLifecyclePolicyArtifactsRequest {#yandex.cloud.cloudregistry.v1.ListDryRunLifecyclePolicyArtifactsRequest}

```json
{
  "dry_run_id": "string",
  "page_size": "int64",
  "page_token": "string",
  "path_filter": "string",
  "version_filter": "string",
  "order_by": "string"
}
```

#|
||Field | Description ||
|| dry_run_id | **string**

Required field. ID of the dry run.

The maximum string length in characters is 50. ||
|| page_size | **int64**

The maximum number of results per page to return.

The maximum value is 1000. ||
|| page_token | **string**

Page token. To get the next page of results, set page_token to the
ListDryRunLifecyclePolicyArtifactsResponse.next_page_token returned by a previous list request.

The maximum string length in characters is 1000. ||
|| path_filter | **string**

Filter by artifact path.
The expression must specify:
1. The field path
2. An operator: =, !=.
3. The value in double quotes.
Examples:
path = "pool/main/all"
path != "pool/main/all"
No regular expressions allowed.

The maximum string length in characters is 1000. ||
|| version_filter | **string**

Filter by artifact version.
The expression must specify:
1. The field version
2. An operator: =, !=.
3. The value in double quotes.
Examples:
version = "latest"
version != "latest"
No regular expressions allowed.

The maximum string length in characters is 1000. ||
|| order_by | **string**

Sort order. Comma-separated "field [asc\|desc]", e.g. "path desc".
Valid fields: path.
Defaults to "path asc" when empty.

The maximum string length in characters is 256. ||
|#

## ListDryRunLifecyclePolicyArtifactsResponse {#yandex.cloud.cloudregistry.v1.ListDryRunLifecyclePolicyArtifactsResponse}

```json
{
  "artifacts": [
    {
      "path": "string",
      "version": "string",
      "artifact_id": "string",
      "affected_by": {
        "rule_type": "LifecycleRuleType",
        "rule_index": "int64"
      }
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| artifacts[] | **[AffectedArtifact](#yandex.cloud.cloudregistry.v1.AffectedArtifact)**

List of artifacts that the dry run would delete. ||
|| next_page_token | **string**

This token allows you to get the next page of results for list requests. ||
|#

## AffectedArtifact {#yandex.cloud.cloudregistry.v1.AffectedArtifact}

One artifact that a dry run would delete.

#|
||Field | Description ||
|| path | **string**

Full path of the artifact, for example /library/ubuntu/latest. ||
|| version | **string**

Version of the artifact. The backend does not store it.
The backend takes the part of the path after the last "/", for example latest. ||
|| artifact_id | **string**

ID of the artifact. ||
|| affected_by | **[TriggeredRule](#yandex.cloud.cloudregistry.v1.AffectedArtifact.TriggeredRule)**

Rule that would delete this artifact. ||
|#

## TriggeredRule {#yandex.cloud.cloudregistry.v1.AffectedArtifact.TriggeredRule}

Rule that matched the artifact during the dry run.

#|
||Field | Description ||
|| rule_type | enum **LifecycleRuleType**

Type of the rule that matched.

- `LIFECYCLE_RULE_TYPE_HARD_DELETE`: Hard delete. The artifact is removed for good and can not be restored.
- `LIFECYCLE_RULE_TYPE_SOFT_DELETE`: Soft delete. The artifact is marked for deletion but can be restored.
- `LIFECYCLE_RULE_TYPE_RETAIN`: Retain. The artifact is kept. ||
|| rule_index | **int64**

Index of the rule in the policy rules snapshot (policy_snapshot) of this dry run. ||
|#