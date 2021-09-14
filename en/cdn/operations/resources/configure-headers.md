# Configuring HTTP headers of requests and responses

To configure, for your resource, the [HTTP headers of requests and responses](../../concepts/resource.md#http):

{% list tabs %}

- Management console

  1. In the [management console]({{ link-console-main }}), select the folder your resource is hosted in.
  
  1. Select **{{ cdn-name }}**.
  
  1. On the **CDN resources** tab, click on the name of the desired resource.
  
  1. Go to the **HTTP headers and methods** tab.
  
  1. In the upper-right corner, click **Edit**.
  
  1. Under **Origin request headers**:
      * In the **Header** field, click **Add**.
      * Enter names and values of the desired headers.

  1. Under **Client response headers**:
      * In the **Header** field, click **Add**.
      * Enter names and values of the desired headers.

      {% note info %}

      The `Access-Control-Allow-Origin` header for the CORS configuration is configured under **CORS when responding to client requests**. Read more in [{#T}](configure-cors.md).

      {% endnote %}

  1. Click **Save**.

{% endlist %}
