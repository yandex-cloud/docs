You can authenticate with APNs using either a _token_ or a _certificate_:
* To authenticate using a token, you will need the following data:
   * **Token**: To get a token in `.p8` format, create an authentication key in your Apple developer account: **Certificates, Identifiers & Profiles** → **Keys** → ![image](../../_assets/console-icons/circle-plus-fill.svg). You can download the token file only once.
   * **Token ID**: Get the ID in your Apple developer account: **Certificates, Identifiers & Profiles** → **Keys**. Make sure the ID matches the token you want to use. It must be 10 characters long.
   * **Team ID**: You can find it in the top-right corner of your Apple developer account. It must be 10 characters long and contain only numbers and Latin letters.
   * **Bundle ID**: Get the [bundle ID](https://developer.apple.com/documentation/appstoreconnectapi/list_bundle_ids) in your Apple developer account: **Certificates, Identifiers & Profiles** → **Identifiers** or in the Xcode app: **Target** → **General** → **Identity**. It may contain only numbers, Latin letters, hyphens, and periods.
* To authenticate using a certificate, you will need the following data:
   * **Certificate**: SSL certificate file in `.p12` format.
   * **Certificate private key**.

   For more information about the certificate, see the [Apple documentation](https://developer.apple.com/documentation/usernotifications/setting_up_a_remote_notification_server/establishing_a_certificate-based_connection_to_apns#2947597).

Token-based authentication is preferred as it is more progressive.