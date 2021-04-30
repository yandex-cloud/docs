---
title: Website hosting (html, css, javascript)
description: Website Hosting allows you to host a static website built on HTML, CSS and JavaScript. The site cannot contain any scripts that require running on the web server side.
keywords:
  - website hosting
  - hosting
  - static website hosting
  - hosting html
  - hosting jss
  - hosting css
---

# Static website hosting

You can host your static website in {{ objstorage-name }}. A static website is based on client-side technology such as HTML, CSS, and JavaScript. It may not contain any scripts that run on the web server side.

{% note info %}

To enable hosting, you need [public access](../operations/buckets/bucket-availability.md) to the bucket. Otherwise, {{ objstorage-name }} returns a 403 error code to the user trying to access the website.

{% endnote %}

{{ objstorage-name }} lets you configure a bucket:

* For static website hosting.

  {% cut "Upload to the bucket the content of your site and specify the main page of the site" %}

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

  {% cut "You can specify the host to which all requests will be redirected, and also specify the protocol for transmitting requests." %}

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

To set up [static site hosting](../operations/hosting/setup.md) or [forwarding for all requests](../operations/hosting/setup.md), use the {{ yandex-cloud }} management console.

All the hosting settings are available through the [Amazon S3-compatible HTTP API](../s3/api-ref/hosting.md).

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

When accessing the website, you get responses with the codes described in [{#T}](../s3/api-ref/hosting/answer-codes.md).

When hosting a website, you can:
* [Use your own domain](../operations/hosting/own-domain.md).
* [Support multiple domain names](../operations/hosting/multiple-domains.md).