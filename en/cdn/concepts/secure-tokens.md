# Secure tokens

Using _secure tokens_ , you can restrict access to [CDN resource](./resource.md) files. For example, with secure tokens, you can provide temporary or paid access to files and ensure the security of sensitive data.

Files are accessed via [signed links](#protected-link) with the limited validity period whose query parameters contain a secure token. A CDN server uses a hash to map the received token to the CDN resource's secret key and data provided in an HTTP request and either grants or denies access to the file.

You can also use secure tokens to specify a trusted IP address from which to access a CDN resource.

You can [enable](../operations/resources/enable-secure-token.md#enable-secure-token) secure token access to a CDN resource using the [management console]({{ link-console-main }}), [CLI](../../cli/cli-ref/cdn/cli-ref/resource/update.md), [{{ TF }}]({{ tf-provider-resources-link }}/cdn_resource), or [API](../api-ref/Resource/update.md). It may take up to 15 minutes for the changes to take effect.

If you enable access to a CDN resource via a secure token, content is only available via signed links. If you want some content to be accessible via regular links, [create](../operations/resources/create-resource.md) another CDN resource with a separate [origin](./origins.md) for this content.

For more information about secure tokens, see the documentation of the EdgeCenter CDN provider:
* [Secure token. Feature overview](https://support.edgecenter.ru/knowledge_base/item/268821?sid=57227)
* [API documentation](https://apidocs.edgecenter.ru/cdn#tag/Resources/operation/change_cdn_resource)


## Signed links {#protected-link}

A _signed link_ is [generated](#link-generation-code) outside a CDN resource, e.g., on a lightweight website, and contains the following query parameters:
* `md5`: [Base64](https://en.wikipedia.org/wiki/Base64)-encoded secure token represented by an [MD5](https://en.wikipedia.org/wiki/MD5) hash of a string containing the following elements:
  * Secret key: Arbitrary string of 6 to 32 characters.
  * Link validity: Time point, in [Unix format](https://en.wikipedia.org/wiki/Unix_time), after which access to the file will be denied. Users can start downloading the file before the link validity expires and complete downloading it after that.
  * Path to the file on the origin.
  * (Optional) Trusted IP address the file can be downloaded from. It is specified if you restricted access to the CDN resource based on IP. If no restriction is set, file access will be allowed from any IP. You can restrict access based on IP either when [enabling](../operations/resources/enable-secure-token.md#enable-secure-token) access via a secure token or at any later time.
* `expires`: Link validity period in Unix format.

Here is an example of a signed link:

> http://cdn.example.com/files/image.jpg?md5=xu7AXOAOQ********Ua0xw&expires=1701609223


## Examples {#link-generation-code}

Use one of the examples below to generate a signed link.

### Signed links with access restriction based on IP {#link-code-ip-access}

{% note info %}

A VPN connection may interfere with the proper functioning of signed links with access restriction based on IP. For links to function properly, disable the VPN.

{% endnote %}

{% list tabs group=programming_language %}

- PHP {#php}

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
  * `$secret`: Secret key, a string of 6 to 32 characters.
  * `$path`: Path to the file the link is generated to provide access to, e.g., `/files/image.jpg`.
  * `$ip`: Trusted IP address the file can be accessed from, e.g., `1.2.3.4`.
  * `$expires`: Time point in [Unix format](https://en.wikipedia.org/wiki/Unix_time) after which the link will become invalid. `<link_validity>`: Link validity period, in seconds, since it was generated.
  * `$hostname`: CDN resource's [domain name](./resource.md#hostnames) stating the scheme (`http` or `https`), e.g., `https://cdn.example.com`.
  * `$url`: Ready-made [signed link](#protected-link) to the file.

- Python {#python}

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
  * `ip`: Trusted IP address the file can be accessed from, e.g., `1.2.3.4`.
  * `secret`: Secret key, a string of 6 to 32 characters.
  * `path`: Path to the file the link is generated to provide access to, e.g., `/files/image.jpg`.
  * `expires`: Time point in [Unix format](https://en.wikipedia.org/wiki/Unix_time) after which the link will become invalid. `<link_validity>`: Link validity period, in seconds, since it was generated.
  * `hostname`: CDN resource's [domain name](./resource.md#hostnames) stating the scheme (`http` or `https`), e.g., `https://cdn.example.com`.
  * `secured_url`: Ready-made [signed link](#protected-link) to the file.

- OpenSSL {#openssl}

  ```bash
  #!/bin/bash
  # This script generates a signed link with IP-based restricted access
  let "EXPIRES=$(date +%s) + <link_validity>"
  HOSTNAME="<domain_name>"
  FILEPATH="<file_path>"
  IP="<IP_address>"
  SECRET="<secret_key>"
  TOKEN=$(echo -n $EXPIRES$FILEPATH$IP' '$SECRET | openssl md5 -binary | openssl base64 | tr +/ -_ | tr -d = )
  echo $HOSTNAME$FILEPATH'?md5='$TOKEN'&expires='$EXPIRES
  ```

  Where:
  * `$EXPIRES`: Time point in [Unix format](https://en.wikipedia.org/wiki/Unix_time) after which the link will become invalid. `<link_validity>`: Link validity period, in seconds, since it was generated.
  * `$HOSTNAME`: CDN resource's [domain name](./resource.md#hostnames) stating the scheme (`http` or `https`), e.g., `https://cdn.example.com`.
  * `$FILEPATH`: Path to the file the link is generated to provide access to, e.g., `/files/image.jpg`.
  * `$IP`: Trusted IP address the file can be accessed from, e.g., `1.2.3.4`.
  * `$SECRET`: Secret key, a string of 6 to 32 characters.

{% endlist %}

### Signed links with no restriction on access based on IP {#link-code-no-ip}

{% list tabs group=programming_language %}

- PHP {#php}

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
  * `$secret`: Secret key, a string of 6 to 32 characters.
  * `$path`: Path to the file the link is generated to provide access to, e.g., `/files/image.jpg`.
  * `$expires`: Time point in [Unix format](https://en.wikipedia.org/wiki/Unix_time) after which the link will become invalid. `<link_validity>`: Link validity period, in seconds, since it was generated.
  * `$hostname`: CDN resource's [domain name](./resource.md#hostnames) stating the scheme (`http` or `https`), e.g., `https://cdn.example.com`.
  * `$url`: Ready-made [signed link](#protected-link) to the file.

- Python {#python}

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
  * `secret`: Secret key, a string of 6 to 32 characters.
  * `path`: Path to the file the link is generated to provide access to, e.g., `/files/image.jpg`.
  * `expires`: Time point in [Unix format](https://en.wikipedia.org/wiki/Unix_time) after which the link will become invalid. `<link_validity>`: Link validity period, in seconds, since it was generated.
  * `hostname`: CDN resource's [domain name](./resource.md#hostnames) stating the scheme (`http` or `https`), e.g., `https://cdn.example.com`.
  * `secured_url`: Ready-made [signed link](#protected-link) to the file.

- OpenSSL {#openssl}

  ```bash
  #!/bin/bash
  # This script generates a signed link with no IP address restrictions
  let "EXPIRES=$(date +%s) + <link_validity>"
  HOSTNAME="<domain_name>"
  FILEPATH="<file_path>"
  SECRET="<secret_key>"
  TOKEN=$(echo -n $EXPIRES$FILEPATH' '$SECRET | openssl md5 -binary | openssl base64 | tr +/ -_ | tr -d = )
  echo $HOSTNAME$FILEPATH'?md5='$TOKEN'&expires='$EXPIRES
  ```

  Where:
  * `$EXPIRES`: Time point in [Unix format](https://en.wikipedia.org/wiki/Unix_time) after which the link will become invalid. `<link_validity>`: Link validity period, in seconds, since it was generated.
  * `$HOSTNAME`: CDN resource's [domain name](./resource.md#hostnames) stating the scheme (`http` or `https`), e.g., `https://cdn.example.com`.
  * `$FILEPATH`: Path to the file the link is generated to provide access to, e.g., `/files/image.jpg`.
  * `$SECRET`: Secret key, a string of 6 to 32 characters.

{% endlist %}


### See also {#see-also}

* [{#T}](../operations/resources/enable-secure-token.md)
* [{#T}](../operations/resources/create-resource.md)
* [{#T}](../operations/resources/configure-basics.md)
* [{#T}](../tutorials/protected-access-to-content/index.md)