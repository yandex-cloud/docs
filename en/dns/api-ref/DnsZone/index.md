---
editable: false
sourcePath: en/_api-ref/dns/v1/api-ref/DnsZone/index.md
---

# Cloud DNS API, REST: DnsZone

A set of methods for managing DNS zones.

## Methods

#|
||Method | Description ||
|| [Get](get.md) | Returns the specified DNS zone. ||
|| [List](list.md) | Retrieves the list of DNS zones in the specified folder. ||
|| [Create](create.md) | Creates a DNS zone in the specified folder. ||
|| [Update](update.md) | Updates the specified DNS zone. ||
|| [Delete](delete.md) | Deletes the specified DNS zone. ||
|| [GetRecordSet](getRecordSet.md) | Returns the specified record set. ||
|| [ListRecordSets](listRecordSets.md) | Retrieves the list of record sets in the specified folder. ||
|| [UpdateRecordSets](updateRecordSets.md) | Method with strict control for changing zone state. Returns error when: ||
|| [UpsertRecordSets](upsertRecordSets.md) | Method without strict control for changing zone state. Nothing happens if deleted record doesn't exist. ||
|| [ListOperations](listOperations.md) | Lists operations for the specified DNS zone. ||
|| [ListAccessBindings](listAccessBindings.md) | Lists existing access bindings for the specified DNS zone. ||
|| [SetAccessBindings](setAccessBindings.md) | Sets access bindings for the specified DNS zone. ||
|| [UpdateAccessBindings](updateAccessBindings.md) | Updates access bindings for the specified DNS zone. ||
|| [UpdatePrivateNetworks](updatePrivateNetworks.md) | Atomically updates zone private networks ||
|#