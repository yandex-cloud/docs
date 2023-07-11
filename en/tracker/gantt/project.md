# Gantt chart in projects {{ tracker-name }}

Gantt charts for {{ tracker-name }} projects show issues within the associated project and the links between them.

## Creating a chart for a project {#sec_project}

To go to the Gantt chart:

1. In the [left-hand panel]({{ link-tracker }}) , select ![](../../_assets/tracker/svg/project.svg)&nbsp;**Projects** or follow the [direct link]({{ link-tracker }}pages/projects) and open the project page.

1. {% include [go-to-gantt](../../_includes/tracker/go-to-gantt.md) %}

1. {% include [gantt-time-scale](../../_includes/tracker/gantt-time-scale.md) %}

## Updating links between issues {#links}

{% include [gantt-links](../../_includes/tracker/gantt-links.md) %}

* If an issue has blockers outside the current project, you will see the ![](../../_assets/tracker/svg/blocker.svg) icon with their number to the left of the issue bar.

   * To enable displaying external blockers in the issue list, go to [](../../_assets/tracker/svg/gantt-settings-button.svg)&nbsp;**Chart settings** → **Show external blockers**.

   * External blockers are highlighted in gray and can be found under the dependent issue in the issue list. If you enable [displaying issues as a hierarchy](#trees), blockers are shown under an issue branch. You cannot move external blockers in the list, but you can still open and edit them.

   * You can [change](#timing) the start date and deadline of external blockers.

   * To delete links between external blockers and their dependent issues, click ![](../../_assets/tracker/svg/blocker.svg), and then ![](../../_assets/tracker/svg/del-link.svg) **Delete link**.

## Changing issue deadlines {#timing}

{% include [gantt-timing](../../_includes/tracker/gantt-timing.md) %}

{% include [gantt-timing-prolongate](../../_includes/tracker/gantt-timing-prolongate.md) %}

* If no deadline is set for the parent issue, a hint (blue bar) is displayed next to it on the chart depending on the deadlines of all sub-issues.

## Assigning an issue {#assigned}

{% include [gantt-assigned](../../_includes/tracker/gantt-assigned.md) %}

## Chart settings {#settings}

### Displaying the issue bar {#issue-bar}

{% include [issue-bar](../../_includes/tracker/issue-bar.md) %}

### Timeline area {#timeline}

{% include [timeline-area](../../_includes/tracker/timeline-area.md) %}

{% include [external-blockers](../../_includes/tracker/external-blockers.md) %}

### Issue color {#task-color}

{% include [color-issue](../../_includes/tracker/color-issue.md) %}

## Displaying the issue list section {#tasks-view}

{% include [issues-table-project](../../_includes/tracker/issues-table-project.md) %}
