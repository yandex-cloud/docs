---
title: FAQ about {{ baremetal-full-name }}
description: This page covers FAQ about {{ baremetal-name }}.
---

# FAQ about {{ baremetal-name }}

## What should I do if the server KVM console does not respond to actions taken via the management console? {#kvm}

Restart the BMC: 

1. In the [management console]({{ link-console-main }}), select **{{ baremetal-name }}** and the relevant server.
1. In the left-hand menu, select **{{ ui-key.yacloud.baremetal.label_kvm-console_37Kma }}**.
1. In the console window, click **Reset BMC**.

If restarting the BMC did not help, contact [support]({{ link-console-support }}).

## What should I do if there is a disk failure on the server? {#add-to-raid}

If there is a disk failure on the server, contact support and request a replacement. If the defective disk was a part of a RAID array, you need to add the new disk to this array.

For more information, see the [disk replacement guide](../operations/servers/switch-raid-member.md#add-to-raid).

## Can I copy text from a local machine to the KVM console?

Yes. In the top-right part of the KVM console window, paste the text into the `Paste text here` field. The text will appear immediately in the server command line.

## What is a gigabit per second (Gbps)? {#Gbps}

Gigabit per second (Gbps) is a unit of measurement for data transmission speed. It describes the throughput of a network interface and represents the number of gigabits of data that can be transmitted through the network interface in one second.

## What is a gigabyte per second (GB/s)? {#Gbs}

Gigabyte per second (GB/s) is a unit of measurement for data transmission speed. It represents the number of gigabytes of data that can be transmitted in one second. Typically, one gigabyte (GB/s) equals eight gigabits (Gbps).

## How to calculate the amount of data transmitted over a server's network connection? {#calculate-amount-of-data}

To calculate this, you can use this formula:

```text
Amount of data transmitted per day = number of seconds in a day * speed (in GB/s)
```

Calculation examples:

| Amount of data transmitted per day | Bandwidth in Gbps | Bandwidth in GB/s | Calculation example           |
|------------------------------------|-------------------|-----------------|--------------------------|
| ~10 TB                             | 1                 | 0.125           | 86,400 * 0.125 = 10,800 GB |
| ~100 TB                            | 10                | 1.25            | 86,400 * 1.25 = 108,000 GB |

## Can I get logs of my operations in {{ yandex-cloud }}? {#logs}

Yes, you can request information about operations with your resources from {{ yandex-cloud }} logs. For more information, see [Data requests](../../support/request.md).