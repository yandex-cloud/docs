---
title: How to create a response template
description: In this tutorial, you will learn how to create a custom template for responding to client requests.
---

# Creating a response page template

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create the template.
  1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. In the left-hand panel, select **Response templates** and click **Create template**.
  1. Enter the **Page name**, which is the name of the file returned in response to the client request.

     The name must be between 1 to 50 characters long and may contain lowercase Latin letters, numbers, hyphens, underscores, and periods. The first character must be a letter or number.

  1. Optionally, provide a template description.
  1. Select a **Response code**, i.e., one of the standard [HTTP response codes](https://www.iana.org/assignments/http-status-codes/http-status-codes.xhtml) for which the client will get a page based on your template.
  1. Select the **Response format**: **HTML**, **JSON**, **XML**, or **Custom**.

     Each format has a matching HTTP [Content-Type](https://www.rfc-editor.org/rfc/rfc9110.html#name-content-type) header: `text/html`, `application/json`, or `application/xml`. For a custom header, select **Custom**.

  1. For the **Custom** format, enter **Content-Type**, e.g., `text/plain`.

  1. Optionally, to add an HTTP header, click **Add response header** and specify its parameters:
     
     * **Key**: HTTP header name, e.g., `User-Agent`, `Host`.
     * **Value**: For example, `Mozilla/5.0 (...)`, `example.com`.
  
     You can add up to 10 headers. You cannot add **Content-Type** and **Content-Length** headers, you can only set **Content-Type** in a separate field for the **Custom** format.

  1. Enter the **Response body**, i.e., the page content the client will get as a response. The response must not exceed `2 KB` (about 2,000 UTF-8 characters) in size.
  
     {% include [template-body-response](../../_includes/smartwebsecurity/template-body-response.md) %}

  1. Optionally, add other parameters to the response body by selecting the relevant preset: **Request ID**, **Client IP address**, **Request time**.

     This data may be useful when the client contacts support.

     {% include [template-body-presets](../../_includes/smartwebsecurity/template-body-presets.md) %}

  1. To view the final page on the client side, click **Preview** at the top right.
  1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

#### See also {#see-also}

* [{#T}](template-attach.md)
* [{#T}](../concepts/response-templates.md)
