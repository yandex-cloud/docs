# Fixing the `publicAccessBindings` error when moving a cloud to a different organization



## Issue description {#issue-description}

When moving a cloud to a different organization, you get the `publicAccessBindings` error message.

## Solution {#issue-resolution}

This error occurs due to a mismatch in the user list between the source organization and the new one. During the transfer, the system tries to maintain the existing permissions for the cloud but fails to do this because users from the old organization do not have membership or the appropriate permissions for the new one.

To resolve the issue, you have two options:

1. Remove these users' permissions for the cloud and move the cloud to the new organization.
1. Add the users to the new organization, and then move the cloud.