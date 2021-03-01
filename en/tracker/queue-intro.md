# Configuring queues

In {{ tracker-name }}, every issue is part of a queue. A queue is an area shared by related issues being worked on under a single product or pipeline. Queues can also be used as a list of issues meant for a specific team or department.

Queues help you organize issues and quickly find their assignees. For example, you can create separate queues for the HR department, a project team, and support staff.

 ![](../_assets/tracker/que.png)

Each queue can have its own unique workflow that best suits the team. To configure your pipeline, you need to set issue stages (statuses) and their order in the queue, which make up the [workflow](manager/workflow.md). Standard workflows in {{ tracker-name }} already have their own [queue templates](manager/workflows.md).

You can use advanced features to make your queue workflow more efficient:

- Set up [automated recurring actions](automation.md).
{% if audience == "internal" %}
- Configure integration with [email](manager/queue-mail.md) and [Yandex.Forms](manager/forms-integration.md).
{% endif %}
- Configure [access rights to issues in your queue](manager/queue-access.md).
- Structure queue issues using [projects](manager/projects.md), [components](manager/components.md), and [versions](manager/versions.md).

If you want to learn more about organizing your queue workflow, read [how queues can be configured to benefit support teams](support-process.md).

{% if audience == "external" %}

[Contact support](troubleshooting.md)

{% endif %}

