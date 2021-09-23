# Configuring resource caching

To configure the parameters of [caching](../../concepts/caching.md) for the [resource](../../concepts/resource.md):

{% list tabs %}

- Management console

  1. In the [management console]({{ link-console-main }}), select the folder your resource is hosted in.
  
  1. Select **{{ cdn-name }}**.
  
  1. On the **CDN resources** tab, click on the name of the desired resource.
  
  1. Go to the **Caching** tab.
  
  1. In the upper-right corner, click **Edit**.
  
  1. Select and configure the caching options:

      * Under **CDN**:
          * Enable **CDN caching**.
          * Select the setting type: **Same as origin** or **Custom**.
          * Select the cache lifetime from the list.
          * (optional) For the settings type **Custom**, set the cache lifetime for the desired HTTP response codes.

      * Under **Browser**:
          * Enable **Browser caching**.
          * Select the cache lifetime from the list.

  1. (optional) Under **Additional**:
      * Select the option to ignore Cookies.
      * Select the option to ignore the query parameters.

  1. Click **Save**.

{% endlist %}
