# Fixing the `Contact your organization administrator for a new invitation` error



## Issue description {#issue-description}

When joining a cloud organization via the invitation link, you see this error message:
```
Ask the organization administrator to send you a new invitation.
```

## Solution {#issue-resolution}

You can get a detailed description of this error by clicking **Report details** on the page with the error message. If you get this error text:

```text
Invitation ... has 'ACCEPTED' status. Expected status 'PENDING'.
```
This means that the invitation already has the **Accepted** status, so when you try to accept it again, you see this error.