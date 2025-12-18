# Troubleshooting connection to {{ console-name }}



## Issue description {#issue-description}

Accessing the [management console]({{ link-console-main }}) dashboard through a browser ends with a timeout.

## Solution {#issue-resolution}

Follow these steps:

1. Temporarily disable IPv6 protocol support. 
   Check that IPv6 is disabled using these commands:
    * `ip addr | grep inet6`: For devices running a Linux kernel-based OS.
    * `netsh interface ipv6 show config`: For devices running Microsoft Windows®.
   If you see an empty command output, it means that IPv6 has been successfully disabled.
1. Restart your device and reopen the [management console page]({{ link-console-main }}).

## If the issue persists {#if-issue-still-persists}

If the above actions did not help, [create a support ticket]({{ link-console-support }}). Provide the following information in your ticket:

1. Name and version of the OS on your device.
1. Name and version of your browser: you can get them using [this website](https://whatmyuseragent.com/).
1. Outputs of the `ping console.cloud.yandex.ru -c 10` and `ping -6 console.cloud.yandex.ru -c 10` commands.
1. Outputs of the `mtr -rzbw console.cloud.yandex.ru --tcp -P 443 -c 100` and `mtr -6 -rzbw console.cloud.yandex.ru --tcp -P 443 -c 100` commands.

{% note info %}

The MTR utility is not preinstalled on Linux. You can install it using the package manager of your Linux distribution.

If your device runs Microsoft Windows®, you can use its built-in `tracert` utility.


{% endnote %}
