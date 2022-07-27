# Creating a Wiki page

A _Wiki page_ is a simple page containing text, images, tables, attached files, and more.

There are different ways you can create a Wiki page:

- [From any page {{ wiki-name }}](#create-page) by manually setting the address of the new Wiki page.

- [By creating a subpage in a specific cluster](#create-subpage).

## Setting the page address manually {#create-page}

To create a new Wiki page:

1. In the top {{ wiki-name }} menu, click **Create**.

1. Select **Page**.

1. Create a heading for your Wiki page.

1. Choose a cluster for your Wiki page:

    - **Personal cluster**: create a Wiki page in your [personal cluster](structure.md#personal_cluster).

    - **Current cluster**: create a subpage for the current page.

    - **New cluster**: create a new [top-level page](structure.md#structure).

    If necessary, you can manually change the page address.

    {% note tip %}

    The `~` symbol at the start of a row indicates that the address is relative to your personal cluster. The `!` symbol at the start of a row indicates that the address is relative to the current page.
    You can set a page address for a page that doesn't exist. For example, you set the page address to `~/foo/bar` even the `~/foo` page doesn't exist.

    {% endnote %}

1. Click **Create**.

1. [Add text to the](basic-markup.md) page and save your changes.

## Create cluster subpages {#create-subpage}

You can create a Wiki page in a specific cluster:

1. Go to the cluster.

1. Click **Action** in the upper-right corner and select **Create subpage**.

1. Select **Page**.

1. Enter your title.

    The **Address** field is filled in automatically. You can edit the address if necessary. The `!` symbol at the start of a row indicates that the address is relative to the current cluster.

1. Click **Create**.

1. Enter the page text and save your changes.

#### See also

- [{#T}](page-management/access-setup.md)

- [{#T}](edit-page.md)

- [{#T}](create-grid.md)

{% if audience == "internal" %}

- [{#T}](wysiwyg-create.md)

{% endif %}

- [{#T}](delete-page.md)

