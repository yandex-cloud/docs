---
editable: false
---

# SAML Application API, gRPC: ApplicationService.ListSupportedAttributeValues

Returns the list of supported attribute values for SAML applications.

## gRPC request

**rpc ListSupportedAttributeValues ([ListSupportedAttributeValuesRequest](#yandex.cloud.organizationmanager.v1.idp.application.saml.ListSupportedAttributeValuesRequest)) returns ([ListSupportedAttributeValuesResponse](#yandex.cloud.organizationmanager.v1.idp.application.saml.ListSupportedAttributeValuesResponse))**

## ListSupportedAttributeValuesRequest {#yandex.cloud.organizationmanager.v1.idp.application.saml.ListSupportedAttributeValuesRequest}

```json
{}
```

Request to list supported attribute values for SAML applications.

#|
||Field | Description ||
|| Empty | > ||
|#

## ListSupportedAttributeValuesResponse {#yandex.cloud.organizationmanager.v1.idp.application.saml.ListSupportedAttributeValuesResponse}

```json
{
  "supported_attribute_values": [
    {
      "value": "string"
    }
  ]
}
```

Response message for [ApplicationService.ListSupportedAttributeValues](#ListSupportedAttributeValues).

#|
||Field | Description ||
|| supported_attribute_values[] | **[SupportedAttributeValue](#yandex.cloud.organizationmanager.v1.idp.application.saml.SupportedAttributeValue)**

List of supported attribute values. ||
|#

## SupportedAttributeValue {#yandex.cloud.organizationmanager.v1.idp.application.saml.SupportedAttributeValue}

A supported attribute value for SAML applications.

#|
||Field | Description ||
|| value | **string**

The attribute value. ||
|#