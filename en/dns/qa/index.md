---
title: FAQ about {{ dns-full-name }}
description: This page covers questions and answers about {{ dns-name }}.
---

# Frequently asked questions about {{ dns-name }}

#### Why am I being charged for {{ dns-name }} even though I have no DNS zones in my cloud? {#dns-fee-without-usage}

[Public DNS requests](../concepts/dns-zone.md#public-zones) from VMs to {{ yandex-cloud }} DNS servers are also [charged](../pricing.md#public-dns-requests).

Thus, {{ dns-name }} may still be used even if your cloud does not contain any DNS zones other than service ones.

We recommend using [caching resolvers](../tutorials/local-dns-cache.md), such as `systemd-resolved`, `dnsmasq`, or `unbound`. These reduce the number of public DNS requests, and thereby, your costs.

{% include [logs](../../_qa/logs.md) %}


#### How do I register a domain name using non-Latin characters? {#dns-create-rf-zone}

Cloud DNS supports any domain names, including those with local characters. To create a domain name with non-Latin characters, use [Punycode](https://{{ lang }}.wikipedia.org/wiki/Punycode).

#### How do I delegate reverse zone management to {{ dns-name }}? {#dns-reverse-zone}

To delegate reverse zone management to {{ dns-name }}:

1. Confirm that you own the domain zone (dedicated IP). To do this, just provide a copy of the document confirming ownership right transfer and registration information from the RIPE database that identifies IP ownership.
1. The {{ yandex-cloud }} information security team will verify the data you provide and notify you of the results.
1. After your data has been successfully verified, [contact support](../../support/overview.md).

#### Why cannot I add a TXT record? {#dns-add-txt-record}

You get an error when attempting to add one more TXT record of the same type next to an existing record. {{ dns-name }} only supports a single TXT record, which, however, may store multiple values.

To add a new value:

1. In the [management console]({{ link-console-main }}), select a folder to modify the DNS zone record in.
1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}**.
1. Select the zone from the list.
1. Click ![image](../../_assets/console-icons/ellipsis.svg) next to the record you need and select ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
1. On the page that opens, click **{{ ui-key.yacloud.common.add }}**.
1. Enter the new **{{ ui-key.yacloud.dns.label_records }}** of the record in the field that appears.
1. In the **{{ ui-key.yacloud.dns.label_form-ttl }}** field, specify a TTL for the value or select it from the list.
1. Click **{{ ui-key.yacloud.common.save }}**.

For more information, see [{#T}](../operations/resource-record-update.md).