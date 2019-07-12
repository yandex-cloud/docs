# Configuring buckets

You can configure a bucket:

{% list tabs %}

- As a website
  
  - [Allow public access](../operations/buckets/bucket-availability.md). Otherwise, Object Storage returns error code 403 to the user.
  - [Specify the website's home page](setup.md).
  - You can optionally specify the web page that will be returned if 4xx errors occur.
  
- To redirect all requests to an arbitrary host
  
  - [Set the host](setup.md) to redirect requests to.
  - If necessary, specify the protocol to be used to access the host. The initial request protocol is used by default.
  
{% endlist %}

If you are going to use your own domain to publish a website, the bucket name must match the domain name. For instance, `www.example.com`.

Buckets can be configured:

- In the Yandex.Cloud [management console](setup.md).
- Through the [HTTP API](../s3/api-ref/hosting.md) compatible with Amazon S3.

## Support for multiple website domain names

If you want to have multiple domain names supported for your website, for instance, `example.com` and `www.example.com`, you can do this as follows:

1. Create the `www.example.com` bucket and upload your data to it.
2. Set up an alias for the bucket through your provider.

    ```
    www.example.com CNAME www.example.com.website.yandexcloud.net
    ```
3. Set up a redirect from the `example.com` domain to the `www.example.com` domain on the provider side.

If for some reason you can't or don't want to redirect the domain, you can do the following:

1. Purchase a virtual machine with an external IP address.
2. Configure the `example.com` domain to use the IP address of the virtual machine.
3. Set up all necessary aliases on the provider side.
4. Install a web server on the virtual machine and configure a redirect to the Object Storage bucket.

