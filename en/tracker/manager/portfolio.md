# Project portfolios

In {{ tracker-name }}, a portfolio is a set of [projects](project-new.md) and other portfolios grouped into a single activity area. Portfolios help you structure and manage your project activities.

## Getting started {#quick-start}

To start working on a project portfolio in {{ tracker-name }}, [create](create-project.md#create-portfolio) a new portfolio and add projects to it. A portfolio may include both projects and other portfolios.

You can use a [Gantt chart](../gantt/project.md) to schedule your work under a project portfolio and manage the deadlines of projects within a single activity area.

## Portfolio page {#page}

In {{ tracker-name }}, you can open any portfolio available to you from the navigation panel on the left: click ![](../../_assets/tracker/svg/project.svg)&nbsp;**Projects** or follow the [direct link]({{ link-tracker }}pages/projects/list) and select a project portfolio from the list.

The project portfolio page shows information about the portfolio team and current status and specifies the projects included in the portfolio:

* **{{ ui-key.startrek.ui_components_portfolios_Header.description-tab }}** tab. Portfolio description, status, timeline, portfolio author and owner, list of team members, comments, customers, [links](./create-portfolio.md#links) to other portfolios and projects, tags.

* **{{ ui-key.startrek.ui_components_portfolios_Header.projects-tab }}** tab. The list shows both open and closed portfolios and projects. You can reorder them, move across portfolios, and filter by the parameters you specify.

* **Gantt chart** tab. This is a roadmap for portfolio projects and issues included in them. The Gantt chart specifies the timeframes of the portfolios, projects, and issues and relationships between them. For more information, see [{#T}](../gantt/portfolio.md).

You can track your portfolio's progress indicator in the top-right corner of the portfolio page. The colors and sizes of the indicator bars change depending on the statuses of portfolios and projects explicitly nested in this portfolio. The portfolios and projects nested in the portfolios of this portfolio are not displayed in the progress indicator.

To record portfolio updates, type in a comment. If you need to change the portfolio status, select a new status at the bottom panel before submitting the comment.

The portfolio is available to all the organization's employees and **Followers** by default. To restrict access to the portfolio, click the lock icon in the top-right corner and select **Members only**. This will make the portfolio available only to the users specified in the **Author**, **Person in charge**, **Customers**, **Followers**, and **Participants** fields.

{% note info %}

Access to a portfolio or project does not automatically grant access to other portfolios or projects associated with them. Permissions to access individual portfolios and projects must be granted separately.

{% endnote %}