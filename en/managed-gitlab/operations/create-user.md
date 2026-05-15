# Creating and adding users to a project

You can create users in a {{ GL }} instance and invite them to your project. Thus you will grant your team access to the repository.

Use a unique email address for each account. Make sure it is not linked to the primary account created together with the {{ GL }} instance.

## Creating a user {#create}

1. Open your {{ GL }} instance.
1. In the left-hand menu, select **Search or go to** → **Admin Area**.
1. In the left-hand menu, navigate to **Overview** → **Users**.
1. Click **New user**.
1. In the window that opens, fill out these fields:

    * **Name**: Name of the user.
    * **Username**: User login.
    * **Email**: User email address.

    If creating a service account to [set up approval rules](approval-rules.md), specify **Administrator** in the **Access level** field.

    Optionally, fill out the **Profile** and **Admin notes** sections. Leave the other fields unchanged.

1. Click **Create user**.

    This will create a new user.

1. To set a password for the user, click **Edit** on the user page.
1. In the **Password** section, enter and confirm a user password.
1. Click **Save changes**.

## Adding a user to a project {#add-to-project}

1. Open your project in {{ GL }}.
1. In the left-hand menu, navigate to **Manage** → **Members**.
1. Click **Invite members**.
1. In the window that opens, enter the user login or email address and select a [project role]({{ gl.docs }}/ee/user/permissions.html) for the user.

    {% note info %}

    If adding a user for [setting up approval rules](approval-rules.md), assign them the `Maintainer` or `Owner` role. Users with other roles lack the permissions required to set up approval rules.

    {% endnote %}

1. Click **Invite**.

The user will receive an email with a project link and confirmation of being added to the project.
