To create a rule:

1. Fill in the fields as follows:
   * **{{ ui-key.yacloud.storage.bucket.cors.column_description }}**: Rule description in any form.
   * **{{ ui-key.yacloud.storage.bucket.cors.column_allowed-origin }}**: Comma-separated list of domains. Each domain is written in a separate `AllowedOrigin` field in the CORS configuration, e.g., `http://*.example.com, http://some.another.dom`.
   * **{{ ui-key.yacloud.storage.bucket.cors.column_allowed-method }}**: Comma-separated list of HTTP methods allowed in the object request. Each method is written in a separate `AllowedMethod` field in the CORS configuration, e.g., `GET, PUT, HEAD, POST, DELETE`.
   * **{{ ui-key.yacloud.storage.bucket.cors.column_allowed-header }}**: Comma-separated list of headers allowed in the object request. Each header is written in a separate `AllowedHeader` field in the CORS configuration, e.g., `X-Request-Id, X-Request-With`.
   * `expose_headers`: Comma-separated list of headers that can be displayed in a JavaScript app in the browser. Each header is written in a separate `ExposeHeader` field in the CORS configuration, e.g., `X-Amz-Request-Id`.
   * **{{ ui-key.yacloud.storage.bucket.cors.column_max-age-seconds }}**: Time, in seconds, for the browser to cache the result of an object request using the `OPTIONS` method.
1. Click **{{ ui-key.yacloud.storage.bucket.cors.button_save }}**.

You can add multiple rules at once. To add a new rule, click **{{ ui-key.yacloud.storage.bucket.cors.label_add-cors-settings }}** and repeat the above steps.
