# Resolving the `message: Unauthorized; description: Unauthorized` error


## Issue description {#issue-description}

When trying to register a billing account, you see this error:

```
url: {{ link-console-billing }}; 
message: Unauthorized; 
description: Unauthorized;
```

## Solution {#issue-resolution}

To create a billing account, you must be the owner of the organization, i.e., have the `{{ roles-organization-owner }}` role.

{% list tabs %}

- If you do not have one

    You can ask the organization owner to assign you the `{{ roles-organization-owner }}` role as per [this guide](../../../iam/operations/roles/grant.md), or [create a new organization](../../../organization/operations/enable-org.md), [switch to it](../../../organization/operations/manage-organizations.md#switch-to-another-org), and [create a billing account](../../../billing/operations/create-new-account.md) there.

- If you have one

    Refresh the page.

{% endlist %}

## If the issue persists {#if-issue-still-persists}

If the above actions did not help, [create a support ticket]({{ link-console-support }}). When creating your ticket, please attach a relevant [HAR file](../../../support/create-har.md), as it will help us better understand the issue.
