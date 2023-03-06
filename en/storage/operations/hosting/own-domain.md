# Your own domain

To publish a website, you can use your own domain (for example, `example.com`).

To support your own domain:

- Name a bucket the same as your domain.

- On your {% if lang == "ru" and audience != "internal" %}[DNS server](../../../glossary/dns.md#dns-server){% else %}DNS server{% endif %}, for example, in {% if audience != "internal" %}[{{ dns-full-name }}](../../../dns/operations/resource-record-create.md){% else %}{{ dns-full-name }}{% endif %}, create a resource record to link your domain name to the bucket. We recommend using {% if audience != "internal" %}[ANAME records](../../../dns/concepts/resource-record.md#aname){% else %}ANAME records{% endif %} in {{ dns-name }}:

   ```
   example.com ANAME example.com.{{ s3-web-host }}
   ```

   ANAME records allow second-level domains to be used for hosting and, unlike CNAME records, do not restrict the use of other record types in the same zone with them.

   If you create a CNAME record for your bucket on a third-party DNS server, make sure your domain name belongs to at least a third-level domain. This is related to how CNAME records are processed on DNS hosting. For more information, see section 2.4 of [RFC 1912](https://www.ietf.org/rfc/rfc1912.txt).

{% note info %}

By default, the website is only available over HTTP. To provide HTTPS support for your website, [upload your own security certificate](certificate.md) to {{ objstorage-name }}.

{% endnote %}
