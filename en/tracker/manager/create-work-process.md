# Workflow templates

A workflow template is a set of {{ tracker-name }} tools grouped and configured for most common workflows.

## Project management {#manage-process-template}

This template is good for projects that are limited in time and number of issues. A project is aimed to achieve the same result by one or more teams. By using projects, you can easily group issues of several teams focused on the same goal, set the [issue hierarchy](project-list.md), and plan deadlines.

When you select this template, the following items are created automatically:
  * [Project](project-new.md) with a [Gantt chart](../gantt/overview.md) and an [issue board](boards-project.md).
  * [Queue](create-queue.md) with a basic set of issue [types and statuses](workflow.md).

You can create additional queues separately.

## Development {#for-developers-template}

This template is suitable for software development teams that use [Scrum]({{ link-wiki-scrum }}). With the {{ tracker-name }} tools, you can decompose projects using [epics](epic.md) and [stories](agile.md#sec_basics), plan sprints, and [estimate issues](planning-poker.md).

When you select this template, the following items are created automatically:
  * [Issue board](agile-new.md) with a [backlog](backlog.md) and a [planning poker](planning-poker.md).
  * [Queue](create-queue.md) with a basic set of issue [types and statuses](workflow.md).

If you are using cloud-based services, such as GitHub, GitLab, or Bitbucket, you can [connect](add-repository.md) any number of repositories and [link](../user/ticket-links.md#section_commit) commits to issues.

## Support {#for-support-template}

This template is good for internal and external support services. You can create issues [from emails](queue-mail.md) sent to the support team's email address or via the [feedback form](forms-integration.md) on your website, as well as from the {{ tracker-name }} interface using the embedded form. This template has sample response templates, [SLA](sla.md) timers, and auto responses pre-configured.

When you select this template, the following items are created automatically:
  * Issue queue with a [form for user requests](../../forms/new-form.md).
  * [Basic issue board](boards-project.md).
  * [Queue](create-queue.md) with a basic set of issue [types and statuses](workflow.md).

## Basic template {#basic-template}

It is good for getting started with {{ tracker-name }}. If you select this template, you can then configure and extend it.

When you select this template, the following items are created automatically:
  * [Basic issue board](agile.md#sec_boards).
  * [Queue](create-queue.md) with a basic set of issue [types and statuses](workflow.md).

## Creating a workflow based on a template {#create-from-template}

1. Open the **Workflow templates** widget on [**My page**](https://tracker.yandex.ru/pages/my) and click **Select template**.
1. Select the template you need and click **Continue**.
1. Specify the queue parameters:
    * Issue queue name.
    * [Queue key](create-queue.md#key).
    * Permissions.
1. Click **Next**. Depending on the selected template, one of the following items will open:
    * [Project management](create-work-process.md#manage-process-template): New project page.
    * [Development](create-work-process.md#for-developers-template): Board with a backlog.
    * [Support](create-work-process.md#for-support-template): Issue queue.
    * [Basic template](create-work-process.md#basic-template): Issue board.