---
title: How to create, update, or delete a black or white list of IP addresses, ASNs, regular expressions, or string values
description: Follow this guide to manage lists of IP addresses, ASNs, regular expressions, and string values.
---

# Managing lists

{% include [lists-preview](../../_includes/smartwebsecurity/lists-preview.md) %}

You can only manage [custom lists](../concepts/lists.md#user-rules). [Preset {{ yandex-cloud }} lists](../concepts/lists.md#yc-rules) cannot be changed.


## Creating a list {#create}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/files.svg) **{{ ui-key.yacloud.smart-web-security.match-lists.label_match-lists }}** and click **{{ ui-key.yacloud.smart-web-security.match-lists.label_create-list }}**.
  1. Select the list type:

      * `{{ ui-key.yacloud.smart-web-security.MatchListForm.item-type_ip_7TYwL }}`: IP addresses, address ranges, or prefixes in [CIDR](https://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing) format. Here are some examples:

          ```text
          111.222.33.44
          2001:0db8:85a3:0000:0000:8a2e:5678:1234
          10.123.1.1/32
          10::1234:1abc:1/64
          1.2.0.0-1.2.1.1
          ```

      * `{{ ui-key.yacloud.smart-web-security.MatchListForm.item-type_asn_oyhKw }}`: [Autonomous system](https://en.wikipedia.org/wiki/Autonomous_system_(Internet)) numbers. Here are some examples:

          ```text
          AS64512
          AS4294967294
          15169
          1.10
          ```

      * `{{ ui-key.yacloud.smart-web-security.MatchListForm.item-type_regexp_eLHPr }}`: [Regular expressions](../concepts/conditions.md#regular-expressions), e.g., for analyzing the `User-Agent` header. Here are some examples:

          ```text
          User-Agent:\s*
          \\[\'\"\.\;]
          a{100,}
          --.*
          ```

      * `{{ ui-key.yacloud.smart-web-security.MatchListForm.item-type_string_hGRJK }}`: Text strings, e.g., IDs. Here are some examples:

          ```text
          fev4ct8l9infabcd1234
          id345678
          ```

  1. Enter a name and description for the list.
  1. Add a label if needed.
  1. Click **{{ ui-key.yacloud.smart-web-security.match-lists.label_create-match-list }}** and then click **{{ ui-key.yacloud.smart-web-security.MatchListTable.button_add-to-list_1kKXh }}**.
  1. Input the list values manually or upload them from a TXT or CSV file.

     Specify each value in a new row in the list or file. You can also add an optional description separated by a comma without a space:

     ```text
     <value_1>,<description_1>
     <value_2>,<description_2>
     <value_3>
     <value_4>
     ```

     The list you upload will replace the previous one.

  1. Click **{{ ui-key.yacloud.common.save-changes }}**.

Now you will be able to select this list when adding a rule to a [security](rule-add.md) or [ARL profile](arl-rule-add.md).

{% endlist %}


## Downloading a list {#download}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/files.svg) **{{ ui-key.yacloud.smart-web-security.match-lists.label_match-lists }}**.
  1. Click the row with the list you need.
  1. Navigate to the **{{ ui-key.yacloud.smart-web-security.label_match-list_ip_qG1ho }}** tab.
  1. Click ![image](../../_assets/console-icons/arrow-down-to-line.svg) **{{ ui-key.yacloud.smart-web-security.MatchListActions.button_download_bdcBp }}**.
      
      The list will be saved in CSV format.

{% endlist %}


## Updating list parameters {#update-params}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/files.svg) **{{ ui-key.yacloud.smart-web-security.match-lists.label_match-lists }}**.
  1. Next to the list, click ![options](../../_assets/console-icons/ellipsis.svg) and select ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. Update the name and/or description for the list, add or delete labels as needed.
  1. Click **{{ ui-key.yacloud.common.save-changes }}**.

{% endlist %}

## Updating a list of values {#update-values}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/files.svg) **{{ ui-key.yacloud.smart-web-security.match-lists.label_match-lists }}**.
  1. Click the row with the list you need.
  1. Navigate to the **{{ ui-key.yacloud.smart-web-security.label_match-list_ip_qG1ho }}** tab.

      * To update the description for one or more values, select them and click ![image](../../_assets/console-icons/pencil-to-line.svg) **{{ ui-key.yacloud.smart-web-security.match-lists.label_action-edit-description }}**.
      * To delete one or more values, select them and click ![image](../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.
      * To edit the list as text or upload a new list file:

          1. Click **{{ ui-key.yacloud.smart-web-security.MatchListActions.button_edit-list-items_2JFvu }}**.
          1. Edit the list or upload a new file.
          1. Click **{{ ui-key.yacloud.common.save-changes }}**.

{% endlist %}

## Deleting a list {#delete}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/files.svg) **{{ ui-key.yacloud.smart-web-security.match-lists.label_match-lists }}**.
  1. Next to the list, click ![options](../../_assets/console-icons/ellipsis.svg) and select ![image](../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.

{% endlist %}

### See also {#see-also}

* [{#T}](../concepts/lists.md)
* [{#T}](../concepts/conditions.md)
* [{#T}](rule-add.md)
* [{#T}](arl-rule-add.md)