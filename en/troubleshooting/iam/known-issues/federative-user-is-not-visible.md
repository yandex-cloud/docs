# Federated user is not displayed in the organization's user list


## Issue description {#issue-description}

The [federation’s user page]({{ link-org-users }}) does not display a federated user that belongs to a federation in this organization.

The `yc organization-manager federation saml list-user-accounts --id federation_id` output contains the user, but there is no such user in the `yc organization-manager user list --organization-id organization_id` output.

## Solution {#issue-resolution}

This user is most likely removed from the organization. You can add them back using the [YC CLI](../../../cli/quickstart.md). 

The general format of the command is as follows:

```
yc organization-manager federation saml add-user-accounts --id=federation_id --name-ids="user e-mail"
```

{% note info %}

The minimum required role for this command is `{{ roles-organization-admin }}` for the organization.

{% endnote %}