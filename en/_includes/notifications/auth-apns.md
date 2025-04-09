* To authenticate with a token, you will need:
  * **{{ ui-key.yacloud.cns.field_apns-key }}**: File with the signature key that you will use to certify the authentication token.
      
      Create and download a signature key in your Apple developer account: **Certificates, Identifiers & Profiles** → **Keys** → ![image](../../_assets/console-icons/circle-plus-fill.svg). You can download the key file only once.
  * **{{ ui-key.yacloud.cns.field_apns-key-id }}** (Key ID): Get the ID in your Apple developer account: **Certificates, Identifiers & Profiles** → **Keys**. Make sure the ID matches the signature key you downloaded in the previous step. It must be 10 characters long.
  * **{{ ui-key.yacloud.cns.field_apns-team-id }}** (Team ID): You can find it in the top-right corner of your Apple developer account. It must be 10 characters long and contain only numbers and Latin letters.
  * **{{ ui-key.yacloud.cns.field_apns-bundle-id }}**: Get the [bundle ID](https://developer.apple.com/documentation/appstoreconnectapi/list_bundle_ids) in your Apple developer account: **Certificates, Identifiers & Profiles** → **Identifiers** or in the Xcode app: **Target** → **General** → **Identity**. It may contain only numbers, Latin letters, hyphens, and periods.
   
   Learn more about the token in the [relevant Apple documentation](https://developer.apple.com/documentation/usernotifications/establishing-a-token-based-connection-to-apns).

* To authenticate with a certificate, you will need:
  * **{{ ui-key.yacloud.cns.field_apns-certificate }}**: SSL certificate file in `.pem` format.
  * **{{ ui-key.yacloud.cns.field_apns-private-key }}**: Key file in `.pem` format. 

  For more information about the certificate, see the [Apple documentation](https://developer.apple.com/documentation/usernotifications/setting_up_a_remote_notification_server/establishing_a_certificate-based_connection_to_apns#2947597).

  {% include [convert-p12-to-pem](convert-p12-to-pem.md) %}

Token-based authentication is preferred as a faster, more modern and secure option.
