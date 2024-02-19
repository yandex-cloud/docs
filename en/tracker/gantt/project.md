# Gantt chart in projects {{ tracker-name }}

Gantt charts for {{ tracker-name }} projects show issues within the associated project and the links between them.

## Creating a chart {#sec_project}

To go to the Gantt chart:

1. In the [left-hand panel]({{ link-tracker }}), select ![](../../_assets/tracker/svg/project.svg)&nbsp;**Projects** or follow the [direct link]({{ link-tracker }}pages/projects/list) and open the project page.

1. {% include [go-to-gantt](../../_includes/tracker/go-to-gantt.md) %}

1. {% include [gantt-time-scale](../../_includes/tracker/gantt-time-scale.md) %}

## Updating links between issues {#links}

{% include [gantt-links](../../_includes/tracker/gantt-links.md) %}

* If an issue has blockers outside the current project, you will see the ![](../../_assets/tracker/svg/blocker.svg) icon with their number to the left of the issue bar.

   * To enable the display of external blockers in the issue list, go to [](../../_assets/tracker/svg/gantt-settings-button.svg)&nbsp;**{{ ui-key.startrek.ui_components_Gantt.timeline-config }}** → **{{ ui-key.startrek.ui_components_Gantt.show-external-blockers }}**.

   * External blockers are highlighted in gray and can be found under the dependent issue in the issue list. If you enable [displaying issues as a hierarchy](#trees), blockers are shown under an issue branch. You cannot move external blockers in the list, but you can still open and edit them.

   * You can [change](#timing) the start date and deadline of external blockers.

   * To delete links between external blockers and their dependent issues, click ![](../../_assets/tracker/svg/blocker.svg), and then ![](../../_assets/tracker/svg/del-link.svg) **{{ ui-key.startrek.ui_components_Gantt.delete-link }}**.

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

{% note info %}

Issue color settings are saved at the project chart level, i.e., the selected color scheme applies to all users viewing the chart.

{% endnote %}

{% include [color-issue](../../_includes/tracker/color-issue.md) %}

### Critical path {#critical-path}

{% include [critical-path](../../_includes/tracker/gantt-critical-path.md) %}

### Baselines {#baselines}

A baseline is a saved version of the project Gantt chart. With its help, you can look back and compare the originally planned deadlines with the current ones. Baselines help to predict the outcome of the project and, retrospectively, understand what can be improved in planning.

To open the project baseline panel, click ![](../../_assets/console-icons/clock-arrow-rotate-left.svg) above the time scale on the right.

#### Creating a baseline {#create-baseline}

Create a baseline when the current deadlines, milestones, and links between issues are laid out on the chart. When creating a baseline, the current deadlines will be saved on the Gantt chart. To create a baseline:

1. On the project baseline panel, click **Create**.
1. By default, the name of the baseline includes the day and month it was created. If required, adjust the name of the baseline and click **Create**.

The baseline will save the current status of issue deadlines in the project. On the baseline panel, you can compare the current deadlines for project issues with those fixed in the baselines: how many days the actual deadlines are ahead or behind the planned ones (for the last issue in the project).

#### Using a baseline {#working-with-baselines}

Baselines can be overlaid on top of the original project Gantt chart. To do this, open the baseline panel and click the baseline. In comparison mode, you can evaluate the differences in the chart:

1. Lag from the fixed deadline for specific issues: when hovering over the issue deadlines in the baseline.
1. Converting an issue to a milestone or vice versa: the appearance of the issue or milestone on the chart will change, and a comment will appear when hovering the cursor.
1. Deleting issues from the project: deadlines of such issues will not be displayed in the comparison mode.
1. Adding new issues to the project: such issues will not have old deadlines fixed.

To turn off comparison mode, hover over ![](../../_assets/console-icons/clock-arrow-rotate-left.svg) and click the highlighted baseline.

## Displaying the issue list section {#tasks-view}

{% include [issues-table-project](../../_includes/tracker/issues-table-project.md) %}

## Actions with issues {#issue-actions}

To open the issue actions menu in the issue list section, click ![](../../_assets/tracker/svg/actions.svg) **{{ ui-key.startrek.ui_components_Gantt_IssueActionsCell.issue-action-menu-title }}** to the right of the issue name.

In the menu, you have the following actions available:
* ![](../../_assets/tracker/text-edit/link.svg) **{{ ui-key.startrek.ui_components_projects_hooks.copy-to-clipboard }}**.
* ![](../../_assets/tracker/svg/move-up.svg) **{{ ui-key.startrek.ui_components_projects_hooks.issue-actions--move-up }}** (for manual sorting only).
* ![](../../_assets/tracker/svg/move-down.svg) **{{ ui-key.startrek.ui_components_projects_hooks.issue-actions--move-down }}** (for manual sorting only).
* ![](../../_assets/tracker/svg/convert.svg) **Convert to a [milestone](../manager/milestones.md) or issue**.
* ![](../../_assets/tracker/svg/icon-remove.svg) **{{ ui-key.startrek.ui_components_projects_hooks.delete-from-project }}**.
* ![](../../_assets/tracker/svg/gantt-palette.svg) **Choose color** (only when the **{{ ui-key.startrek.ui_components_Gantt.color-type-by-manual }}** setting is enabled).