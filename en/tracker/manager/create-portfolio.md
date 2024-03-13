---
title: "How to create a portfolio in {{ tracker-full-name }}"
description: "Follow this guide to create a portfolio."
---

# Creating a portfolio

To create a project portfolio:

1. Go to any page that a portfolio can be created from:

   * In the left-hand panel, select ![](../../_assets/tracker/svg/project.svg)&nbsp;**Projects** and click **Create** → **Portfolio**.
   * In the [list of portfolios and projects](my-projects.md) of the **Structure** tab, click **Create portfolio** under the list.
   * In the [list of portfolios and projects](my-projects.md) of the **List** tab, click **Create portfolio** under the list.

1. Enter a name for the portfolio, set its end date, and click **Create**.

1. In the **{{ ui-key.startrek.ui_components_portfolios_Header.description-tab }}** tab, add the following information:

   * Portfolio description: What you are working on and what goals you want to achieve.
   * Attachments: Working materials of the portfolio.
   * Checklist: List of milestones or goals of the portfolio.
   * **Status**: Specify the current stage of the portfolio.
   * **Start date** and **End date**.
   * **Responsible**, **Clients**, and **Participants**: Start typing the name or login of the employee and select a relevant option from the list.
   * **Tags**: Add or select the tags that would make it easier to find the portfolio.


## Linking portfolios and projects {#add-portfolios-projects}

#### Adding a nested portfolio or project {#add-nested}

1. Open the window for portfolio or project creation using one of these methods:
   * In the top-right corner of the portfolio page, click **Add** and select **Portfolio** or **Project**.
   * On the portfolio page, go to the **Projects** tab and click **Add project** or **Add portfolio**.
1. Fill in the fields of the project or portfolio creation window:
   * To create a new project or portfolio:
      1. Select **New**.
      1. Enter a name for the project or portfolio, leave the default end date or reset it, and click **Create**.

         {% note alert %}

         The end of the current quarter is set as the end date by default.

         {% endnote %}

   * To add an existing project or portfolio:
      1. Select **Existing**.
      1. Start typing the project or portfolio name and pick the option you need from the list that appears.

#### Adding a parent portfolio {#add-parent}

{% note alert %}

A project or portfolio can have only one parent portfolio.

{% endnote %}

1. Go to the project or portfolio page and click **Included in the portfolio** in the right-hand panel.
1. Start typing the portfolio name and pick the option you need from the list that appears.
1. Click **Save**.

## Deleting a portfolio {#delete}

{% note alert %}

A portfolio can be deleted by its author or the user specified in the **Responsible** field.

{% endnote %}

To delete a portfolio:

1. In the left-hand panel, select ![](../../_assets/tracker/svg/project.svg)&nbsp;**Projects** or follow the [direct link]({{ link-tracker }}pages/projects) and open the portfolio page.

1. In the top-right corner, click ![](../../_assets/horizontal-ellipsis.svg) and select **{{ ui-key.startrek.ui_components_portfolios_PortfolioMenu.remove-portfolio }}**.