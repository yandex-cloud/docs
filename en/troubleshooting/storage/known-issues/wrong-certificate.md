# Resolving certificate error



## Issue description {#issue-description}

When using a bucket, you see the certificate error: `err_cert_common_name_invalid` or `ssl_error_bad_cert_domain`.

## Solution {#issue-resolution}

Perhaps, a CNAME record has been created in the domain management panel, pointing to the `<bucket-name>.storage.yandexcloud.net` subdomain.

Change its content to `<bucket-name>.website.yandexcloud.net`, where `<bucket-name>` is the name of your bucket.

To learn how to set up a custom domain, see [here](../../../storage/operations/hosting/own-domain).
