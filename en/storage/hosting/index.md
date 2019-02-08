# Static website hosting

You can host your static website in [!KEYREF objstorage-full-name]. A static website is based on client-side technology such as HTML, CSS, and JavaScript. It may not contain any scripts that run on the web server side.

To host a website:

- Upload the website's files to the bucket created specifically for hosting the website.
- [Configure the bucket](bucket-configuration.md) for hosting.

After you configure the bucket for hosting, the website becomes accessible at:

```
http(s)://<bucket name>.[!KEYREF s3-web-host]
```

or

```
http(s)://[!KEYREF s3-web-host]/<bucket name>
```

> [!NOTE]
>
> You can use HTTPS only if there is no dot in a bucket name.

## Your own domain

You can use your own domain to display the website.

In this case:

- The bucket name must exactly match the domain name.

- Set up an alias for the bucket through your DNS provider or on your own DNS server.

    For instance, for the `example.com` domain, the following record should be added:

    ```
    example.com CNAME example.com.[!KEYREF s3-web-host]
    ```

> [!NOTE]
>
> The website is accessible only over HTTP, for instance, `http://example.com` or `http://example.com.[!KEYREF s3-web-host]`.

