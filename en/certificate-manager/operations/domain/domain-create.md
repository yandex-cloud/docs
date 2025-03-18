---
title: How to add a domain
description: Follow this guide to add a domain.
---

# Adding a domain

{% include [preview-stage](../../../_includes/certificate-manager/preview-stage.md) %}

To add a [domain](../../concepts/domains/index.md) to be used in {{ yandex-cloud }} services:

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder to add a domain to.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_certificate-manager }}**.
   1. In the left-hand panel, select ![image](../../../_assets/console-icons/globe.svg) **Domains**.
   1. Click **{{ ui-key.yacloud.common.create }}**.
   1. In the window that opens, enter the domain name in the **{{ ui-key.yacloud.certificate-manager.domain.form.field_domain }}** field.
   1. (Optional) In the **{{ ui-key.yacloud.common.description }}** field, enter a description for the domain.
   1. (Optional) In the **{{ ui-key.yacloud.certificate-manager.domain.form.field_certificate }}** field, select a certificate from the list of verified [Let's Encrypt® certificates](../../concepts/managed-certificate.md) with the appropriate domain name. You can [add](../managed/cert-create.md) a certificate for the domain you created later.
   1. Click **{{ ui-key.yacloud.common.create }}**.

   A new domain will appear in the list of domains.

{% endlist %}
