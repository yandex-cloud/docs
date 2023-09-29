# Fixing errors related to invitations to a cloud organization

## Issue description {#issue-descriprtion}

When you try to accept an invitation to a cloud organization, you see one of the following error messages:
- `No valid emails. Or all specified emails have been invited before`.
- `Invitation ‘Invitation.Id(value=xxxxxxxxxxxxx) has 'ACCEPTED' status. But 'PENDING' status is expected`.
- `Invitation ‘Invitation.Id(value=xxxxxxxxxxxxx)’ has been expired after YYYY-MM-DDTHH:MM:SSZ`.

## Troubleshooting and reproducing issues {#diagnosis-and-reproduction}

* The error `No valid emails. Or all specified emails have been invited before;` means that the invitation was sent to invalid email addresses or users with the specified email addresses have already joined the organization.

* The error `Invitation ‘Invitation.Id(value=xxxxxxxxxxxxx)' has 'ACCEPTED' status. But 'PENDING' status is expected.` Means that the invitation has already been accepted. When you try to accept the invitation again, this error is raised.

* The `Invitation ‘Invitation.Id(value=xxxxxxxxxxxxx)’ has been expired after YYYY-MM-DDTHH:MM:SSZ` error means that the invitation expired at the time specified in the error text.

## Solution {#issue-resolution}

Try deleting the current invitation, then create a new one and send it to the user again.
To learn more about the steps to delete and create an invitation, see [Invite a Yandex user](../../../organization/operations/add-account.md#add-or-invite-user-account) in the Yandex Cloud Organization documentation.

## If the issue persists {#if-issue-still-persists}

If the above actions didn't help, [create a request for support](https://console.cloud.yandex.ru/support?section=contact).
In the request, specify the following information:
1. Error description shown when clicking the "Error details" button on the invitation page after following the link in the email.
2. [HAR file](../../../support/create-har.md) with the recorded results of browser interaction with Yandex Cloud servers.
