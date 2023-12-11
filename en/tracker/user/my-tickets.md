---
title: "How to view a list of my issues in {{ tracker-full-name }}"
description: "In this tutorial, you will learn how to view a list of your issues."
---

# My issues

To find issues you're working on:

1. In the left-hand panel, open ![](../../_assets/tracker/svg/tasks.svg) **{{ ui-key.startrek.ui_components_NavigationBar.issue-lists-menu-item }}**.

1. To find issues in which you are reporter, assignee, or follower, select the **All my issues** filter.

1. If you cannot see all relevant issues, expand the list:

   * In the left-hand panel at the bottom of the page, click **{{ ui-key.startrek.ui_components_NavigationBar_IssuesPanel.filter-items-link }}** or [follow the direct link]({{ link-tracker }}issues/my-issues).

   * To open all issues available to you in {{ tracker-name }}, at the bottom of the window, click **{{ ui-key.startrek.ui_components_NavigationBar_IssuesPanel.all-items-link }}** or follow the [direct link]({{ link-tracker }}issues).

To search for issues in the list, use [filtering by parameters](#q-filters) or [add search criteria](default-filters.md#add-condition).

## Filter by parameters {#q-filters}

Use filters to narrow down your issue list and display only those issues that match the selected parameters. The filter by parameters buttons are above the issue list:

* To use standard filters, click the filter name in the list located in the bottom-left corner of the page:
   * **Favorite issues**.
   * **All my issues**.
   * **Created by me**.
   * **Assigned to me**.
   * **Followed by me**.
   * **Waiting for response**.
   * **{{ ui-key.startrek.ui_components_IssuesPresetSelect.preset-deadline }}**.

* To filter issues by their [resolution](../manager/create-resolution.md), click **Resolution** and select relevant values from the list.

* To use [advanced search parameters](./default-filters.md#add-condition), click ![](../../_assets/tracker/svg/add-filter.svg) **{{ ui-key.startrek.ui_components_filter-pane_FieldsSelectButton.add-filter-field-button-title }}** and select a field.

## Searching for issues by name {#search-name}

If you want to find an issue using its name:

1. In the left-hand panel, open ![](../../_assets/tracker/svg/tasks.svg) **{{ ui-key.startrek.ui_components_NavigationBar.issue-lists-menu-item }}** or follow the [link]({{ link-tracker }}issues/).

1. In the **{{ ui-key.startrek.ui_components_filter-pane.search-placeholder }}** field, enter the text to search for.

The system will search for issues that match all the selected filters.

## Configuring how issues are displayed {#manage-list}

{% note info %}

Issue display settings are only available in the {{ tracker-name }} web interface.

{% endnote %}

You can set up the display of issues in the list or save the list to a file:

* If you want to hide or display certain issue parameters, click ![](../../_assets/tracker/svg/settings.svg), select the parameters, and click **Apply**.
* To group issues by a certain parameter, click ![](../../_assets/tracker/svg/group.svg) **Not grouped** above the list and select the parameter.
* To save an issue list, at the top right of the page, click ![](../../_assets/tracker/svg/export.svg) and select the format of the file to download or simply copy the list to the clipboard.
