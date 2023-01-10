# Your own domain

To publish a website, you can use your own domain (for example, `example.com`).

To support your own domain:

- Name a bucket the same as your domain.

- In {% if audience != "internal" %}[{{ dns-name }}](../../../dns/operations/resource-record-create.md){% else %}{{ dns-name }}{% endif %}, create a record:

   ```
   example.com ANAME example.com.{{ s3-web-host }}
   ```

   We recommend using {% if audience != "internal" %}[ANAME records](../../../dns/concepts/resource-record.md#aname){% else %}ANAME records{% endif %} in {{ dns-name }} when hosting an {{ objstorage-name }} website. These records allow second-level domains to be used for hosting and, unlike CNAME records, do not restrict the use of other record types in the same zone with them.

   If necessary, you can use CNAME records on external DNS servers. In this case, use at least third-level domains for hosting in Object Storage. This is due to the way CNAME records are processed on DNS hostings. For more information, see section 2.4 of [RCF 1912](https://www.ietf.org/rfc/rfc1912.txt).

{% note info %}

By default, the website is only available over HTTP. To provide HTTPS support for your website, [upload your own security certificate](certificate.md) to {{ objstorage-name }}.

{% endnote %}
