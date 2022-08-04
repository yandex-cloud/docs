# Version control systems

## GitHub {#section_nb1_3mx_3bb}

Follow these steps to link tickets, pull requests, and new repository branches to your {{ tracker-name }} issues:

1. Configure the webhook for the repository with these settings:
    - **Payload URL** — `{{ host }}/v2/system/github/receive`.
    - **Content type** — `application/json`.
    - **Events** — `Pull Request` or `Issues` or `Branch or tag creation`.

1. The key of the issue you want to link should be specified in the branch name or the description of the ticket or pull request.

    {% note warning %}

    {{ tracker-name }} won't process the issue key if it is preceded by a `#` or `~`.

    {% endnote %}

The linked tickets, pull requests, and branches are displayed on the issue page in the Links section.

## Mercurial {#section_jqk_zqx_3bb}

To link commits to issues in {{ tracker-name }}, specify the issue key in the commit description. The associated commit is shown on the **Commits** tab on the issue page.

