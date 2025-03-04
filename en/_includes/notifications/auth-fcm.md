You can authenticate with FCM using either the _HTTP v1 API_ or _legacy API_:
* To authenticate using the HTTP v1 API, you will need a **{{ ui-key.yacloud.cns.field_gcm-file }}**. The key is used to generate OAuth 2.0 temporary tokens for authenticating requests in the FCM HTTP v1 API. You can get it in the Google Cloud management console.
* To authenticate using the legacy API, you will need an **{{ ui-key.yacloud.cns.field_gcm-api-key }}** (server key). You can get it in the Firebase management console.

{% note info %}

The HTTP v1 API is preferred as [FCM will no longer support](https://firebase.google.com/docs/cloud-messaging/migrate-v1) the legacy API starting from June 2024.

{% endnote %}

See more in the [Firebase documentation](https://firebase.google.com/docs/cloud-messaging/android/client).