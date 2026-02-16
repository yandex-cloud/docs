# Fixing the `Unauthorized` error when creating a billing account


## Issue description {#issue-description}

When trying to create a billing account in the management console, you get this error message:
```
text message: Unauthorized; status: 401; description: Unauthorized;
```

## Solution {#issue-resolution}

Check the list of roles for your account. Your current account may not have relevant roles in the selected cloud.

To create a billing account, you need the `{{ roles-cloud-owner }}` role for the cloud you selected in the management console.

You can ask the actual owner to grant you the owner role as well, or create a new cloud, or switch to another one.

## If the issue persists {#if-issue-still-persists}

If the above actions did not help, [create a support ticket]({{ link-console-support }}). Provide the following information in your ticket:

1. ID of the cloud for which you are unable to create a billing account.
1. Full text of the error message.
1. [HAR file](../../../support/create-har.md) with the recorded results of browser interaction with {{ yandex-cloud }} servers.