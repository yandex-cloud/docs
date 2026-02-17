---
editable: false
apiPlayground:
  - url: https://organization-manager.{{ api-host }}/organization-manager/v1/idp/synchronization-supported-attributes
    method: get
    path: null
    query:
      type: object
      properties:
        flavor:
          description: |-
            **enum** (AttributesFlavor)
            Required field. Flavor of attributes to list.
            - `ACTIVE_DIRECTORY`: Active Directory attributes.
          type: string
          enum:
            - ATTRIBUTES_FLAVOR_UNSPECIFIED
            - ACTIVE_DIRECTORY
      required:
        - flavor
      additionalProperties: false
    body: null
    definitions: null
---

# Identity Provider API, REST: Synchronization.ListSupportedAttributes

Lists supported attributes for synchronization.

## HTTP request

```
GET https://organization-manager.{{ api-host }}/organization-manager/v1/idp/synchronization-supported-attributes
```

## Query parameters {#yandex.cloud.organizationmanager.v1.idp.ListSupportedAttributesRequest}

Request to list supported attributes.

#|
||Field | Description ||
|| flavor | **enum** (AttributesFlavor)

Required field. Flavor of attributes to list.

- `ACTIVE_DIRECTORY`: Active Directory attributes. ||
|#

## Response {#yandex.cloud.organizationmanager.v1.idp.ListSupportedAttributesResponse}

**HTTP Code: 200 - OK**

```json
{
  "userSupportedAttributes": [
    {
      "targetAttribute": "string",
      "sourceAttributes": [
        {
          "type": "string",
          "attributes": [
            "string"
          ]
        }
      ]
    }
  ],
  "groupSupportedAttributes": [
    {
      "targetAttribute": "string",
      "sourceAttributes": [
        {
          "type": "string",
          "attributes": [
            "string"
          ]
        }
      ]
    }
  ]
}
```

Response message for [SynchronizationService.ListSupportedAttributes](#ListSupportedAttributes).

#|
||Field | Description ||
|| userSupportedAttributes[] | **[UserSupportedAttribute](#yandex.cloud.organizationmanager.v1.idp.UserSupportedAttribute)**

List of supported user attributes. ||
|| groupSupportedAttributes[] | **[GroupSupportedAttribute](#yandex.cloud.organizationmanager.v1.idp.GroupSupportedAttribute)**

List of supported group attributes. ||
|#

## UserSupportedAttribute {#yandex.cloud.organizationmanager.v1.idp.UserSupportedAttribute}

Supported user attribute configuration.

#|
||Field | Description ||
|| targetAttribute | **enum** (UserTargetAttribute)

Target attribute to map to.

- `FULL_NAME`: Full name attribute.
- `GIVEN_NAME`: Given name attribute.
- `FAMILY_NAME`: Family name attribute.
- `EMAIL`: Email attribute.
- `PHONE_NUMBER`: Phone number attribute.
- `USERNAME`: Username attribute. ||
|| sourceAttributes[] | **[SourceAttributes](#yandex.cloud.organizationmanager.v1.idp.SourceAttributes)**

List of source attribute configurations. ||
|#

## SourceAttributes {#yandex.cloud.organizationmanager.v1.idp.SourceAttributes}

Source attribute configuration.

#|
||Field | Description ||
|| type | **enum** (MappingType)

Type of mapping.

- `DIRECT`: Direct mapping from source to target.
- `EMPTY`: Empty mapping (no source attribute). ||
|| attributes[] | **string**

List of source attribute names. Empty for EMPTY type. ||
|#

## GroupSupportedAttribute {#yandex.cloud.organizationmanager.v1.idp.GroupSupportedAttribute}

Supported group attribute configuration.

#|
||Field | Description ||
|| targetAttribute | **enum** (GroupTargetAttribute)

Target attribute to map to.

- `NAME`: Name attribute.
- `DESCRIPTION`: Description attribute. ||
|| sourceAttributes[] | **[SourceAttributes](#yandex.cloud.organizationmanager.v1.idp.SourceAttributes)**

List of source attribute configurations. ||
|#