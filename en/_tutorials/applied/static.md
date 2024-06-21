# Static website in {{ objstorage-full-name }}

In this tutorial, you will learn how to upload your website [static files](../../storage/concepts/hosting.md) to [{{ objstorage-name }}](../../storage/) and link a domain name to a [bucket](../../storage/concepts/bucket.md). You can use [{{ dns-full-name }}](../../dns/) to manage your domain.

By default, the website is only available over HTTP. To [provide](../../storage/operations/hosting/certificate.md) HTTPS support for your website, you can upload a [security certificate](../../certificate-manager/concepts/index.md) from [{{ certificate-manager-full-name }}](../../certificate-manager/).

You can create an infrastructure for a static website in {{ objstorage-full-name }} using one of these tools:

* [Management console](../../tutorials/web/static/console.md): Create your infrastructure one step at a time from the {{ yandex-cloud }} management console.
* [{{ TF }}](../../tutorials/web/static/terraform.md): Streamline creating and managing your resources using the _infrastructure as code_ (IaC) approach. Download the {{ TF }} configuration example and then deploy the infrastructure using the [{{ TF }} {{ yandex-cloud }} provider]({{ tf-docs-link }}).