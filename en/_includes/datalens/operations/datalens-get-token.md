## Getting an OAuth token {#get-oauth-token}

You can specify an OAuth token of any Yandex account.

To get access to a Yandex Metrica tag for a username other than your current Yandex account, follow these steps:

1. Switch to an account that has access to Yandex Metrica.
1. Use the [link](https://oauth.yandex.com/authorize?response_type=token&client_id=4f802221a95340dd9417c04bc30606b5) to get a token. If necessary, allow access to the application, then copy the token.
1. Switch to an account that has access to {{ datalens-full-name }}.
1. Create a new connection to Yandex Metrica and paste the obtained token from the clipboard to the **OAuth token** field.

