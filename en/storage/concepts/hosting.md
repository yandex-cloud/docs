---
title: "Static website hosting (html, css, javascript)"
description: "Static website hosting enables you to host your static website based on HTML, CSS, or JavaScript. Your website should not contain any scripts that run on the web server side."
---

# Static website hosting

You can host your static website in {{ objstorage-name }}. A static website is one that is based on such client-side technologies as HTML, CSS, or JavaScript. It may not contain any scripts that run on the web server side.

{% note info %}

To enable hosting, you need [public access](../operations/buckets/bucket-availability.md) to the bucket. Otherwise, {{ objstorage-name }} will return the 403 error code to the user trying to access the website.

{% endnote %}

{{ objstorage-name }} allows you to configure a bucket:

* For static website hosting.

  {% cut "Upload your website content to the bucket and specify the home page" %}

  ```xml
  <WebsiteConfiguration xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
    <IndexDocument>
        <Suffix>index.html</Suffix>
    </IndexDocument>
    <ErrorDocument>
        <Key>error.html</Key>
    </ErrorDocument>
  </WebsiteConfiguration>
  ```

  {% endcut %}

* To redirect all requests.

  {% cut "You can specify the host to which all requests will be redirected, as well as the protocol for transmitting requests" %}

  ```xml
  <WebsiteConfiguration xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
    <RedirectAllRequestsTo>
        <HostName>example.com</HostName>
        <Protocol>http</Protocol>
    </RedirectAllRequestsTo>
  </WebsiteConfiguration>
  ```

  {% endcut %}

* For conditionally redirecting requests.

  Using routing rules, you can redirect requests based on the object name prefixes or HTTP response codes. You can redirect an object request to other web pages (if the object was deleted) or redirect the requests that return errors.

  {% cut "Example of a rule that redirects a request to a deleted folder to another page" %}

  ```xml
  <WebsiteConfiguration xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
    <RoutingRules>
      <RoutingRule>
        <Condition>
          <KeyPrefixEquals>temp/</KeyPrefixEquals>
        </Condition>
        <Redirect>
          <ReplaceKeyWith>folderdeleted.html</ReplaceKeyWith>
        </Redirect>
      </RoutingRule>
    </RoutingRules>
  </WebsiteConfiguration>
  ```

  {% endcut %}

You can configure [static website hosting](../operations/hosting/setup.md#hosting), [redirection for all requests](../operations/hosting/setup.md#redirects), or [conditional request redirection](../operations/hosting/setup.md#redirects-on-conditions) using the {{ yandex-cloud }} management console.

All hosting settings are available through Amazon S3-compatible [HTTP API](../s3/api-ref/hosting.md).

After you configure the bucket for hosting, the website will become accessible at:


```
http(s)://<bucket_name>.{{ s3-web-host }}
```

or

```
http(s)://{{ s3-web-host }}/<bucket name>
```



{% note info %}

By default, a bucket with a dot in the name is only available over HTTP. To provide HTTPS support for your bucket, [upload your own security certificate](../operations/hosting/certificate.md) to {{ objstorage-name }}.

{% include [redirect-https](../../_includes/storage/redirect-https.md) %}

{% endnote %}


When accessing your website, you will receive responses with the codes described in the [{#T}](../s3/api-ref/hosting/answer-codes.md) section.

When hosting a website, you can:

* [Support multiple domain names](../operations/hosting/multiple-domains.md).
* [Use your own domain](../operations/hosting/own-domain.md).

  To use HTTPS with your own domain, specify the [FQDN](https://en.wikipedia.org/wiki/Fully_qualified_domain_name) of the required domain in the bucket name.

You can manage {{ dns-full-name }} domains in the bucket settings or in [{{ dns-name }}](../../dns/operations/index.md).

{% include [public-link](../../_includes/storage/public-link.md) %}

