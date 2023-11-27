# Resolving Issues when transferring a cloud between organizations

## Issue description {#issue-description}

When transferring a cloud between different organizations, you see this error message: `publicAccessBindings`.

## Solution {#issue-resolution}

This error arises due to a mismatch in the user list between the source and new organizations.
During the transfer, the system tries to maintain existing rights for the cloud, but fails to do this because users from the old organization do not have membership or proper rights for the new one.

You can choose one of the options:

1. Remove these users' rights to the ump-group cloud and transfer the cloud to the new organization
2. Add the users to the new organization and then move the cloud.
