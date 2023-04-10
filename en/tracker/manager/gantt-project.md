# Gantt chart in {{ tracker-name }} projects

A project's Gantt chart in {{ tracker-name }} is a tool for calendar planning of work on project issues. The Gantt chart shows all the project's issues and links between them.

To go to the Gantt chart:

1. In the left panel, select ![](../../_assets/tracker/svg/project.svg)&nbsp;**Projects** or follow the [direct link]({{ link-tracker }}pages/projects) and open the project page.

1. {% include [go-to-gantt](../../_includes/tracker/go-to-gantt.md) %}

1. {% include [gantt-time-scale](../../_includes/tracker/gantt-time-scale.md) %}

{% note tip %}

You can also open the calendar as a [Gantt chart for all projects](./my-projects.md#gantt-projects) you have access to.

{% endnote %}

## Updating links between issues {#links}

{% include [gantt-links](../../_includes/tracker/gantt-links.md) %}

* If an issue has blockers outside the current project, you will see the ![](../../_assets/tracker/svg/blocker.svg) icon with their number to the left of the issue bar.

   * You can enable the display of external blockers in the issue list; to do this, go to ![](../../_assets/tracker/svg/gantt-settings-button.svg)&nbsp;**Chart settings** and select **Show external blockers**.

   * External blockers are shown in gray under the dependent issue in the list of issues. If you selected to [display issues as a hierarchy](#trees), blockers will be shown under an issue branch. You cannot move external blockers in the list, while you can still open and edit them like any issue.

   * You can [change](#timing) the start date and deadline of external blockers.

   * To delete links between external blockers and their dependent issues, click ![](../../_assets/tracker/svg/blocker.svg) and select ![](../../_assets/tracker/svg/del-link.svg) **Delete link**.

## Changing issue deadlines {#timing}

{% include [gantt-timing](../../_includes/tracker/gantt-timing.md) %}

* To set up automatic update of start dates and deadlines for the parent issue, go to ![](../../_assets/tracker/svg/gantt-settings-button.svg)&nbsp;**Chart settings** and enable **Automatically extend the deadlines of the parent issue based on the deadlines of sub-issues**. If a sub-issue's deadline is later than that of the parent issue, the deadline of the parent issue is shifted. The start date of the sub-issue also changes depending on the start date of the parent issue.

* If no deadline is set for the parent issue, a hint (blue bar) is displayed next to it on the chart depending on the deadlines of all sub-issues.

## Assigning an issue {#assigned}

{% include [gantt-assigned](../../_includes/tracker/gantt-assigned.md) %}

## Setting up the chart {#settings}

{% include [gantt-settings](../../_includes/tracker/gantt-settings.md) %}

## Setting up the display of the issue list section {#tasks-view}

* To select the fields you want to see in the issue list table to the left of the chart, click ![](../../_assets/tracker/svg/settings-old.svg). Select the relevant fields and click **Apply**.

{% include [task-list-settings](../../_includes/tracker/task-list-settings.md) %}

* To resize a column in a section, click and hold its edge and then change the width.

* To hide the issue list section, click ![](../../_assets/tracker/svg/close-block.svg).
