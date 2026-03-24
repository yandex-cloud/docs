---
title: Configuring dedicated IP addressing of CDN resources
description: Follow this guide to configure dedicated IP addressing of CDN resources.
---

# Configuring dedicated IP addressing of CDN resources

{% note warning %}

The dedicated IP addressing service is subject to the [{{ cdn-full-name }} pricing policy](../../pricing.md).

{% endnote %}

To get a [dedicated IP address](../../concepts/dedicated-ip-addressing.md) for [CDN resources](../../concepts/resource.md) from a specific folder:
1. Make sure the folder you are requesting dedicated IP addressing for already contains at least one CDN resource.
1. [Submit]({{ link-console-support }}/tickets/create) a ticket to {{ yandex-cloud }} support.

    Specify the following:
    * **Service**: `{{ cdn-name }}`.
    * **Subject**: `Dedicated IP addressing of CDN resources`.
    * **Ticket text**: [ID of the folder](../../../resource-manager/operations/folder/get-id.md) in question.

1. After you get a response, in your ticket:
    * Confirm your consent to the [dedicated IP addressing pricing policy](../../pricing.md).
    * Agree on the date and time of switching to dedicated IP addressing.

      {% note alert %}

      When dedicated IP addressing is being activated, you get a traffic balancing type update during which time your resources get no service. This takes up to 15 minutes.

      {% endnote %}

    * Learn the dedicated public IP address that is going to be used for the folder’s CDN resources.

1. Optionally, to avoid the temporary unavailability of your content when activating dedicated IP addressing, redirect traffic from the {{ yandex-cloud }} CDN resources ahead of time, e.g., by routing it directly to the [origin](../../concepts/origins.md).

    {% note info %}

    When you are activating dedicated IP addressing and temporarily rerouting traffic from your CDN resource, the [cached content](../../concepts/caching.md#server-side) is saved on the CDN servers.

    {% endnote %}

    To redirect traffic:
    1. In your DNS hosting settings, change the CNAME record value from the one pointing to the {{ cdn-full-name }} domain name to a temporary one, e.g., the origin’s FQDN:

        <br>

        > Example of an original record:
        > 
        > ```text
        > cdn.example.com. CNAME {{ cname-example-yc }}
        > ```
        > 
        > Example of an updated record:
        > 
        > ```text
        > cdn.example.com. CNAME <origin_FQDN>
        > ```

        {% include [note-dns-hosting](../../../_includes/cdn/note-dns-hosting.md) %}

    1. Wait for the updated CNAME record to get propagated across DNS servers. This may take a few hours.
    1. To make sure the CDN resource receives no more requests, [check](get-stats.md) the resource statistics.

1. Wait until support informs you that dedicated IP addressing is activated. Check that the {{ cdn-full-name }} domain name of your CDN resource has a dedicated IP address specified in the support ticket, e.g.:

    ```bash
    host {{ cname-example-yc }}
    ```

    Result:

    ```bash
    {{ cname-example-yc }} has address 188.72.111.11
    ```

    From this point on, you start paying for dedicated IP addressing.

1. If you had redirected traffic from your CDN resource, restore the original CNAME record.

### See also {#see-also}

* [{#T}](../../concepts/dedicated-ip-addressing.md)