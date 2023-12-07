# Project portfolios

In {{ tracker-name }}, a portfolio is a set of [projects](project-new.md) and other portfolios grouped into a single activity area. Portfolios help you structure and manage your project activities.

## Getting started {#quick-start}

To start working on a project portfolio in {{ tracker-name }}, [create](create-project.md#create-portfolio) a new portfolio and add projects to it. A portfolio may include both projects and other portfolios.

You can use a [Gantt chart](../gantt/project.md) to schedule your work under a project portfolio and manage the deadlines of projects within a single activity area.

## Portfolio page {#page}

In {{ tracker-name }}, you can open any portfolio available to you from the navigation panel on the left: click ![](../../_assets/tracker/svg/project.svg)&nbsp;**Projects** or follow the [direct link]({{ link-tracker }}pages/projects/list) and select a project portfolio from the list.

The project portfolio page shows information about the portfolio team and current status, as well as lists projects included in the portfolio:

* **{{ ui-key.startrek.ui_components_portfolios_Header.description-tab }}** tab. It includes the portfolio description, status, timeframes, author and employee in charge of the portfolio, list of team members, comments, customers, and tags.

* **{{ ui-key.startrek.ui_components_portfolios_Header.projects-tab }}** tab. The list shows both open and closed portfolios and projects. You can reorder and move them across portfolios.

* **Gantt chart** tab. This is a road map for portfolio projects and issues included in them. The Gantt chart specifies the timeframes of the portfolios, projects, and issues and relationships between them. For more information, see [{#T}](../gantt/project.md).

You can track your portfolio's progress indicator in the top-right corner of the portfolio page. The colors and sizes of the indicator bars change depending on the statuses of portfolios and projects explicitly nested in this portfolio. The portfolios and projects nested in the portfolios of this portfolio are not displayed in the progress indicator.

To commit changes to the portfolio activities, click **Update status**. In the status transition window, you can update the status and end date of your project portfolio and add a comment.

To restrict access to the portfolio, click the lock icon in the top-right corner and select **Members only**. Doing so will make the portfolio only available to the users listed in the **Participants**, **Author**, **Clients**, and **Responsible** fields.

{% note info %}

Access to a portfolio or project does not automatically grant access to other portfolios or projects associated with them. Permissions to access individual portfolios and projects must be granted separately.

{% endnote %}