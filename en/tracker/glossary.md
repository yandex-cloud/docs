# Concepts

In this section, you will find the basic terms and concepts used in {{ tracker-name }} and this Help.

## B {#rus-b}

Backlog
:   List of issues or product requirements that must be completed in the project. Backlog issues are usually sorted by priority.

## V {#rus-v}

Version
:   Parameter that allows you to group issues pertaining to the same version of a product. Version values can be [configured on the queue page](manager/versions.md).

Widget
:   Information section located on the [dashboard](#dashboard-definition) that automatically receives issue-related data and displays it as a list, table, or chart. You can learn more about widgets [here](user/widgets.md).

Workflow
:   Set of possible issue statuses and status transition rules. Queue settings for issues of various types allow users to [choose preset workflows](manager/add-ticket-type.md) or [create custom ones](manager/add-workflow.md).

## A {#rus-g}

Agile methodologies {#agile}
:   Team work strategies that follow iterative development at their core, breaking the workload down into smaller cycles called sprints. There is a number of [Agile development approaches]({{ link-wiki-agile-en }}), e.g., [Scrum]({{ link-wiki-scrum }}) and [Kanban]({{ link-wiki-kanban }}). In {{ tracker-name }}, agile tools are grouped on [issue boards](manager/agile.md).

## D {#rus-d}

Dashboard {#dashboard-definition}
:  Page that helps users monitor the status of important issues and view statistics. You can add issue lists, tables, charts, and notes to the dashboard. [Learn more about dashboards](user/dashboard.md).

Issue board
:   Boards help users easily monitor and update issue statuses. On the board, issues are shown as cards distributed across columns of the board depending on their status. [Learn more about boards.](user/agile.md)

## I {#rus-z}

Issue
:   In {{ tracker-name }}, issues can be used to register tasks, requests, and other types of work. An issue has a name, assignee, deadline, and other parameters. Learn more about [creating issues](user/create-ticket.md) and [managing issues](user/ticket-in-progress.md).

## K {#rus-k}

Key (queue key and issue key) {#key}
:   Queue key is a unique code consisting of Latin characters, which can be used to identify a queue, e.g., `TEST`.

    Issue key is a unique ID of the issue. It consists of the queue key and the sequence number, e.g., `TEST-123`.

Queue team {#queue-team}
:   Queue team includes users who create and complete issues in the given queue. You can assign the team members privileged access rights to issues in the queue.

Component
:   Parameter that allows users to group queue issues related to the same subject, such as their product, pipeline, employee in charge, etc. Components can be [configured on the queue page](manager/components.md).

## O {#rus-o}


Organization
:   Organization refers to the company account. The organization employees get access to the {{ yandex-cloud }} services.


Queue
:   Area shared by related issues being worked on under a single product or pipeline. Queues can also be used as an issue list meant for a specific team or department. Queues enable you to order your issues and see who is responsible for their execution. [More about setting up queues](queue-intro.md).

## P {#rus-p}

Issue fields
:   Various attributes, such as issue <q>{{ ui-key.startrek-backend.fields.issue.assignee-key-value }}</q>, <q>{{ ui-key.startrek-backend.fields.issue.dueDate-key-value }}</q>, or <q>{{ ui-key.startrek-backend.fields.issue.status-key-value }}</q>. You can [edit parameters on the issue page](user/edit-ticket.md#edit-fields).

Invite to comment
:   Inviting a user to comment means entering the user's name when [sending a comment to an issue](user/comments.md#call-comment) in order to draw their attention to that comment. The mentioned user will receive a notification with the text of the comment by email and in {{ tracker-name }} ![](../_assets/tracker/svg/bell_2.svg) **Notifications** (if the user opened the {{ tracker-name }} interface before).

Project
:   In {{ tracker-name }}, projects are sets of issues that have a shared goal. Every project has a deadline and an employee in charge. Projects can include issues from different queues. That is why you can use projects to group issues from different teams. You can learn more about projects [here](manager/project-new.md).

## R {#rus-r}

Resolution
:   Issue attribute that specifies why the issue was closed. For example, an issue can be closed because it was completed (the <q>{{ ui-key.startrek-backend.applinks.samsara.resolution.resolved }}</q> resolution) or because it is a duplicate of another issue (the <q>{{ ui-key.startrek-backend.applinks.samsara.resolution.duplicate }}</q> resolution).

## L {#rus-s}

Link
:   Link included in an issue that refers to another issue and shows the hierarchy between the two, e.g., when an issue is a sub-issue of another one, or completing an issue depends on the result of another issue. You can read more about issue linking [here](user/links.md).

Sprint {#sprint-definition}
:   In [Agile methodologies](#agile), a sprint is an iterative project cycle that usually lasts from one to four weeks. {{ tracker-name }} allows you to [use sprints](manager/create-agile-sprint.md) on <q>Scrum</q> boards.

Status
:   Issue attribute that reflects the current state of the issue completion process, e.g., <q>{{ ui-key.startrek-backend.applinks.samsara.status.open }}</q>, <q>{{ ui-key.startrek-backend.applinks.samsara.status.in.progress }}</q>, <q>{{ ui-key.startrek-backend.presets.advancedDevelopment.board.column.testing }}</q>, or <q>{{ ui-key.startrek-backend.applinks.samsara.status.closed }}</q>.

## T {#rus-t}

Tag
:   Type of a label one can add to any issue. Tags are useful for grouping issues by any attribute and then searching for issues with preset tags. To add tags to an issue, [edit the **{{ ui-key.startrek-backend.fields.issue.tags-key-value }}** parameter](user/edit-ticket.md#edit-fields).

Issue type
:   {{ tracker-name }} issues come in various types, e.g., <q>New feature</q>, <q>Bug</q>, or <q>Improvement</q>. In the queue created for each issue type, you can [set up your workflow](manager/add-ticket-type.md).

## F {#rus-f}

Filter
:   Filters allow users to search for issues in {{ tracker-name }} by issue settings. For example, you can find all issues in queues where you have the author or assignee status. [More about searching issues by parameters.](user/create-filter.md)

## C {#rus-ch}

Checklist
:   To-do list or a list of planned work steps that you can use to mark the items you have completed. {{ tracker-name }} allows users to [add checklists to issues](user/checklist.md).

## E {#rus-ee}

Epic
:   In [Agile methodologies](#agile), an epic is a larger feature or requirement that cannot be implemented within a single [sprint](#sprint-definition). {{ tracker-name }} includes the {{ ui-key.startrek-backend.fields.issue.epic }} issue type that can be used to [group any issues](user/links.md) by theme.

## Q {#rus-ya}

Query language
:   Text-based format for entering conditions used for searching issues. You can learn more about our query language [here](user/query-filter.md).

## A {#en-a}

Agile
:   See [Agile methodologies](#agile).

## S {#en-s}

SLA
:   In {{ tracker-name }}, an SLA is a [set of rules](manager/sla.md) that defines timeframes for processing issues in queues. For example, you can set the time within which the assignee has to respond to the issue, answer the requestor's comment, or complete the issue. [Learn more about SLAs.](sla-head.md)

Story
:   In [Agile methodologies](#agile), a <q>User Story</q> is a description of a feature that needs to be implemented in a product. {{ tracker-name }} includes the Story issue type that can be used to [group any issues](user/links.md) by theme.

Story Point
:   Relative rating that describes the effort needed to complete an issue. The Story Point unit is not usually measured in terms of man-hours. [The team rates issues collectively](manager/planning-poker.md) by comparing them to a simple task.

## Y {#en-y}

{{ yfm }} (YFM)
:   {{ yfm }} markup is a set of rules for formatting text using special characters. You can use it to [format text in issue descriptions and comments](user/markup.md).
