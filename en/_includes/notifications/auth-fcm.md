You can authenticate with FCM using either the _HTTP v1 API_ or _Legacy API_:
* To authenticate using the HTTP v1 API, you will need a **Google Cloud service account key in JSON format**. The key is used to generate OAuth 2.0 temporary tokens for authenticating requests in the FCM HTTP v1 API. You can get it in the Google Cloud management console.
* To authenticate using the Legacy API, you will need an **API key** (server key). You can get it in the Firebase management console.

{% note info %}

The HTTP v1 API is preferred as [FCM will no longer support](https://firebase.google.com/docs/cloud-messaging/migrate-v1) the Legacy API starting from June 2024.

{% endnote %}

See more in the [Firebase documentation](https://firebase.google.com/docs/cloud-messaging/android/client).