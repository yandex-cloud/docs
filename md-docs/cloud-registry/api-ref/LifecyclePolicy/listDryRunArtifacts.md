[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Registry](../../index.md) > Справочник API > [REST (англ.)](../index.md) > [LifecyclePolicy](index.md) > ListDryRunArtifacts

# Yandex Cloud Registry API, REST: LifecyclePolicy.ListDryRunArtifacts

Returns the list of artifacts that the dry run would delete.

## HTTP request

```
GET https://registry.api.cloud.yandex.net/cloud-registry/v1/lifecyclePolicyDryRunResults/{dryRunId}:artifacts
```

## Path parameters

#|
||Field | Description ||
|| dryRunId | **string**

Required field. ID of the dry run.

The maximum string length in characters is 50. ||
|#

## Query parameters {#yandex.cloud.cloudregistry.v1.ListDryRunLifecyclePolicyArtifactsRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64)

The maximum number of results per page to return.

The maximum value is 1000. ||
|| pageToken | **string**

Page token. To get the next page of results, set page_token to the
ListDryRunLifecyclePolicyArtifactsResponse.next_page_token returned by a previous list request.

The maximum string length in characters is 1000. ||
|| pathFilter | **string**

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
|| versionFilter | **string**

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
|| orderBy | **string**

Sort order. Comma-separated "field [asc\|desc]", e.g. "path desc".
Valid fields: path.
Defaults to "path asc" when empty.

The maximum string length in characters is 256. ||
|#

## Response {#yandex.cloud.cloudregistry.v1.ListDryRunLifecyclePolicyArtifactsResponse}

**HTTP Code: 200 - OK**

```json
{
  "artifacts": [
    {
      "path": "string",
      "version": "string",
      "artifactId": "string",
      "affectedBy": {
        "ruleType": "string",
        "ruleIndex": "string"
      }
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| artifacts[] | **[AffectedArtifact](#yandex.cloud.cloudregistry.v1.AffectedArtifact)**

List of artifacts that the dry run would delete. ||
|| nextPageToken | **string**

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
|| artifactId | **string**

ID of the artifact. ||
|| affectedBy | **[TriggeredRule](#yandex.cloud.cloudregistry.v1.AffectedArtifact.TriggeredRule)**

Rule that would delete this artifact. ||
|#

## TriggeredRule {#yandex.cloud.cloudregistry.v1.AffectedArtifact.TriggeredRule}

Rule that matched the artifact during the dry run.

#|
||Field | Description ||
|| ruleType | **enum** (LifecycleRuleType)

Type of the rule that matched.

- `LIFECYCLE_RULE_TYPE_HARD_DELETE`: Hard delete. The artifact is removed for good and can not be restored.
- `LIFECYCLE_RULE_TYPE_SOFT_DELETE`: Soft delete. The artifact is marked for deletion but can be restored.
- `LIFECYCLE_RULE_TYPE_RETAIN`: Retain. The artifact is kept. ||
|| ruleIndex | **string** (int64)

Index of the rule in the policy rules snapshot (policy_snapshot) of this dry run. ||
|#