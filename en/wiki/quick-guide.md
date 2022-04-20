# Create your first Wiki page

Try out {{ wiki-name }} features by creating your first page. The page will be created in your personal cluster, so don't be shy about experimenting.


## Create a Wiki page {#create}

To create a Wiki page in your personal cluster:

1. [Go to {{ wiki-name }}]({{ link-wiki }}) and on the top panel click **Create**.

1. Fill in the **Header** field and click **Create**.

    The address field is filled in automatically. Don't edit the address field if this is your first time creating a Wiki page.

1. Copy this example to the left panel or create your own:

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

You can find a list of all pages you've created on the top panel {{ wiki-name }} under **Bookmarks** → **My Pages**.

## Configure access {#access}

To configure access to your page:

1. Open the page.

1. At the top of the page, click the button that displays the page's access status (**All staff employees** is set by default).

1. Specify who will be able to view the page:

    - **Same as parent page**: The access level is carried over from the parent page.

    - **All staff employees**: All employees of your organization.

    - **Only authors**: Only the page owners can view and edit the page.

    - **Specific employees**: Specify the usernames of people to be granted viewing and editing access.

    {% note warning %}

    Changing access settings for [{{ wiki-name }} home page]({{ link-homepage }}) is not recommended.

    By default, the owner of the {{ wiki-name }} homepage is a service account. If this page's access mode is set to "Only page owners", all other users will be blocked from accessing the page. To open access to other users, follow the link [{{link-homepage-access}}]({{ link-homepage-access }}) and change access settings for the page.

    {% endnote %}

1. Click **Save**.

