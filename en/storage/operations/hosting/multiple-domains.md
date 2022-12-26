# Support for multiple website domain names

If you want to support multiple domain names for your website, such as `example.com` and `www.example.com`:

1. Create a bucket named `www.example.com` and upload your data to it.
1. Create record in {% if audience != "internal" %}[{{ dns-name }}](../../../dns/operations/resource-record-create.md){% else %}{{ dns-name }}{% endif %}

    ```
    www.example.com CNAME www.example.com.{{ s3-web-host }}
    ```
3. Set up a redirect from the `example.com` domain to the `www.example.com` domain on the provider side.

If for some reason you can't or don't want to redirect the domain, you can do the following:

1. Create a VM with an external IP address.
2. Configure the `example.com` domain to use the IP address of the VM.
3. Set up all necessary aliases on the provider side.
4. Install a web server on the VM and configure a redirect to the {{ objstorage-name }} bucket.

