# How to delegate a domain to {{ dns-name }} servers 



## Case description {#case-description}

You need to transfer the management of the domain name to {{ dns-name }} servers.

## Solution {#case-resolution}

You can transfer your domain management to {{ yandex-cloud }} and manage resource records using {{ dns-name }}.

To transfer domain management, follow these steps:

1. Delegate your domain to {{ yandex-cloud }} servers. To do this, specify the addresses of the {{ yandex-cloud }} name servers in your registrar's NS records:
    * `ns1.yandexcloud.net.`
    * `ns2.yandexcloud.net.`
1. [Create a public {{ dns-name }} zone](../../../dns/operations/zone-create-public.md) for your domain.
1. [Create the appropriate resource records](../../../dns/operations/resource-record-create.md).
​
{% note info %}

After creating the records, wait for the changes to take effect. New records may take up to 72 hours to propagate across public servers.

{% endnote %}

## If the issue persists {#if-nothing-worked}

If, after 72 hours, the resource records you created in {{ yandex-cloud }} public DNS zone are not resolving on other public DNS servers on the internet, [create a support ticket]({{ link-console-support }}). Provide the following information in your ticket:

1. Name or ID of the public DNS zone.
1. Issue description.
1. Screenshot of the NS record configuration from the domain registrar's control panel.
1. Date and time when the NS server settings changed in the domain registrar's control panel.
