* To select the fields you want to see in the issue list table to the left of the chart, click ![](../../_assets/tracker/svg/settings-old.svg). Select the relevant items and click **{{ ui-key.startrek.blocks-desktop_b-filter.apply }}**.

* To find issues in the list, start typing in the **{{ ui-key.startrek.ui_components_filter-pane.search-placeholder }}** field.

* To set up their display order in the list, click ![](../../_assets/tracker/svg/sorting.svg)&nbsp;**{{ ui-key.startrek.ui_components_SortButton.default-title }}**, specify the parameter, and click ![](../../_assets/tracker/svg/new-first.svg). In this case, you will not be able to move issues manually.

* To group issues by their status, assignee, or other parameters, click ![](../../_assets/tracker/svg/group.svg)&nbsp;**{{ ui-key.startrek.blocks-desktop_issues-table.group-by--null }}** and select the appropriate option from the list.

* To filter the issue list, use the filter builder. For this, on the ![](../../_assets/tracker/svg/filter.svg)&nbsp;**{{ ui-key.startrek.ui_components_IssueListsPanel.filters }}** panel, select the parameters and specify the values to use for generating an issue list.

* To swap the list columns, click ![](../../_assets/tracker/svg/settings-old.svg) above the list. Next, in the **{{ ui-key.startrek.ui_components_Table2.added-columns }}** section, click the parameter, hold and drag it within the section. Click **{{ ui-key.startrek.blocks-desktop_b-filter.apply }}**.

* To resize a column in a section, click and hold its edge and then change the width.

* To hide the issue list section, click ![](../../_assets/tracker/svg/close-block.svg).

* To change the layout of the issue list, select ![](../../_assets/tracker/svg/flat-list.svg)&nbsp;**{{ ui-key.startrek.ui_components_filter-pane.list-mode-flat }}** or ![](../../_assets/tracker/svg/tree-list.svg)&nbsp;**{{ ui-key.startrek.ui_components_filter-pane.list-mode-tree }}**.{#trees}

   {% note info %}

   In the tree list, nesting of issues is implemented as <q>Parent issue — Sub-issue</q> [links](../../tracker/user/links.md).

   {% endnote %}

   In the flat list, you can range (move) issues with respect to other issues. To do this, click and hold ![](../../_assets/tracker/svg/range.svg) on the left of the issue and drag it where needed.

   In the tree list, you can create new sub-issues or change links for sub-issues:

   * To create a sub-issue, click ![](../../_assets/tracker/svg/icon-add.svg) **{{ ui-key.startrek.ui_components_projects_Table.add-sub-issue }}** next to the issue:

      * To create an issue, go to the **{{ ui-key.startrek.ui_components_CreateIssuePopup.new-issue }}** tab. Give your issue a name and press **Enter**.
      * If the issue already exists, go to the **{{ ui-key.startrek.ui_components_CreateIssuePopup.existing-issue }}** tab, specify the issue key or name, and select the issue from the list. You can find the key on the issue page, under the title (for example, `TEST-1234`).

   * To change a link, click and hold ![](../../_assets/tracker/svg/range.svg) to the left of the sub-issue, switch the toggle to the right, and drag the issue to the one you want to assign as a parent issue.

   * When building the issue hierarchy, you can nest issues into one another or move a sub-issue to a higher level. To move an issue one level up, click and hold ![](../../_assets/tracker/svg/range.svg) to the left of a sub-issue and switch the toggle to the left.

   {% note info %}

   You can move issues manually if no sorting parameter is selected in the **{{ ui-key.startrek.ui_components_SortButton.default-title }}** field. By default, manual sorting mode is selected for the list of issues: you can drag issues in the list.

   {% endnote %}