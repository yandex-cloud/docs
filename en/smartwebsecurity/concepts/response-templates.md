# Response page templates

{{ sws-name }} protects websites and web applications against cybersecurity threats by blocking or allowing external requests. By default, when a request is blocked, the client gets a standard {{ yandex-cloud }} page with the response code and general information. With response templates, you can tailor the response pages to the needs and design of your website.

Response page templates help to implement a unified format for {{ sws-name }} messages displayed when security profile or ARL profile rules are triggered. They allow you to securely forward request data to the client for diagnostics, maintain a consistent interface for your web application, and optimize pages for different platforms.

When handling browser requests from users, templates enable you to:

* Explain reasons for the denial and recommended next steps.
* Describe authorization requirements and ways to get access.
* Outline the timelines and access recovery conditions.

When processing API requests, templates enable you to:

* Provide uniform responses when blocking occurs.
* Return structured responses for convenient client-side processing.
* Reduce the risk of internal information leaks in server responses.
* Streamline diagnostics by returning request data.
* Control client behavior via HTTP headers.
* Maintain compatibility with integrations by selecting the response format.

When configuring a response page template, you need to specify the [response code](#answer-code), [response format](#answer-format), and [response content](#answer-body). Once you create the template, you can assign it to all blocking actions of a [security](profiles.md) and [ARL profile](arl.md), or to a specific rule within these profiles.

## Response code {#answer-code}

You can redefine the default response page or create a custom one for standard [HTTP codes](https://www.iana.org/assignments/http-status-codes/http-status-codes.xhtml).

{% cut "Response code descriptions" %}

* **Successful responses 2xx**
  * 200 OK: Request successfully completed.
  * 201 CREATED: Resource created.
  * 202 ACCEPTED: Request accepted for processing.
  * 203 NON-AUTHORITATIVE INFORMATION: Information received not from the original server.
  * 204 NO CONTENT: Server successfully processed the request but returned no response.
  * 205 RESET CONTENT: Reset the document view after request completion.
  * 206 PARTIAL CONTENT: Server returning the resource only in part.
  * 207 MULTI-STATUS: Message body contains multiple status codes.
  * 208 ALREADY REPORTED: Parts of the resource already listed earlier.
  * 226 IM USED: Server processed the request with modified content.

* **3xx redirects**
  * 300 MULTIPLE CHOICES: Multiple options available for the resource.
  * 301 MOVED PERMANENTLY: Resource moved permanently.
  * 302 FOUND: Resource located at a different address.
  * 303 SEE OTHER: Result is at a different URL.
  * 304 NOT MODIFIED: Resource not modified (for caching).
  * 305 USE PROXY: Access the resource via a proxy (deprecated).
  * 307 TEMPORARY REDIRECT: Temporary redirection to a different URL.
  * 308 PERMANENT REDIRECT: Resource moved permanently to a new URL.

* **Client errors 4xx**
  * 400 BAD REQUEST: Server failed to understand the request.
  * 401 UNAUTHORIZED: Authentication required.
  * 402 PAYMENT REQUIRED: Payment required to access the resource.
  * 403 FORBIDDEN: Access denied.
  * 404 NOT FOUND: Resource not found.
  * 405 METHOD NOT ALLOWED: Request method not allowed.
  * 406 NOT ACCEPTABLE: No acceptable response format.
  * 407 PROXY AUTHENTICATION REQUIRED: Authentication with the proxy required.
  * 408 REQUEST TIMEOUT: Request timed out.
  * 409 CONFLICT: Request in conflict with the current resource state.
  * 410 GONE: Resource deleted.
  * 411 LENGTH REQUIRED: Content-Length header required.
  * 412 PRECONDITION FAILED: Request conditions not met.
  * 413 PAYLOAD TOO LARGE: Request body too large.
  * 414 URI TOO LONG: Request URI too long.
  * 415 UNSUPPORTED MEDIA TYPE: Media type (Content-Type) not supported.
  * 416 RANGE NOT SATISFIABLE: Requested range unavailable.
  * 417 EXPECTATION FAILED: Expectation from the request cannot be met.
  * 421 MISDIRECTED REQUEST: Request sent to the wrong server.
  * 422 UNPROCESSABLE ENTITY: Request is correct but cannot be processed by the server.
  * 423 LOCKED: Resource locked.
  * 424 FAILED DEPENDENCY: Request failed due to the previous request failure.
  * 426 UPGRADE REQUIRED: Protocol must be upgraded.
  * 428 PRECONDITION REQUIRED: Sever requires the request to be conditional, e.g., If-Match.
  * 429 TOO MANY REQUESTS: Too many requests.
  * 431 REQUEST HEADER FIELDS TOO LARGE: Request header fields too large.

* **Server errors 5xx**
  * 500 INTERNAL SERVER ERROR: Internal server error.
  * 501 NOT IMPLEMENTED: Server does not support the required functionality.
  * 502 BAD GATEWAY: Server received no response from the upstream server.
  * 503 SERVICE UNAVAILABLE: Service temporarily unavailable.
  * 504 GATEWAY TIMEOUTt: Server failed to receive a timely response from the upstream server.
  * 505 HTTP VERSION NOT SUPPORTED: Server does not support the HTTP version.
  * 506 VARIANT ALSO NEGOTIATES: Content negotiation error.
  * 507 INSUFFICIENT STORAGE: Insufficient storage space for the resource.
  * 508 LOOP DETECTED: Infinite loop detected while processing the request.
  * 510 NOT EXTENDED: Additional extensions required to complete the request.
  * 511 NETWORK AUTHENTICATION REQUIRED: Network authentication required.

{% endcut %}

## Response format {#answer-format}

Depending on the client type, you can select the response format:

* **HTML** (Content-Type: `text/html`): Browser page with a human-readable message about an error, redirect, allowed access, etc.

* **JSON** (Content-Type: `application/json`): Structured response for API clients, suitable for automated processing and logging.

* **XML** (Content-Type: `application/xml`): Response for systems requiring a structured XML message, e.g., SOAP services.

* **Custom** (Content-Type: arbitrary): Response content in any other format, e.g., plain text.

## Response content {#answer-body}

_Response content_ comprises a required response body in the selected format markup and HTTP headers.

### Response body {#body-response}

_Response body_ is the content of the page returned to the client. The response must not exceed `2 KB` (about 2,000 UTF-8 characters) in size.

You can also include dynamic data (presets) in the response body, such as the request ID, time, and client IP address. This may be useful for application debugging or in case a user will contact support.

{% include [template-body-response](../../_includes/smartwebsecurity/template-body-response.md) %}

To add parameters, you can use the preset buttons in the interface or the following placeholders:

* `%unique_key%`: Request ID.
* `%request_time%`: Request time.
* `%client_ip%`: Client IP address.

{% include [template-body-presets](../../_includes/smartwebsecurity/template-body-presets.md) %}

After adding the response body, you can preview the page on the client side by clicking **Preview**.

### HTTP headers {#http-headers}

In addition to the page content, you can include HTTP headers (no more than 10) in the response. This helps enhance browser security, deny page caching, and control client behavior. You can add any standard [HTTP headers](https://www.iana.org/assignments/http-fields/http-fields.xhtml) except for **Content-Type** and **Content-Length**. You can set an arbitrary **Content-Type** in a separate field for the **Custom** format.

Here are some HTTP header examples:

* `Cache-Control: no-store` (managing caching): Do not store the response.
* `Retry-After: 60` (for `429/503` responses): Inform the client when to retry the request.

## Recommended practices {#recommendations}

* For convenient page management, give them names mapped to the error codes, e.g., `401-unauthorized-web`, `403-forbidden-ru`, or `429-rate-limit-api`.
* Add the `Cache-Control: no-store` HTTP header to pages with blocked requests and errors.
* Include contact information, e.g., support email address, in the response body for pages with blocked requests. This way, users can inquire about the reason for the block or report an error.
* Do not expose internal information about security rules and policies in the response body.
* Do not override successful response codes (`2xx`) unless necessary, as it may disrupt business logic and API calls.
* To create a redirect to another page, create a template using one of the redirect codes (`301`, `302`, `303`, `304`, `305`, `307`, `308`) and add the `Location` HTTP header.
* Test your response pages, as the preview in the {{ sws-name }} interface may display encodings and complex layouts incorrectly. When testing, view the page in different browsers (Chrome, Firefox, Safari, Edge) and on devices with various screen resolutions.
* To avoid encoding issues, specify it in the metadata, e.g., `<meta charset="UTF-8">`.
* To stay within the `2 KB` response body size limit, host static content, such as logos, images, and CSS styles, on external resources and load them via links in the HTML markup. The browser will fetch this content in separate requests.

  {% note warning %}

  To ensure the external content is available, create exceptions for it in the security profile. If a user is blocked by a rule, the browser may fail to load external resources if the safeguards also apply and block them. In this case, the response page will be displayed incorrectly.

  {% endnote %}

## Adding a response page template to profiles and rules {#add-to-profiles-and-rules}

The profile template is displayed when this profile is blocked by any rule. If you select another template for a particular profile, the selected template will be used. If no template is selected for a profile or rule, the default template will be used.

{% include [rules-for-template](../../_includes/smartwebsecurity/rules-for-template.md) %}

#### See also {#see-also}

* [{#T}](../operations/template-create.md)
* [{#T}](../operations/template-attach.md)
* [{#T}](../operations/template-manage.md)
