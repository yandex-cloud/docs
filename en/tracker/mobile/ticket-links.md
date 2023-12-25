# Editing issue links

You can link issues to other issues to group multiple issues based on a common topic or set the issue hierarchy.

The number of links per issue is unlimited. The list of related issues is shown under the issue description.

You can also link issues and [repository commits](#section_commit).

{% note info %}

Issue links are created automatically when an issue key is entered into the issue's description or comment body.

{% endnote %}

## Adding a link {#add-link}

Create links with other issues:

1. Insert the issue key into the issue's description or comment body. You will see the linked issue in the **{{ ui-key.startrek.ui_components_IssueTabs.links-tab }}** tab.

1. If necessary, change the [link type](#change-link-type) to any of the ones available.

## Creating a sub-issue {#create-subtask}

You can break down your complex issues into simpler sub-issues and track their resolution separately. After creating a sub-issue, you can change the [link type](../user/links.md).

To create a sub-issue:

1. Open the issue to create a sub-issue for.

1. In the top-right corner of the page, click ![](../../_assets/horizontal-ellipsis.svg) and select **Create sub-issue**.

1. Fill in the fields the same way as when [creating a new issue](./create-ticket.md).

1. Click **{{ ui-key.startrek.ui_components_CreateIssueForm.create-issue }}**. You will see a link to the parent issue next to the sub-issue name.

## Changing the link type {#change-link-type}

To change an issue's [link type](../user/links.md):

1. Open one of the two linked issues.

1. Click the **{{ ui-key.startrek.ui_components_IssueTabs.links-tab }}** tab.

1. Next to the linked issue, tap ![](../../_assets/horizontal-ellipsis.svg) → **Change link type** and choose a new type.

## Removing a link {#delete-link}

To remove an issue's link:

1. Open one of the two linked issues.

1. Click the **{{ ui-key.startrek.ui_components_IssueTabs.links-tab }}** tab.

1. Next to the linked issue, click ![](../../_assets/horizontal-ellipsis.svg) and select **Remove link**.
