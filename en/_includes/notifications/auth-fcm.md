You can authenticate with FCM using the API:
* _HTTP v1 API_: You will need a **{{ ui-key.yacloud.cns.field_gcm-file }}**. The key is used to generate OAuth 2.0 temporary tokens for authenticating requests in the FCM HTTP v1 API. You can get it in the Google Cloud management console.
* _Legacy API_: You will need an **{{ ui-key.yacloud.cns.field_gcm-api-key }}** (server key). You can get it in the Firebase management console.

{% note info %}

[FCM no longer supports](https://firebase.google.com/docs/cloud-messaging/migrate-v1) the legacy API starting June 2024.

{% endnote %}

See more in the [Firebase documentation](https://firebase.google.com/docs/cloud-messaging/android/client).