[Документация Yandex Cloud](../../../index.md) > [Yandex Identity Hub](../../index.md) > Справочник API > [REST (англ.)](../index.md) > [Organization](index.md) > ListAccessBindings

# Identity Hub API, REST: Organization.ListAccessBindings

Lists access bindings for the specified organization.

## HTTP request

```
GET https://organization-manager.api.cloud.yandex.net/organization-manager/v1/organizations/{resourceId}:listAccessBindings
```

## Path parameters

#|
||Field | Description ||
|| resourceId | **string**

Required field. ID of the resource to list access bindings for.
To get the resource ID, use a corresponding List request.
For example, use the [yandex.cloud.resourcemanager.v1.CloudService.List](../../../resource-manager/api-ref/Cloud/list.md#List) request to get the Cloud resource ID.

The maximum string length in characters is 64. ||
|#

## Query parameters {#yandex.cloud.access.ListAccessBindingsRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64)

The maximum number of results per page that should be returned. If the number of available
results is larger than `pageSize`,
the service returns a [ListAccessBindingsResponse.nextPageToken](#yandex.cloud.access.ListAccessBindingsResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100.

Acceptable values are 0 to 1000, inclusive. ||
|| pageToken | **string**

Page token. Set `pageToken`
to the [ListAccessBindingsResponse.nextPageToken](#yandex.cloud.access.ListAccessBindingsResponse)
returned by a previous list request to get the next page of results.

The maximum string length in characters is 100. ||
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

Required field. ID of the [yandex.cloud.iam.v1.Role](../../../iam/api-ref/Role/get.md#yandex.cloud.iam.v1.Role) that is assigned to the `subject`.

The maximum string length in characters is 64. ||
|| subject | **[Subject](#yandex.cloud.access.Subject)**

Required field. Identity for which access binding is being created.
It can represent an account with a unique ID or several accounts with a system identifier. ||
|#

## Subject {#yandex.cloud.access.Subject}

#|
||Field | Description ||
|| id | **string**

Required field. ID of the subject.
It can contain one of the following values:oauth
* `allAuthenticatedUsers`: A special public group that represents anyone
who is authenticated. It can be used only if the `type` is `system`.
* `allUsers`: A special public group that represents anyone. No authentication is required.
For example, you don't need to specify the IAM token in an API query.
It can be used only if the `type` is `system`.
* `group:organization:<id>:users`: A special system group that represents all members of organization
with given &lt;id&gt;. It can be used only if the `type` is `system`.
* `group:federation:<id>:users`: A special system group that represents all users of federation
with given &lt;id&gt;. It can be used only if the `type` is `system`.
* `<cloud generated id>`: An identifier that represents a user account.
It can be used only if the `type` is `userAccount`, `federatedUser` or `serviceAccount`.

The maximum string length in characters is 100. ||
|| type | **string**

Required field. Type of the subject.
It can contain one of the following values:
* `userAccount`: An account on Yandex or Yandex Connect, added to Yandex Cloud.
* `serviceAccount`: A service account. This type represents the [yandex.cloud.iam.v1.ServiceAccount](../../../iam/api-ref/ServiceAccount/get.md#yandex.cloud.iam.v1.ServiceAccount) resource.
* `federatedUser`: A federated account. This type represents a user from an identity federation, like Active Directory.
* `system`: System group. This type represents several accounts with a common system identifier.
For more information, see [Subject to which the role is assigned](../../../iam/concepts/access-control/index.md#subject).

The maximum string length in characters is 100. ||
|#