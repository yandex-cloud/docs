# Configuring buckets

You can configure a bucket:

---

**[!TAB As a website]**

- [Allow public access](../operations/buckets/bucket-availability.md). Otherwise, [!KEYREF objstorage-name] returns error code 403 to the user.
- [Specify the website's home page](setup.md).
- You can optionally specify the web page that will be returned if 4xx errors occur.

**[!TAB To redirect all requests to an arbitrary host]**

- [Set the host](setup.md) to redirect requests to.
- If necessary, specify the protocol to be used to access the host. The initial request protocol is used by default.

---

If you are going to use your own domain to publish a website, the bucket name must exactly match the domain name. For instance, `example.com`.

Buckets can be configured:

- In the Yandex.Cloud [management console](setup.md).
- Through the [HTTP API](../s3/api-ref/hosting.md) compatible with Amazon S3.

## Support for multiple website domain names

If you want to have multiple domain names supported for your website, for instance, `example.com` and `www.example.com`, you can do this as follows:

1. Create the `example.com` bucket and upload your data to it.
2. Set up an alias for the bucket through your provider.

    ```
    example.com CNAME example.com.[!KEYREF s3-web-host]
    ```
3. Create the `www.example.com` bucket and leave it empty.
4. Set up an alias for the bucket through your provider.

    ```
    www.example.com CNAME www.example.com.[!KEYREF s3-web-host]
    ```
5. Set up a [redirect](setup.md) for all data from the `www.example.com` bucket to the `example.com` one.

