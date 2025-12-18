# Fixing the `No space left on device` error


## Issue description {#issue-description}

When trying to create a function, you get this error:

```
zip I/O error: No space left on device
zip error: Output file write failure (write error on zip file)
```

## Solution {#issue-resolution}

This error means that you do not have enough free space, since the deployed packages exceed the [{{ sf-name }} limits](../../../functions/concepts/limits.md#functions-limits).

If you need most recent package versions but your function has run out of space for them, you can use a virtual machine to deploy your application.