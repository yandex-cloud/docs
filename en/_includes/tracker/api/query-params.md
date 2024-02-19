In the query `fields` parameter, specify one or more values:

| Field | Description |
-------- | --------
| summary | Entity name |
| description | Entity description |
| author | Author (user ID) |
| lead | Responsible person (user ID) |
| teamUsers | Participants (array of user IDs) |
| clients | Customers (array of user IDs) |
| followers | Followers (array of user IDs) |
| start | Start Date |
| end | Deadline |
| checklistItems | Checklists |
| tags | Tags |
| parentEntity | Parent entity (portfolio) ID |
| teamAccess | Access |
| quarter | Project start and end quarters |
| entityStatus | Status |
| issueQueues | Issue queues within the project |

> For example, you can configure the response to include a project description and checklist items information:
>
> ```
> POST /{{ ver }}/entities/<entity_type>/<entity_ID>/checklistItems?fields=description&fields=checklistItems
> ```

The response body will include the requested information in JSON format.
