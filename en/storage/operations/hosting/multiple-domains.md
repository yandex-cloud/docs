---
title: How to set up multiple domain name support for a website
description: Follow this guide to set up multiple domain name support for a website.
---

# Multiple domain name support for a website

{% note info %}

This guide describes how to set up support for a website's primary domain name and its [subdomain](https://en.wikipedia.org/wiki/Subdomain), e.g., `example.com` and `www.example.com`.
To set up an additional domain, e.g, `example2.com`, [create](../buckets/create.md) a bucket with the same name. Next, [configure](setup.md#hosting) hosting for this bucket and [specify](setup.md#redirects) the parameters for redirects to the primary domain.

{% endnote %}

To enable multiple domain name support for your website, e.g., `example.com` and `www.example.com`:

1. [Create](../buckets/create.md) a bucket. Give it one of the domain names, e.g., `www.example.com`.

1. {% include [setup-bucket.md](../../../_includes/storage/setup-bucket.md) %}

1. [Link](./own-domain.md) the domain name, e.g., `www.example.com`, and the bucket.

1. On the DNS server, add another [resource record](../../../dns/concepts/resource-record.md) to link one more domain name, e.g., `example.com`, and the bucket:

   {% include [storage-cloud-dns-domains](../../_includes_service/storage-cloud-dns-domains.md) %}

    {% list tabs group=instructions %}

    - {{ dns-full-name }} {#dns}

      [Create](../../../dns/operations/resource-record-create.md) a resource record in {{ dns-name }} with the following parameters:

      | Name          | Type   | TTL | Value                          |
      |--------------|-------|-----|-----------------------------------|
      | example.com. | ANAME | 600 | www.example.com.{{ s3-web-host }} |

      [ANAME](../../../dns/concepts/resource-record.md#aname) records enable using second-level domains for hosting. Unlike [CNAME](../../../dns/concepts/resource-record.md#cname) records, they do not restrict the use of other record types in the same zone.

      Updating resource records may take a while.

    - Third-party DNS server {#third-party-dns-server}

      An example of a [CNAME](../../../dns/concepts/resource-record.md#cname) resource record looks like this: 

      ```text
      example.com CNAME www.example.com.{{ s3-web-host }}
      ```

      To use a CNAME resource record, make sure your domain name belongs to at least a third-level domain. This restriction is due to the way CNAME records are handled on DNS hosting platforms. For more information, see [RFC 1912](https://www.ietf.org/rfc/rfc1912.txt), section 2.4.

      Updating resource records may take a while.

    {% endlist %}

If for some reason you cannot or do not want to create another resource record, you can do the following:

1. [Create](../../../compute/operations/vm-create/create-linux-vm.md) a VM with a [public IP address](../../../vpc/concepts/address.md#public-addresses).
1. Link `example.com` to the VM public IP address.
1. Set up all required aliases on the DNS server side.
1. Install a web server on the VM and configure a redirect to the {{ objstorage-name }} bucket.
