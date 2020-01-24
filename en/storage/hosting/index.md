# Static website hosting

You can host your static website in {{ objstorage-full-name }}. A static website is based on client-side technology such as HTML, CSS, and JavaScript. It may not contain any scripts that run on the web server side.

To host a website:

- Upload the website's files to the bucket created specifically for hosting the website.
- [Configure the bucket](bucket-configuration.md) for hosting.

After you configure the bucket for hosting, the website becomes accessible at:

```
http(s)://<bucket name>.{{ s3-web-host }}
```

or

```
http(s)://{{ s3-web-host }}/<bucket name>
```

{% note info %}

You can use HTTPS only if there is no dot in a bucket name.

{% endnote %}

## Your own domain {#your-domain}

To display the site, you can use your own domain (for example, `www.example.com`).

In this case:

- The name of the bucket must match the domain name (for example, `www.example.com`).

    {% note info %}

    Use only for hosting third-level domains or higher in {{ objstorage-name }}. This is related to how `CNAME` records are processed on DNS hosting. Read more in point 2.4 in [RFC 1912](https://www.ietf.org/rfc/rfc1912.txt).

    {% endnote %}

- Set up an alias for the bucket through your DNS provider or on your own DNS server.

    For instance, for the `www.example.com` domain, the following record should be added:

    ```
    www.example.com CNAME www.example.com.{{ s3-web-host }}
    ```

{% note info %}

The website is accessible only over HTTP, for instance, `http://www.example.com` or `http://www.example.com.{{ s3-web-host }}`.

{% endnote %}

