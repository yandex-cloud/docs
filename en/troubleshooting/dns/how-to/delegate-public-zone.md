# Domain delegation to Yandex Cloud DNS servers



## Issue description {#case-description}

You need to transfer domain name control to Yandex Cloud DNS servers.

## Solution {#case-resolution}

You can transfer control of your domain to Yandex Cloud to manage resource records using the DNS service.
To transfer domain control, follow these steps:

1. Delegate your domain to the Yandex Cloud servers. For this, specify the addresses of the Yandex Cloud name servers in your registrar's NS records:
   `ns1.yandexcloud.net.`
   `ns2.yandexcloud.net.`
2. [Create a public DNS zone](../../../dns/operations/zone-create-public.md) for your domain.
3. [Create the appropriate resource records](../../../dns/operations/resource-record-create.md).
   ​
   {% note info %}

After creating the records, wait for the changes to take effect.
Data exchange about new records can take up to 72 hours on public DNS servers.

{% endnote %}

## If the issue persists {#if-issue-still-persists}

If after 72 hours, the resource records created in the public DNS zone in Yandex Cloud are not resolved using other public DNS servers on the internet, [create a request for technical support](https://console.cloud.yandex.ru/support?section=contact).

In the request, specify the following information:

1. Name or ID of the public DNS zone.
2. Problem description.
3. Screenshot of the NS record configuration from the domain registrar's control panel
4. Date and time when the NS server settings changed in the domain registrar's control panel.
