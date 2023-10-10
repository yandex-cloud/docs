# Github

In [{{ tracker-name }} issues](../about-tracker.md#zadacha), you can automatically add links to commits from GitHub. To do this, specify the appropriate issue's [key](../glossary.md#key) in the commit comment. The links will be placed on the **{{ ui-key.startrek-backend.fields.issue.commits-key-value }}** tab.


## Connecting a repository {#repo}

To connect your repository on [GitHub](https://github.com) to {{ tracker-name }}:

{% list tabs %}

- Public repository

   1. {% include [make sure you are admin](../../_includes/tracker/make-sure-admin.md) %}

   1. {% include [path to the repository](../../_includes/tracker/repository-path.md) %}

   1. Choose GitHub in the **{{ ui-key.startrek.blocks-desktop_repository-modal.platform }}** field.

   1. Enter the public repository address in the `https://github.com/<repository_owner_login>/<repository_name>` format. Leave the **{{ ui-key.startrek.blocks-desktop_repository-modal.token }}** field blank.

   1. Click **{{ ui-key.startrek.blocks-desktop_repository-modal.button--connect }}**.

   1. Make sure that the repository status in {{ tracker-name }} is **{{ ui-key.startrek.blocks-desktop_page-admin-tab_type_repositories.status--success }}**.

- Private repository

   1. {% include [make sure you are admin](../../_includes/tracker/make-sure-admin.md) %}

   1. {% include [path to the repository](../../_includes/tracker/repository-path.md) %}

   1. Choose GitHub in the **{{ ui-key.startrek.blocks-desktop_repository-modal.platform }}** field.

   1. Get an OAuth token for your repository on GitHub:

      - Log in to GitHub. If the repository is linked to an organization on GitHub, make sure that you have admin rights for it.

      - Click your profile picture in the top-right corner and select **Settings**.
      - In the left-hand panel, select **Developer settings** → **Personal access token** → **Tokens (classic)**.
      - Click **Generate new token**.

      - Enter a name for the token.

      - Configure permissions for the token. For {{ tracker-name }} to operate properly, enable the **repo** and **read:org** options:

         ![](../../_assets/tracker/github-token-settings.png)

      - Click **Generate token**.

      - Copy the token to the clipboard.

         {% note alert %}

         The token value is displayed only once. If you close the page, you will not be able to view it again.

         {% endnote %}

   1. Enter the repository address in the `https://github.com/<repository_owner_login>/<repository_name>` format and specify the access token.

   1. Click **{{ ui-key.startrek.blocks-desktop_repository-modal.button--connect }}**.

   1. Make sure that the repository status in {{ tracker-name }} is **{{ ui-key.startrek.blocks-desktop_page-admin-tab_type_repositories.status--success }}**.

{% endlist %}

To link a commit to an issue in {{ tracker-name }}, specify the issue key in the comments for the commit. You can view the linked commits:

- In the **{{ ui-key.startrek-backend.fields.issue.commits-key-value }}** tab on the issue page.
- In the **{{ ui-key.startrek.blocks-desktop_b-page_type_queue.tab_commits }}** tab on the queue page.

If the **{{ ui-key.startrek.blocks-desktop_b-page_type_queue.tab_commits }}** tab is missing, make sure it is enabled in your [queue settings](../manager/edit-queue-general.md#ul_gcz_xlp_m2b).

## Own server {#on-premise}

{% include [on-premise server](../../_includes/tracker/on-premise-server.md) %}
