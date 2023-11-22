---
sourcePath: en/tracker/api-ref/concepts/queues/change-trigger-conditions.md
---
# Trigger condition objects

To set trigger conditions, specify one or more objects.

## Events {#events}

| Parameter | Description | Acceptable values | Data type |
----- | ----- | ----- | -----
| type | Condition type | Possible values:<ul><li>`Event.update`: Issue changed.</li><li>`CalculationFormulaWatch`: Formula fields changed.</li><li>`Event.comment-create`: Comment created.</li><li>`Event.create`: Issue created.</li></ul> | String |

> For example:
> ```
> {"type": "Event.update"}
> ```


## Checklist {#checklist}

| Parameter | Description | Acceptable values | Data type |
----- | ----- | ----- | -----
| type | Condition type | `ChecklistDone` | String |

> For example:
> ```
> {"type": "ChecklistDone"}
> ```


## Comment Text {#comment-text}

| Parameter | Description | Acceptable values | Data type |
----- | ----- | ----- | -----
| type | Condition type | Possible values:<ul><li>`CommentNoneMatchCondition`: Doesn't contain any fragments.</li><li>`CommentStringNotMatchCondition`: Doesn't contain the fragment.</li><li>`CommentFullyMatchCondition`: Matches.</li><li>`CommentAnyMatchCondition`: Contains any of the fragments.</li><li>`CommentStringMatchCondition`: Contains the fragment.</li></ul> | String |
| word | Text of the comment | Strings to search | String or Array of strings |
| ignoreCase | Ignore case | `true` or `false` | Logical |
| removeMarkup | Ignore markup | `true` or `false` | Logical |
| noMatchBefore | Didn't match before | `true` or `false` | Logical |

**Type of data depending on the condition type**

| Condition type | Data type |
----- | ----- 
| `CommentNoneMatchCondition` | Array of strings |
| `CommentStringNotMatchCondition` | String |
| `CommentFullyMatchCondition` | String |
| `CommentAnyMatchCondition` | Array of strings |
| `CommentStringMatchCondition` | String |

> For example:
> ```
> {
> 	"type": "CommentNoneMatchCondition", 
> 	"words": ["Version 0.1", "Version 0.2"], 
> 	"ignoreCase": true, 
> 	"removeMarkup": true, 
> 	"noMatchBefore": false 
> }
> ```


## Comment author {#comment-author}

| Parameter | Description | Acceptable values | Data type |
----- | ----- | ----- | -----
| type | Condition type | Possible values:<ul><li>`CommentAuthorNot`: Field value isn't equal to.</li><li>`CommentAuthor`: Field value is equal to.</li></ul> | String |
| user | Comment author | User ID | String |

> For example:
> ```
> { "type": "CommentAuthorNot", "user": "user1" }
> ```

## Comment type {#comment-type}

| Parameter | Description | Acceptable values | Data type |
----- | ----- | ----- | -----
| type | Condition type | Possible values:<ul><li>`CommentMessageInternal`: Comment in Tracker</li><li>`CommentMessageExternal`: Email</li></ul> | String |
| user | Comment author | User ID | String |

> For example:
> ```
> { "type": "CommentMessageInternal" }
> ```


## Action with link {#relationship}

| Parameter | Description | Acceptable values | Data type |
----- | ----- | ----- | -----
| type | Condition type | Possible values:<ul><li>`UpdatedLinkCondition`: Link updated.</li><li>`CreatedLinkCondition`: Link created.</li><li>`RemovedLinkCondition`: Link deleted.</li></ul> | String |
| relationship | Type of links between issues | Link list | Array of strings |

{% cut "Link types" %}

* `relates`: Simple link.
* `is dependent by`: The current issue blocks the linked one.
* `depends on`: The current issue depends on the linked one.
* `is subtask for`: The current issue is a sub-issue of the linked one.
* `is parent task for`: The current issue is a parent issue of the linked one.
* `duplicates`: The current issue duplicates the linked one.
* `is duplicated by`: The linked issue duplicates the current one.
* `is epic of`: The current issue is an epic of the linked one. You can only set this type of link for Epic-type issues.
* `has epic`: The linked issue is an epic of the current one. You can only set this type of link for Epic-type issues.

{% endcut %}

> For example:
> ```
> { "type": "RemovedLinkCondition", "relationship": ["is parent task for", "is epic of"] }
> ```


