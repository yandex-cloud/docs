---
title: FAQ about {{ baremetal-full-name }}
description: This page covers FAQ about {{ baremetal-name }}.
---

# FAQ about {{ baremetal-name }}

## What should I do if the server KVM console does not respond to actions taken via the management console? {#kvm}

Reboot the WMS: 

1. In the [management console]({{ link-console-main }}), select **{{ baremetal-name }}** and the relevant server.
1. In the left-hand menu, select **{{ ui-key.yacloud.baremetal.label_kvm-console }}**.
1. In the console window, click **Reset WMS**.

If rebooting the WMS did not help, contact [support]({{ link-console-support }}).

## What should I do if there is a disk failure on the server? {#add-to-raid}

If there is a disk failure on the server, contact support and request a replacement. If the defective disk was a part of a RAID array, you need to add a new disk to this array.

For more information, see the [disk replacement guide](../operations/servers/switch-raid-member.md#add-to-raid).

## Can I copy text from a local machine to the KVM console?

Yes, you can. In the top-right part of the KVM console window, paste the text into the `Past text here` field. The text will appear immediately in the server command line.