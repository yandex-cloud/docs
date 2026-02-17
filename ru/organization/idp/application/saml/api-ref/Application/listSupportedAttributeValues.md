---
editable: false
apiPlayground:
  - url: https://organization-manager.{{ api-host }}/organization-manager/v1/idp/application/saml/applications:listSupportedAttributeValues
    method: get
    path: null
    query: null
    body: null
    definitions: null
---

# SAML Application API, REST: Application.ListSupportedAttributeValues

Returns the list of supported attribute values for SAML applications.

## HTTP request

```
GET https://organization-manager.{{ api-host }}/organization-manager/v1/idp/application/saml/applications:listSupportedAttributeValues
```

## Response {#yandex.cloud.organizationmanager.v1.idp.application.saml.ListSupportedAttributeValuesResponse}

**HTTP Code: 200 - OK**

```json
{
  "supportedAttributeValues": [
    {
      "value": "string"
    }
  ]
}
```

Response message for [ApplicationService.ListSupportedAttributeValues](#ListSupportedAttributeValues).

#|
||Field | Description ||
|| supportedAttributeValues[] | **[SupportedAttributeValue](#yandex.cloud.organizationmanager.v1.idp.application.saml.SupportedAttributeValue)**

List of supported attribute values. ||
|#

## SupportedAttributeValue {#yandex.cloud.organizationmanager.v1.idp.application.saml.SupportedAttributeValue}

A supported attribute value for SAML applications.

#|
||Field | Description ||
|| value | **string**

The attribute value. ||
|#