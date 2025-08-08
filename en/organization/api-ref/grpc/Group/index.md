---
editable: false
sourcePath: en/_api-ref-grpc/organizationmanager/v1/api-ref/grpc/Group/index.md
---

# Identity Hub API, gRPC: GroupService

A set of methods for managing groups.

## Methods

#|
||Method | Description ||
|| [Get](get.md) | Returns the specified Group resource. ||
|| [ResolveExternal](resolveExternal.md) | Returns external group by subject container and external id ||
|| [List](list.md) | Retrieves the list of group resources. ||
|| [ListExternal](listExternal.md) | Retrieves the list of external group linked subject container ||
|| [Create](create.md) | Creates a group in the specified organization. ||
|| [CreateExternal](createExternal.md) | Creates an external group. ||
|| [Update](update.md) | Updates the specified group. ||
|| [ConvertToExternal](convertToExternal.md) | Converts single basic (not external) group to external. Precondition: group must be basic. ||
|| [ConvertAllToBasic](convertAllToBasic.md) | Converts all groups that belongs to subject container from external to basic (not external). ||
|| [Delete](delete.md) | Deletes the specified group. ||
|| [ListOperations](listOperations.md) | Lists operations for the specified group. ||
|| [ListMembers](listMembers.md) | List group active members. ||
|| [UpdateMembers](updateMembers.md) | Update group members. ||
|| [ListAccessBindings](listAccessBindings.md) | Lists access bindings for the specified group. ||
|| [SetAccessBindings](setAccessBindings.md) | Sets access bindings for the specified group. ||
|| [UpdateAccessBindings](updateAccessBindings.md) | Updates access bindings for the specified group. ||
|#