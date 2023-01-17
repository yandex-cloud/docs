---
title: "Static website hosting (html, css, javascript)"
description: "Static website hosting enables you to host your static website built on HTML, CSS and JavaScript. The website cannot contain any scripts that run on the web server side."
---

# Static website hosting

You can host your static website in {{ objstorage-name }}. A static website is based on such client-side technology as HTML, CSS, and JavaScript. It may not contain any scripts that run on the web server side.

{% note info %}

To enable hosting, you need [public access](../operations/buckets/bucket-availability.md) to the bucket. Otherwise, {{ objstorage-name }} returns a 403 error code to the user trying to access the website.

{% endnote %}

{{ objstorage-name }} lets you configure a bucket:

* For static website hosting.

  {% cut "Upload your site content to the bucket and specify the main page of the site" %}

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

  {% cut "You can specify the host to which all requests will be redirected, and also specify the protocol for transmitting requests" %}

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

  {% cut "Example of a rule that redirects a request to a remote folder to another page" %}

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

All the hosting settings are available through the Amazon S3-compatible [HTTP API](../s3/api-ref/hosting.md).

After you configure the bucket for hosting, the website becomes accessible at:

```
http(s)://<bucket_name>.{{ s3-web-host }}
```

or

```
http(s)://{{ s3-web-host }}/<bucket name>
```

{% note info %}

By default, a bucket with a dot in the name is only available over HTTP. To provide HTTPS support for your bucket, [upload your own security certificate](../operations/hosting/certificate.md) to {{ objstorage-name }}.

{% endnote %}

When accessing the website, you receive responses with the codes described in [{#T}](../s3/api-ref/hosting/answer-codes.md).

When hosting a website, you can:

* [Support multiple domain names](../operations/hosting/multiple-domains.md).
* [Use your own domain](../operations/hosting/own-domain.md).

   To use HTTPS with your own domain, specify the [FQDN]{% if lang == "ru" %}(https://ru.wikipedia.org/wiki/FQDN){% endif %}{% if lang == "en" %}(https://en.wikipedia.org/wiki/Fully_qualified_domain_name){% endif %} of the required domain in the bucket name.