# Adding and removing users from a project

You can create users in a {{ GL }} instance and invite them to your project. Thus you will grant your team access to the repository.

Use different email addresses for each account. They should not be linked to the primary account created together with the {{ GL }} instance.

## Creating a user {#create}

1. Open your {{ GL }} instance.
1. In the left-hand menu, select **Search or go to** → **Admin Area**.
1. In the menu on the left, go to **Overview** → **Users** section.
1. Click **New user**.
1. In the window that opens, fill out the fields:

   * **Name**: User name
   * **Username**: User login
   * **Email**: User email address

   If you create a service account for [configuring approval rules](approval-rules.md), specify **Administrator** in the **Access level** field.

   Optionally, complete the **Profile** and **Admin notes** sections. Leave the other fields unchanged.

1. Click **Create user**.

   A new user will be created.

1. To set a password for the user, click **Edit** on the user's page.
1. In the **Password** section, enter and confirm the user's password.
1. Click **Save changes**.

## Adding a user to a project {#add-to-project}

1. Open your project in {{ GL }}.
1. In the left-hand menu, navigate to **Manage** → **Members**.
1. Click **Invite members**.
1. In the window that opens, enter the user's login or email address and select a [project role]({{ gl.docs }}/ee/user/permissions.html) for the user.

   {% note info %}

   If adding a user to [configure approval rules](approval-rules.md), assign the `Maintainer` or `Owner` role to them. Users with other roles will not have sufficient permissions to configure approval rules.

   {% endnote %}

1. Click **Invite**.

The user will receive an email with a link to the project and a confirmation of being added to the project.
