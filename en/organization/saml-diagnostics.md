# Troubleshooting errors in SAML 2.0 federations

## Error when creating a new user {#automatic-user-creation}

An attempt to add a new user to a federation has failed because the auto user creation option is disabled. [Add a user manually](operations/add-account.md#add-user-sso) or enable the **{{ ui-key.yacloud_org.entity.federation.field.autocreateUsers }}** option in the federation settings.

## SAMLResponse assertions not encrypted {#response-not-encrypted}

The **{{ ui-key.yacloud_org.entity.federation.field.encryptedAssertions }}** option is enabled in the federation. When it is enabled, `SAMLResponse` assertions must be encrypted.

## Resulting XML is not a SAMLResponse {#not-saml2-response}

The response received from the IdP server is a correct XML but not a correct `SAMLResponse`. You can learn more about `SAMLResponse` requirements in the [SAML V2.0 specification](https://docs.oasis-open.org/security/saml/v2.0/saml-core-2.0-os.pdf#page=46).

## SAMLResponse is an incorrect XML {#invalid-xml-response}

XML recognition error occurred. `SAMLResponse` data is incomplete or corrupt.

## SAMLResponse contains no assertions {#assertions-not-found}

The received `SAMLResponse` contains no `assertions`. A valid status code must be specified in the error message, such as: `No assertions found in response. The status code is 'Responder'`.

## Error handling the response {#invalid-response}

Failed to decode a `SAMLResponse` string.

## Invalid sender address {#invalid-destination}

The `SAMLResponse` sender address does not match the URL address of the `SamlRequest` recipient. You can learn more about the requirements in the [SAML V2.0 specification](https://docs.oasis-open.org/security/saml/v2.0/saml-core-2.0-os.pdf#page=3).

## Incorrect SAMLResponse assertions {#invalid-assertion}

`SAMLResponse` assertions failed mandatory checks under authentication.

## Invalid response signature {#invalid-signature}

`SAMLResponse` signature is not valid.

## Assertions are missing the `subject` element {#subject-not-found}

There is no `subject` in the `SAMLResponse`.

## Assertion contains an incorrect `subject` element {#username-not-found}

There is a `subject` in the `SAMLResponse` but the `NameID` or `EncryptedID` field is missing in it.

## Decryption error {#decryption}

Failed to decrypt an assertion or name ID in the `SAMLResponse`. Check the certificates.

## Incorrect `Issuer` {#invalid_issuer}

`SAMLResponse` contains an incorrect `Issuer` element. You can learn more about this element in the [SAML V2.0 specification](https://docs.oasis-open.org/security/saml/v2.0/saml-core-2.0-os.pdf#page=15).

## `SAMLResponse` parameter not found {#saml-response-not-found}

There is no `SAMLResponse` parameter in the IdP server response. This parameter is required and must be included in the HTTP response body.

## `RelayState` parameter not found {#relay-state-not-found}

No `RelayState` parameter in the IdP server response. This parameter is required and must be included in the HTTP response body.

## Federation not supported {#federations-not-supported}

This type of identity federations is no longer supported. Contact [support]({{ link-console-support }}).

## Invalid SSO URL protocol {#sso-url-incorrect-scheme}

`Sso url: isn't valid schema. The scheme must be HTTPS or HTTP`

{% list tabs %}

- Management console

   Invalid URL protocol in the **{{ ui-key.yacloud_org.entity.federation.field.ssoUrl }}** field. You can only use HTTP and HTTPS.

- CLI

   Invalid URL protocol in the `sso-url` field. You can only use HTTP and HTTPS.

- API

   Invalid URL protocol in the `ssoUrl` field. You can only use HTTP and HTTPS.

- {{ TF }}

   Invalid URL protocol in the `sso_url` field. You can only use HTTP and HTTPS.

{% endlist %}

## Invalid SSO URL {#sso-url-invalid-url}

`Sso url: isn't valid (the link to the IdP login page)`

{% list tabs %}

- Management console

   Invalid URL in the **{{ ui-key.yacloud_org.entity.federation.field.ssoUrl }}** field. Please check the URL.

- CLI

   Invalid URL in the `sso-url` field. Please check the URL.

- API

   Invalid URL in the `ssoUrl` field. Please check the URL.

- {{ TF }}

   Invalid URL in the `sso_url` field. Please check the URL.

{% endlist %}

## Invalid NameID {#invalid-name-id}

The NameID value must follow this format: `"^[a-z0-9A-Z/@_.\\-=+*\\\\]+$"`.
