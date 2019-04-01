1. [Log in](https://passport.yandex.com/auth) to your Yandex or Yandex.Connect account.

2. Get an OAuth token from Yandex.OAuth. To do this, follow the [link](https://oauth.yandex.com/authorize?response_type=token&client_id=1a6990aa636648e9b2ef855fa7bec2fb), click **Allow** and copy the OAuth token that is issued.

3. Exchange the OAuth token for an IAM token:

    ```
    $ curl -X POST \
        -H 'Content-Type: application/json' \
        -d '{"yandexPassportOauthToken": "<OAuth-token>"}' \
        https://iam.api.cloud.yandex.net/iam/v1/tokens
    ```

