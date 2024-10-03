---
title: Managing portfolios in {{ tracker-full-name }}
description: This tutorial explains how to manage {{ tracker-full-name }} portfolios.
---

# Managing portfolios

In this section, you will learn how to manage your portfolios:

* [Creating a portfolio](#create-potfolio)
* [Setting up a hierarchy](#add-portfolios-projects)
* [Adding links for a portfolio](#links)
* [Deleting a portfolio](#delete)

## Creating a portfolio {#create-potfolio}

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


## Setting up a hierarchy {#add-portfolios-projects}

### Adding a nested portfolio or project {#add-nested}

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

### Adding a parent portfolio {#add-parent}

{% note alert %}

A project or portfolio can have only one parent portfolio.

{% endnote %}

1. Go to the project or portfolio page and click **Included in the portfolio** in the right-hand panel.
1. Start typing the portfolio name and pick the option you need from the list that appears.
1. Click **Save**.

## Adding links for a portfolio {#links}

You can link a portfolio to other projects or portfolios to group entities based on a common topic or highlight their hierarchy.

You can find a list of linked projects and portfolios on the **About portfolio** tab under the portfolio description.

### Creating a link {#create-link}

To create a link to other project or portfolio:

1. Go to the **About portfolio** tab and click ![plus](../../_assets/console-icons/plus.svg)**Add link**.
1. Choose the appropriate link type:

   * **Depends on**: Start of work on the current portfolio depends on the completion of another project or portfolio.
   * **Blocks**: Execution of this portfolio blocks the start of work on another project or portfolio.

1. Choose an entity to create a link to:

   * **New**: To create a new entity. Choose entity type (![briefcase](../../_assets/console-icons/briefcase.svg) for a portfolio and ![folders](../../_assets/console-icons/folders.svg) for a project), enter a name, specify the deadline and click **Create**.
   * **Existing**: If a project or portfolio already exists. Specify the key and the name of the entity and select it from the list.

The link will appear in the list of linked projects and portfolios.

### Changing the link type {#change-link-type}

To change a portfolio's link type:

1. Open the portfolio page.
1. Go to the **About portfolio** tab.
1. In the **Depends on** or **Blocks** list under the portfolio description, select the link whose type you want to change.
1. Next to the linked entity, click ![ellipsis](../../_assets/console-icons/ellipsis.svg) → **Change link type** and choose a new type.

### Removing a link {#delete-link}

To remove an entity's link:

1. Open the portfolio page.
1. Go to the **About portfolio** tab.
1. In the **Depends on** or **Blocks** list under the portfolio description, select the link you want to remove.
1. Next to the linked entity, click ![ellipsis](../../_assets/console-icons/ellipsis.svg) → **Remove link**.

## Bulk editing projects in a portfolio {#bulk-change}

To bulk edit multiple projects in a portfolio:

1. In the left-hand panel, select ![](../../_assets/console-icons/folders.svg)&nbsp;**Projects** and open the portfolio you need.
1. In the selected portfolio, go to the **Projects** tab.
1. Set ![check](../../_assets/console-icons/check.svg) next to the box next to the portfolios and projects you want to edit.

   If you want to select all the listed portfolios and projects at once, set ![check](../../_assets/console-icons/check.svg) above the list.

1. Under the list of portfolios and projects, select the operation you need:

   * **Change status**: Select a status from the list.
   * **Assign person in charge**: Enter a username or name in the search bar and select a user.
   * **Move to portfolio**: In the window that opens, select an existing portfolio or create a new one using the relevant tab. If one or several of the selected projects and portfolios already belong to another portfolio, this operation will remove them from the current portfolio and place in the new one.
   * ![](../../_assets/console-icons/ellipsis.svg) → **Edit parameters**: In the window that opens, edit the parameters and click **Apply**. If the fields you need are not in the list, click **Edit parameter list** to add them.
   * ![](../../_assets/console-icons/ellipsis.svg) → **Delete**: Delete the selected projects and portfolios.

1. After the operation is complete, you will be notified of the number of portfolios and projects you successfully edited in the bottom-right corner.

## Deleting a portfolio {#delete}

{% note alert %}

A portfolio can be deleted by its author or the user specified in the **Responsible** field.

{% endnote %}

To delete a portfolio:

1. In the left-hand panel, select ![](../../_assets/tracker/svg/project.svg)&nbsp;**Projects** or follow the [direct link]({{ link-tracker }}pages/projects) and open the portfolio page.

1. In the top-right corner, click ![](../../_assets/horizontal-ellipsis.svg) and select **{{ ui-key.startrek.ui_components_portfolios_PortfolioMenu.remove-portfolio }}**.
