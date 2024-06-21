* Specify a **{{ ui-key.yacloud.cdn.field_secure-key }}** that is a string of 6 to 32 characters. You will need a secret key to generate [pre-signed URLs](../../cdn/concepts/secure-tokens.md#protected-link).

   You can view the secret key you saved in the management console or using the `yc cdn resource list` [CLI](../../cli/) command.
* Use the **{{ ui-key.yacloud.cdn.field_secure-key-type }}** field to restrict access to content by IP address:

   * `{{ ui-key.yacloud.cdn.value_secure-key-type-enable }}`: Access to files will be allowed only from a specific IP address of the content recipient. The IP address is specified as a parameter outside a CDN resource when generating an [MD5](https://en.wikipedia.org/wiki/MD5) hash for a pre-signed URL.
   * `{{ ui-key.yacloud.cdn.value_secure-key-type-disable }}`: Access to files will be allowed from any IP address.