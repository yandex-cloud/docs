---
title: Updating a {{ yandex-cloud }} SAML certificate in a {{ org-full-name }} identity federation
description: Follow this guide to update a {{ yandex-cloud }} certificate in a {{ org-name }} identity federation.
---

# Updating a {{ yandex-cloud }} SAML certificate in an identity federation

{% note info %}

This guide describes how to update a SAML certificate issued by {{ yandex-cloud }} and used to sign requests from an identity federation to an IdP provider. To update an IdP provider certificate used to sign requests from the IdP provider to an identity federation, see [Adding an IdP server certificate to a federation](./setup-federation.md#add-certificate-fed).

{% endnote %}

A {{ yandex-cloud }} SAML certificate is valid for 5 years. {{ yandex-cloud }} generates a new SAML certificate automatically before the previous certificate's expiration date.

Make sure to start using the new SAML certificate before the previous one expires.

To start using the new SAML certificate in a {{ org-full-name }} identity federation:

{% list tabs group=instructions %}

- {{ cloud-center }} interface {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}) with an administrator or organization owner account.
  1. In the left-hand panel, select ![VectorSquare](../../_assets/console-icons/vector-square.svg) **{{ ui-key.yacloud_org.pages.federations }}**.
  1. In the list that opens, select the identity federation of interest.

      If the {{ yandex-cloud }} SAML certificate was reissued and requires a replacement, the ![TriangleExclamation](../../_assets/console-icons/triangle-exclamation.svg) icon will appear in the **{{ ui-key.yacloud_org.entity.federation.field.encryptedAssertions }}** field to the left of ![ArrowDownToLine](../../_assets/console-icons/arrow-down-to-line.svg) **{{ ui-key.yacloud_org.page.federation.action.download-cert }}**. If the icon is orange, it means the previous certificate is still valid; if red, the previous certificate has expired. In both these cases, you need to update the {{ yandex-cloud }} SAML certificate in the identity federation and on the IdP server.
  1. In the top-right corner, click ![pencil](../../_assets/console-icons/pencil.svg) **Update**.

      In the window that opens, you will see two certificates in the **SAML certificate** section under **Advanced**: the current one and the new (reissued) one. Expiration dates will be specified for both. The current one will also feature a warning that you need to download and install a new certificate.
  1. To the right of the new (reissued) SAML certificate’s expiration date, click ![ArrowDownToLine](../../_assets/console-icons/arrow-down-to-line.svg) **Download**.
  
      {% note tip %}

      Track SAML certificate expiration dates and always install new a new certificate before the current one expires.

      {% endnote %}

      Before you proceed to the next step, deliver the downloaded {{ yandex-cloud }} SAML certificate to the IdP server. To learn how to do this, consult the identity provider's documentation or contact their support.

  1. Once you have delivered the new SAML certificate to your IdP server, select the new (reissued) SAML certificate in the federation settings update form and click **{{ ui-key.yacloud.common.save }}**.

{% endlist %}