# Enabling file segmentation

To enable [segmentation](../../concepts/slicing.md) for the files of the [resource](../../concepts/resource.md):

{% list tabs %}

- Management console

  1. In the [management console]({{ link-console-main }}), select the folder your resource is hosted in.
  
  1. Select **{{ cdn-name }}**.
  
  1. On the **CDN resources** tab, click on the name of the desired resource.
  
  1. Go to the **Content** tab.
  
  1. Click **Edit** at the top right.
  
  1. Enable the **Optimize delivery** option.

     {% note info %}

     Files larger than 10 MB will be requested and cached in parts, each part no larger than 10 MB. For segmentation to work, content origins must support partial GET requests with the `Range` header.

     {% endnote %}

  1. Click **Save**.

{% endlist %}

