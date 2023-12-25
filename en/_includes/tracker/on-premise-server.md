To connect your own server to {{ tracker-name }}:

1. {% include [make sure you are admin](make-sure-admin.md) %}

1. {% include [path to the repository](repository-path.md) %}

1. In the **Platform** field, select the platform your server is connected to.

1. In the **{{ ui-key.startrek.ui_components_admin-repositories_ConnectRepositoryDialog_fields_UrlField.server-url-label }}** field, specify your server address to any repository that can be accessed using a token.

1. Get an OAuth token for your repository on GitLab. For details on how to get a token, see the [GitLab documentation](https://docs.gitlab.com/ee/user/profile/personal_access_tokens.html#create-a-personal-access-token). For the proper operation of {{ tracker-name }}, enable the **read_repository** and **read_api** options when setting up permissions.

1. In the **{{ ui-key.startrek.ui_components_admin-repositories_ConnectRepositoryDialog.token-label }}** field, enter the token for connecting to your server.

1. Click **Connect**.

1. Make sure that the repository status in {{ tracker-name }} is **Connected**.
