1. In the ![image](../../_assets/console-icons/flag.svg) **{{ ui-key.yacloud.common.overview }}** tab on the CDN resource page, under **{{ ui-key.yacloud.cdn.label_dns-settings_title }}**, copy the generated domain name in `{{ cname-example-yc }}` format.
1. Navigate to your domain’s DNS settings on your DNS hosting provider’s website.
1. Edit the relevant CNAME record so that it points to the previously copied URL in the `.topology.gslb.yccdn.ru` domain. For example, if the content delivery domain name you specified when creating your CDN resource is `cdn.example.com`, you need to create the following CNAME record or use it to replace the current record for `cdn`:

    ```http
    cdn CNAME {{ cname-example-yc }}.
    ```

    {% include [note-dns-aname](./note-dns-aname.md) %}
