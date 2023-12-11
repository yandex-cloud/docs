---
title: "Migrating a board to our new technologies in {{ tracker-full-name }}"
description: "Follow this guide to migrate a board to our new technologies."
---

# Migrating a board to our new technologies

Switching boards to [our new technologies](agile-new.md) allows you to add new features for effective issue planning:

* Speed. You will no longer need to reload the page after each change: everything will display on the board immediately.
* Sorting issues by any parameter.
* Mass editing of issues.
* Updated backlog and poker planning.
* Creating any columns with no link to the issue status.
* Flexible configuration of issue cards on the board.

{% note info %}

Starting from September 1, 2023, the boards with no migration restrictions will be transferred to the new technologies. You will still have an option to [switch back to the old board version](#backward).

{% endnote %}

## Migration process {#about-migration}

When migrating the board, the following is retained:

* ID
* Name
* Issues added
* Status distribution by column
* <q>{{ ui-key.startrek.ui_components_IssuesPresetSelect.preset_author }}</q> and <q>{{ ui-key.startrek.ui_components_IssuesPresetSelect.preset_assignee }}</q> filters
* Filter for adding issues

The board type is also retained during migration: **Basic** and **Kanban** (both have the same functionality) boards are converted into basic boards, while **Scrum** boards become boards with a backlog and sprints.

When migrating the board, the following is not retained:

* Filters with criteria written in the query language. They are not yet supported in the new board version. Therefore, you will need to recreate filters after migrating the board and formulate their criteria using parameters.

   {% note warning %}

   If you are using a filter like this with criteria written in the query language to add issues to your board, you will not be able to migrate the board until you replace the filter with a similar one that uses parameter-based criteria.

   {% endnote %}

* The ability to store over 2,000 issues, since the new board version has a limit on the number of issues. If your board contains more than 2,000 issues, it cannot be migrated. To avoid overflow on new boards, you can set up a filter to automatically remove issues from the board.

## Migration steps {#how-to-migrate}

The **Update your board** button is available to all board users. Any user can perform migration and changes will be visible to all board users.

{% note info %}

If you cannot see the **Update your board** button in your board's top panel, it means that your board has already switched to these technologies.

{% endnote %}

To perform migration:

1. In the top panel, click **Update your board**. Your board is verified for whether it can be migrated and the migration window opens.

1. Review the migration window:
   * If there are errors, follow the recommendations on how to fix them and try again.
   * If there are no errors, click **{{ ui-key.startrek.ui_components_agile_agile-board_AgileBoardMigrationForm.submit-btn }}**. This may take a few minutes.

## Switching back to the old board version {#backward}

If, after switching to our new technologies, you decide that they do not suit you, you can roll your board back to its original view. To do this, click ![](../../_assets/tracker/svg/actions.svg) → **{{ ui-key.startrek.ui_components_agile_agile-board_AgileBoardActionsMenu.migration-rollback }}** in the board's top panel and wait until it switches back.

{% note warning %}

If you enable a backlog on your **basic** board after migration, it will be converted into a **Scrum** board.

{% endnote %}

