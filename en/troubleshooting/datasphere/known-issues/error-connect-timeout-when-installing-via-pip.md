# Fixing the `ConnectTimeoutError` error when installing packages through pip


## Issue description {#issue-description}

When installing new Python packages in a project, {{ ml-platform-short-name }} returns this error:
```
% pip install langchain
Defaulting to user installation because normal site-packages is not writeable
WARNING: Retrying (Retry (total=4, connect=None, read=None, redirect=None, status=None))
after connection broken by; ConnectTimeoutError(pip._v endor.urllib3.connection.HTTPSConnection object at 0x7f711cb08df0;
Connection to pypi.org timed out. (connect timeout=15))
```

## Solution {#issue-resolution}

Make sure you specified the subnet in your project; in its settings, you should specify the NAT gateway to connect to the internet. You can learn how to set up a NAT gateway in [this guide](../../../vpc/operations/create-nat-gateway.md).

If it does not help, remove the security group and subnet from the advanced project settings. 