## Issue fields {#task-fields}

In general, a trigger condition linked to an issue field can be described using an object with two required parameters:

| Parameter | Description | Acceptable values | Data type |
----- | ----- | ----- | -----
| type | Condition type | <condition_ID> | String |
| field | Issue field | <field_ID> | String |

An object may also contain additional parameters.

Possible values of condition types depend on specific issue fields. Additional object parameters depend on a combination of required parameters.

### Field value

For most fields, the following three condition types associated with a field value are available:

| Condition type | Description | Additional parameters | Data type |
----- | ----- | ----- | -----
| `FieldChangedCondition` | Field value changed | Without parameters | &nbsp; |
| `FieldEquals` | is equal to | `value` | String |
| `FieldBecameEqual` | became equal to | `value` | String |

{% cut "List of fields that conditions apply to" %}

| Field | ID |
----- | ----- 
| Queue | queue |
| Type | type |
| Priority | priority |
| Key | key |
| Issue | summary |
| Description \* | description |
| Status | status |
| Resolution | resolution |
| Status Changed | statusStartTime |
| Created | createdAt |
| Updated | updatedAt |
| Resolved | resolvedAt |
| Last Comment | lastCommentUpdatedAt |
| Deadline | deadline |
| Start Date | start |
| End Date | end |
| Author | createdBy |
| Assignee | assignee |
| Followers | followers |
| Access | access |
| Updated by | updatedBy |
| Resolved by | resolvedBy |
| Mailing lists | followingMaillists |
| Project | project |
| Tags | tags |
| Components | components |
| Affected Version | affectedVersions |
| Fix Version | fixVersions |
| Parent issue | parent |
| Old queue | previousQueue |
| Voted By | votedBy |
| Votes | votes |
| Number of comments without message | commentWithoutExternalMessageCount |
| Number of comments with message | commentWithExternalMessageCount |
| Boards | boards |
| Pending reply from | pendingReplyFrom |
| Previous queue | lastQueue |
| Total participation percentage | participantPercentsTotal |
| Possible spam | possibleSpam |
| Status type | statusType |
| QA Engineer | qaEngineer |
| Original Estimate | originalEstimation |
| Estimate | estimation |
| Time Spent | spent |
| Epic | epic |
| Story Points | storyPoints |
| Sprint | sprint |
| Email from \* | emailFrom |
| Email To | emailTo |
| Email CC | emailCc |
| Created by email to \* | emailCreatedBy |

\* For the fields marked with an asterisk, the **Is equal to the string** (`FieldEqualsString`) condition type is used instead of **is equal to** (`FieldEquals`).

{% endcut %}

> Examples:
> ```
> { "type": "FieldChangedCondition", "field": "Priority" }
> { "type": "FieldEquals", "field": "Priority", "value": "blocker" }
> { "type": "FieldBecameEqual", "field": "Priority", "value": "blocker" }
> ```

### Field state

Conditions related to whether a field contains a value:

| Condition type | Description | Additional parameters |
----- | ----- | ----- 
| `FieldIsNotEmpty` | Field value is not empty | Without parameters |
| `FieldIsEmpty` | Field value is empty | Without parameters |
| `FieldBecameEmpty` | Field value deleted | Without parameters |
| `FieldBecameNotEmpty` | Field value set | Without parameters |

{% cut "List of fields that conditions apply to" %}

| Field | ID |
----- | ----- 
| Description | description |
| Resolution | resolution |
| Status Changed | statusStartTime |
| Resolved | resolvedAt |
| Last Comment | lastCommentUpdatedAt |
| Deadline | deadline |
| Start Date | start |
| End Date | end |
| Assignee | assignee |
| Followers | followers |
| Access | access |
| Resolved by | resolvedBy |
| Mailing lists | followingMaillists |
| Project | project |
| Tags | tags |
| Components | components |
| Affected Version | affectedVersions |
| Fix Version | fixVersions |
| Parent issue | parent |
| Old queue | previousQueue |
| Voted By | votedBy |
| Boards | boards |
| Pending reply from | pendingReplyFrom |
| Previous queue | lastQueue |
| Total participation percentage | participantPercentsTotal |
| Possible spam | possibleSpam |
| Status type | statusType |
| QA Engineer | qaEngineer |
| Original Estimate | originalEstimation |
| Estimate | estimation |
| Time Spent | spent |
| Epic | epic |
| Story Points | storyPoints |
| Sprint | sprint |
| Email From | emailFrom |
| Email To | emailTo |
| Email CC | emailCc |
| Created by email to | emailCreatedBy |

