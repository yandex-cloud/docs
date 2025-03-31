---
title: Possible errors when using SAML federations in {{ org-full-name }}
description: In this tutorial, you will learn about possible errors related to SAML federations.
---

# Troubleshooting errors in SAML 2.0 federations

## Error when creating a new user {#automatic-user-creation}

An attempt to add a new user to a federation has failed because the auto user creation option is disabled. [Add a user manually](operations/add-account.md#add-user-sso) or enable the **{{ ui-key.yacloud_org.entity.federation.field.autocreateUsers }}** option in the federation settings.

## SAMLResponse assertions not encrypted {#response-not-encrypted}

The **{{ ui-key.yacloud_org.entity.federation.field.encryptedAssertions }}** option is enabled in the federation. With this option on, `SAMLResponse` assertions must be encrypted.

## The resulting XML is not a SAMLResponse {#not-saml2-response}

The response received from the IdP server is a valid XML but not a valid `SAMLResponse`. You can learn more about `SAMLResponse` requirements in the [SAML V2.0 standard](https://docs.oasis-open.org/security/saml/v2.0/saml-core-2.0-os.pdf#page=46).

## SAMLResponse is an incorrect XML {#invalid-xml-response}

XML recognition error occurred. `SAMLResponse` data is incomplete or corrupt.

## SAMLResponse contains no assertions {#assertions-not-found}

The resulting `SAMLResponse` contains no `assertions`. The error message must contain an up-to-date status code, e.g., `No assertions found in response. The status code is 'Responder'`.

Make sure the identity provider's response contains the correct SAML. Learn more about [setting up a SAML application on the IdP server side](operations/setup-federation.md#configure-sso).

## Error handling the response {#invalid-response}

Failed to decode a `SAMLResponse` string.

## Invalid sender address {#invalid-destination}

`SAMLResponse` sender address does not match the URL address of the `SamlRequest` recipient. You can learn more about the requirements in the [SAML V2.0 specification](https://docs.oasis-open.org/security/saml/v2.0/saml-core-2.0-os.pdf#page=3).

## Incorrect SAMLResponse assertions {#invalid-assertion}

`SAMLResponse` assertions failed required authentication checks.

## Invalid response signature {#invalid-signature}

Invalid `SAMLResponse` signature.

## Assertions contain no subject element {#subject-not-found}

There is no `subject` element in `SAMLResponse`.

## Assertion contains an incorrect subject element {#username-not-found}

`SAMLResponse` contains a `subject` element, but there is no `NameID` or `EncryptedID` field in it.

## Decryption error {#decryption}

Failed to decrypt an assertion or name ID in `SAMLResponse`. Check the certificates.

## Incorrect Issuer element {#invalid_issuer}

`SAMLResponse` contains an incorrect `Issuer` element. You can learn more about this element in the [SAML V2.0 specification](https://docs.oasis-open.org/security/saml/v2.0/saml-core-2.0-os.pdf#page=15).

## SAMLResponse parameter not found {#saml-response-not-found}

No `SAMLResponse` parameter found in the IdP response. This parameter is required and must be included in the HTTP response body.

## RelayState parameter not found {#relay-state-not-found}

No `RelayState` parameter found in the IdP response. This parameter is required and must be included in the HTTP response body.

## Federation not supported {#federations-not-supported}

This type of federation is no longer supported. Contact [support]({{ link-console-support }}).

## Invalid SSO URL protocol {#sso-url-incorrect-scheme}

`Sso url: isn't valid schema. The scheme must be HTTPS or HTTP`

{% list tabs group=instructions %}

- Management console {#console}

  Invalid URL protocol in the **{{ ui-key.yacloud_org.entity.federation.field.ssoUrl }}** field. You can only use HTTP and HTTPS.

- CLI {#cli}

  Invalid URL protocol in the `sso-url` field. You can only use HTTP and HTTPS.

- {{ TF }} {#tf}

  Invalid URL protocol in the `sso_url` field. You can only use HTTP and HTTPS.

- API {#api}

  Invalid URL protocol in the `ssoUrl` field. You can only use HTTP and HTTPS.

{% endlist %}

## Invalid SSO URL {#sso-url-invalid-url}

`Sso url: isn't valid (the link to the IdP login page)`

{% list tabs group=instructions %}

- Management console {#console}

  Invalid URL in the **{{ ui-key.yacloud_org.entity.federation.field.ssoUrl }}** field. Please check the URL.

- CLI {#cli}

  Invalid URL in the `sso-url` field. Please check the URL.

- {{ TF }} {#tf}

  Invalid URL in the `sso_url` field. Please check the URL.

- API {#api}

  Invalid URL in the `ssoUrl` field. Please check the URL.

{% endlist %}

## Invalid NameID {#invalid-name-id}

The NameID value must follow this format: `"^[a-z0-9A-Z/@_.\\-=+*\\\\]+$"`.
