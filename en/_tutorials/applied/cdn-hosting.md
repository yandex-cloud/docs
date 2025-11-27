# Setting up static website hosting in a {{ objstorage-full-name }} bucket with {{ cdn-full-name }} access


In this tutorial, you will create a static website in a [{{ objstorage-full-name }}](../../storage/) [bucket](../../storage/concepts/bucket.md) and publish it as a content origin in [{{ cdn-full-name }}](../../cdn/). The connection between the client and the CDN server can use TLS 1.0 and TLS 1.1; the connection between the CDN server and {{ objstorage-name }} can use TLS 1.2 or higher. The website will be available via the domain name delegated in [{{ dns-full-name }}](../../dns/), for which a TLS certificate will be issued in [{{ certificate-manager-full-name }}](../../certificate-manager/). The website domain name will be mapped to the CDN resource using a [CNAME](../../dns/concepts/resource-record.md#cname) record in DNS.

We will use the `cdn.yandexcloud.example` domain name as an example.