{% endcut %}

> Examples:
> ```
> { "type": "FieldIsNotEmpty", "field": "assignee" }
> { "type": "FieldIsEmpty", "field": "assignee" }
> { "type": "FieldBecameEmpty", "field": "assignee" } 
> { "type": "FieldBecameNotEmpty", "field": "assignee" } 
> ```


### Date

Conditions related to dates:

| Condition type | Description | Additional parameters | Data type |
----- | ----- | ----- | -----
| `DateEqualCondition` | The date matches | `value` | String in date format |
| `DateGreaterCondition` | Later than the date | `value` | String in date format |
| `DateGreaterOrEqualCondition` | Later than or equal to | `value` | String in date format |
| `DateLessCondition` | Earlier than | `value` | String in date format |
| `DateLessOrEqualCondition` | Earlier than or equal to | `value` | String in date format |

{% cut "List of fields that conditions apply to" %}

| Field | ID |
----- | ----- 
| Status Changed | statusStartTime |
| Created | createdAt |
| Updated | updatedAt |
| Resolved | resolvedAt |
| Last Comment | lastCommentUpdatedAt |
| Deadline | deadline |
| Start Date | start |
| End Date | end |

{% endcut %}

> Examples:
> ```
> { "type": "DateEqualCondition", "field": "resolvedAt", "value": "2023-10-28T09:25:00"} 
> { "type": "DateGreaterCondition", "field": "resolvedAt", "value": "2023-10-28T09:25:00"}
> { "type": "DateGreaterOrEqualCondition", "field": "resolvedAt", "value": "2023-10-28T09:25:00"}
> { "type": "DateLessCondition", "field": "resolvedAt", "value": "2023-10-28T09:25:00"}
> { "type": "DateLessOrEqualCondition", "field": "resolvedAt", "value": "2023-10-28T09:25:00"}
> ```

### User groups

Conditions related to dates:

| Condition type | Description | Additional parameters | Data type |
----- | ----- | ----- | -----
| `UserInGroups` | The user is a member of one of the groups. | `value` | String or Array of strings |
| `UserNotInGroups` | The user isn't a member of any of the groups. | `value` | String or Array of strings |

{% cut "List of fields that conditions apply to" %}

| Field | ID |
----- | ----- 
| Author | createdBy |
| Assignee | assignee |
| Updated by | updatedBy |
| Resolved by | resolvedBy |
| QA Engineer | qaEngineer |

{% endcut %}

> Examples:
> ```
> {"type": "UserInGroups", "field": "createdBy","value": "1"}
> {"type": "UserNotInGroups", "field": "createdBy","value": ["1", "4"]}
> ```

### Number of elements

Conditions related to element count:

| Condition type | Description | Additional parameters | Data type |
----- | ----- | ----- | ----- 
| `Container.SizeGreater` | The number of elements is greater than | `value` | Number |
| `Container.SizeGreaterOrEquals` | The number of elements is greater than or equal to | `value` | Number |
| `Container.SizeLess` | The number of elements is less than | `value` | Number |
| `Container.SizeLessOrEquals` | The number of elements is less than or equal to | `value` | Number |
| `Container.SizeNotEquals` | The number of elements is not equal to | `value` | Number |
| `Container.SizeEquals` | The number of elements is equal to | `value` | Number |
| `ContainerContainsNone` | Doesn't contain any elements | <ul><li>`value`</li><li>`noMatchBefore`</li></ul> | <ul><li>Array</li><li>Logical</li></ul> |
| `ContainerContainsAll` | Contains all elements | <ul><li>`value`</li><li>`noMatchBefore`</li></ul> | <ul><li>Array</li><li>Logical</li></ul> |
| `ContainerContainsAny` | Contains any of the elements | <ul><li>`value`</li><li>`noMatchBefore`</li></ul> | <ul><li>Array</li><li>Logical</li></ul> |

{% cut "List of fields that conditions apply to" %}

| Field | ID |
----- | ----- 
| Followers | followers |
| Access | access |
| Tags | tags |
| Components | components |
| Affected Version | affectedVersions |
| Fix Version | fixVersions |
| Voted By | votedBy |
| Boards | boards |
| Pending reply from | pendingReplyFrom |
| Sprint | sprint |
| Email CC | emailCc |
| Email To | emailTo |
| Mailing lists | followingMaillists |

