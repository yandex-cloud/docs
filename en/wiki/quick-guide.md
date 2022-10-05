# Creating the first page

Try out {{ wiki-name }} features by creating your first Wiki page. The page will be created in your personal cluster, so don't be afraid to experiment.

{% if audience == "internal" %}

To learn about the basic {{ wiki-name }} features, you can also [take the course on Moebius](https://moe.yandex-team.ru/courses/my/course/904).

{% endif %}

## Create a Wiki page {#create}

To create a Wiki page in your personal cluster:

1. [Go to {{ wiki-name }}]({{ link-wiki }}) and in the panel on the left, click ![](../_assets/wiki/svg/create-page.svg) **Create page**.

1. Select the **Page** type.

1. In the **Name** field, enter the page name.

1. The address field is filled in automatically. Don't edit it if this is your first time creating a Wiki page.

1. Select **Personal cluster**.

1. Click **Create**.

1. Paste this sample to the entry field on the left or come up with your own text:

    ```
    # First-level title
    ## Second-level title
    Text of the cluster.
    Sample [link]({{ link-yandex }})
    ### Third-level title
    *Text is in italics.* ** Text is highlighted in bold.**
    ~~Strikethrough~~. `Fragment of the source code`
    Bulleted list:
    * List item
      * Sub-item
      * Sub-item
    * List item
    
    Numbered list:
    1. List item
    2. List item
    3. List item
    
    Example of a table:
    
    |header 1|header 2|header 3|
    |---|---|---|
    |cell 11|cell 12|cell 13|
    |cell 21|cell 22||
    ```

    {% cut "See the result" %}

    ![](../_assets/wiki/example-wiki-page.png =500x)

    {% endcut %}

1. Click **Save**.

A list of all your pages is available in the top {{ wiki-name }} panel in the menu ![](../_assets/wiki/svg/structure-icon.svg) **Cluster structure**.

## Configuring access {#access}

To configure access to your page:

1. Open the page.

1. At the top of the page, click the button that specifies the access mode for the page (by default **Available to all employees**).

1. Specify who will be able to view the page:

    - **Same as parent page**: The access level is inherited from the parent page.

    - **All employees**: All employees of your company.

    - **Only authors**: Only [authors](page-management/edit-owner.md) can view and edit the page.

    - **Specific employees**: Enter usernames of users that should be able to view and edit the page.

    {% note warning %}

    It is not recommended to change the access settings for [{{ wiki-name }} home page]({{ link-homepage }}).

    By default, the author of the main page {{ wiki-name }} is a service account. If the "Only page authors" access is selected for this page, access for other users will be blocked. To remove the block, click the link [{{link-homepage-access}}]({{ link-homepage-access }}) and change the access parameters.

    {% endnote %}

1. Click **Save**.

