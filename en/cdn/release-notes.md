# {{ cdn-full-name }} release notes

## Q1 2024 {#q1-2024}

* Added support for [IP-based access policies](./concepts/ip-address-acl.md) for CDN resources.
* Now you can restrict access to a CDN resource using [secure tokens](./concepts/secure-tokens.md).
* Removed support for automatic issue of TLS certificates for CDN resources on the side of the EdgeCenter CDN provider. Now, you must pre-upload TLS certificates to {{ certificate-manager-full-name }}. For more information, see [{#T}](./concepts/clients-to-servers-tls.md).
