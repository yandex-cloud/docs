### How do I revoke a Yandex account access token? {#revoke-token}

You can disable access to account data at any time by revoking a Yandex ID token:

1. Open [Yandex ID](https://passport.yandex.com).
1. Go to **Logins and devices** → **Devices, services, and applications**.
1. Under **Other applications and services**, select {{ datalens-short-name }}.
1. Click **Delete**.

Once the token is revoked, any connections using it will stop working (see [this error description](../../datalens/troubleshooting/errors/ERR-DS_API-SOURCE_ACCESS_DENIED-INVALID_TOKEN.md)).
