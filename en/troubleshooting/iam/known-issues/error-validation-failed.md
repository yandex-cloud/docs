# Fixing the `Validation failed: - access_binding_deltas: Number of elements must be in the range of 1 to 1000` error


## Issue description {#issue-description}

When attempting to assign or revoke roles for an organization, folder, or any other eligible entity, you get the following error:

```
Validation failed: - access_binding_deltas: Number of elements must be in the range of 1 to 1000
```

## Solution {#issue-resolution}

This error occurs when no role was added or removed during access configuration. Most likely, the role was already assigned to the selected resource.