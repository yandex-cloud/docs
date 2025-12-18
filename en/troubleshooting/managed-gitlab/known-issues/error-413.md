# Resolving error 413 when running a `git push`


## Issue description {#issue-description}

When you attempt to push data to a {{ mgl-name }} repository, the command fails with the following error:

```
error: RPC failed; 
HTTP 413 curl 22 
The requested URL returned error: 413
```

## Solution {#issue-resolution}

You cannot change the Nginx settings for a specific instance: the maximum `git push` size over HTTP is limited to 250 MB.

To resolve this issue, you can:

1. Use SSH to upload data.
1. Push the code to the repository in parts.

To learn more, see [this GitHub page](https://docs.github.com/en/get-started/using-git/troubleshooting-the-2-gb-push-limit).