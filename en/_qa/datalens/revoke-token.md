### How do I revoke a Yandex account access token? {#revoke-token}

Access to account data can be disabled at any time by revoking a token issued in Yandex ID:

1. Open [Yandex ID](https://passport.yandex.com).
1. Go to **Logins and devices** → **Devices, services, and applications**.
1. Under **Other applications and services**, select {{ datalens-short-name }}.
1. Click **Delete**.

Once a token is revoked, any connections using it will stop working (see error [{#T}](../../datalens/troubleshooting/errors/ERR-DS_API-SOURCE_ACCESS_DENIED-INVALID_TOKEN.md)).
