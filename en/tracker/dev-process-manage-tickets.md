# Structuring issues in {{ tracker-name }}

There are several ways to structure issues in {{ tracker-name }}. You can use them individually or combine them.

### Issue types

Your queue may include multiple [issue types](manager/add-ticket-type.md) with different pipelines. For instance, the <q>Basic development model</q> queue template includes the following issue types by default: <q>Issue</q>, <q>Improvement</q>, <q>Error</q>, <q>Release</q>, and [<q>Milestone</q>](manager/milestones.md).

You can also add new issue types and [set up a dedicated workflow](manager/add-workflow.md) for them if needed, such as setting up their possible statuses and status transition rules.

### Links

In {{ tracker-name }}, you can [link issues to each other](user/ticket-links.md). A list of links with their URLs is shown on the issue page. Use links:

- To decompose your issues: Break larger project chunks into standalone issues and sub-issues.

   For example, you need to implement a new feature in your product, which implies resolving multiple smaller issues. For such cases, you can create a parent issue of the <q>New feature</q> type and link sub-issues to it.

- To show dependencies between issues (if an issue can only be completed after its blocker is completed).

- To add links to issues that share the same subject.

### Components

[Components](manager/components.md) help you group issues in a queue that relate to the same topic. When managing issues with components, you can set up a default assignee and [access rights](manager/queue-access.md#access-components).

### Versions

[Versions](manager/versions.md) help you group issues within the same queue based on the product version they belong to.

### Projects

Use [projects](manager/project-new.md) to group issues with a common deadline and responsible employee. Projects may include issues from different queues.