# Secure tokens

Using _secure tokens_, you can restrict access to [CDN resource](./resource.md) files. They are used, for example, to provide temporary or paid access to files and ensure the security of sensitive data.

Files are accessed via [signed links](#protected-link) with the limited validity period whose query parameters contain a secure token. A CDN server uses a hash to map the received token to the CDN resource's secret key and data provided in an HTTP request and either grants or denies access to the file.

Secure tokens can also be used to specify a trusted IP address to allow access to a CDN resource from.

You can [enable](../operations/resources/enable-secure-token.md#enable-secure-token) access to a CDN resource based on a secure token using the [CLI](../../cli/cli-ref/managed-services/cdn/resource/update.md), [{{ TF }}]({{ tf-provider-resources-link }}/cdn_resource), or [API](../api-ref/Resource/update.md). It may take up to 15 minutes for the changes to take effect.

If you enable access to a CDN resource via a secure token, content is only available via signed links. If you want some content to be accessible via regular links, [create](../operations/resources/create-resource.md) another CDN resource with a separate [origin](./origins.md) for this content.

For more information about secure tokens, see the documentation of the EdgeCenter CDN provider:
* [Secure token. Feature overview](https://support.edgecenter.ru/knowledge_base/item/268821?sid=57227)
* [API documentation](https://apidocs.edgecenter.ru/cdn#tag/Resources/operation/change_cdn_resource)

## Signed links {#protected-link}

A _signed link_ is [generated](#link-generation-code) outside a CDN resource, e.g., on a lightweight website, and contains the following query parameters:
* `MD5`: Secure token in [Base64](https://en.wikipedia.org/wiki/Base64) encoding that is an [MD5](https://en.wikipedia.org/wiki/MD5) hash of a string containing the following elements:
   * Secret key: Arbitrary string of 6 to 32 characters.
   * Link validity: Point in time in [Unix format](https://en.wikipedia.org/wiki/Unix_time), after which file access will be denied. Users can start downloading the file before the link validity expires and complete downloading it after that.
   * Path to the file on the origin.
   * (Optional) Trusted IP address the file can be downloaded from. It is specified if you restricted access to the CDN resource based on IP. If no restriction is set, file access will be allowed from any IP. You can restrict access based on IP either when [enabling](../operations/resources/enable-secure-token.md#enable-secure-token) access via a secure token or at any later time.
* `expires`: Validity period of a link in Unix format.

Here is an example of a signed link:

> http://cdn.example.com/files/image.jpg?md5=xu7AXOAOQ********Ua0xw&expires=1701609223

## Examples {#link-generation-code}

Use one of the examples below to generate a signed link.

### Signed links with restricted access based on IP {#link-code-ip-access}

{% list tabs %}

- PHP

   ```php
   <?php

   $secret = '<secret_key>';
   $path = '<file_path>';
   $ip = '<IP_address>';
   $expires = time() + <link_validity>;
   $hostname = '<domain_name>';
   $link = "$expires$path$ip $secret";
   $md5 = md5($link, true);
   $md5 = base64_encode($md5);
   $md5 = strtr($md5, '+/', '-_');
   $md5 = str_replace('=', '', $md5);
   $url = "{$hostname}{$path}?md5={$md5}&expires={$expires}";

   ?>
   ```

   Where:
   * `$secret`: Secret key that is an arbitrary string of 6 to 32 characters.
   * `$path`: Path to the file for access to which the link is generated, e.g., `/files/image.jpg`.
   * `$ip`: Trusted IP address the file can be accessed from.
   * `$expires`: Point in time in [Unix format](https://en.wikipedia.org/wiki/Unix_time), after which the link will be invalid; `<link_validity>`: Number of seconds during which the link will be valid once generated.
   * `$hostname`: CDN resource [domain name](./resource.md#hostnames), e.g., `cdn.example.com`.
   * `$url`: Ready-to-use [signed link](#protected-link) to the file.

- Python

   ```python
   import base64
   from hashlib import md
   from time import time
   ip = '<IP_address>'
   secret = '<secret_key>'
   path = f'<file_path>'
   expires = int(time()) + <link_validity>
   hostname = '<domain_name>'
   token = base64.encodebytes(md5(f"{expires}{path}{ip} {secret}".encode()).digest()).decode().replace("\n", "").replace("+", "-").replace("/", "_").replace("=", "")
   secured_url = f"{hostname}{path}?md5={token}&expires={expires}"
   ```

   Where:
   * `ip`: Trusted IP address the file can be accessed from.
   * `secret`: Secret key that is an arbitrary string of 6 to 32 characters.
   * `path`: Path to the file for access to which the link is generated, e.g., `/files/image.jpg`.
   * `expires`: Point in time in [Unix format](https://en.wikipedia.org/wiki/Unix_time), after which the link will be invalid; `<link_validity>`: Number of seconds during which the link will be valid once generated.
   * `hostname`: CDN resource [domain name](./resource.md#hostnames), e.g., `cdn.example.com`.
   * `secured_url`: Ready-to-use [signed link](#protected-link) to the file.

- OpenSSL

   ```bash
   echo -n '<link_validity><file_path><IP_address> <secret_key>' | openssl md5 -binary | openssl base64 | tr +/ -_ | tr -d ='<link_validity><file_path><IP_address> <secret_key>' = '{expires}{path}{ip} {secret_key}'
   ```

   Where:
   * `<link_validity>`: Point in time in [Unix format](https://en.wikipedia.org/wiki/Unix_time), after which the link will be invalid.
   * `<file_path>`: Path to the file for access to which the link is generated, e.g., `/files/image.jpg`.
   * `<IP_address>`: Trusted IP address the file can be accessed from.
   * `<secret_key>`: Secret key that is an arbitrary string of 6 to 32 characters.

{% endlist %}

### Signed links with no restriction on access based on IP {#link-code-no-ip}

{% list tabs %}

- PHP

   ```php
   <?php

   $secret = '<secret_key>';
   $path = '<file_path>';
   $expires = time() + <link_validity>;
   $hostname = '<domain_name>';
   $link = "$expires$path $secret";
   $md5 = md5($link, true);
   $md5 = base64_encode($md5);
   $md5 = strtr($md5, '+/', '-_');
   $md5 = str_replace('=', '', $md5);
   $url = "{$hostname}{$path}?md5={$md5}&expires={$expires}";

   ?>
   ```

   Where:
   * `$secret`: Secret key that is an arbitrary string of 6 to 32 characters.
   * `$path`: Path to the file for access to which the link is generated, e.g., `/files/image.jpg`.
   * `$expires`: Point in time in [Unix format](https://en.wikipedia.org/wiki/Unix_time), after which the link will be invalid; `<link_validity>`: Number of seconds during which the link will be valid once generated.
   * `$hostname`: CDN resource [domain name](./resource.md#hostnames), e.g., `cdn.example.com`.
   * `$url`: Ready-to-use [signed link](#protected-link) to the file.

- Python

   ```python
   import base64
   from hashlib import md5
   from time import time
   secret = '<secret_key>'
   path = f'<file_path>'  
   expires = int(time()) + <link_validity>
   hostname = '<domain_name>'
   token = base64.encodebytes(md5(f"{expires}{path} {secret}".encode()).digest()).decode().replace("\n", "").replace("+", "-").replace("/", "_").replace("=", "")
   secured_url = f"{hostname}{path}?md5={token}&expires={expires}"
   ```

   Where:
   * `secret`: Secret key that is an arbitrary string of 6 to 32 characters.
   * `path`: Path to the file for access to which the link is generated, e.g., `/files/image.jpg`.
   * `expires`: Point in time in [Unix format](https://en.wikipedia.org/wiki/Unix_time), after which the link will be invalid; `<link_validity>`: Number of seconds during which the link will be valid once generated.
   * `hostname`: CDN resource [domain name](./resource.md#hostnames), e.g., `cdn.example.com`.
   * `secured_url`: Ready-to-use [signed link](#protected-link) to the file.

- OpenSSL

   ```bash
   echo -n '<link_validity><file_path> <secret_key>' | openssl md5 -binary | openssl base64 | tr +/ -_ | tr -d = '<link_validity><file_path> <secret_key>' = '{expires}{path} {secret_key}'
   ```

   Where:
   * `<link_validity>`: Point in time in [Unix format](https://en.wikipedia.org/wiki/Unix_time), after which the link will be invalid.
   * `<file_path>`: Path to the file for access to which the link is generated, e.g., `/files/image.jpg`.
   * `<secret_key>`: Secret key that is an arbitrary string of 6 to 32 characters.

{% endlist %}

### See also {#see-also}

* [{#T}](../operations/resources/enable-secure-token.md)
* [{#T}](../operations/resources/create-resource.md)
* [{#T}](../operations/resources/configure-basics.md)
