## Events for setting up a trigger {#event}

Events with bucket objects that can be tracked using a trigger:
- [Creating an object](../../storage/operations/objects/upload.md).
- [Editing an object ACL](../../storage/operations/objects/edit-acl.md).
- [Deleting an object](../../storage/operations/objects/delete.md).

### Filtering events by object {#filter}

Events are filtered using prefixes and suffixes for an object [key](../../storage/concepts/object.md#key).
* The prefix is the part of the object key that contains the beginning of the object key.
* The suffix is the part of the object key that contains the end of the object key.

Prefixes and suffixes can be any length. When using a prefix and suffix at the same time, filtering is done based on the logical `AND`: for the trigger to work, the object key must match both the prefix and suffix.