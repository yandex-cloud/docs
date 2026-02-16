# Fixing the `Service account is not available` error



## Issue description {#issue-description}

When sending a request via the REST API, you get the `Service account is not available` error.

## Solution {#issue-resolution}

Assign the `iam.serviceAccounts.user` role to the service account or user sending the request.

{% note info %}

If you make a request on behalf of a service account, it must have the permission to use itself as a subject.

For example, {{ serverless-containers-full-name }} checks the permissions of the assigned service account when creating a new container revision.

{% endnote %}