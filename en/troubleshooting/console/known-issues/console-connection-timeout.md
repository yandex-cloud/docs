# Troubleshooting the console connection error



## Issue description {#issue-description}

When trying to open the console through a web browser, the page does not open: an attempt to access the page ends with a timeout error.

## Solution {#issue-resolution}

Try the following actions:

1. Temporarily disable IPv6 protocol support.
   You can make sure IPv6 is disabled using the commands:
* `ip addr | grep inet6` (for devices with an OS based on the Linux kernel)
* `netsh interface ipv6 show config` (for devices with Windows).  
   If you see an empty output as a result of its execution, it means that IPv6 has been successfully disabled.

2. Restart the device and reopen the [management console page]({{ link-console-main }}).


## If the issue persists {#if-issue-still-persists}

If the above actions did not help solve the problem, create a [request for technical support]({{ link-console-support }}).

When creating the request, provide the following information:

1. Name and version of the OS on your device.
2. Name and version of your browser: you can collect this information using this [site](https://whatmyuseragent.com/).
3. The result of executing these commands: `ping console.cloud.yandex.ru -c 10` and `ping -6 console.cloud.yandex.ru -c 10`.
4. The result of executing these commands: `mtr -rzbw console.cloud.yandex.ru --tcp -P 443 -c 100` and `mtr -6 -rzbw console.cloud.yandex.ru --tcp -P 443 -c 100`. U

{% note info %}

The MTR utility is not preinstalled on Linux.
You can install it using the package manager of your Linux distribution.

If your device has Windows OS installed, you can use the built-in `tracert` utility.

{% endnote %}