---
editable: false
---

# Identity Provider API, gRPC: SynchronizationService.ListSupportedAttributes

Lists supported attributes for synchronization.

## gRPC request

**rpc ListSupportedAttributes ([ListSupportedAttributesRequest](#yandex.cloud.organizationmanager.v1.idp.ListSupportedAttributesRequest)) returns ([ListSupportedAttributesResponse](#yandex.cloud.organizationmanager.v1.idp.ListSupportedAttributesResponse))**

## ListSupportedAttributesRequest {#yandex.cloud.organizationmanager.v1.idp.ListSupportedAttributesRequest}

```json
{
  "flavor": "AttributesFlavor"
}
```

Request to list supported attributes.

#|
||Field | Description ||
|| flavor | enum **AttributesFlavor**

Required field. Flavor of attributes to list.

- `ACTIVE_DIRECTORY`: Active Directory attributes. ||
|#

## ListSupportedAttributesResponse {#yandex.cloud.organizationmanager.v1.idp.ListSupportedAttributesResponse}

```json
{
  "user_supported_attributes": [
    {
      "target_attribute": "UserTargetAttribute",
      "source_attributes": [
        {
          "type": "MappingType",
          "attributes": [
            "string"
          ]
        }
      ]
    }
  ],
  "group_supported_attributes": [
    {
      "target_attribute": "GroupTargetAttribute",
      "source_attributes": [
        {
          "type": "MappingType",
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
|| user_supported_attributes[] | **[UserSupportedAttribute](#yandex.cloud.organizationmanager.v1.idp.UserSupportedAttribute)**

List of supported user attributes. ||
|| group_supported_attributes[] | **[GroupSupportedAttribute](#yandex.cloud.organizationmanager.v1.idp.GroupSupportedAttribute)**

List of supported group attributes. ||
|#

## UserSupportedAttribute {#yandex.cloud.organizationmanager.v1.idp.UserSupportedAttribute}

Supported user attribute configuration.

#|
||Field | Description ||
|| target_attribute | enum **UserTargetAttribute**

Target attribute to map to.

- `FULL_NAME`: Full name attribute.
- `GIVEN_NAME`: Given name attribute.
- `FAMILY_NAME`: Family name attribute.
- `EMAIL`: Email attribute.
- `PHONE_NUMBER`: Phone number attribute.
- `USERNAME`: Username attribute. ||
|| source_attributes[] | **[SourceAttributes](#yandex.cloud.organizationmanager.v1.idp.SourceAttributes)**

List of source attribute configurations. ||
|#

## SourceAttributes {#yandex.cloud.organizationmanager.v1.idp.SourceAttributes}

Source attribute configuration.

#|
||Field | Description ||
|| type | enum **MappingType**

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
|| target_attribute | enum **GroupTargetAttribute**

Target attribute to map to.

- `NAME`: Name attribute.
- `DESCRIPTION`: Description attribute. ||
|| source_attributes[] | **[SourceAttributes](#yandex.cloud.organizationmanager.v1.idp.SourceAttributes)**

List of source attribute configurations. ||
|#