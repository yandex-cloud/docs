# Fixing an Unauthorized error when creating a billing account

## Issue description {#issue-description}

When you try to create a billing account in the management console interface, you see this error message:

```
text message: Unauthorized; status: 401; description: Unauthorized;
```

## Solution {#issue-resolution}

Check the list of roles on your account.
Your current account might not have relevant roles in the given cloud.
To create a billing account, you need the owner role (`resource-manager.clouds.owner`) for the cloud selected in the management console.

You can ask the cloud owner to grant you the cloud owner role. You might also create a new cloud or switch to another cloud.

## If the issue persists {#if-issue-still-persists}

If the above actions didn't help, [create a request for support](https://console.cloud.yandex.ru/support?section=contact).
In the request, specify the following information:
1. ID of the cloud you are unable to create a billing account for.
2. Full text of the error message.
3. [HAR file](../../../support/create-har.md) with the recorded results of browser interaction with Yandex Cloud servers.