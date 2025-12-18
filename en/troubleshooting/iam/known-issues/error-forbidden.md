# Resolving the `Forbidden` error as a service account


## Issue description {#issue-description}

When running operations as a service account, you get the `403 Forbidden` or `Permission Denied` errors.

## Solution {#issue-resolution}

Most likely, the selected role is assigned to the service account for itself as a resource. You need to assign the role to the service account for the folder following [this guide](../../../iam/operations/sa/assign-role-for-sa.md).
 
