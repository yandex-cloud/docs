# Fixing password reset issues for VMs based on a Kosmos VM image


## Issue description {#issue-description}

* When you attempt to reset the password for your Administrator account from the management console interface, nothing happens.

## Solution {#issue-resolution}

It is possible that third-party DNS servers, not associated with Yandex Cloud DNS, are used in your VM network configuration.
In such a case, you need to add an A-record to these servers in the format:
`metadata.google.internal A 169.254.169.254`

You can also change the DNS configuration on VM instances, specifying the default DNS address, that is, the second address in the subnet used for the VM `(x.x.x.2)`.

## If the issue persists {#if-issue-still-persists}

If the above actions did not help solve the problem, create a [request for technical support]({{ link-console-support }}).
When creating a request, provide the ID of the problematic VM and attach its network configuration as a plain text or a screenshot.
