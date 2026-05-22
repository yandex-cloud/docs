---
title: How to edit and delete a response template
description: Follow this guide to edit or delete a response page template.
---

# Managing a response page template

## Editing a template {#change-template}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) with the template.
  1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. In the left-hand panel, select **Response templates**.
  1. In the row with the template, click ![options](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.edit }}**.
  1. In the window that opens, edit the following parameters:

       * **Page name**.
       * **Description**.
       * **Response code**: One of the standard [HTTP response codes](https://www.iana.org/assignments/http-status-codes/http-status-codes.xhtml) for which the client will get a page based on your template.
       * **Response format**: **HTML**, **JSON**, **XML**, or **Custom**.

          Each format has a matching HTTP [Content-Type](https://www.rfc-editor.org/rfc/rfc9110.html#name-content-type) header: `text/html`, `application/json`, or `application/xml`.

          For a custom header, select **Custom**. For the **Custom** format, you can change the **Content-Type**.

       * To add an HTTP header, click **Add response header** and specify its **Key** (header name) and **Value**. You can add up to 10 headers per template.
       
          To delete a header, click ![options](../../_assets/console-icons/xmark.svg) next to its row.
       
       * **Response body**: Edit the page content the client will get as a response. The response must not exceed `2 KB` (about 2,000 UTF-8 characters) in size. Add the content as per the response format you selected while preserving the markup.
       * Add or delete presets in the response body, i.e., the additional parameters the client may get on the response page.

  1. To view the final page on the client side, click **Preview** at the top right.
  1. Click **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

## Getting template info {#get-template-info}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) with the template.
  1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. In the left-hand panel, select **Response templates**.
  1. Select the template.
  1. The **{{ ui-key.yacloud.common.overview }}** page will show the template details.

{% endlist %}


## Deleting a template {#delete-template}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) with the template.
  1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. In the left-hand panel, select **Response templates**.
  1. In the row with the template, click ![options](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.delete }}**.

   You cannot delete a template added to a profile or rule. If you attempt to delete such a template, you will get a list of objects that use it. Navigate to each object’s settings and select a different template.

{% endlist %}