{% endcut %}

> Examples:
> ```
> { "type": "Container.SizeGreater", "field": "followers", "value": 5 }
> { "type": "Container.SizeGreaterOrEquals", "field": "followers", "value": 5 }
> { "type": "Container.SizeLess", "field": "followers", "value": 5 }
> { "type": "Container.SizeLessOrEquals", "field": "followers", "value": 5 }
> { "type": "Container.SizeNotEquals", "field": "followers", "value": 5 }
> { "type": "Container.SizeEquals", "field": "followers", "value": 5 }
> { "type": "ContainerContainsNone", "field": "followers", "value": ["user11"], "noMatchBefore": false }
> { "type": "ContainerContainsAll", "field": "followers", "value": ["user11", "user22"], "noMatchBefore": false }
> { "type": "ContainerContainsAny", "field": "followers", "value": ["user33", "user35"], "noMatchBefore": false }
> ```


### Numeric values

Conditions related to numeric values:

| Condition type | Description | Additional parameters | Data type |
----- | ----- | ----- | ----- 
| `GreaterCondition` | is greater than | `value` | Number |
| `GreaterOrEqualCondition` | is greater than or equal to | `value` | Number |
| `LessCondition` | is less than | `value` | Number |
| `LessOrEqualCondition` | is less than or equal to | `value` | Number |
| `BecameGreaterCondition` | became greater than | `value` | Number |
| `BecameGreaterOrEqualCondition` | became greater than or equal to | `value` | Number |
| `BecameLessCondition` | became less than | `value` | Number |
| `BecameLessOrEqualCondition` | became less than or equal to | `value` | Number |

{% cut "List of fields that conditions apply to" %}

| Field | ID |
----- | ----- 
| Votes | votes |
| Number of comments without message | commentWithoutExternalMessageCount |
| Number of comments with message | commentWithExternalMessageCount |
| Total participation percentage | participantPercentsTotal |
| Possible spam | possibleSpam |
| Original Estimate | originalEstimation |
| Estimate | estimation |
| Time Spent | spent |
| Story Points | storyPoints |

{% endcut %}

> Examples:
> ```
> { "type": "GreaterCondition", "field": "spent", "value": 50400000 },
> { "type": "GreaterOrEqualCondition", "field": "spent", "value": 50400000 }, 
> { "type": "LessCondition", "field": "spent", "value": 50400000 }, 
> { "type": "LessOrEqualCondition", "spent", "value": 50400000 }, 
> { "type": "BecameGreaterCondition", "field": "votes", "value": 6 },
> { "type": "BecameGreaterOrEqualCondition", "field": "votes", "value": 6 },
> { "type": "BecameLessCondition", "field": "votes", "value": 6 },
> { "type": "BecameLessOrEqualCondition", "field": "votes", "value": 6 }
> ```


### String values

Conditions related to string values:

| Condition type | Description | Additional parameters | Data type |
----- | ----- | ----- | ----- 
| `ContainsNoneOfStrings` | Doesn't contain any fragments | <ul><li>`value`</li><li>`ignoreCase`</li></ul> | <ul><li>Array</li><li>Logical</li></ul> |
| `FieldEqualsString` | Is equal to the string | <ul><li>`value`</li><li>`ignoreCase`</li></ul> | <ul><li>String</li><li>Logical</li></ul> |
| `ContainsAnyOfStrings` | Contains any of the fragments | <ul><li>`value`</li><li>`ignoreCase`</li></ul> | <ul><li>Array</li><li>Logical</li></ul> |

{% cut "List of fields that conditions apply to" %}

| Field | ID |
----- | ----- 
| Key | key |
| Issue | summary |
| Description | description |
| Email From | emailFrom |
| Created by email to | emailCreatedBy |

{% endcut %}

> Examples:
> ```
> { "type": "ContainsNoneOfStrings", "field": "summary", "value": ["Test task", "Test Version"], "ignoreCase": true }
> { "type": "FieldEqualsString", "field": "summary", "value": "New Task", "ignoreCase": false }
> { "type": "ContainsAnyOfStrings", "field": "summary", "value": ["Test task", "Test Version", "New Task"], "ignoreCase": false } 
> ```

