# Creating pages

_Pages_ are regular pages that can contain text, images, tables, attached files, and so on.

There are multiple ways to create pages:

- [From any {{ wiki-name }} page](#create-page) by manually setting the address of the new page.

- [In a specific cluster](#create-subpage) by creating a subpage.

## Setting the page address manually {#create-page}

To create a new page:

1. In the in {{ wiki-name }} upper panel, click **Create**.

1. Select **Page**.

1. Enter your page title.

1. Choose which cluster your page will be located in:

    - **Personal cluster** (by default): Create a page in your [personal cluster](structure.md#personal_cluster).

    - **Current cluster**: Create a subpage for the current page.

    - **New cluster**: Create a new [top-level page](structure.md#structure).

    If necessary, you can change the page address manually.

    {% note tip %}

    The `~` symbol at the beginning of the line indicates that the address is specified relative to your personal cluster. The `!` symbol at the beginning of the line means that the address is specified relative to the current page.

    You can enter URLs for pages that do not exist. For example, you can create a page at `~/foo/bar`, even if the page `~/foo` doesn't exist.

    {% endnote %}

1. Click **Create**.

1. [Add text to the page](basic-markup.md) and save the changes.

## Creating cluster subpages {#create-subpage}

You can create a page in a specific cluster:

1. Go to the cluster.

1. In the upper-right corner of the page, click **Actions** and select **Create a subpage**.

1. Select **Page**.

1. Enter your page title.

    The **Address** field is filled in automatically. You can edit the address if necessary. The `!`  symbol at the beginning of the line means that the address is specified relative to the current cluster.

1. Click **Create**.

1. Enter the page text and save your changes.

#### See also

- [{#T}](page-managment/access-setup.md)

- [{#T}](edit-page.md)

- [{#T}](create-note.md)

- [{#T}](create-grid.md)

- [{#T}](delete-page.md)

