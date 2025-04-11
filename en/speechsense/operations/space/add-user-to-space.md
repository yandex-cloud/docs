# Adding a user to a space

You can add users to a space to grant them access to any connection or project within the space. If you want to give users access to a specific project alone, [add them](../project/add-user-to-project.md) to this project.

To add users, you need the `{{ roles-speechsense-admin }}` role for the space.

## Who can be added to a space {#types-of-users}

{% include [types-of-accounts](../../../_includes/speechsense/types-of-accounts.md) %}

## Adding a user from an organization {#organization}

1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
1. Go to the space of your choice.
1. Click ![image](../../../_assets/console-icons/person-plus.svg) **{{ ui-key.yc-ui-talkanalytics.projects.add-participant }}** → ![image](../../../_assets/console-icons/persons.svg) **{{ ui-key.yc-ui-talkanalytics.team.add-from-organization-key-value }}**.
1. Specify the username or email address of the user in the search bar. If you are adding a service account, copy its ID and paste it into the search bar.
1. Select a new user and specify their role.

   For more information about roles, see [{#T}](../../security/index.md).

1. Click **{{ ui-key.yc-ui-talkanalytics.common.add }}**.

## Adding a new user {#new-user}

1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
1. Go to the space of your choice.
1. Click ![image](../../../_assets/console-icons/person-plus.svg) **{{ ui-key.yc-ui-talkanalytics.projects.add-participant }}** → ![image](../../../_assets/console-icons/person-plus.svg) **{{ ui-key.yc-ui-talkanalytics.team.invite-new-key-value }}**.
1. In the window that opens, enter the email address of the user you want to invite to the space.

   You can send invitations to any email address. Invited users will be able to select the appropriate Yandex account once they accept the invitation.

1. Click **Send invitation**.

   The user will receive an invitation to join the organization. The user will be able to log in to the organization upon accepting the invitation via the emailed link.

1. Once the user joins the organization, [add them to the space](#organization) as an organization member.
