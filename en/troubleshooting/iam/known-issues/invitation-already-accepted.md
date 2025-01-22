# Resolving the "Contact your organization's administrator for a new invitation" error



## Issue description {#issue-description}

When joining a cloud organization via the invitation link, you see this error message:
```
Ask the organization administrator to give you a new invitation.
```

## Solution {#issue-resolution}

On the page with this error text, there is a **Report details** button that provides a detailed error description.

If the error text looks like this:

```text
Invitation ... has 'ACCEPTED' status. Expected status 'PENDING'.
```
This means that the invitation already has the **Accepted** status, so when you try to accept it again, you see this error.