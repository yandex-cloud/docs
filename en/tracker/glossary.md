# Concepts

In this section, you will find the basic terms and concepts used in {{ tracker-name }} and this Help.

## B {#rus-b}

Backlog
:   A list of issues or product requirements that must be completed in the project. Backlog issues are usually sorted by priority.

## V {#rus-v}

Version
:   A parameter that lets you group issues pertaining to the same version of a product. Version values can be [configured on the queue page](manager/versions.md).

Widget
:   An information block located on the [dashboard](#dashboard-definition) that automatically receives issue-related data and displays it as a list, table, or chart. [Learn more about widgets.](user/widgets.md)

Workflow
:   A set of possible issue statuses and status transition rules. Queue settings for issues of various types let users [choose preset workflows](manager/add-ticket-type.md) or [create custom ones](manager/add-workflow.md).

## A {#rus-g}

Agile methodologies {#agile}
:   Team work strategies that follow iterative development at their core, breaking the workload down into smaller cycles called sprints. There are various {% if lang == "ru" %}[Agile development approaches]({{ link-wiki-agile }}){% else %}[Agile development approaches]({{ link-wiki-agile-en }}){% endif %}, such as [Scrum]({{ link-wiki-scrum }}) and [Kanban]({{ link-wiki-kanban }}). In {{ tracker-name }}, agile tools are grouped on [issue boards](manager/agile.md).

## D {#rus-d}

Dashboard {#dashboard-definition}
:  Page that helps users monitor the status of important issues and view statistics. You can add issue lists, tables, charts, and notes to the dashboard. [Learn more about dashboards](user/dashboard.md).

Issue board
:   Boards help users easily monitor and update issue statuses. On the board, issues are shown as cards distributed across columns of the board depending on their status. [Learn more about boards.](user/agile.md)

## I {#rus-z}

Issue
:   In {{ tracker-name }}, issues can be used to register tasks, requests, and other types of work. An issue has a name, assignee, deadline, and other parameters. Learn more about [creating issues](user/create-ticket.md) and [managing issues](user/ticket-in-progress.md).

## K {#rus-k}

Key (queue key and issue key)
:   Queue key is a unique code consisting of Latin characters, which can be used to identify a queue. For example: `TEST`.

    Issue key is the unique ID of the issue. It consists of the queue key and the sequence number. For example: `TEST-123`.

Component
:  Parameter that allows users to group queue issues based on a shared theme, such as their product, pipeline, responsible party, etc. Components can be [configured on the queue page](manager/components.md).

## O {#rus-o}

{% if audience == "external" %}

Organization
:   Organization refers to the company account. The organization employees get access to the {{ yandex-cloud }} services.

{% endif %}

Queue
:   A queue is an area shared by related issues being worked on under a single product or pipeline. Queues can also be used as an issue list meant for a specific team or department. Queues enable you to order your issues and see who is responsible for their execution. [More about setting up queues.](queue-intro.md)

## P {#rus-p}

Issue fields
:  Various attributes such as issue <q>Assignee</q>, <q>Deadline</q>, or <q>Status</q>. You can [edit parameters on the issue page](user/edit-ticket.md#edit-fields).

Invite to comment
:   Inviting a user to comment means entering that user's name when [sending a comment to an issue](user/comments.md#call-comment) in order to draw their attention to that comment. The selected user will receive the comment text by email.

Project
:   In {{ tracker-name }}, projects are sets of issues that have a shared goal. Every project has a deadline and responsible employee. Projects can include issues from different queues. That's why you can use projects to group issues from different teams. [Learn more about projects.](manager/project-new.md)

## R {#rus-r}

Resolution
:  Issue attribute that specifies why the issue was closed. For example, an issue can be closed because it was completed (the <q>Resolved</q> resolution) or because it is a duplicate of another issue (the <q>Duplicate</q> resolution).

## L {#rus-s}

Link
:  Link included in an issue that refers to another issue and shows the hierarchy between the two, e.g., when an issue is a sub-issue of another one, or completing an issue depends on the result of another issue. You can read more about issue linking [here](user/links.md).

Sprint {#sprint-definition}
:   In [Agile methodologies](#agile), a sprint is an iterative project cycle that usually lasts from one to four weeks. {{ tracker-name }} allows you to [use sprints](manager/create-agile-sprint.md) on <q>Scrum</q> boards.

Status
:   A status is an issue attribute that reflects the current state of the issue completion process. For example: <q>Open</q>, <q>In progress</q>, <q>Testing</q>, and <q>Closed</q>.

## T {#rus-t}

Tag
:   Type of label that can be added manually to any issue. It is convenient to use tags to group issues by any criteria and then search for issues with preset tags. To add tags to an issue, [edit the **Tags** parameter](user/edit-ticket.md#edit-fields).

Issue type
:  {{ tracker-name }} issues come in various types, such as: <q>New feature</q>, <q>Bug</q>, or <q>Improvement</q>. In the queue created for each issue type, you can [set up your workflow](manager/add-ticket-type.md).

## F {#rus-f}

Filter
:   Filters let users search for issues in {{ tracker-name }} by issue settings. For example, you can find all issues in queues where you have the author or assignee status. [More about searching issues by parameters.](user/create-filter.md)

## C {#rus-ch}

Checklist
:   A checklist is a to-do list or a list of planned issue stages that you can use to mark items you've completed. {{ tracker-name }} lets users [add checklists to issues](user/checklist.md).

## E {#rus-ee}

Epic
:  In [Agile methodologies](#agile), an epic is a larger feature or requirement that cannot be implemented within a single [sprint](#sprint-definition). {{ tracker-name }} includes the Epic issue type that can be used to [group any issues](user/links.md) based on a shared theme.

## Q {#rus-ya}

Query language
:  Text-based format for entering conditions used for searching issues. You can learn more about our query language [here](user/query-filter.md).

## A {#en-a}

Agile
:   See [Agile methodologies](#agile).

## S {#en-s}

SLA
:  In {{ tracker-name }}, an SLA is a [set of rules](manager/sla.md) that defines timeframes for processing issues in queues. For example, you can set the time within which the assignee has to respond to the issue, answer the requestor's comment, or complete the issue. [Learn more about SLAs.](sla-head.md)

Story
:   In [Agile methodologies](#agile), a <q>User Story</q> is a description of a feature that needs to be implemented in a product. {{ tracker-name }} includes the Story issue type that can be used to [group any issues](user/links.md) based on a common topic.

Story Point
:  Relative rating that describes the effort needed to complete an issue. The Story Point unit is not usually measured in terms of man-hours. [The team rates issues collectively](manager/planning-poker.md) by comparing them to a simple task.

## Y {#en-y}

{{ yfm }} (YFM)
:  Markup {{ yfm }} is a set of rules for formatting text using special characters. You can use it to [format text in issue descriptions and comments](user/markup.md).
