# Finding my issues

To find the issues you're working on, use the _system filters_ preset. The filters return the lists of issues where you were specified as an assignee, reporter, or in other roles. To search for issues in the list, use [standard filters](#sys_filters) or [add search criteria](#add-condition).

## Using standard filters {#sys_filters}

Find your issues using preset system filters.

1. In the top-left corner, tap **{{ ui-key.startrek.ui_components_agile_common_AgileFilters.all-issues-filter-title }}** and select one of the options:

   * **{{ ui-key.startrek.ui_components_IssueListsPanel.filter-favorite }}**: Issues you [added to Favorites](../user/favourites.md#task-fav).

   * **{{ ui-key.startrek.ui_components_IssueListsPanel.filter-my-issues }}**: Issues in which you are the reporter, assignee, or follower.

   * **{{ ui-key.startrek.ui_components_IssueListsPanel.filter-author }}**: Issues you created.

   * **{{ ui-key.startrek.ui_components_IssueListsPanel.filter-assignee }}**: Issues in which you are the assignee.

   * **{{ ui-key.startrek.ui_components_IssueListsPanel.filter-follower }}**: Issues you are [subscribed](../user/subscribe.md#section_xt5_xrv_jz) to.

   * **{{ ui-key.startrek.ui_components_IssueListsPanel.filter-waiting }}**: Issues you were [invited to comment](comments.md#call-comment) on.

   * **{{ ui-key.startrek.ui_components_IssuesPresetSelect.preset_deadline }}**: Issues in which you are the reporter, assignee, or follower and where:

   * Issues that have exceeded their deadlines in the past two weeks ![](../../_assets/tracker/deadline-red.png).

   * The deadline will be due within three months ![](../../_assets/tracker/deadline-grey.png).


1. After setting the filter, you'll see the selected issue list.

## Adding search parameters {#add-condition}

#### Searching by parameters

To find issues by the parameters that can't be set using the system filters, add search conditions.

1. In the top-right corner, tap ![](../../_assets/tracker/svg/gantt-settings-button.svg).

1. Select an issue parameter, set its value, and tap **{{ ui-key.startrek.blocks-desktop_b-filter.apply }}**.

   Any issues that don't meet your criteria are filtered out of the list.


1. If you need to refine the search conditions, add more parameters.

1. To reset the search parameters, tap **{{ ui-key.startrek.blocks-desktop_issues-filter.action--reset }}** in the top-right corner of the **{{ ui-key.startrek.blocks-desktop_b-page-issues.page-title }}** page.

{% endlist %}
