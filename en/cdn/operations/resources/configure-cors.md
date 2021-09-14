# Configuring CORS when responding to clients

To configure for the [resource](../../concepts/resource.md) cross-domain requests with [CORS](../../concepts/cors.md):

{% list tabs %}

- Management console

  1. In the [management console]({{ link-console-main }}), select the folder your resource is hosted in.
  
  1. Select **{{ cdn-name }}**.
  
  1. On the **CDN resources** tab, click on the name of the desired resource.
  
  1. Go to the **HTTP headers and methods** tab.
  
  1. In the upper-right corner, click **Edit**.
  
  1. Under **CORS when responding to client requests**:
      * In the **Access-Control-Allow-Origin header** field, specify whether to add this header to responses.
      * When adding a header, select the values of the `Origin` header that allow access to the content. To allow access only to certain origins, select **Same as Origin if on the list**, specify the domain names of the origins, and click **Add domain name**.

  1. Click **Save**.

{% endlist %}
