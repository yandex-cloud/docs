# Connecting repositories to {{ tracker-name }}

If you are using cloud-based services, such as GitHub, GitLab, or Bitbucket, you can connect your repositories to {{ tracker-name }} and then link commits to issues. It enables you to find changes in your code that are related to a specific issue, if required.

{% note warning %}

Git repositories hosted on your own private server cannot be linked to {{ tracker-name }}.

{% endnote %}

To connect a repository:

1. Make sure you are authorized in {{ tracker-name }} as an [administrator](role-model.md).

1. {% include [path to the repository](../_includes/tracker/repository-path.md) %}

1. Select the service that hosts the repository and specify the connection details:

   - Link to the repository.

   - Token (for private GitHub and GitLab repositories). You do not need to specify a token for public repositories.

   - For Bitbucket repositories, specify your Bitbucket login and a special password generated for {{ tracker-name }}.

   For more information about the connection parameters, see [{#T}](user/add-repository.md).

1. To display related commits on the issue page, go to [your queue settings](manager/edit-queue-general.md#integration) and enable **Show "Сommits" tab**.

To link a commit to an issue in {{ tracker-name }}, specify your [issue key](user/create-ticket.md#key) in a comment under the commit.

