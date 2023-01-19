# Basic terms

In this section, you'll find the basic terms and concepts used in {{ tracker-name }} and this Help.

## A {#en-a}

Agile methodologies {#agile}
:   Team work strategies that follow iterative development at their core, breaking the workload down into smaller cycles called sprints. There are several variations of agile methodologies, such as [Scrum]({{ link-wiki-scrum }}) and [Kanban]({{ link-wiki-kanban}}). In {{ tracker-name }}, agile tools are grouped on the [issue board](manager/agile.md).

## B {#rus-b}

Backlog 
:   A list of issues or product requirements that must be completed in the project. Backlog issues are usually sorted by priority.

## C {#rus-ch}

Checklist
:  A checklist is a to-do list or a list of planned issue stages that lets you mark items you've completed. {{ tracker-name }} lets users [add checklists to issues](user/checklist.md).

Component
:  A parameter that lets users group queue issues based on a shared theme, such as their product, process, responsible party, and so on. Components can be [configured on the queue page](manager/components.md).


## D {#rus-d}

Dashboard {#dashboard-definition}
:   A dashboard is a page that helps users monitor the status of important issues and view statistics. A dashboard can display lists, tables, graphs, and notes. [ Learn more about dashboards.](user/dashboard.md)

## E {#rus-ee}

Epic
:  In [Agile methodologies](#agile), an epic is a larger feature or requirement that can't be implemented within a single [sprint](#sprint-definition). {{ tracker-name }} includes the Epic issue type that can be used to [group any issues](user/links.md) based on a shared theme.

## F {#rus-f}

Filter
:  Filters let users search for issues in {{ tracker-name }} by issue settings. This can be used to find all issues in queues where you have the author or assignee status, among other things. [ Learn more about using filters.](user/create-filter.md)

## I {#rus-p}

Invite to comment
:  Inviting a user to comment means entering that user's name when [sending a comment to an issue](user/comments.md#call-comment) in order to draw their attention to that comment. The selected user will receive an email notification with the comment in question.

Issue
:  In {{ tracker-name }}, issues can be used to register tasks, requests, and other types of work. Each issue has its own name, assignee, deadline, and other parameters. Learn more about [creating issues](user/create-ticket.md) and [working with issues](user/ticket-in-progress.md).

Issue board
:  Boards help users easily monitor and update issue statuses. Issues are displayed on the board as cards, which are sorted into columns based on their status. [ Learn more about issue boards.](user/agile.md)

Issue fields
:  Issue fields are various attributes such as an issue's <q>Assignee</q>, <q>Deadline</q>, <q>Status</q>, and so on. Fields can be [edited on the issue page](user/edit-ticket.md#section_jqw_ppn_jz).

Issue type
:  There are various types of {{ tracker-name }} issues, such as <q>New feature</q>, <q>Bug</q>, and <q>Improvement</q>. You can [customize your workflow](manager/add-ticket-type.md) for queues of each issue type.

## K {#rus-k}

Key (queue and issue)
:  The queue key is a unique code comprised of Latin characters that can be used to identify a queue. For example: `TEST`.

    An issue key is a unique issue ID. It's comprised of a queue key and an issue index. For example: `TEST-123`.

## L {#rus-s}

Link
:  An issue link means a link included in an issue that refers to another issue and shows the hierarchy between the two. Such as when one issue is considered a parent issue. Or when completion of an issue depends on the results of another issue. [ Learn more about issue links.](user/links.md)


## O {#rus-o}

Organization
:  Organization refers to the company account. Company employees receive access to platforms featured on {{ yandex-cloud }} in order to work together.


## P {#p}

Project
:  In {{ tracker-name }}, projects are sets of issues that have a shared goal. Projects have deadlines and responsible employees. A project may include issues from multiple queues, which is why they're convenient for grouping issues meant for different teams. [ Learn more about projects.](manager/projects.md)

## Q {#rus-ya}

Query language
:  A query language is a text-based format for entering conditions used for searching issues. [ Learn more about the query language.](user/query-filter.md)

Queue
:  A queue is a common workspace for issues in the same pipeline or for a single product. Queues can also be used as a list of issues meant for a specific team or department. Queues help you organize issues and quickly find their assignees. [ Learn more about queue settings.](queue-intro.md)


## R {#rus-r}

Resolution
:  A resolution is an issue attribute that specifies why the issue was closed. For example, an issue can be closed because it was completed (the <q>Resolved</q> resolution status) or because it's a duplicate of another issue (the <q>Duplicate</q> status).

## S {#en-s}

SLA
:  In {{ tracker-name }}, an SLA is a [set of rules](manager/sla.md) that defines a timeframe for processing issues in the queue. For example you can set up a time limit during which the assignee must respond to a new issue, respond to a client's comment or completely finish their work on the issue. [ Learn more about using SLAs.](sla-head.md)

Sprint {#sprint-definition}
:   In [Agile methodologies](#agile), a sprint is an iterative project cycle that usually lasts from 1 to 4 weeks. {{ tracker-name }} lets you [use sprints](manager/create-agile-sprint.md) on <q>Scrum</q> boards.

Status
:  A status is an issue attribute that reflects the current state of the issue completion process. For example: <q>Open</q>, <q>In progress</q>, <q>Testing</q>, or <q>Closed</q>.

Story
:  In [Agile methodologies](#agile), a <q>User Story </q> is a description of a feature or function that needs to be implemented in the product. {{ tracker-name }} includes the Story issue type that can be used to [group issues](user/links.md) based on a shared theme.

Story Point
:  A relative rating that describes effort needed to complete an issue. Usually a story point doesn't directly correlate with the number of work hours needed to solve the problem. [ The team rates issues collectively](manager/planning-poker.md) by comparing them to a simple task.

## T {#rus-t}

Tag 
:  A tag is a type of label that can be added manually to any issue. Tags let users group issues based on any attribute, which makes it easy to search for those issues by tag later. To add tags to an issue, [edit the **Tags**](user/edit-ticket.md#section_jqw_ppn_jz) parameter.

## V {#rus-v}

Version 
:  A parameter that lets you group issues pertaining to the same version of a product. Version values can be [configured on the queue page](manager/versions.md).

## W {#w}

Widget 
:  An information block located on the [dashboard](#dashboard-definition) that automatically receives issue-related data and displays it as a list, table, or chart. [ Learn more about widgets.](user/widgets.md)

Workflow 
:  A set of possible issue statuses and status transition rules. The queue settings for issues of various types let users [choose preset workflows](manager/add-ticket-type.md) and [create custom ones](manager/add-workflow.md).

## Y {#en-y}

Yandex Flavored Markdown (YFM)
:  Yandex Flavored Markdown is a set of text formatting rules that use special characters. You can use it to [format text in issue descriptions and comments](user/markup.md).
