# Your own domain

To publish a website, you can use your own domain (for example, `www.example.com`).

By default, the website is only available over HTTP. To provide HTTPS support for your website, [upload your own security certificate](certificate.md) to {{ objstorage-name }}.

To support your own domain:

- Give your bucket the same name as your domain.

    {% note info %}

    For hosting your websites in {{ objstorage-name }}, use only third-level domains or higher. This is related to how `CNAME` records are processed on DNS hosting. Read more in point 2.4 in [RFC 1912](https://www.ietf.org/rfc/rfc1912.txt).

    {% endnote %}

- Set up an alias for the bucket through your DNS provider or on your own DNS server.

    For instance, for the `www.example.com` domain, the following record should be added:

    ```
    www.example.com CNAME www.example.com.{{ s3-web-host }}
    ```

