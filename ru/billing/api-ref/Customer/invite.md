---
editable: false
sourcePath: en/_api-ref/billing/v1/api-ref/Customer/invite.md
---

# Billing API, REST: Customer.invite
Invites customer to the specified reseller.
 

 
## HTTP request {#https-request}
```
POST https://billing.{{ api-host }}/billing/v1/customers:invite
```
 
## Body parameters {#body_params}
 
```json 
{
  "resellerId": "string",
  "name": "string",
  "invitationEmail": "string",
  "person": {
    "name": "string",
    "longname": "string",
    "phone": "string",
    "email": "string",
    "postCode": "string",
    "postAddress": "string",
    "legalAddress": "string",
    "tin": "string"
  }
}
```

 
Field | Description
--- | ---
resellerId | **string**<br><p>Required. Billing account ID of the reseller that the customer will be associated with.</p> <p>The maximum string length in characters is 50.</p> 
name | **string**<br><p>Required. Name of the customer.</p> 
invitationEmail | **string**<br><p>Required. Customer email to send invitation to.</p> 
person | **object**<br><p>Required. Person of the customer.</p> <p>Person of the customer. Contains legal information.</p> 
person.<br>name | **string**<br><p>Name of the person.</p> 
person.<br>longname | **string**<br><p>Long name of the person.</p> 
person.<br>phone | **string**<br><p>Phone of the person.</p> 
person.<br>email | **string**<br><p>Email of the person.</p> 
person.<br>postCode | **string**<br><p>Post code of the person.</p> 
person.<br>postAddress | **string**<br><p>Post address of the person.</p> 
person.<br>legalAddress | **string**<br><p>Legal address of the person.</p> 
person.<br>tin | **string**<br><p>Tax identification number of the person.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": true,
  "metadata": "object",

  //  includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": "object",
  // end of the list of possible fields

}
```
An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).
 
Field | Description
--- | ---
id | **string**<br><p>ID of the operation.</p> 
description | **string**<br><p>Description of the operation. 0-256 characters long.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
createdBy | **string**<br><p>ID of the user or service account who initiated the operation.</p> 
modifiedAt | **string** (date-time)<br><p>The time when the Operation resource was last modified.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
done | **boolean** (boolean)<br><p>If the value is ``false``, it means the operation is still in progress. If ``true``, the operation is completed, and either ``error`` or ``response`` is available.</p> 
metadata | **object**<br><p>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any.</p> 
error | **object**<br>The error result of the operation in case of failure or cancellation. <br> includes only one of the fields `error`, `response`<br>
error.<br>code | **integer** (int32)<br><p>Error code. An enum value of <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>An error message.</p> 
error.<br>details[] | **object**<br><p>A list of messages that carry the error details.</p> 
response | **object** <br> includes only one of the fields `error`, `response`<br><br><p>The normal response of the operation in case of success. If the original method returns no data on success, such as Delete, the response is <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. If the original method is the standard Create/Update, the response should be the target resource of the operation. Any method that returns a long-running operation should document the response type, if any.</p> 