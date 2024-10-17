---
editable: false
sourcePath: en/_api-ref-grpc/iam/v1/saml/api-ref/grpc/Federation/list.md
---

# Identity and Access Management SAML API, gRPC: FederationService.List {#List}

Retrieves the list of federations in the specified folder.

## gRPC request

**rpc List ([ListFederationsRequest](#yandex.cloud.iam.v1.saml.ListFederationsRequest)) returns ([ListFederationsResponse](#yandex.cloud.iam.v1.saml.ListFederationsResponse))**

## ListFederationsRequest {#yandex.cloud.iam.v1.saml.ListFederationsRequest}

```json
{
  // Includes only one of the fields `cloudId`, `folderId`
  "cloudId": "string",
  "folderId": "string",
  // end of the list of possible fields
  "pageSize": "int64",
  "pageToken": "string",
  "filter": "string"
}
```

#|
||Field | Description ||
|| cloudId | **string**

ID of the cloud to list federations in.
To get the cloud ID, make a [yandex.cloud.resourcemanager.v1.CloudService.List](/docs/resource-manager/api-ref/grpc/Cloud/list#List) request.

Includes only one of the fields `cloudId`, `folderId`. ||
|| folderId | **string**

ID of the folder to list federations in.
To get the folder ID, make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/Folder/list#List) request.

Includes only one of the fields `cloudId`, `folderId`. ||
|| pageSize | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`,
the service returns a [ListFederationsResponse.nextPageToken](#yandex.cloud.iam.v1.saml.ListFederationsResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100 ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken`
to the [ListFederationsResponse.nextPageToken](#yandex.cloud.iam.v1.saml.ListFederationsResponse)
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
      "folderId": "string",
      "name": "string",
      "description": "string",
      "createdAt": "google.protobuf.Timestamp",
      "cookieMaxAge": "google.protobuf.Duration",
      "autoCreateAccountOnLogin": "bool",
      "issuer": "string",
      "ssoBinding": "BindingType",
      "ssoUrl": "string",
      "securitySettings": {
        "encryptedAssertions": "bool"
      },
      "caseInsensitiveNameIds": "bool"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| federations[] | **[Federation](#yandex.cloud.iam.v1.saml.Federation)**

List of federations. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListFederationsRequest.pageSize](#yandex.cloud.iam.v1.saml.ListFederationsRequest), use
the `nextPageToken` as the value
for the [ListFederationsRequest.pageToken](#yandex.cloud.iam.v1.saml.ListFederationsRequest) query parameter
in the next list request. Each subsequent list request will have its own
`nextPageToken` to continue paging through the results. ||
|#

## Federation {#yandex.cloud.iam.v1.saml.Federation}

A federation.
For more information, see [SAML-compatible identity federations](/docs/iam/concepts/federations).

#|
||Field | Description ||
|| id | **string**

Required field. ID of the federation. ||
|| folderId | **string**

Required field. ID of the folder that the federation belongs to. ||
|| name | **string**

Required field. Name of the federation. ||
|| description | **string**

Description of the federation. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| cookieMaxAge | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Browser cookie lifetime in seconds.
If the cookie is still valid, the management console
authenticates the user immediately and redirects them to the home page. ||
|| autoCreateAccountOnLogin | **bool**

Add new users automatically on successful authentication.
The user will get the `resource-manager.clouds.member` role automatically,
but you need to grant other roles to them.

If the value is `false`, users who aren't added to the cloud
can't log in, even if they have authenticated on your server. ||
|| issuer | **string**

Required field. ID of the IdP server to be used for authentication.
The IdP server also responds to IAM with this ID after the user authenticates. ||
|| ssoBinding | enum **BindingType**

Single sign-on endpoint binding type. Most Identity Providers support the `POST` binding type.

SAML Binding is a mapping of a SAML protocol message onto standard messaging
formats and/or communications protocols.

- `BINDING_TYPE_UNSPECIFIED`
- `POST`: HTTP POST binding.
- `REDIRECT`: HTTP redirect binding.
- `ARTIFACT`: HTTP artifact binding. ||
|| ssoUrl | **string**

Required field. Single sign-on endpoint URL.
Specify the link to the IdP login page here. ||
|| securitySettings | **[FederationSecuritySettings](#yandex.cloud.iam.v1.saml.FederationSecuritySettings)**

Federation security settings. ||
|| caseInsensitiveNameIds | **bool**

Use case insensitive Name IDs. ||
|#

## FederationSecuritySettings {#yandex.cloud.iam.v1.saml.FederationSecuritySettings}

Federation security settings.

#|
||Field | Description ||
|| encryptedAssertions | **bool**

Enable encrypted assertions. ||
|#