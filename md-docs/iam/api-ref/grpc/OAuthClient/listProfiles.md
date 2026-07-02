[Документация Yandex Cloud](../../../../index.md) > [Yandex Identity and Access Management](../../../index.md) > Справочник API > [gRPC (англ.)](../index.md) > [OAuthClient](index.md) > ListProfiles

# Identity and Access Management API, gRPC: OAuthClientService.ListProfiles

Retrieves the list of profiles that define sets of allowed settings for oauth clients.

## gRPC request

**rpc ListProfiles ([ListProfilesRequest](#yandex.cloud.iam.v1.ListProfilesRequest)) returns ([ListProfilesResponse](#yandex.cloud.iam.v1.ListProfilesResponse))**

## ListProfilesRequest {#yandex.cloud.iam.v1.ListProfilesRequest}

```json
{}
```

Request message for [OAuthClientService.ListProfiles](#ListProfiles).

#|
||Field | Description ||
|| Empty | > ||
|#

## ListProfilesResponse {#yandex.cloud.iam.v1.ListProfilesResponse}

```json
{
  "profiles": [
    {
      "id": "string",
      "authentication_methods_allowed_values": [
        "string"
      ],
      "authentication_methods_default_values": [
        "string"
      ],
      "pkce_required_readonly": "bool",
      "pkce_required_default_value": "bool"
    }
  ]
}
```

Response message for [OAuthClientService.ListProfiles](#ListProfiles).

#|
||Field | Description ||
|| profiles[] | **[Profile](#yandex.cloud.iam.v1.Profile)**

List of profiles that define sets of allowed settings for oauth clients. ||
|#

## Profile {#yandex.cloud.iam.v1.Profile}

Profile defines a set of allowed settings that can be applied to an OAuthClient
(see [CreateOAuthClientRequest.profile_id](create.md#yandex.cloud.iam.v1.CreateOAuthClientRequest)).

#|
||Field | Description ||
|| id | **string**

ID of the profile. ||
|| authentication_methods_allowed_values[] | **string**

Authentication methods that are allowed to be set on the oauth client. ||
|| authentication_methods_default_values[] | **string**

Suggested default authentication methods for oauth clients bound to this profile. ||
|| pkce_required_readonly | **bool**

If true, the [OAuthClient.pkce_required](get.md#yandex.cloud.iam.v1.OAuthClient) flag cannot be changed and is fixed
to `pkce_required_default_value`. ||
|| pkce_required_default_value | **bool**

Default value of the [OAuthClient.pkce_required](get.md#yandex.cloud.iam.v1.OAuthClient) flag for oauth clients bound to this profile. ||
|#