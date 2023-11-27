# Resolving the "Service account is not available" error



## Issue description {#issue-description}

When making a request via REST API, you see this error: `Service account is not available`.

## Solution {#issue-resolution}

Add the `iam.serviceAccounts.user` role for the service account or user making the request.

{% note info %}

If you make a request on behalf of a service account, it must have rights to use itself as a subject.

For example, the Serverless Containers service checks the rights to use the assigned service account when creating a new container revision.

{% endnote %}


