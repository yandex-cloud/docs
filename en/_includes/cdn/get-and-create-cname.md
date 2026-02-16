Once the CDN resource is created, [get](../../cdn/operations/resources/get-resources-info.md#get-cname) the CDN provider's domain name and create a [CNAME resource record](../../dns/concepts/resource-record.md#cname) for the specified name in your DNS hosting settings, e.g., in [{{ dns-full-name }}](../../dns/operations/resource-record-create.md). For more information, see [{#T}](../../cdn/concepts/resource.md#hostnames).

Sample resource record:

```text
cdn.example.com. CNAME {{ cname-example-yc }}
```