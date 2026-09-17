---
title: How to create a response template
description: In this tutorial, you will learn how to create a custom template for responding to client requests.
---

# Creating a response page template

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create the template.
  1. [Navigate]({{ link-console-main }}/link/smartwebsecurity) to **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. In the left-hand panel, select ![square-article](../../_assets/console-icons/square-article.svg) **{{ ui-key.yacloud.smart-web-security.customPages_rriaz }}** and click **{{ ui-key.yacloud.smart-web-security.createCustomPage_t4SuU }}**.
  1. Enter the **{{ ui-key.yacloud.smart-web-security.custom-pages.context_name }}**, which is the name of the file returned in response to the client request.

      The name must be between 1 to 50 characters long and may contain lowercase Latin letters, numbers, hyphens, underscores, and periods. The first character must be a letter or number.

  1. Optionally, provide a template description.
  1. Select a **{{ ui-key.yacloud.smart-web-security.custom-pages.label_status_code }}**, i.e., one of the standard [HTTP response codes](https://www.iana.org/assignments/http-status-codes/http-status-codes.xhtml) for which the client will get a page based on your template.
  1. Select the **{{ ui-key.yacloud.smart-web-security.custom-pages.label_format }}**: `HTML`, `JSON`, `XML`, or `Custom`.

      Each format has a matching HTTP [Content-Type](https://www.rfc-editor.org/rfc/rfc9110.html#name-content-type) header: `text/html`, `application/json`, or `application/xml`. For a custom header, select `Custom`.

  1. For the `Custom` format, enter a **{{ ui-key.yacloud.smart-web-security.custom-pages.label_content_type }}**, e.g., `text/plain`.
  1. Optionally, to add an HTTP header, click **{{ ui-key.yacloud.smart-web-security.CustomPageForm.add_header_8Zgm9 }}** and specify its parameters:

      * **{{ ui-key.yacloud.common.label_key }}**: HTTP header name, e.g., `User-Agent` or `Host`.
      * **{{ ui-key.yacloud.common.value }}**, e.g., `Mozilla/5.0 (...)` or `example.com`.

      You can add up to 10 headers. You cannot add `Content-Type` and `Content-Length` headers, you can only set the `Content-Type` in a separate field for the `Custom` format.

  1. Enter the **{{ ui-key.yacloud.smart-web-security.custom-pages.label_body }}**, i.e., the page content the client will get as a response. The response must not exceed `2 KB` (about 2,000 UTF-8 characters) in size.

      {% include [template-body-response](../../_includes/smartwebsecurity/template-body-response.md) %}

  1. Optionally, add other parameters to the response body by selecting the relevant preset: **{{ ui-key.yacloud.smart-web-security.CustomPageForm.preset_unique_key_j7Rw2 }}**, **{{ ui-key.yacloud.smart-web-security.CustomPageForm.preset_client_ip_m4Np5 }}**, or **{{ ui-key.yacloud.smart-web-security.CustomPageForm.preset_request_time_k9Lx1 }}**.

      This data may be useful when the client contacts support.

      {% include [template-body-presets](../../_includes/smartwebsecurity/template-body-presets.md) %}

  1. Click **{{ ui-key.yacloud.common.create }}**.

  To view the final page on the client side, click ![eye](../../_assets/console-icons/eye.svg) **{{ ui-key.yacloud.smart-web-security.CustomPagesActions.label_view_tJsLT }}** on the template page.

{% endlist %}

#### Useful links {#see-also}

* [{#T}](template-attach.md)
* [{#T}](../concepts/response-templates.md)
