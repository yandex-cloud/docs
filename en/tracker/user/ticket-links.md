# Editing issue links

You can link issues to other issues to group multiple issues based on a common topic or set the issue hierarchy.

The number of links to an issue is unlimited. The list of related issues is shown under the issue description.

You can also link issues and [repository commits](#section_commit).

{% note info %}

Issue links are created automatically when an issue key is entered into the issue's description or comment body.

{% endnote %}

## Adding a link {#add-link}

{% list tabs %}

- Web interface

    To add a link to another issue:

    1. Select **Actions** → **Add link**.

    1. Choose the appropriate [link type](links.md).

    1. Specify the key of the issue to link to. You can find the key on the issue page, under the title (for example, `TEST-1234`).

    1. Click **Add link**.

- Mobile app

    To add a link to another issue:

    1. Insert the issue key into the issue's description or comment body. You'll see the linked issue on the **Related** tab.

    1. If necessary, [change the link type](#change-link-type) to any of the ones available.

{% endlist %}

## Creating a sub-issue {#create-subtask}

Complex tasks can be divided into simpler sub-issues and tracked separately. After creating a sub-issue, you can change the [link type](links.md).

{% list tabs %}

- Web interface

    To create a sub-issue:

    1. Open the issue page to create a sub-issue for.

    1. Select **Actions** → **Create sub-issue**.

    1. Fill in the fields the same way as when [creating a new issue](#create-task).

    1. Click **Create**. You'll see a link to the parent issue next to the sub-issue name.

- Mobile app

    To create a sub-issue:

    1. Open the issue to create a sub-issue for.

    1. In the upper-right corner, tap ![](../../_assets/tracker/dots.png) and select **Create sub-issue**.

    1. Fill in the fields the same way as when [creating a new issue](#create-task).

    1. Tap **Create issue**. You'll see a link to the parent issue next to the sub-issue name.

{% endlist %}

## Changing the link type {#change-link-type}

{% list tabs %}

- Web interface

    To change an issue's [link type](links.md):

    1. Open the page of one of the two linked issues.

    1. In the list under the issue description, select the link whose type you want to change.

    1. Next to the linked issue, click ![](../../_assets/tracker/link.png) and choose a new type.

- Mobile app

    To change an issue's [link type](links.md):

    1. Open one of the two linked issues.

    1. Go to the **Related** tab.

    1. Next to the linked issue, tap ![](../../_assets/tracker/dots.png) → **Change link type** and choose a new type.

{% endlist %}

## Removing a link {#delete-link}

{% list tabs %}

- Web interface

    To remove an issue's link:

    1. Open the page of one of the two linked issues.

    1. In the list under the issue description, select the link you want to remove.

    1. Next to the linked issue, click ![](../../_assets/tracker/remove-task-type.png).

- Mobile app

    To remove an issue's link:

    1. Open one of the two linked issues.

    1. Go to the **Related** tab.

    1. Next to the linked issue, tap ![](../../_assets/tracker/dots.png) and select **Remove link**.

{% endlist %}

## Creating a sub-issue from an issue {#make-subtask}

You can integrate your issue with a larger parent issue:

1. Select **Actions** → **Convert to sub-issue**.

1. Specify the key for the parent issue. You can find the key on the issue page, under the title (for example, `TEST-1234`).

1. Click **Save**.

## Changing the parent issue {#edit-parent-task}

1. Open the sub-issue page.

1. Click ![](../../_assets/tracker/edit-parent.png) next to the name of the parent issue at the top of the page.

1. Enter the key of the issue that you want to make the parent.

1. Click **Save**.

## Removing the link to a parent issue {#delete-parent-task}

To remove the link to a parent issue:

1. Open the sub-issue page.

1. Click ![](../../_assets/tracker/edit-parent.png) next to the name of the parent issue at the top of the page.

1. Click **Remove link**.

## Linking a commit to an issue {#section_commit}

You can link an issue to a commit, provided its repository is [linked to {{ tracker-name }}](../manager/add-repository.md). To do this, specify the issue key in the commit comment. You can view linked commits the following ways:

- On the **Commits** tab on the issue page.
- On the **Commits** tab on the queue page.

If you don't see the **Commits** tab, make sure it's enabled in your [queue settings](../manager/edit-queue-general.md).

