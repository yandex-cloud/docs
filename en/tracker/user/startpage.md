# Start page


The home page opens on clicking the {{ tracker-name }} logo. You can [select](#change-start-page) which page to use as a homepage. By default, [**{{ ui-key.startrek.ui_components_page-my_PageMy.page-title }}**](https://tracker.yandex.ru/pages/my) is selected as the homepage: this is the user's personal page that includes the following widgets:

* [Information for employees](#staff-widget): This widget is set up by the administrator for every employee in the organization.
* [Useful information about {{ tracker-name }}](#tracker-info).
* [Invitation to {{ tracker-name }}](#invite).
* [Note](#notes).
* [Issues](#tasks).

## My page {#my-page}

{% note tip %}

To select widgets and position them, click **{{ ui-key.yacloud.common.edit }}** in the top-right corner. Did you know that you can expand or drag widgets, delete unneeded widgets and add new widgets.

You can also edit widgets using ![image](../../_assets/tracker/dots.png).

{% endnote %}

### Widget with information for employees {#staff-widget}

The widget is positioned in the upper part of the page and the shown similarly for all employees in the organization. It is designed for publishing important links and news. The page can only include one widget with information for employees.

The widget with information for employees is published by the organization administrator, and only the administrator can edit or delete it.

To publish a widget:
1. On the **{{ ui-key.startrek.ui_components_page-my_PageMy.page-title }}** page, click **{{ ui-key.startrek.ui_components_dashboard_DashboardHeader.dashboard-header-settings-button }}** → **{{ ui-key.startrek.ui_components_dashboard_DashboardHeader.dashboard-header-add-button }}** → **{{ ui-key.startrek.ui_components_dashboard_DashboardHeader.dashboard-header-add-orgAdmin }}**.
1. Enable **{{ ui-key.startrek.ui_components_dashboard_OrgAdminEditor.editor-published-field-label }}**.

   {% note tip %}

   Until the widget is published, only the administrator can see it.

   {% endnote %}

1. Fill out the contents of the widget.
1. Click **{{ ui-key.startrek.ui_components_dashboard_OrgAdminEditor.editor-save-button }}**.

### Widgets with useful information about {{ tracker-name }} {#tracker-info}

This widget is prepared by the {{ tracker-name }} team for all its users. It includes useful information, links to documentation, communication channel, and video tutorials for new employees. Familiarize yourself with the widget content to learn {{ tracker-name }} faster.

Users can delete this widget, but in this case, they risk missing some important updates in {{ tracker-name }}.

### Widget with invitation to Tracker {#invite}

This widget is only visible to organization administrators It describes the methods for inviting users to {{ tracker-name }}.

### Notes {#notes}

The notes are good for keeping records that will always be close at hand: on the home page. For creating records, you can use a built-in WYSIWYG editor and the Markdown markup as on [{{ wiki-name }} pages](../../wiki/static-markup).

### Issues {#tasks}

The widget with issues enables you to view a list of issues using a defined filter. For improved experience, users can add multiple widgets with issues to **My page**.

By default, three widgets are created on **My page**. They include the issues that are:
1. Reported by you.
1. Assigned to you.
1. Need your response.

By editing or adding a new widget with issues, you can set up:
* Name: The header of the widget.
* Number of issues per page: if there are more issues, the widget will include multiple pictures, and you will see page navigation buttons at the bottom of the page.
* Filter: The filter used for creating the issue list. You can use the name of an existing filter or use the query language to create an expression.
* Columns: Issue parameters to be shown in the widget.

## How to set up a start page {#change-start-page}



As a home page, you can use any [filter](create-filter.md), [dashboard](dashboard.md), or [issue board](../manager/create-agile-board.md).If you do so, you can still access **{{ ui-key.startrek.ui_components_page-my_PageMy.page-title }}** at the direct link: [https://tracker.yandex.ru/pages/my](https://tracker.yandex.ru/pages/my) or by clicking the home icon in the {{ tracker-name }} header.

For now, you can only change the home page in the old interface:
1. {% include [open-personal-settings](../../_includes/tracker/open-personal-settings.md) %}
1. Under **{{ ui-key.startrek.ui_components_NavigationBar.start-page-title }}**, choose the filter, dashboard, or issue board you want to see on the homepage.
1. Click **{{ ui-key.yacloud.common.save }}**.