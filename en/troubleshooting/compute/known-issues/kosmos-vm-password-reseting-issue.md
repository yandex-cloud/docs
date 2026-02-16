# Fixing password reset issues for VMs built based on a Kosmos VM image



## Issue description {#issue-description}

When trying to reset the password for your `Administrator` account in the [management console]({{ link-console-main }}), nothing happens.

## Solution {#issue-resolution}

Your VM network configuration probably uses third-party DNS servers that are not associated with {{ dns-full-name }}. In such a case, you need to add an A record to these servers that has this format: `metadata.google.internal A 169.254.169.254`.


You can also change the DNS configuration on VMs, specifying the default DNS address, i.e., the second address in the subnet used for the VM, `(*.*.*.2)`.

## If the issue persists {#if-issue-still-persists}

If the above actions did not help, [create a support ticket]({{ link-console-support }}). Provide the following information in your ticket:

1. ID of the VM in question.
1. VM network configuration as plain text or a screen capture.
