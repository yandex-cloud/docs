# Structuring issues in {{ tracker-name }}

Any project or process is easier to manage when your workflow is structured. The primary tools to structure your workflow are decomposition and issue grouping.

Issue decomposition means breaking down larger chunks of a project into standalone issues and sub-issues. If your workload is divided into smaller, singular issues, it becomes much easier to gauge their difficulty, distribute issues among your employees and plan your deadlines. In {{ tracker-name }}, you can decompose your issues using [links](user/links.md). Let's say you need to implement a new feature in your product, which implies resolving multiple smaller issues. For such cases, you can create a parent issue of the <q>New feature</q> type and link your sub-issues to it.

Grouping issues can prove useful for determining your workload at various stages of the project or for indicating responsibilities of your various teams or individual employees.

There are several ways to structure issues in {{ tracker-name }}. You can apply them individually or use several at the same time.

Issue queues
:  A [queue](queue-intro.md) is an area shared by related issues being worked on under a single product or pipeline. Queues can also be used as an issue list meant for a specific team or department.

    Queues help you organize issues and quickly find their assignees. For example, you can create separate queues for the HR department, a project team, and support staff.
    
    Each queue can have its own unique workflow that best suits the team. To configure your pipeline, set issue stages (statuses) and their order in the queue, which make up their [workflow](manager/workflow.md). Standard workflows already have their own [queue templates](manager/workflows.md) in {{ tracker-name }}.

Links between issues
:  In {{ tracker-name }}, you can link issues to each other. [Links](user/links.md) help decompose issues and denote issue hierarchy.

Projects
:  Use [projects](manager/projects.md) to group issues with a shared deadline and responsible employee. Projects can include issues from different queues.

Components 
:  [Components](manager/components.md) help you group issues in a queue that relate to the same topic. When managing issues with components, you can set up a default assignee and [access rights](manager/queue-access.md#section_tbh_cs5_qbb).

Versions
:  [Versions](manager/versions.md) help you group issues within the same queue based on the product version they belong to.

Tags
:  A tag is a type of label that can be added manually to any issue. Tags let users group issues based on any attribute, which makes it easy to search for those issues by tag later. To add tags to an issue, [edit the **Tags**](user/edit-ticket.md#section_jqw_ppn_jz) setting.

