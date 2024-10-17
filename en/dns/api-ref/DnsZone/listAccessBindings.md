---
editable: false
sourcePath: en/_api-ref/dns/v1/api-ref/DnsZone/listAccessBindings.md
---

# Cloud DNS API, REST: DnsZone.ListAccessBindings {#ListAccessBindings}

Lists existing access bindings for the specified DNS zone.

## HTTP request

```
GET https://dns.{{ api-host }}/dns/v1/zones/{resourceId}:listAccessBindings
```

## Path parameters

#|
||Field | Description ||
|| resourceId | **string**

Required field. ID of the resource to list access bindings for.

To get the resource ID, use a corresponding List request.
For example, use the [yandex.cloud.resourcemanager.v1.CloudService.List](/docs/resource-manager/api-ref/Cloud/list#List) request to get the Cloud resource ID. ||
|#

## Query parameters {#yandex.cloud.access.ListAccessBindingsRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64)

The maximum number of results per page that should be returned. If the number of available
results is larger than `pageSize`,
the service returns a [ListAccessBindingsResponse.nextPageToken](#yandex.cloud.access.ListAccessBindingsResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100. ||
|| pageToken | **string**

Page token. Set `pageToken`
to the [ListAccessBindingsResponse.nextPageToken](#yandex.cloud.access.ListAccessBindingsResponse)
returned by a previous list request to get the next page of results. ||
|#

## Response {#yandex.cloud.access.ListAccessBindingsResponse}

**HTTP Code: 200 - OK**

```json
{
  "accessBindings": [
    {
      "roleId": "string",
      "subject": {
        "id": "string",
        "type": "string"
      }
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| accessBindings[] | **[AccessBinding](#yandex.cloud.access.AccessBinding)**

List of access bindings for the specified resource. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListAccessBindingsRequest.pageSize](#yandex.cloud.access.ListAccessBindingsRequest), use
the `nextPageToken` as the value
for the [ListAccessBindingsRequest.pageToken](#yandex.cloud.access.ListAccessBindingsRequest) query parameter
in the next list request. Each subsequent list request will have its own
`nextPageToken` to continue paging through the results. ||
|#

## AccessBinding {#yandex.cloud.access.AccessBinding}

#|
||Field | Description ||
|| roleId | **string**

Required field. ID of the [yandex.cloud.iam.v1.Role](/docs/iam/api-ref/Role/get#yandex.cloud.iam.v1.Role) that is assigned to the `subject`. ||
|| subject | **[Subject](#yandex.cloud.access.Subject)**

Required field. Identity for which access binding is being created.
It can represent an account with a unique ID or several accounts with a system identifier. ||
|#

## Subject {#yandex.cloud.access.Subject}

#|
||Field | Description ||
|| id | **string**

Required field. ID of the subject.

It can contain one of the following values:
* `allAuthenticatedUsers`: A special public group that represents anyone
who is authenticated. It can be used only if the `type` is `system`.
* `allUsers`: A special public group that represents anyone. No authentication is required.
For example, you don't need to specify the IAM token in an API query.
It can be used only if the `type` is `system`.
* `group:organization:<id>:users`: A special system group that represents all members of organization
with given <id>. It can be used only if the `type` is `system`.
* `group:federation:<id>:users`: A special system group that represents all users of federation
with given <id>. It can be used only if the `type` is `system`.
* `<cloud generated id>`: An identifier that represents a user account.
It can be used only if the `type` is `userAccount`, `federatedUser` or `serviceAccount`. ||
|| type | **string**

Required field. Type of the subject.

It can contain one of the following values:
* `userAccount`: An account on Yandex or Yandex Connect, added to Yandex Cloud.
* `serviceAccount`: A service account. This type represents the [yandex.cloud.iam.v1.ServiceAccount](/docs/iam/api-ref/ServiceAccount/get#yandex.cloud.iam.v1.ServiceAccount) resource.
* `federatedUser`: A federated account. This type represents a user from an identity federation, like Active Directory.
* `system`: System group. This type represents several accounts with a common system identifier.

For more information, see [Subject to which the role is assigned](/docs/iam/concepts/access-control/#subject). ||
|#