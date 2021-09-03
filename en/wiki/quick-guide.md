# Getting started

Try out the features of {{ wiki-name }} by creating your first page. The page will be created in your personal cluster, so feel free to experiment.

{% note alert %}

To use {{ wiki-name }}, you need an account in [Yandex.Connect]({{ link-connect }}). Before you start working, make sure that the service is enabled. Learn more about how to enable or disable {{ wiki-name }} in [Yandex.Connect Help]({{ support-enable-wiki }}).

{% endnote %}

## Creating pages {#section_qvp_th2_sy}

To create a page in your personal cluster:

1. [Go to {{ wiki-name }}]({{ link-wiki }}) and click **Create** in the upper panel.

1. Fill in the **Title** field and click **Create**.

    The address field is filled in automatically. Don't edit it if this is your first time creating a page.

1. Copy this example into the left panel or create your own:

    ```
    # The first level header
    ## The second level header
    Some text.
    Here is a [link]({{ link-yandex }})
    ### Third-level title
    *Some italic text.* **Some bold text.**
    ~~Strikethrough text~~. `Piece of  source code`
    Here is an unordered list:
    * List item;
      * nested list item;
      * nested list item;
    * List item.
    
    Here is an ordered list:
    1. list item;
    2. list item;
    3. list item.
    
    Example table:
    
    |header 1|header 2|header 3|
    |---|---|---|
    |cell 11|cell 12|cell 13|
    |cell 21|cell 22||
    ```

    {% cut "See the result" %}

    ![](../_assets/wiki/example-wiki-page.png)

    {% endcut %}

1. Click **Save**.

A list of all your pages is available on the {{ wiki-name }} top panel in the menu **Bookmarks** → **My pages**.

## Configuring access {#section_drd_5h2_sy}

To configure access to your page:

1. Open the page.

1. At the top of the page, click the button that indicates page access (by default **All staff employees**).

1. Select who will be able to view the page:

    - **Same as parent page**: The access level is carried over from the parent page.

    - **All staff employees**: All employees of your organization.

    - **Only authors**: Only the page authors can view and edit the page.

    - **Specific employees**: Specify the usernames of people to grant access to view and edit the page.

    {% note warning %}

    We do not recommend changing access settings for the [{{ wiki-name }} home page]({{ link-homepage }}).

    By default, the author of the {{ wiki-name }} home page is a service account. If "Only authors" access is selected for this page, access for other users will be blocked. To unblock access, click the [{{link-homepage-access}}]({{ link-homepage-access }}) link and change the access parameters.

    {% endnote %}

1. Click **Save**.

