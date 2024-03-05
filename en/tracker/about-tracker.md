---
title: "How {{ tracker-name }} works"
description: "In this section, you will learn how {{ tracker-name }} works and how you can use {{ tracker-name }} to suit your workflow. Organizing your workflow in {{ tracker-name }} requires managing two crucial elements: issues and queues. Issues describe what needs to be done, while queues set the rules for working with issues."
---

# How {{ tracker-name }} works

In this section, you will learn how {{ tracker-name }} works and how you can use {{ tracker-name }} to suit your workflow.


Before you start, check the {{ tracker-name }} setup guide in [{#T}](quick-start.md).


## {{ tracker-name }} structure {#blocks}

Organizing your workflow in {{ tracker-name }} requires managing two crucial elements: _issues_ and _queues_. Issues describe what needs to be done, while queues set the rules for working with issues.

Additional elements, such as components, issue boards, and dashboards, allow you to manage issues, monitor their status, and keep track of results. An overview of these features is given below.

![](../_assets/tracker/concept-structure.png)

#### Issue

To manage your team's workload via {{ tracker-name }}, you need to break it down into smaller chunks called issues. These may include adding a new feature to your app, managing a support service request from a client, creating a new logo, or applying for a business trip.

An issue has a name, assignee, deadline, and other parameters. Issues may be linked or subordinate to each other.

If you want your team member to do some work, create an issue and make this employee the issue's assignee.

#### Queue

Queues combine issues that share a common topic (be it a process, product, and so on) and let users configure a [workflow](#process) for the issues. In each queue, you can set up the stages of working with issues, rules for automatic issue processing, and issue access rights.

Every team usually has its own workflow, so we recommend creating separate queues for your teams or company divisions. You can create queues for the development department, design team, or legal department. This way, a queue becomes a flow of issues to be handled by a certain team. For instance, if you need a new logo to be designed, create an issue in the designer queue.

![](../_assets/tracker/que.png)

## Organizing your workflow in {{ tracker-name }} {#process}

A workflow for an issue usually involves multiple stages. For example, creating an issue, resolving it, approving its results, and completing the work.

In {{ tracker-name }}, each issue stage refers to a certain _status_, e.g., **{{ ui-key.startrek-backend.applinks.samsara.status.open }}**, **{{ ui-key.startrek-backend.applinks.samsara.status.in.progress }}**, **{{ ui-key.startrek-backend.presets.advancedDevelopment.board.column.testing }}**, or **{{ ui-key.startrek-backend.applinks.samsara.status.closed }}**. To set your pipeline up around {{ tracker-name }}, you need to configure your _workflow_, which is a set of statuses an issue goes through from creation to completion as well as specific rules of transitioning between those statuses.

Your workflow is linked to your issue queue. If you need to set up multiple workflows for different teams, you can [create individual queues for them](manager/create-queue.md). You can also add multiple [issue types](manager/add-ticket-type.md) to a single queue and set up an exclusive workflow for each type.

{{ tracker-name }} also provides [queue templates](manager/workflows.md) with preset workflows tailored for various processes to help you get started. A universal workflow looks as follows:

![](../_assets/tracker/Workflow.png)

You can [create unique workflows](manager/add-workflow.md) tailored for specific issues. Try not to overload them with unnecessary statuses: the simpler the workflow, the more easier it is to handle it.

Apart from workflows, you can configure the following in the queue: [access rights to issues](manager/queue-access.md), [automated issue processing](./automation.md), integration with  [{{ forms-full-name }}](manager/forms-integration.md), etc. These features allow you to flexibly configure queues to suit your team's tasks.

For some examples on how you can set up workflows in {{ tracker-name }}, see the following sections:

- [{#T}](dev-process.md)
- [{#T}](support-process.md)


## Grouping and sorting issues {#group}

Grouping issues is useful, for example, to estimate the workload at different project stages or specify the scope of responsibility for teams and individual employees.

![](../_assets/tracker/concept-group.png)

You can use {{ tracker-name }} to group issues by the following criteria:

- [Components](manager/components.md) help you group issues in a queue that relate to the same topic. When managing issues with components, you can set up a default assignee and [access rights](manager/queue-access.md#access-components).
   For example, using components, you can [classify requests to technical support](support-process-group.md).
- [Versions](manager/versions.md) help you group issues within the same queue based on the product version they belong to.
   For example, to schedule a bug fix for a specific product release, you can specify the product version in the **{{ ui-key.startrek-backend.fields.issue.fixVersions-key-value }}** field.
- A tag is a type of label that can be added manually to any issue. You can use tags to group issues by any attribute and then search for issues with preset tags. To add tags to an issue, [edit the **Tags** parameter](user/edit-ticket.md#edit-fields).


## Planning your workload {#in-order}

There are multiple ways to plan your workload in {{ tracker-name }}:
- [Creating projects](#in-order-create-project)
- [Decomposing issues](#in-order-decompose-task)
- [Dividing your workload into sprints](#in-order-divide-work)
- [Planning deadlines using a Gantt chart](#in-order-gantt)

#### Creating projects {#in-order-create-project}

A project is any activity with fixed objectives and timeframes.

[Use projects in {{ tracker-name }}](manager/project-new.md) to combine issues that have a common goal to be completed within a given deadline. You can set a project's deadline and appoint an employee responsible for the project. Projects may include issues from different queues.

#### Decomposing issues {#in-order-decompose-task}

To estimate the amount of work to be done to implement a project or create a new product version, decompose issues.

Decomposition is breaking larger project chunks into standalone issues and sub-issues. When the workload is broken down into smaller issues, it's much easier to evaluate their complexity and required resources, distribute the issues across assignees, and schedule deadlines. In {{ tracker-name }}, you can decompose your issues using [links](user/links.md). For example, you need to implement a new feature in your product, which implies resolving multiple smaller issues. For such cases, you can create a **New feature** parent issue and link sub-issues to it.

#### Dividing your workload into sprints {#in-order-divide-work}
If your product or project development is long-term and you have no fixed workload and deadline, you can plan your work using sprints.

In [Scrum]({{ link-wiki-scrum }}), sprints are small iterative cycles of development that last 1 to 4 weeks. When a sprint starts, your team assesses the complexity of issues stored in the [backlog](glossary.md#rus-b) and selects the issues to be completed within the current sprint. Short iterations let you estimate deadlines for your work more accurately and, if necessary, change your priorities on the fly.

To use this planning strategy, [create a **Scrum** issue board](manager/create-agile-board.md). Using the board, you can [manage sprints](manager/create-agile-sprint.md), [estimate issues with planning poker](manager/planning-poker.md), and use [burn down charts](manager/burndown.md).

#### Planning deadlines using a Gantt chart {#in-order-gantt}

You can use a [Gantt chart](gantt/overview.md) to plan and monitor deadlines for multiple issues on a single page. For example, when issues need to be handled in a certain sequence or when multiple issues are assigned to one employee.

You can create a Gannt chart for a project, a queue, or a list of issues found using a filter. The chart displays the work start and end dates as horizontal lines. You can set or change them right on the chart.

## Monitoring results {#control}

{{ tracker-name }} offers several tools that let users view all issue-related data quickly and easily, monitor progress, and keep track of results.

![](../_assets/tracker/concept-control.png)

#### Dashboards {#dash}
A dashboard is a page that helps users monitor the status of important issues and view statistics. You can customize your dashboard and add [widgets](glossary.md#rus-v) that display data you wish to track. Widgets receive issue-related data automatically and display it as a list of issues, a table, or a chart.

See an example of setting up a dashboard in [{#T}](support-process-dashboards.md).

#### Issue boards {#boards}
You can easily monitor issues assigned to your team on an [issue board](manager/create-agile-board.md). Issues are displayed on the board as cards with basic issue parameters. Issue cards are placed in columns corresponding to issue statuses.

You can use the issue board for any issues, not necessarily related to software development. If you're not working with [Scrum]({{ link-wiki-scrum }}) or [Kanban]({{ link-wiki-kanban }}), try using a basic board.

#### Subscriptions and notifications {#subscriptios}
{{ tracker-name }} sends you notifications about issue changes by default. You can [configure the list of events](user/notification-settings.md) that you want to get notifications for.

You can [subscribe to notifications](user/subscribe.md) and not miss any updates in a queue, component, or issues of other users.

#### Searching for issues {#search}
You can search for issues by any parameter or a combination of parameters using filters.

{{ tracker-name }} includes system filters that help you [find your issues](user/default-filters.md).

If you often need to search for issues with specific parameters, you can [create and save a custom filter](user/create-filter.md). For example, you can use custom filters to find all issues in queues where you have the author or assignee status.