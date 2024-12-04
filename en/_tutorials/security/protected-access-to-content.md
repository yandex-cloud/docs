# Providing secure access to content in {{ cdn-name }}


In this tutorial, you will create a website to generate [signed links](../../cdn/concepts/secure-tokens.md#protected-link) with a [secure token](../../cdn/concepts/secure-tokens.md) to a CDN resource in {{ cdn-name }}. The referenced content will be available only for five minutes from the time the link was received and only to the user the link was generated for.

The website will be deployed on a [VM](../../compute/concepts/vm.md) created from a public [LAMP](/marketplace/products/yc/lamp) image with a pre-installed [Apache HTTP server](https://httpd.apache.org/). The website will be available via the domain name delegated in {{ dns-full-name }} for which a [TLS certificate](../../certificate-manager/concepts/managed-certificate.md) will be issued in {{ certificate-manager-full-name }}.

You can create your website infrastructure using one of these tools:
