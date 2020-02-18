# Static website hosting

You can host your static website in {{ objstorage-name }}. A static website is based on client-side technology such as HTML, CSS, and JavaScript. It may not contain any scripts that run on the web server side.

{{ objstorage-name }} lets you configure a bucket:

- For static website hosting.
- For request redirects.

In both cases, [public access should be open](../operations/buckets/bucket-availability.md) to a bucket. Otherwise, {{ objstorage-name }} returns a 403 error code to the user trying to access the website.

After you configure the bucket for hosting, the website becomes accessible at:

```
http(s)://<bucket name>.{{ s3-web-host }}
```

or

```
http(s)://{{ s3-web-host }}/<bucket name>
```

{% note info %}

By default, a bucket with a dot in the name is only available over HTTP. To grant it HTTPS support, [upload your own security certificate](../operations/hosting/certificate.md) to {{ objstorage-name }}.

{% endnote %}

When accessing the website, you receive responses with the codes described in [{#T}](../s3/api-ref/hosting/answer-codes.md)

Buckets can be configured:

- In the Yandex.Cloud [management console](../operations/hosting/setup.md).
- Through the [Amazon S3-compatible HTTP API](../s3/api-ref/hosting.md).

When hosting a website, you can:

- [Use your own domain](../operations/hosting/own-domain.md)
- [Support multiple domain names](../operations/hosting/multiple-domains.md)

