---
editable: false
sourcePath: en/_api-ref-grpc/organizationmanager/v1/api-ref/grpc/User/listMembers.md
---

# Identity Hub API, gRPC: UserService.ListMembers

List organization active members.

## gRPC request

**rpc ListMembers ([ListMembersRequest](#yandex.cloud.organizationmanager.v1.ListMembersRequest)) returns ([ListMembersResponse](#yandex.cloud.organizationmanager.v1.ListMembersResponse))**

## ListMembersRequest {#yandex.cloud.organizationmanager.v1.ListMembersRequest}

```json
{
  "organization_id": "string",
  "page_size": "int64",
  "page_token": "string"
}
```

#|
||Field | Description ||
|| organization_id | **string**

Required field. ID of the Organization resource to list members for. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`, the service returns a [ListMembersResponse.next_page_token](#yandex.cloud.organizationmanager.v1.ListMembersResponse)
that can be used to get the next page of results in subsequent list requests.
Acceptable values are 0 to 1000, inclusive. Default value: 100. ||
|| page_token | **string**

Page token. Set `page_token`
to the [ListMembersResponse.next_page_token](#yandex.cloud.organizationmanager.v1.ListMembersResponse)
returned by a previous list request to get the next page of results. ||
|#

## ListMembersResponse {#yandex.cloud.organizationmanager.v1.ListMembersResponse}

```json
{
  "users": [
    {
      "subject_claims": {
        "sub": "string",
        "name": "string",
        "given_name": "string",
        "family_name": "string",
        "preferred_username": "string",
        "picture": "string",
        "email": "string",
        "zoneinfo": "string",
        "locale": "string",
        "phone_number": "string",
        "sub_type": "SubjectType",
        "federation": {
          "id": "string",
          "name": "string"
        },
        "last_authenticated_at": "google.protobuf.Timestamp"
      }
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| users[] | **[OrganizationUser](#yandex.cloud.organizationmanager.v1.ListMembersResponse.OrganizationUser)**

List of users for the specified organization. ||
|| next_page_token | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListMembersRequest.page_size](#yandex.cloud.organizationmanager.v1.ListMembersRequest), use the `next_page_token` as the value
for the [ListMembersRequest.page_token](#yandex.cloud.organizationmanager.v1.ListMembersRequest) query parameter in the next list request.
Each subsequent list request will have its own `next_page_token` to continue paging through the results. ||
|#

## OrganizationUser {#yandex.cloud.organizationmanager.v1.ListMembersResponse.OrganizationUser}

#|
||Field | Description ||
|| subject_claims | **[SubjectClaims](#yandex.cloud.oauth.SubjectClaims)**

OpenID standard claims with additional Cloud Organization claims. ||
|#

## SubjectClaims {#yandex.cloud.oauth.SubjectClaims}

Claims representation, see https://openid.net/specs/openid-connect-core-1_0.html#StandardClaims for details.

#|
||Field | Description ||
|| sub | **string**

Required field. Subject - Identifier for the End-User at the Issuer. ||
|| name | **string**

End-User's full name in displayable form including all name parts, possibly including titles and suffixes, ordered according to the End-User's locale and preferences. ||
|| given_name | **string**

Given name(s) or first name(s) of the End-User. Note that in some cultures, people can have multiple given names; all can be present, with the names being separated by space characters. ||
|| family_name | **string**

Surname(s) or last name(s) of the End-User. Note that in some cultures, people can have multiple family names or no family name; all can be present, with the names being separated by space characters. ||
|| preferred_username | **string**

Shorthand name by which the End-User wishes to be referred to at the RP, such as janedoe or j.doe.
This value MAY be any valid JSON string including special characters such as @, /, or whitespace. The RP MUST NOT rely upon this value being unique, as discussed in Section 5.7. ||
|| picture | **string**

URL of the End-User's profile picture. This URL MUST refer to an image file (for example, a PNG, JPEG, or GIF image file),
rather than to a Web page containing an image. Note that this URL SHOULD specifically reference a profile photo of the End-User suitable for displaying when describing the End-User, rather than an arbitrary photo taken by the End-User. ||
|| email | **string**

End-User's preferred e-mail address. Its value MUST conform to the RFC 5322 [RFC5322] addr-spec syntax.
The RP MUST NOT rely upon this value being unique, as discussed in Section 5.7. ||
|| zoneinfo | **string**

String from zoneinfo `zoneinfo` time zone database representing the End-User's time zone. For example, Europe/Paris or America/Los_Angeles. ||
|| locale | **string**

End-User's locale, represented as a BCP47 [RFC5646] language tag. This is typically an ISO 639-1 Alpha-2 [ISO639-1] language code in lowercase and an ISO 3166-1 Alpha-2 [ISO3166-1] country code in uppercase, separated by a dash.
For example, en-US or fr-CA. As a compatibility note, some implementations have used an underscore as the separator rather than a dash, for example, en_US; Relying Parties MAY choose to accept this locale syntax as well. ||
|| phone_number | **string**

End-User's preferred telephone number. E.164 [E.164] is RECOMMENDED as the format of this Claim, for example, +1 (425) 555-1212 or +56 (2) 687 2400.
If the phone number contains an extension, it is RECOMMENDED that the extension be represented using the RFC 3966 [RFC3966] extension syntax, for example, +1 (604) 555-1234;ext=5678. ||
|| sub_type | enum **SubjectType**

Subject type.

- `SUBJECT_TYPE_UNSPECIFIED`
- `USER_ACCOUNT`
- `SERVICE_ACCOUNT`
- `GROUP`
- `INVITEE` ||
|| federation | **[Federation](#yandex.cloud.oauth.Federation)**

User federation, non-empty only for federated users. ||
|| last_authenticated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Last time the access token was created. Filled only for federated users (not for global users). ||
|#

## Federation {#yandex.cloud.oauth.Federation}

Minimalistic analog of yandex.cloud.organizationmanager.v1.saml.Federation

#|
||Field | Description ||
|| id | **string**

Required field. ID of the federation. ||
|| name | **string**

Name of the federation. The name is unique within the cloud or organization ||
|#