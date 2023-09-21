# Connecting repositories to {{ tracker-name }}

{% note warning %}

Only an [administrator](../role-model.md) can connect repositories.

{% endnote %}

Connecting your repositories to {{ tracker-name }} enables you to link commits to issues. You can connect any number of repositories hosted on GitHub, GitLab, or Bitbucket.

You can also connect your own server associated with GitHub, GitLab, or Bitbucket to {{ tracker-name }}. In this case, all repositories that a token has access to will be connected to {{ tracker-name }}.

## GitHub {#section_mhj_yrk_m2b}

To connect your repository on [GitHub](https://github.com) to {{ tracker-name }}:

{% list tabs %}

- Public repository

   1. {% include [make sure you are admin](../../_includes/tracker/make-sure-admin.md) %}

   1. {% include [path to the repository](../../_includes/tracker/repository-path.md) %}

   1. Choose GitHub in the **{{ ui-key.startrek.blocks-desktop_repository-modal.platform }}** field.

   1. Enter the public repository address in the `https://github.com/<repository owner login>/<repository name>` format. Leave the **{{ ui-key.startrek.blocks-desktop_repository-modal.token }}** field blank.

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

      - Configure the token's access right. To make sure {{ tracker-name }} operates properly, enable the **repo** and **read:org** options:

         ![](../../_assets/tracker/github-token-settings.png)

      - Click **Generate token**.

      - Copy a token to the clipboard.

         {% note alert %}

         The token value is displayed only once. If you close the page, you will not be able to view it again.

         {% endnote %}

   1. Enter the repository address in the `https://github.com/<repository owner login>/<repository name>` format and specify the access token.

   1. Click **{{ ui-key.startrek.blocks-desktop_repository-modal.button--connect }}**.

   1. Make sure that the repository status in {{ tracker-name }} is **{{ ui-key.startrek.blocks-desktop_page-admin-tab_type_repositories.status--success }}**.

{% endlist %}

To link a commit to an issue in {{ tracker-name }}, specify the issue key in the comments for the commit. You can view the linked commits:

- In the **{{ ui-key.startrek-backend.fields.issue.commits-key-value }}** tab on the issue page.
- In the **{{ ui-key.startrek.blocks-desktop_b-page_type_queue.tab_commits }}** tab on the queue page.

If the **{{ ui-key.startrek.blocks-desktop_b-page_type_queue.tab_commits }}** tab is missing, make sure it is enabled in your [queue settings](edit-queue-general.md#ul_gcz_xlp_m2b).

## GitLab {#section_kjw_cy2_ggb}

To connect your repository on [GitLab](https://gitlab.com) to {{ tracker-name }}:

{% list tabs %}

- Public repository

   1. {% include [make sure you are admin](../../_includes/tracker/make-sure-admin.md) %}

   1. {% include [path to the repository](../../_includes/tracker/repository-path.md) %}

   1. Choose GitLab in the **{{ ui-key.startrek.blocks-desktop_repository-modal.platform }}** field.

   1. Enter the public repository address in the `https://gitlab.com/<repository owner login>/<repository name>` format. Leave the **{{ ui-key.startrek.blocks-desktop_repository-modal.token }}** field blank.

   1. Click **{{ ui-key.startrek.blocks-desktop_repository-modal.button--connect }}**.

   1. Make sure that the repository status in {{ tracker-name }} is **{{ ui-key.startrek.blocks-desktop_page-admin-tab_type_repositories.status--success }}**.

- Private repository

   {% note info %}

   Private repositories can only be accessed by users logged in to GitLab (**Internal project**) or the project team (**Private project**).

   {% endnote %}

   1. {% include [make sure you are admin](../../_includes/tracker/make-sure-admin.md) %}

   1. {% include [path to the repository](../../_includes/tracker/repository-path.md) %}

   1. Choose GitLab in the **{{ ui-key.startrek.blocks-desktop_repository-modal.platform }}** field.

   1. Get an OAuth token for your repository on GitHub:

      - Log in to GitLab.

      - Click on your picture in the upper-right corner and choose **Settings**.

      - On the left-hand panel, select **Access Tokens**.

      - Enter a name for the token in the **Name** field.

      - Set the token expiration date in the **Expires at** field.

      - Configure the token's access rights. For {{ tracker-name }} to operate properly, make sure to enable the **api** option.

         ![](../../_assets/tracker/gitlab-token-settings.png)

      - Click **Create personal access token**.

      - Copy a token to the clipboard.

         {% note alert %}

         The token value is displayed only once. If you close the page, you will not be able to view it again.

         {% endnote %}

   1. Enter the public repository address in the `https://gitlab.com/<repository owner login>/<repository name>` format and specify the access token.

   1. Click **{{ ui-key.startrek.blocks-desktop_repository-modal.button--connect }}**.

   1. Make sure that the repository status in {{ tracker-name }} is **{{ ui-key.startrek.blocks-desktop_page-admin-tab_type_repositories.status--success }}**.

{% endlist %}

To link a commit to an issue in {{ tracker-name }}, specify the issue key in the comments for the commit. You can view the linked commits:

- In the **{{ ui-key.startrek-backend.fields.issue.commits-key-value }}** tab on the issue page.
- In the **{{ ui-key.startrek.blocks-desktop_b-page_type_queue.tab_commits }}** tab on the queue page.

If the **{{ ui-key.startrek.blocks-desktop_b-page_type_queue.tab_commits }}** tab is missing, make sure it is enabled in your [queue settings](edit-queue-general.md#ul_gcz_xlp_m2b).

## Bitbucket {#section_u5z_zxk_m2b}

To connect your repository on [Bitbucket](https://bitbucket.org) to {{ tracker-name }}:

1. {% include [make sure you are admin](../../_includes/tracker/make-sure-admin.md) %}

1. {% include [path to the repository](../../_includes/tracker/repository-path.md) %}

1. Choose Bitbucket in the **{{ ui-key.startrek.blocks-desktop_repository-modal.platform }}** field.

1. Create a {{ tracker-name }} password in Bitbucket. {{ tracker-name }} will use this password to connect to your repositories.
   - Log in to Bitbucket.
   - Click on your picture in the lower-left corner and select **Bitbucket settings**.
   - Choose **App passwords** under **Access management**.
   - Click **Create app password**.
   - Think up a name for your password, such as `Tracker integration password`.
   - Configure the password's access right. For {{ tracker-name }} to operate properly, make sure to enable the **read** option under **Repositories**:
      ![](../../_assets/tracker/bitbucket-password-settings.png)
      ..
   - Click **Create**.
   - Copy a password to the clipboard.

      {% note alert %}

      The password value is displayed only once. If you close the page, you will not be able to view it again.

      {% endnote %}

1. Enter the repository address in the `https://bitbucket.org/<repository owner's login>/<repository name>` format and specify your Bitbucket login.

1. Enter the password you used when linking {{ tracker-name }} to Bitbucket. You cannot use your Bitbucket password for this purpose.

1. Click **{{ ui-key.startrek.blocks-desktop_repository-modal.button--connect }}**.

1. Make sure that the repository status in {{ tracker-name }} is **{{ ui-key.startrek.blocks-desktop_page-admin-tab_type_repositories.status--success }}**.

To link a commit to an issue in {{ tracker-name }}, specify the issue key in the comments for the commit. You can view the linked commits:

- In the **{{ ui-key.startrek-backend.fields.issue.commits-key-value }}** tab on the issue page.
- In the **{{ ui-key.startrek.blocks-desktop_b-page_type_queue.tab_commits }}** tab on the queue page.

If the **{{ ui-key.startrek.blocks-desktop_b-page_type_queue.tab_commits }}** tab is missing, make sure it is enabled in your [queue settings](edit-queue-general.md#ul_gcz_xlp_m2b).

## Own server {#server}

To connect your own server to {{ tracker-name }}:

1. {% include [make sure you are admin](../../_includes/tracker/make-sure-admin.md) %}

1. {% include [path to the repository](../../_includes/tracker/repository-path.md) %}

1. In the **{{ ui-key.startrek.blocks-desktop_repository-modal.platform }}** field, select the platform your server is connected to.

1. In the **{{ ui-key.startrek.ui_components_admin-repositories_ConnectRepositoryDialog_fields_UrlField.server-url-label }}** field, specify your server address to any repository that can be accessed using a token.

1. In the **{{ ui-key.startrek.ui_components_admin-repositories_ConnectRepositoryDialog.token-label }}** field, enter the token for connecting to your server.

1. Click **{{ ui-key.startrek.blocks-desktop_repository-modal.button--connect }}**.

1. Make sure that the repository status in {{ tracker-name }} is **{{ ui-key.startrek.blocks-desktop_page-admin-tab_type_repositories.status--success }}**.