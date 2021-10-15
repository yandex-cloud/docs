# Creating a resource

To create a [resource](../../concepts/resource.md):

{% list tabs %}

- Management console

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create a resource.
  
  1. Select **{{ cdn-name }}**.
  
  1. On the **CDN resources** tab, click **Create resource**.
  
  1. Under **Content**, enter the **Origin domain name** or select an **Origin group**.
     You can create a new origin group:

     1. Click **Create new**.
     
     1. Enter the **Group name**.
     
     1. Enter the **Origin domain name** and select **Active** or **Backup**.
     
     1. Add other origins if needed.
     
     1. Click **Create**.

        In the **Origin group** field, you will see the name of the created group.

  1. Under **Domain names for content distribution**, enter the **Domain name**. You can add multiple **Domain names**. The first name is considered the primary domain name.

     {% note warning %}

     After you create a resource, you can't change the primary domain name.

     {% endnote %}

     In the settings of your DNS hosting, create CNAME records for the specified domain names using the value displayed at the bottom of the **Domain names for content distribution** section.

  1. In the **Advanced** section:
      
      1. Select **Origin request protocol**.
      
      1. Enable or disable **End-user access to content**.
      
      1. If you have selected only the HTTP protocol, then in the **TLS certificate** field, select **Don't use**. Otherwise, select the **Let's Encrypt®**  certificate.
      
      1. Select the value of the **Host header** or choose **Custom** and enter the **Header value**.

  1. Click **Create**.

{% endlist %}

{% note info %}

To stop the created resource, [disable access](disable-resource.md) to the content for end users. You can't delete a resource using the management console at the moment: to do this, please [contact support](../../../support/overview.md).

{% endnote %}
