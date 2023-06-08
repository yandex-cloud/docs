---
editable: false
sourcePath: en/_api-ref/dns/v1/api-ref/DnsZone/index.md
---

# Cloud DNS API, REST: DnsZone methods
A set of methods for managing DNS zones.
## JSON Representation {#representation}
```json 
{
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "zone": "string",
  "privateVisibility": {
    "networkIds": [
      "string"
    ]
  },
  "publicVisibility": {}
}
```
 
Field | Description
--- | ---
id | **string**<br><p>ID of the DNS zone. Generated at creation time.</p> 
folderId | **string**<br><p>ID of the folder that the DNS zone belongs to.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
name | **string**<br><p>Name of the DNS zone. The name is unique within the folder.</p> 
description | **string**<br><p>Description of the DNS zone.</p> 
labels | **object**<br><p>DNS zone labels as ``key:value`` pairs.</p> 
zone | **string**<br><p>DNS zone suffix.</p> 
privateVisibility | **object**<br><p>Privately visible zone settings. Specifies whether records within the zone are visible from a VPC networks only.</p> <p>Configuration for privately visible zones.</p> 
privateVisibility.<br>networkIds[] | **string**<br><p>Network IDs.</p> <p>The number of elements must be in the range 0-100. The string length in characters for each value must be equal to 20.</p> 
publicVisibility | **object**<br><p>Publicly visible zone settings. Indicates whether records within the zone are publicly visible.</p> <p>Configuration for publicly visible zones.</p> 

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | Creates a DNS zone in the specified folder.
[delete](delete.md) | Deletes the specified DNS zone.
[get](get.md) | Returns the specified DNS zone.
[getRecordSet](getRecordSet.md) | Returns the specified record set.
[list](list.md) | Retrieves the list of DNS zones in the specified folder.
[listAccessBindings](listAccessBindings.md) | Lists existing access bindings for the specified DNS zone.
[listOperations](listOperations.md) | Lists operations for the specified DNS zone.
[listRecordSets](listRecordSets.md) | Retrieves the list of record sets in the specified folder.
[setAccessBindings](setAccessBindings.md) | Sets access bindings for the specified DNS zone.
[update](update.md) | Updates the specified DNS zone.
[updateAccessBindings](updateAccessBindings.md) | Updates access bindings for the specified DNS zone.
[updateRecordSets](updateRecordSets.md) | Method with strict control for changing zone state. Returns error when: 1. Deleted record is not found. 2. Found record with matched type and name but different TTL or value. 3. Attempted to add record with existing name and type. Deletions happen first. If a record with the same name and type exists in both lists, then the existing record will be deleted, and a new one added.
[upsertRecordSets](upsertRecordSets.md) | Method without strict control for changing zone state. Nothing happens if deleted record doesn't exist. Deletes records that match all specified fields which allows to delete only specified records from a record set.