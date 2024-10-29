---
title: How to view my projects in {{ tracker-full-name }}
description: Follow this guide to view a list of your projects.
---

# My projects

Open the list of all portfolios and projects available to you:

1. In the left-hand panel, select ![](../../_assets/tracker/svg/project.svg)&nbsp;**Projects**.

1. Select a filter to find your projects:

   * **My projects** for all portfolios and projects where you are the author, user responsible for the portfolio or project, participant, or customer.

   * **I'm author**, **I'm responsible**, **I'm a participant**, or **I'm the customer** for the portfolios and projects where you have the respective role.

   * **Favorites** for the portfolios and projects you added to your **Favorites**.

   * **Viewed recently** for the portfolios and projects you opened most recently.

1. If you cannot see all relevant portfolios and projects, expand the list.

* In the bottom-left corner of the left-hand panel, click **Full list of my projects**.
* To open all portfolios and projects available to you in {{ tracker-name }}, click **All portfolios and projects** in the left-hand panel at the bottom of the page.

On the [portfolios and projects page]({{ link-tracker }}pages/projects), you can choose the layout of their list. To do this, click one of the tabs at the top of the page:

* **Structure**: Tree list with portfolios and projects nested in higher-level portfolios. The page only shows the portfolios which are not nested in any portfolio. To see portfolios and their nested projects, expand the portfolio.
* **List**: Flat list with portfolios and projects not related in any way.
* **Gantt chart**: [Gantt chart](../gantt/list-of-projects.md) where portfolios, projects, and issues within them are displayed as a calendar.

You can use filters to perform a search in any of these tabs:

* To find a portfolio or project by name, enter it in the **Search** field. If your current tab is **Structure**, you will automatically switch to the **List** tab.

* To select a search parameter by a portfolio or project field, click its name above the list. To select advanced search parameters, click ![](../../_assets/tracker/svg/add-filter.svg) **{{ ui-key.startrek.ui_Common_smart-components_filter-pane_FieldsSelectButton.add-filter-field-button-title }}** and select a field.

   {% note info %}

   If you are using a filter in the **Structure** tab, it will apply to top-level portfolios first of all. This way, if a top-level portfolio does not match the filter, all portfolios and projects inside it will also be excluded from the search results even if they meet the filter criteria.

   {% endnote %}

* To set up the display order, click ![](../../_assets/tracker/svg/sorting.svg) **{{ ui-key.startrek.ui_Common_smart-components_SortButton.default-title }}** and select a parameter.

   {% note info %}

   If you are using sorting in the **Structure** tab, it will only apply to top-level portfolios. The order of internal projects and portfolios is set manually. This allows you to arrange a stable structure of your company's activity area.

   If you are using sorting in the **Gantt chart** tab, the order of project issues is also set manually.

   {% endnote %}

The filter settings persist and apply after you refresh the page or open the project list again. The filter is retained for each tab separately.

{% note tip %}

To share a link to the filtered project list, copy the URL from the browser address bar.

{% endnote %}

To view the portfolio or project card, click the portfolio or project name. The project or portfolio info is displayed in the right-hand panel if the [**Open issues in side panel** option](../user/personal.md#choose-theme) is enabled in the {{ tracker-name }} interface settings.

## Bulk editing projects {#bulk-change}

In project lists, you can use bulk edit operations to make similar changes to multiple projects or portfolios in one go. To do this:

1. In the left-hand panel, select ![](../../_assets/console-icons/folders.svg)&nbsp;**Projects** and open one of the lists:

   * **Full list of my projects**
   * **All portfolios and projects**

1. Go to the **List** or **Structure** tab.
1. Set ![check](../../_assets/console-icons/check.svg) next to the box next to the portfolios and projects you want to edit.

   If you want to select all the listed portfolios and projects at once, set ![check](../../_assets/console-icons/check.svg) above the list.

1. Under the list of portfolios and projects, select the operation you need:

   * **Change status**: Select a status from the list.
   * **Assign person in charge**: Enter a username or name in the search bar and select a user.
   * **Move to portfolio**: In the window that opens, select an existing portfolio or create a new one using the relevant tab. If one or several of the selected projects and portfolios already belong to another portfolio, this operation will remove them from the current portfolio and place in the new one.
   * ![](../../_assets/console-icons/ellipsis.svg) → **Edit parameters**: In the window that opens, edit the parameters and click **Apply**. If the fields you need are not in the list, click **Edit parameter list** to add them.
   * ![](../../_assets/console-icons/ellipsis.svg) → **Delete**: Delete the selected projects and portfolios.

1. After the operation is complete, you will be notified of the number of portfolios and projects you successfully edited in the bottom-right corner.