# Structuring issues in {{ tracker-name }}

Any project or process is easier to manage if your work is structured. Breaking down and grouping your issues are among key methods to put your things in order.

Decomposition is breaking larger project chunks into standalone issues and sub-issues. When the workload is broken down into smaller issues, it's much easier to evaluate their complexity and required resources, distribute the issues across assignees, and schedule deadlines. In {{ tracker-name }}, you can decompose your issues using [links](user/links.md). For example, you need to implement a new feature in your product, which implies resolving multiple smaller issues. For such cases, you can create a parent issue of the <q>New feature</q> type and link sub-issues to it.

It's helpful to group issues, for example, to estimate the workload at different project stages or specify the scope of responsibility for teams and individual employees.

There are several ways to structure issues in {{ tracker-name }}. You can use them individually or combine them.

Issue queues
:  A [queue](queue-intro.md) is an area shared by related issues being worked on under a single product or pipeline. Queues can also be used as an issue list meant for a specific team or department.

    Queues enable you to order your issues and see who is responsible for their execution. For example, you can create individual queues for your HR department, project team, and support team.

    You can set up an independent issue workflow in each queue. To configure your pipeline, set issue stages (statuses) and their order in the queue, which make up their [workflow](manager/workflow.md). Standard workflows already have their own [queue templates](manager/workflows.md) in {{ tracker-name }}.

Links between issues
:   In {{ tracker-name }}, you can link issues to each other. [Links](user/links.md) help decompose issues and denote issue hierarchy.

Projects
:   Use [projects](manager/project-new.md) to group issues with a shared deadline and responsible employee. Projects may include issues from different queues.

Components
:   [Components](manager/components.md) help you group issues in a queue that relate to the same topic. When managing issues with components, you can set up a default assignee and [access rights](manager/queue-access.md#access-components).

Versions
:   [Versions](manager/versions.md) help you group issues within the same queue based on the product version they belong to.

Tags
:  A tag is a type of label that can be added manually to any issue. It is convenient to use tags to group issues by any criteria and then search for issues with preset tags. To add tags to an issue, [edit the **{{ ui-key.startrek-backend.fields.issue.tags-key-value }}** parameter](user/edit-ticket.md#edit-fields).

    {% note info %}

    The {{ tracker-name }} interface doesn't support editing and deleting tags. To delete a tag, use a [request to {{ api-name }}](concepts/queues/delete-tag.md).

    {% endnote %}
