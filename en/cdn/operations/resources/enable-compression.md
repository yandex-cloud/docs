# Enabling file compression

To enable [compression](../../concepts/compression.md) of files for a [resource](../../concepts/resource.md):

{% list tabs %}

- Management console

  1. In the [management console]({{ link-console-main }}), select the folder your resource is hosted in.
  
  1. Select **{{ cdn-name }}**.
  
  1. On the **CDN resources** tab, click on the name of the desired resource.
  
  1. Go to the **Content** tab.
  
  1. In the upper-right corner, click **Edit**.
  
  1. Enable the **Compress** option.

     {% note info %}

     Before delivery, the content will be compressed by CDN servers using the GZIP compression algorithm. This format is also used to send content to clients in the case of the `Content-Encoding` HTTP header. Only uncompressed content is requested from origins.

     {% endnote %}

  1. Click **Save**.

{% endlist %}
