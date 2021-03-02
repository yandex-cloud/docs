# Connecting repositories

{% note warning %}

Repositories can only be connected by your organization's administrator.

{% endnote %}

Connecting your repositories to {{ tracker-name }} lets you link commits to issues. You can link any number of repositories hosted on GitHub, GitLab, and Bitbucket.

{% note warning %}

Git repositories hosted on your own private server can't be linked to {{ tracker-name }}.

{% endnote %}

## GitHub {#section_mhj_yrk_m2b}

Follow these steps to link a [GitHub](https://github.com) repository to {{ tracker-name }}:

{% list tabs %}

- Public repository

    1. Make sure that you are logged in as the organization administrator.

    1. On the top panel in {{ tracker-name }}, choose ![](../../_assets/tracker/icon-settings.png) → **Settings {{ tracker-name }}**.

    1. Open the [**Repositories**]({{ link-repositories }}) tab and click **Connect repository**.

    1. Choose GitHub in the **Platform** field.

    1. Enter the public repository's address in `https://github.com/<repository owner login>/<repository name>` format. Leave the **Token** field empty.

    1. Click **Connect**.

    1. Make sure your repository's status in {{ tracker-name }} is **Connected**.

- Private repository

    1. Make sure that you are logged in as the organization administrator.

    1. On the top panel in {{ tracker-name }}, choose ![](../../_assets/tracker/icon-settings.png) → **Settings {{ tracker-name }}**.

    1. Open the [**Repositories**]({{ link-repositories }}) tab and click **Connect repository**.

    1. Choose GitHub in the **Platform** field.

    1. Go to GitHub and receive an OAuth token for your repository:

        - Log in to GitHub. If your repository is connected to a GitHub organization, make sure you have admin rights.

        - Click your picture in the upper-right corner and choose **Settings**.

        - On the left-hand panel, select **Developer settings** → **Personal access token**.

        - Click **Generate new token**.

        - Choose a name for your token.

        - Configure access rights for your token. To make sure {{ tracker-name }} operates properly, enable the **repo** and **read:org** options:

            ![](../../_assets/tracker/github-token-settings.png)

        - Click **Generate token**.

        - Copy the token to the clipboard.

            {% note alert %}

            Your token will only be displayed once. You won't be able to see it again after closing the page.

            {% endnote %}

    1. Enter the repository address in `https://github.com/<repository owner login>/<repository name>` format and specify the access token.

    1. Click **Connect**.

    1. Make sure your repository's status in {{ tracker-name }} is **Connected**.

{% endlist %}

To link a commit to an issue in {{ tracker-name }}, specify the issue key in the comments for the commit. You can view linked commits the following ways:

- On the **Commits** tab on the issue page.
- On the **Commits** tab on the queue page.

If you don't see the **Commits** tab, make sure it's enabled in your [queue settings](edit-queue-general.md#ul_gcz_xlp_m2b).

## GitLab {#section_kjw_cy2_ggb}

Follow these steps to link a [GitLab](https://gitlab.com) repository to {{ tracker-name }}:

{% list tabs %}

- Public repository

    1. Make sure that you are logged in as the organization administrator.

    1. On the top panel in {{ tracker-name }}, choose ![](../../_assets/tracker/icon-settings.png) → **Settings {{ tracker-name }}**.

    1. Open the [**Repositories**]({{ link-repositories }}) tab and click **Connect repository**.

    1. Choose GitLab in the **Platform** field.

    1. Enter the public repository's address in `https://gitlab.com/<repository owner login>/<repository name>` format. Leave the **Token** field empty.

    1. Click **Connect**.

    1. Make sure your repository's status in {{ tracker-name }} is **Connected**.

- Private repository

    {% note info %}

    Private repositories can only be accessed by users logged in to GitLab (**Internal project**) or the project team (**Private project**).

    {% endnote %}

    1. Make sure that you are logged in as the organization administrator.

    1. On the top panel in {{ tracker-name }}, choose ![](../../_assets/tracker/icon-settings.png) → **Settings {{ tracker-name }}**.

    1. Open the [**Repositories**]({{ link-repositories }}) tab and click **Connect repository**.

    1. Choose GitLab in the **Platform** field.

    1. Go to GitLab and receive an OAuth token for your repository:

        - Log in to GitLab.

        - Click your picture in the upper-right corner and choose **Settings**.

        - On the left-hand panel, select **Access Tokens**.

        - Enter your token's name in the **Name** field.

        - Set the token expiration date in the **Expires at** field.

        - Configure the token's access rights. To make sure {{ tracker-name }} operates properly, enable the **api** option:

            ![](../../_assets/tracker/gitlab-token-settings.png)

        - Click **Create personal access token**.

        - Copy the token to the clipboard.

            {% note alert %}

            Your token will only be displayed once. You won't be able to see it again after closing the page.

            {% endnote %}

    1. Enter the public repository's address in `https://gitlab.com/<repository owner login>/<repository name>` format and specify the access token.

    1. Click **Connect**.

    1. Make sure your repository's status in {{ tracker-name }} is **Connected**.

{% endlist %}

To link a commit to an issue in {{ tracker-name }}, specify the issue key in the comments for the commit. You can view linked commits the following ways:

- On the **Commits** tab on the issue page.
- On the **Commits** tab on the queue page.

If you don't see the **Commits** tab, make sure it's enabled in your [queue settings](edit-queue-general.md#ul_gcz_xlp_m2b).

## Bitbucket {#section_u5z_zxk_m2b}

Follow these steps to link a [Bitbucket](https://bitbucket.org) repository to {{ tracker-name }}:

1. Make sure that you are logged in as the organization administrator.

1. On the top panel in {{ tracker-name }}, choose ![](../../_assets/tracker/icon-settings.png) → **Settings {{ tracker-name }}**.

1. Open the [**Repositories**]({{ link-repositories }}) tab and click **Connect repository**.

1. Choose Bitbucket in the **Platform** field.

1. Create a {{ tracker-name }} password in Bitbucket. {{ tracker-name }} will use this password to connect to your repositories.

    - Log in to Bitbucket.

    - Click your picture in the bottom-left corner and choose **Bitbucket settings**.

    - Choose **App passwords** in the **Access management** section.

    - Click **Create app password**.

    - Think of a name for your password, such as `Tracker integration password`.

    - Set access rights for your password. To make sure {{ tracker-name }} operates properly, enable the **read** option under **Repositories**:
![](../../_assets/tracker/bitbucket-password-settings.png)

    - Click **Create**.

    - Copy the password to clipboard.

        {% note alert %}

        Your password will only be displayed once. You won't be able to see it again after closing the page.

        {% endnote %}

1. Enter the repository's address in `https://bitbucket.org/<repository owner login>/<repository name>` format and specify your username on Bitbucket.

1. Enter the password you used when linking {{ tracker-name }} to Bitbucket. You cannot use your personal Bitbucket password.

1. Click **Connect**.

1. Make sure your repository's status in {{ tracker-name }} is **Connected**.

To link a commit to an issue in {{ tracker-name }}, specify the issue key in the comments for the commit. You can view linked commits the following ways:

- On the **Commits** tab on the issue page.
- On the **Commits** tab on the queue page.

If you don't see the **Commits** tab, make sure it's enabled in your [queue settings](edit-queue-general.md#ul_gcz_xlp_m2b).


[Contact support](../troubleshooting.md)

