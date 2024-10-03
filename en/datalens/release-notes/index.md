---
title: "{{ datalens-full-name }} release notes: August 2024"
description: "Check out {{ datalens-full-name }} release notes for August 2024."
---

# {{ datalens-full-name }} release notes: August 2024


* [Changes in basic features](#base)
* [Changes available with the _Business_ service plan](#business)

## Changes in basic features {#base}



### Field search in the wizard and dataset {#search-in-wizard}

In the wizard and dataset, added the option to search not only by name, but also by field description.


### List of published objects {#public-objects-list}

The {{ datalens-short-name }} instance [admin](../security/roles.md#datalens-admin) may [view a list](../concepts/datalens-public.md#public-objects-list) of all published objects.


### Support request form {#support-form}

Updated the form for creating a support request.


![image](../../_assets/datalens/release-notes/support-form.png)



### Selector title position {#selector-title-position}

Added a selector setting allowing you to specify the title position: `Left` (default) or `Top`.


### **Selector** widget improvements {#group-selectors-fix}

Fixed errors when working with group selectors where:

* Widget failed to revert to its original height after cancelling edits to a selector.
* Dashboard did not work properly after cancelling selector deletion in a widget with two selectors and autoupdate enabled.
* Navigation window reopened after selecting a dataset in a widget.
* Widget width failed to adjust correctly after adding other selectors to the same group.

### Displaying a tooltip next to the selector title {#selector-tooltips}

Fixed an error where the system tooltip next to the selector title remained visible when hovering over ![icon](../../_assets/console-icons/circle-question.svg).

### Tooltip text in selectors {#selector-hint-text}

In selectors, fixed the **Tooltip** setting error where the text from the dataset field description failed to get added to the tooltip text field.


### Autoupdate of selectors on a public dashboard {#selector-auto-update}

Fixed an error where a public dashboard failed to work properly after enabling the **Dependent selector autoupdate** setting for a selector on that dashboard.


### SQL source name in a dataset {#dataset-sql-source-name}

Fixed an error where, after each subquery edit, the SQL source name was reset to the default one in the dialog box for [adding the SQL source](../operations/dataset/add-data.md) to a dataset.


### Displaying heat map charts {#heat-map-fix}

Fixed the display of [heat map](../visualization-ref/heat-map-chart.md) charts in the wizard.


### Link to documentation in the migration section {#migrate-link}.

Fixed the link to [documentation](../concepts/organizations.md#migration) in the description of the **Migrating from the folder to the organization** section.

### Usernames in {{ datalens-short-name }} Usage Analytics Light {#usage-analytics-light-user-name}

Fixed the display of usernames in [{{ datalens-short-name }} Usage Analytics Light](../operations/connection/create-usage-tracking.md#light-dash).

## Changes available with the _Business_ service plan {#business}

### Disabling publication of objects {#publication-disable}

Added the option to [disable publication](../concepts/datalens-public.md#publication-disable) of charts and dashboards at the {{ datalens-short-name }} instance level.

### Embedding private objects {#private-embedded-hints}

Improved the interface for [embedding private objects](../security/private-embedded-objects.md):

* In the **Embedding keys** dialog box, added tooltips on private object embedding with links to the relevant documentation.
* In the **Create embedding** dialog box, the **Key** field is blocked if the workbook does not contain any valid keys for the object.
* In the **Embedding settings** dialog box:
  
  * Added tooltips on embedding a private object with links to the relevant documentation.
  * In the table with the list of embeddings:

    * When hovering over a row, you will now see buttons for copying the embedding ID and name.
    * Clicking a row will open a window with embedding info in view mode.
    * Display color of dependent objects and parameters was changed.
    * Parameters and dependent objects displayed in the button now also indicate the number of objects that did not fit (if there are more than three objects).

