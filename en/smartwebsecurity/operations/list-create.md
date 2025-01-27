---
title: How to create, update, or delete an IP blacklist or whitelist
description: Follow this guide to manage IP address lists.
---

# Managing address lists

{% include [lists-preview](../../_includes/smartwebsecurity/lists-preview.md) %}

You can only manage custom address lists. You cannot edit any preset {{ yandex-cloud }} lists.

## Creating a list

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select a [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. In the left-hand panel, select ![image](../../_assets/smartwebsecurity/list.svg) **Lists** and click **Create list**.
  1. Enter a name and description for the list.
  1. Add a label if needed.
  1. Click **Create list** and then **Add addresses**.
  1. Enter the IP addresses, address ranges, or prefixes in [CIDR](https://ru.wikipedia.org/wiki/Бесклассовая_адресация) format. You can also add a description to each address.
  1. To upload a custom list:
     1. Click **Upload from file**.
     1. Select a `txt` or `csv` file containing the list.
     
        Once a file is uploaded, the previous list will be permanently replaced with the new one.
  1. Click **Save changes**.

  Now, when adding a rule in a security profile or ARL profile, you can select a condition for the IP address: **Belongs to list** or **Does not belong to list**.

{% endlist %}

## Downloading a list

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select a [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. In the left-hand panel, select ![image](../../_assets/smartwebsecurity/list.svg) **Lists**.
  1. Click the row with the list you need.
  1. Select the **IP addresses** section on the left.
  1. Click **Download list**.
     
     The list will be saved to a `csv` file.

{% endlist %}

## Editing list parameters

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select a [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. In the left-hand panel, select ![image](../../_assets/smartwebsecurity/list.svg) **Lists**.
  1. In the row with the list you need, click ![options](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.edit }}**.
  1. Update the name and/or description for the list, add or delete labels as needed.
  1. Click **Save changes**.

{% endlist %}

## Editing addresses in a list

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select a [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. In the left-hand panel, select ![image](../../_assets/smartwebsecurity/list.svg) **Lists**.
  1. Click the row with the list you need.
  1. Select the **IP addresses** section on the left.
  1. To update the description for one or more addresses, select them in the list and click **Update description**.
  1. To delete one or more addresses, select them in the list and click **Delete**.
  1. To edit addresses as text or upload a new file with addresses:
     1. Click **Edit IP address list**.
     1. Edit the list as needed or upload a new file with addresses.
     1. Click **Save changes**.

{% endlist %}

## Deleting a list

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select a [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. In the left-hand panel, select ![image](../../_assets/smartwebsecurity/list.svg) **Lists**. 
  1. In the row with the list, click ![options](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.delete }}**.

{% endlist %}

### See also {#see-also}

* [{#T}](../concepts/lists.md)
* [{#T}](../concepts/conditions.md)
* [{#T}](rule-add.md)
* [{#T}](arl-rule-add.md)