# Structuring issues in {{ tracker-name }}

There are several ways to structure issues in {{ tracker-name }}. You can apply them individually or use several at the same time.

### Issue types

Your queue may include multiple [issue types](manager/add-ticket-type.md) with different pipelines. For instance, the <q>Basic development model</q> queue template includes the following issue types by default: <q>Task</q>, <q>Improvement</q>, <q>Bug</q>, and <q>Release</q>.

You can also add new issue types and [set up a dedicated workflow for them](manager/add-workflow.md) if needed, such as setting up their possible statuses and status transition rules.

### Links

In {{ tracker-name }}, you can [link issues to each other](user/ticket-links.md). A list of clickable issue links is displayed on the issue pages. Here is what issue links let you do:

- Decompose your issues. Break larger project chunks into standalone issues and sub-issues.

    Let's say you need to implement a new feature in your product, which implies resolving multiple smaller issues. For such cases, you can create a parent issue of the <q>New feature</q> type and link sub-issues to it.

- Display issue hierarchy. Useful if the issue can only be solved after first dealing with the blocker issue.

- Add links to issues sharing a common theme.

### Components

[Components](manager/components.md) help you group issues in a queue that are related to the same subject. When managing issues with components, you can set up a default assignee and [access rights](manager/queue-access.md#section_tbh_cs5_qbb).

### Versions

[Versions](manager/versions.md) help you group issues within the same queue based on the product version they belong to.

### Projects

Use [projects](manager/projects.md) to group issues with a common deadline and responsible employee. Projects can include issues from different queues.

