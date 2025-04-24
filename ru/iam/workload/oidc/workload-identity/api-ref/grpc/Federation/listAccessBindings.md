---
editable: false
sourcePath: en/_api-ref-grpc/iam/v1/workload/oidc/workload-identity/api-ref/grpc/Federation/listAccessBindings.md
---

# Federation, gRPC: FederationService.ListAccessBindings

Lists access bindings for the specified OIDC workload identity federation.

## gRPC request

**rpc ListAccessBindings ([access.ListAccessBindingsRequest](#yandex.cloud.access.ListAccessBindingsRequest)) returns ([access.ListAccessBindingsResponse](#yandex.cloud.access.ListAccessBindingsResponse))**

## access.ListAccessBindingsRequest {#yandex.cloud.access.ListAccessBindingsRequest}

```json
{
  "resource_id": "string",
  "page_size": "int64",
  "page_token": "string"
}
```

#|
||Field | Description ||
|| resource_id | **string**

Required field. ID of the resource to list access bindings for.

To get the resource ID, use a corresponding List request.
For example, use the [yandex.cloud.resourcemanager.v1.CloudService.List](/docs/resource-manager/api-ref/grpc/Cloud/list#List) request to get the Cloud resource ID. ||
|| page_size | **int64**

The maximum number of results per page that should be returned. If the number of available
results is larger than `page_size`,
the service returns a [ListAccessBindingsResponse.next_page_token](#yandex.cloud.access.ListAccessBindingsResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100. ||
|| page_token | **string**

Page token. Set `page_token`
to the [ListAccessBindingsResponse.next_page_token](#yandex.cloud.access.ListAccessBindingsResponse)
returned by a previous list request to get the next page of results. ||
|#

## access.ListAccessBindingsResponse {#yandex.cloud.access.ListAccessBindingsResponse}

```json
{
  "access_bindings": [
    {
      "role_id": "string",
      "subject": {
        "id": "string",
        "type": "string"
      }
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| access_bindings[] | **[AccessBinding](#yandex.cloud.access.AccessBinding)**

List of access bindings for the specified resource. ||
|| next_page_token | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListAccessBindingsRequest.page_size](#yandex.cloud.access.ListAccessBindingsRequest), use
the `next_page_token` as the value
for the [ListAccessBindingsRequest.page_token](#yandex.cloud.access.ListAccessBindingsRequest) query parameter
in the next list request. Each subsequent list request will have its own
`next_page_token` to continue paging through the results. ||
|#

## AccessBinding {#yandex.cloud.access.AccessBinding}

#|
||Field | Description ||
|| role_id | **string**

Required field. ID of the [yandex.cloud.iam.v1.Role](/docs/iam/api-ref/grpc/Role/get#yandex.cloud.iam.v1.Role) that is assigned to the `subject`. ||
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
* `serviceAccount`: A service account. This type represents the [yandex.cloud.iam.v1.ServiceAccount](/docs/iam/api-ref/grpc/ServiceAccount/get#yandex.cloud.iam.v1.ServiceAccount) resource.
* `federatedUser`: A federated account. This type represents a user from an identity federation, like Active Directory.
* `system`: System group. This type represents several accounts with a common system identifier.

For more information, see [Subject to which the role is assigned](/docs/iam/concepts/access-control/#subject). ||
|#