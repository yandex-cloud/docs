---
title: Downloading alerts in {{ sd-full-name }}
description: In this section, you will learn how to download alerts in {{ sd-full-name }}.
---

# Downloading alerts

You can download the required alerts as a JSON file.

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Go to [{{ sd-full-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select ![alerts](../../../_assets/security-deck/alerts.svg) **{{ ui-key.yacloud_org.security-center.label_alerts }}**.
  1. At the top of the window, select the [workspace](../../concepts/workspace.md).
  1. Mark ![image](../../../_assets/console-icons/check.svg) the alerts you need to download. To select the whole list of alerts, put the mark in the top-left corner of the list.
  1. Click ![image](../../../_assets/console-icons/arrow-down-to-square.svg) **Export**.
  1. In the window that opens:

     1. Select the file content:

        * **Full export**: Alert data, [facts](*facts), and comments.
        * **No facts**: Alert data, related resources, and comments without facts.

     1. Click **Download JSON**.

{% endlist %}

[*facts]: A fact is a triggered rule. Rules are different for each module. They can be about detection of sensitive data or violation of the configuration’s security rules. An alert is sent if the triggered rule is sufficient to generate the alert.
