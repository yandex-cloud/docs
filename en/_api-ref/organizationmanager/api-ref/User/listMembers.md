---
editable: false
---

# Cloud Organization API, REST: User.listMembers
List organization active members.
 

 
## HTTP request {#https-request}
```
GET https://organization-manager.{{ api-host }}/organization-manager/v1/organizations/{organizationId}/users
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
organizationId | <p>Required. ID of the Organization resource to list members for.</p> <p>The maximum string length in characters is 50.</p> 
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than <a href="/docs/organization/api-ref/User/listMembers#query_params">pageSize</a>, the service returns a <a href="/docs/organization/api-ref/User/listMembers#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests. Acceptable values are 0 to 1000, inclusive. Default value: 100.</p> <p>Acceptable values are 0 to 1000, inclusive.</p> 
pageToken | <p>Page token. Set <a href="/docs/organization/api-ref/User/listMembers#query_params">pageToken</a> to the <a href="/docs/organization/api-ref/User/listMembers#responses">nextPageToken</a> returned by a previous list request to get the next page of results.</p> <p>The maximum string length in characters is 2000.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "users": [
    {
      "subjectClaims": {
        "sub": "string",
        "name": "string",
        "givenName": "string",
        "familyName": "string",
        "preferredUsername": "string",
        "picture": "string",
        "email": "string",
        "zoneinfo": "string",
        "locale": "string",
        "phoneNumber": "string",
        "federation": {
          "id": "string",
          "name": "string"
        }
      }
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
users[] | **object**<br><p>List of users for the specified organization.</p> 
users[].<br>subjectClaims | **object**<br><p>OpenID standard claims with additional Cloud Organization claims.</p> <p>Claims representation, see https://openid.net/specs/openid-connect-core-1_0.html#StandardClaims for details.</p> 
users[].<br>subjectClaims.<br>sub | **string**<br><p>Required. Subject - Identifier for the End-User at the Issuer.</p> <p>The maximum string length in characters is 50.</p> 
users[].<br>subjectClaims.<br>name | **string**<br><p>End-User's full name in displayable form including all name parts, possibly including titles and suffixes, ordered according to the End-User's locale and preferences.</p> 
users[].<br>subjectClaims.<br>givenName | **string**<br><p>Given name(s) or first name(s) of the End-User. Note that in some cultures, people can have multiple given names; all can be present, with the names being separated by space characters.</p> 
users[].<br>subjectClaims.<br>familyName | **string**<br><p>Surname(s) or last name(s) of the End-User. Note that in some cultures, people can have multiple family names or no family name; all can be present, with the names being separated by space characters.</p> 
users[].<br>subjectClaims.<br>preferredUsername | **string**<br><p>Shorthand name by which the End-User wishes to be referred to at the RP, such as janedoe or j.doe. This value MAY be any valid JSON string including special characters such as @, /, or whitespace. The RP MUST NOT rely upon this value being unique, as discussed in Section 5.7.</p> 
users[].<br>subjectClaims.<br>picture | **string**<br><p>URL of the End-User's profile picture. This URL MUST refer to an image file (for example, a PNG, JPEG, or GIF image file), rather than to a Web page containing an image. Note that this URL SHOULD specifically reference a profile photo of the End-User suitable for displaying when describing the End-User, rather than an arbitrary photo taken by the End-User.</p> 
users[].<br>subjectClaims.<br>email | **string**<br><p>End-User's preferred e-mail address. Its value MUST conform to the RFC 5322 [RFC5322] addr-spec syntax. The RP MUST NOT rely upon this value being unique, as discussed in Section 5.7.</p> 
users[].<br>subjectClaims.<br>zoneinfo | **string**<br><p>String from zoneinfo ``zoneinfo`` time zone database representing the End-User's time zone. For example, Europe/Paris or America/Los_Angeles.</p> 
users[].<br>subjectClaims.<br>locale | **string**<br><p>End-User's locale, represented as a BCP47 [RFC5646] language tag. This is typically an ISO 639-1 Alpha-2 [ISO639-1] language code in lowercase and an ISO 3166-1 Alpha-2 [ISO3166-1] country code in uppercase, separated by a dash. For example, en-US or fr-CA. As a compatibility note, some implementations have used an underscore as the separator rather than a dash, for example, en_US; Relying Parties MAY choose to accept this locale syntax as well.</p> 
users[].<br>subjectClaims.<br>phoneNumber | **string**<br><p>End-User's preferred telephone number. E.164 [E.164] is RECOMMENDED as the format of this Claim, for example, +1 (425) 555-1212 or +56 (2) 687 2400. If the phone number contains an extension, it is RECOMMENDED that the extension be represented using the RFC 3966 [RFC3966] extension syntax, for example, +1 (604) 555-1234;ext=5678.</p> 
users[].<br>subjectClaims.<br>federation | **object**<br><p>User federation, non-empty only for federated users.</p> <p>Minimalistic analog of yandex.cloud.organizationmanager.v1.saml.Federation</p> 
users[].<br>subjectClaims.<br>federation.<br>id | **string**<br><p>Required. ID of the federation.</p> <p>The maximum string length in characters is 50.</p> 
users[].<br>subjectClaims.<br>federation.<br>name | **string**<br><p>Name of the federation. The name is unique within the cloud or organization</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/organization/api-ref/User/listMembers#query_params">pageSize</a>, use the <a href="/docs/organization/api-ref/User/listMembers#responses">nextPageToken</a> as the value for the <a href="/docs/organization/api-ref/User/listMembers#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own <a href="/docs/organization/api-ref/User/listMembers#responses">nextPageToken</a> to continue paging through the results.</p> 