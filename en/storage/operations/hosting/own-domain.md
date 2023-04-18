# Your own domain

To publish a website, you can use your own domain (for example, `example.com`).

To support your own domain:

1. [Create](../buckets/create.md) a bucket. Give it the same name as your domain.

1. {% include [setup-bucket.md](../../../_includes/storage/setup-bucket.md) %}

1. On your DNS server, for example, in [{{ dns-full-name }}](../../../dns/operations/resource-record-create.md), create a resource record to link your domain name to the bucket. We recommend using [ANAME records](../../../dns/concepts/resource-record.md#aname) in {{ dns-name }}:

   ```
   example.com ANAME example.com.{{ s3-web-host }}
   ```

   ANAME records allow second-level domains to be used for hosting and, unlike CNAME records, do not restrict the use of other record types in the same zone with them.

   If you create a CNAME record for your bucket on a third-party DNS server, make sure your domain name belongs to at least a third-level domain. This is related to how CNAME records are processed on DNS hosting. For more information, see section 2.4 of [RFC 1912](https://www.ietf.org/rfc/rfc1912.txt).


1. To make your website available over HTTPS:

   1. {% include [create-cert.md](../../../_includes/storage/create-cert.md) %}
   1. {% include [add-cert.md](../../../_includes/storage/add-cert.md) %}


{% include [objects-access.md](../../../_includes/storage/objects-access.md) %}


