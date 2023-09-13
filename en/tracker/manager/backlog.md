# Backlog

A backlog is a list of issues or product requirements to be completed. Backlog issues are usually sorted by priority.

You can use the **{{ ui-key.startrek.ui_components_agile_common_AgileTabs.backlog }}** tab to store your team's critical issues, sort them by priority, and distribute them across sprints. You can create new issues or add existing ones to both the backlog and directly to a sprint. To move an issue from the backlog to a sprint, just drag its card from one list to another.

Track an issue's [validity](agile-new.md#tips) in the backlog: it should not contain any closed issues, duplicate issues, or issues that work cannot be started on in the near future.

In addition to backlog and sprint columns, you can create [custom columns](agile-new-columns.md#user-columns) and use them as an additional backlog with manually selected issues. For example, a custom column may contain issues to be discussed with the team members during the nearest planning or issue estimation (refinement).

## Enabling a backlog on basic boards {#add-backlog}

The **{{ ui-key.startrek.ui_components_agile_common_AgileTabs.backlog }}** tab with a backlog and sprints is by default available on**{{ ui-key.startrek.ui_components_agile_agile-board_AgileBoardCreateModal.board-type--scrum }}** boards. The tab is missing on **{{ ui-key.startrek.ui_components_agile_agile-board_AgileBoardCreateModal.board-type--simple }}**, but you can enable it.

{% note warning %}

Currently, you cannot disable the **{{ ui-key.startrek.ui_components_agile_common_AgileTabs.backlog }}** tab and sprints. We will add this feature later.

{% endnote %}

To enable a backlog and sprints on **Basic** boards:
1. Click **{{ ui-key.startrek.ui_components_PageAgileBoard_PageAgileBoardHeader_EnableBacklogButton.enable-backlog }}** at the top of the screen.

1. If the issue board already contains issues, select where to move them: to the backlog or sprint.

This opens the **{{ ui-key.startrek.ui_components_agile_common_AgileTabs.backlog }}** tab with a list of backlog issues and sprints.

## Adding issues to a backlog {#add-new-backlog}

You can add or create an issue from any queue that you have access to.

To add a single issue:

1. Decide where to add an issue (to the backlog or sprint) and click **+ {{ ui-key.startrek.blocks-desktop_b-agile-board.create-issue--title }}** in the appropriate section.
1. Select an existing issue or create a new one right on the board.

To add a group of issues, such as all issues from a queue with a certain assignee, use issue auto-import:

1. On the board, click **{{ ui-key.startrek.ui_components_PageAgileBoard_PageAgileBoardHeader.settings }}** → **{{ ui-key.startrek.ui_components_agile_settings_AgileSettingsLayout.issue-updates }}**.
1. Under **{{ ui-key.startrek.ui_components_agile_settings_BoardIssueUpdatesSettings.import-title }}**, click **+ {{ ui-key.startrek.ui_components_issues-import_IssuesImportFilters.add-parameters }}**. Select a parameter from the list and set its value. For example, to add all issues where you are the assignee to the board, select the **Assignee** parameter and set it to **Me**. To add more parameters, repeat the step.

You can also add a group of issues using [bulk edits](agile-new-issues.md#bulk):
1. On the [search issues]({{ link-tracker }}issues) page, select the issues to add by selecting the checkboxes to the left of the issue names.
1. In the panel with bulk issue actions that opens at the bottom of the screen, click ![](../../_assets/tracker/svg/actions.svg) → **Add to board**. Search for the appropriate board by name and click **Apply**.
