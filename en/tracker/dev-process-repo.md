{% if audience == "external" %}

# Connecting repositories

If you're using cloud-based services such as GitHub, GitLab, or Bitbucket, you can connect your repositories to {{ tracker-name }} and then link commits to issues. This will help you track any code changes related to a particular issue.

{% note warning %}

Git repositories hosted on your own private server can't be linked to {{ tracker-name }}.

{% endnote %}

To connect a repository, do the following:

1. Make sure you are logged in to {{ tracker-name }} as an [administrator](role-model.md).

1. In the {{ tracker-name }} settings, go to the [Repositories]({{ link-repositories }}) tab and click **Connect repository**.

1. Select the service where the repository is hosted and specify the following information:

    - Link to the repository.

    - Specify the token for private GitHub and GitLab repositories. For public repositories, you do not need to specify a token.

    - For Bitbucket repositories, specify your Bitbucket login and a special password generated for {{ tracker-name }}.

    For more information about the connection parameters, see [{#T}](manager/add-repository.md).

1. To display related commits on the issue page, go to your [queue settings](manager/edit-queue-general.md#integration) and enable **Show "Commits" tab**.

To link a commit to an issue in {{ tracker-name }}, specify your [issue key](user/create-ticket.md#key) in a comment under the commit.

{% endif %}

