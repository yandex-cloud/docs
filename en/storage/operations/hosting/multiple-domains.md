---
title: "How to set up support of multiple domain names for a website"
description: "Use this guide to set up support for multiple domain names for a website."
---

# Support for multiple website domain names

{% note info %}

This guide describes how to set up support for a website's primary domain name and its [subdomain](https://en.wikipedia.org/wiki/Subdomain), e.g., `example.com` and `www.example.com`.
To set up an additional domain, e.g., `example2.com`, [create](../buckets/create.md) a bucket with its name.Next, [configure](setup.md#hosting) hosting for this bucket and [specify](setup.md#redirects) the parameters for a redirect from it to the primary domain.

{% endnote %}

To support multiple domain names for your website, e.g., `example.com` and `www.example.com`:

1. [Create](../buckets/create.md) a bucket. Give it a domain name, e.g., `www.example.com`.

1. {% include [setup-bucket.md](../../../_includes/storage/setup-bucket.md) %}

1. [Link](./own-domain.md) a domain name, e.g., `www.example.com`, to your bucket.

1. On the DNS server, add another [resource record](../../../dns/concepts/resource-record.md) to link one more domain name, e.g., `example.com`, to the bucket:

   {% list tabs group=instructions %}

   - {{ dns-full-name }} {#dns}

      [Create](../../../dns/operations/resource-record-create.md) a resource record in {{ dns-name }} with the following parameters:

      | Name | Type | TTL | Value |
      |--------------|-------|-----|-----------------------------------|
      | example.com. | ANAME | 600 | www.example.com.{{ s3-web-host }} |

      [ANAME](../../../dns/concepts/resource-record.md#aname) records allow second-level domains to be used for hosting. Unlike [CNAME](../../../dns/concepts/resource-record.md#cname) records, they do not restrict the use of other record types in the same zone.

      Updating the resource records may take some time.

   - Third-party DNS server {#third-party-dns-server}

      [CNAME](../../../dns/concepts/resource-record.md#cname) resource record example:

      ```text
      example.com CNAME www.example.com.{{ s3-web-host }}
      ```

      To use a CNAME resource record, make sure your domain name belongs to at least a third-level domain. This has to do with how CNAME records are processed on DNS hosting. For more information, see section 2.4 of [RFC 1912](https://www.ietf.org/rfc/rfc1912.txt).

      Updating the resource records may take some time.

   {% endlist %}

If for some reason you cannot or do not want to create an additional resource record, you can do the following:

1. [Create](../../../compute/operations/vm-create/create-linux-vm.md) a VM with a [public IP address](../../../vpc/concepts/address.md#public-addresses).
1. Link the `example.com` domain to the VM's public IP address.
1. Set up all required aliases on the DNS server side.
1. Install a web server on the VM and configure a redirect to the {{ objstorage-name }} bucket.
