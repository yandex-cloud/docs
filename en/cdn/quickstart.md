# Getting started with {{ cdn-full-name }}

Configure CDN content distribution using a sample static site in {{ objstorage-name }}:

1. [{#T}](#create-cdn-resource).
1. [{#T}](#upload-content-to-CDN).
1. [{#T}](#setup-cname).
1. [{#T}](#check-cdn-working).

## Before you start {#before-you-begin}

1. Make sure that you have a domain name and can access the DNS settings on the site of the company that provides DNS hosting to you. This is usually the company that registered your domain.
1. Go to the [management console]({{ link-console-main }}). Then log in to {{ yandex-cloud }} or sign up if you don't have an account yet.
1. If you don't have a folder yet, create one:

    {% include [create-folder](../_includes/create-folder.md) %}

1. If you haven't activated the CDN provider, activate it:
    1. Go to the folder page and select **{{ cdn-full-name }}**.
    1. Click **Activate provider**.

1. If you don't have a static site in a {{ objstorage-name }} bucket yet, create one:

    1. [Create a bucket](../storage/operations/buckets/create.md).

        In the bucket settings, enable public access both to the bucket and list of its objects.

    1. [Upload](../storage/operations/objects/upload.md) the site content to your bucket.
    1. [Set up hosting for your domain](../solutions/web/static.md).

    Make sure that the static site is accessible at the specified URL (for example, `www.example.com`): the page opens and its content loads.

## Create a CDN resource {#create-cdn-resource}

1. Go to the folder page and select **{{ cdn-full-name }}**.

1. On the **CDN resources** tab, click **Create resource**.

    Set up the CDN resource parameters as follows:

    * **Content query**: Select **From one origin**.
    * **Origin type**: Select **Bucket**.
    * **Bucket**: Select the bucket created in {{ objstorage-name }} and the **Use bucket site** option.
    * **Domain names for content distribution**: Specify one (primary) domain name that the CDN will use to distribute content. To get static content from the CDN, use links with this domain name in your site code. In the example, all site content in the bucket is distributed over the CDN. That's why you must set this parameter to your site's domain name, for example:

        ```http
        www.example.com
        ```

        {% note alert %}

        You can't change the primary domain name used for content distribution after you create a CDN resource!

        {% endnote %}

    * In the **Advanced** section:

        1. Change the **Host header** setting to **Custom**.
        1. In the **Header value** field, specify a public link to the bucket with a static site. You can find this link on the **Website** tab on the bucket's page in the [management console]({{ link-console-main }}). For example:

            ```http
            www.example.com.{{ s3-web-host }}
            ```

1. Click **Create**.

## Upload your content to the CDN {#upload-content-to-CDN}

{% note tip %}

We recommend that you preload large content to the CDN (for example, files larger than 200 MB). This is an optional step. If you skip uploading content at this point, it will be uploaded to the CDN automatically when a user tries to access it for the first time.

{% endnote %}

To preload content to CDN servers:

1. Go to the **Content** tab.
1. Click **Preload content**.
1. In the **File path** field, enter the names of the files stored in the bucket, omitting the bucket name, for example:

    ```text
    /index.html
    /static/styles.css
    /static/app.js
    ```

1. Click **Preload content**.

## Set up a CNAME record for your domain {#setup-cname}

1. On the **Overview** tab, under **DNS Settings**, copy the generated URL on the `.gcdn.co` domain to the clipboard.
1. Go to your domain's DNS settings on the site of your DNS hosting provider.
1. Edit the CNAME record for `www` so that it points to the previously copied URL on the `.gcdn.co` domain, for example:

    ```http
    www CNAME cl-.....6bb.gcdn.co.
    ```

## Test the CDN {#check-cdn-working}

1. Wait until the DNS records are updated.
1. Make sure that the `www` CNAME record in the DNS server cache points to the generated URL (for example, `cl-.....6bb.gcdn.co`).
1. Try opening the site's URL in the browser, for example:

    ```http
    http://www.example.com/
    ```
