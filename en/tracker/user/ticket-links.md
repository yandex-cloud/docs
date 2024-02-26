# Editing issue links

You can link issues to other issues to group multiple issues based on a common topic or set the issue hierarchy.

The number of links per issue is unlimited. The list of related issues is shown under the issue description.

You can also link issues and [repository commits](#section_commit).

{% note info %}

Issue links are created automatically when an issue key is entered into the issue's description or comment body.

{% endnote %}

## Adding a link {#add-link}

Create links with other issues:

1. Under the issue description, click **Add link**.

1. Select a relevant [link type](links.md) and create a link:

   * To create an issue, click the **New issue** tab. Give your issue a name and press **Enter**.

   * If the issue already exists, click **Existing issue**, specify the issue key or name, and select the issue from the list. You can find the key on the issue page, under the title (for example, `TEST-1234`).

To add a link to multiple issues, use [bulk operations](../manager/bulk-change.md#add-links).

## Creating a sub-issue {#create-subtask}

You can break down your complex issues into simpler sub-issues and track their resolution separately. After creating a sub-issue, you can change the [link type](links.md).

To create a sub-issue:

1. Open the issue page to create a sub-issue for.

1. In the top-right corner, select **{{ ui-key.startrek.ui_components_issue-actions_IssueMenu.title }}** → **{{ ui-key.startrek.ui_components_issue-actions_IssueMenu.create-subissue }}**.

1. Fill in the fields the same way as when [creating a new issue](./create-ticket.md).

1. Click **{{ ui-key.startrek.ui_components_CreateIssueForm.create-issue }}**. You will see a link to the parent issue at the top of the page above the sub-issue name.

## Changing the link type {#change-link-type}

To change an issue's [link type](links.md):

1. Open the page of one of the two linked issues.

1. In the **Related** list under the issue description, select the link whose type you want to change.

1. Next to the linked issue, tap ![](../../_assets/horizontal-ellipsis.svg) → **Change link type** and choose a new type.

## Removing a link {#delete-link}

To remove an issue's link:

1. Open the page of one of the two linked issues.

1. In the **Related** list under the issue description, select the link you want to remove.

1. Next to the linked issue, click ![](../../_assets/horizontal-ellipsis.svg) → ![](../../_assets/tracker/svg/icon-remove.svg) **Remove link**.

## Creating a sub-issue from an issue {#make-subtask}

You can make your issue a part of a larger (parent) issue:

1. In the top-right corner, select **{{ ui-key.startrek.ui_components_issue-actions_IssueMenu.title }}** → **{{ ui-key.startrek.ui_components_issue-actions_IssueMenu.to-subissue }}**.

1. Specify the key or name of the parent issue, then select it from the list. You can find the key on the issue page, under the title (for example, `TEST-1234`).

1. Click **Save**.

## Changing the parent issue {#edit-parent-task}

1. Open the sub-issue page.

1. In the top-right corner, select **{{ ui-key.startrek.ui_components_issue-actions_IssueMenu.title }}** → **{{ ui-key.startrek.ui_components_issue-actions_IssueMenu.to-subissue }}**.

1. Specify the key or name of the new parent issue, then select it from the list. You can find the key on the issue page, under the title (for example, `TEST-1234`).

1. Click **Save**.

## Removing the link to a parent issue {#delete-parent-task}

To remove the link to a parent issue:

1. Open the parent issue page.

1. In the **Related** list under the issue description, select the sub-issue the link to which you want to remove.

1. Next to the linked issue, click ![](../../_assets/horizontal-ellipsis.svg) → ![](../../_assets/tracker/svg/icon-remove.svg) **Remove link**.

## Linking a commit to an issue {#section_commit}

You can link an issue to a commit, provided its repository is [linked to {{ tracker-name }}](add-repository.md).

{% include [commits](../../_includes/tracker/add_commits.md) %}