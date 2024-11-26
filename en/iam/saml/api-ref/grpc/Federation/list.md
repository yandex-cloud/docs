---
editable: false
sourcePath: en/_api-ref-grpc/iam/v1/saml/api-ref/grpc/Federation/list.md
---

# Identity and Access Management SAML API, gRPC: FederationService.List

Retrieves the list of federations in the specified folder.

## gRPC request

**rpc List ([ListFederationsRequest](#yandex.cloud.iam.v1.saml.ListFederationsRequest)) returns ([ListFederationsResponse](#yandex.cloud.iam.v1.saml.ListFederationsResponse))**

## ListFederationsRequest {#yandex.cloud.iam.v1.saml.ListFederationsRequest}

```json
{
  // Includes only one of the fields `cloud_id`, `folder_id`
  "cloud_id": "string",
  "folder_id": "string",
  // end of the list of possible fields
  "page_size": "int64",
  "page_token": "string",
  "filter": "string"
}
```

#|
||Field | Description ||
|| cloud_id | **string**

ID of the cloud to list federations in.
To get the cloud ID, make a [yandex.cloud.resourcemanager.v1.CloudService.List](/docs/resource-manager/api-ref/grpc/Cloud/list#List) request.

Includes only one of the fields `cloud_id`, `folder_id`. ||
|| folder_id | **string**

ID of the folder to list federations in.
To get the folder ID, make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/Folder/list#List) request.

Includes only one of the fields `cloud_id`, `folder_id`. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`,
the service returns a [ListFederationsResponse.next_page_token](#yandex.cloud.iam.v1.saml.ListFederationsResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100 ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token`
to the [ListFederationsResponse.next_page_token](#yandex.cloud.iam.v1.saml.ListFederationsResponse)
returned by a previous list request. ||
|| filter | **string**

A filter expression that filters resources listed in the response.
The expression must specify:
1. The field name. Currently you can use filtering only on the [Federation.name](#yandex.cloud.iam.v1.saml.Federation) field.
2. An `=` operator.
3. The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`. ||
|#

## ListFederationsResponse {#yandex.cloud.iam.v1.saml.ListFederationsResponse}

```json
{
  "federations": [
    {
      "id": "string",
      "folder_id": "string",
      "name": "string",
      "description": "string",
      "created_at": "google.protobuf.Timestamp",
      "cookie_max_age": "google.protobuf.Duration",
      "auto_create_account_on_login": "bool",
      "issuer": "string",
      "sso_binding": "BindingType",
      "sso_url": "string",
      "security_settings": {
        "encrypted_assertions": "bool"
      },
      "case_insensitive_name_ids": "bool"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| federations[] | **[Federation](#yandex.cloud.iam.v1.saml.Federation)**

List of federations. ||
|| next_page_token | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListFederationsRequest.page_size](#yandex.cloud.iam.v1.saml.ListFederationsRequest), use
the `next_page_token` as the value
for the [ListFederationsRequest.page_token](#yandex.cloud.iam.v1.saml.ListFederationsRequest) query parameter
in the next list request. Each subsequent list request will have its own
`next_page_token` to continue paging through the results. ||
|#

## Federation {#yandex.cloud.iam.v1.saml.Federation}

A federation.
For more information, see [SAML-compatible identity federations](/docs/iam/concepts/federations).

#|
||Field | Description ||
|| id | **string**

Required field. ID of the federation. ||
|| folder_id | **string**

Required field. ID of the folder that the federation belongs to. ||
|| name | **string**

Required field. Name of the federation. ||
|| description | **string**

Description of the federation. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| cookie_max_age | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Browser cookie lifetime in seconds.
If the cookie is still valid, the management console
authenticates the user immediately and redirects them to the home page. ||
|| auto_create_account_on_login | **bool**

Add new users automatically on successful authentication.
The user will get the `resource-manager.clouds.member` role automatically,
but you need to grant other roles to them.

If the value is `false`, users who aren't added to the cloud
can't log in, even if they have authenticated on your server. ||
|| issuer | **string**

Required field. ID of the IdP server to be used for authentication.
The IdP server also responds to IAM with this ID after the user authenticates. ||
|| sso_binding | enum **BindingType**

Single sign-on endpoint binding type. Most Identity Providers support the `POST` binding type.

SAML Binding is a mapping of a SAML protocol message onto standard messaging
formats and/or communications protocols.

- `BINDING_TYPE_UNSPECIFIED`
- `POST`: HTTP POST binding.
- `REDIRECT`: HTTP redirect binding.
- `ARTIFACT`: HTTP artifact binding. ||
|| sso_url | **string**

Required field. Single sign-on endpoint URL.
Specify the link to the IdP login page here. ||
|| security_settings | **[FederationSecuritySettings](#yandex.cloud.iam.v1.saml.FederationSecuritySettings)**

Federation security settings. ||
|| case_insensitive_name_ids | **bool**

Use case insensitive Name IDs. ||
|#

## FederationSecuritySettings {#yandex.cloud.iam.v1.saml.FederationSecuritySettings}

Federation security settings.

#|
||Field | Description ||
|| encrypted_assertions | **bool**

Enable encrypted assertions. ||
|#