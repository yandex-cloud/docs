---
title: How to get started with {{ mgl-full-name }}
description: Follow this guide to set up and configure an {{ GL }} cluster.
---

# Getting started with {{ mgl-name }}

To get started:
1. [Create an instance](#instance-create).
1. [Set up a working environment](#configure-mgl).
1. [Add SSH keys to {{ GL }}](#ssh).
1. [Start using the repository](#start-work-with-git).

{% note warning %}

To start working with {{ mgl-name }}, check [this guide](operations/instance/migration.md) on how to migrate your projects from a {{ GL }} custom installation to the service.

{% endnote %}

For more information about the differences between {{ mgl-name }} and the {{ GL }} Community Edition custom installation, see the [Service advantages over a {{ GL }} custom installation](concepts/managed-gitlab-vs-custom-installation.md) section.

## Getting started {#before-you-begin}

{% list tabs group=instructions %}

- Management console {#console}

  1. Navigate to the [management console]({{ link-console-main }}) and either log in to {{ yandex-cloud }} or sign up if you do not have an account yet.
  1. If you do not have a folder yet, create one:

     {% include [create-folder](../_includes/create-folder.md) %}

  1. [Assign](../iam/operations/roles/grant.md) the [{{ roles-vpc-user }}](../vpc/security/index.md#vpc-user) role and the [{{ roles.gitlab.editor }} role or higher](security/index.md#roles-list) to your {{ yandex-cloud }} account. These roles allow you to create an instance.

      {% include [note-managing-roles](../_includes/mdb/note-managing-roles.md) %}

{% endlist %}

## Create an instance {#instance-create}

{% include [warn-subnet](../_includes/managed-gitlab/warn-subnet.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  {% include [instance-create-console](../_includes/managed-gitlab/instance-create-console.md) %}

- CLI {#cli}

  {% include [instance-create-cli](../_includes/managed-gitlab/instance-create-cli.md) %}

{% endlist %}

{% include [HTTPS info](../_includes/managed-gitlab/note-https.md) %}

## Set up a working environment {#configure-mgl}

1. Activate the {{ mgl-name }} instance:
   1. Follow the link you received in your administrator mailbox after creating the instance.
   1. Change the administrator password.
   1. Log in using the administrator username and password.
1. (Optional) [Create a group](https://docs.gitlab.com/ee/user/group/#create-a-group) to host the repository project.

   If there are several projects, you might want to group users together. This will allow you to:

   * Grant rights for specific projects to each group.
   * View issues and merge requests by group.
   * View analytics on group's activities.

   For more information, see [this {{ GL }} article](https://docs.gitlab.com/ee/user/group/).

1. [Create an empty project](https://docs.gitlab.com/ee/user/project/) to host the repository.
1. [Create users and add](operations/create-user.md) them to a group or project with the `Maintainer` or `Owner` role.

   You can only add your team members to a group or project by creating {{ GL }} accounts for them.

## Add SSH keys to {{ GL }} {#ssh}

1. Create a pair of public and private SSH keys for the {{ GL }} account:

    {% list tabs group=operating_system %}

    - Linux/macOS {#linux-macos}

      {% include [vm-ssh-prepare-key-linux-macos](../_includes/vm-ssh-prepare-key-linux-macos.md) %}

    - Windows 10/11 {#windows}

      {% include [vm-ssh-prepare-key-win-10-11](../_includes/vm-ssh-prepare-key-win-10-11.md) %}

    - Windows 7/8 {#windows7-8}

      {% include [vm-ssh-prepare-key-win-7-8](../_includes/vm-ssh-prepare-key-win-7-8.md) %}

    {% endlist %}

1. {% include [turn-on-ssh-agent](../_includes/turn-on-ssh-agent.md) %}
1. Add a key to the SSH agent:

   ```bash
   ssh-add <private_key_path>
   ```

1. [Assign a public SSH key](https://docs.gitlab.com/ee/user/ssh.html#add-an-ssh-key-to-your-gitlab-account) to the {{ GL }} account.
1. Check that you can connect to {{ GL }}:

   ```bash
   ssh -T git@<{{ GL }}_instance_domain>
   ```

   Here is an example:

   ```bash
   ssh -T git@example.gitlab.yandexcloud.net
   ```

   If connecting for the first time, you will get this or similar message:

   ```text
   The authenticity of host 'gitlab.example.com (35.231.145.151)' can't be established.
   ECDSA key fingerprint is SHA256:HbW3g8zUjNSksFbqTiUWPWg2Bq1x8xdGUrliXFzSnUw.
   Are you sure you want to continue connecting (yes/no)? yes
   Warning: Permanently added 'gitlab.example.com' (ECDSA) to the list of known hosts.
   ```

   Type `yes` and press **Enter**.

   If it is not your first time, you will get this upon a successful connection:

   ```text
   Welcome to GitLab, @<login>!
   ```

   In case of an error, run the connection in Verbose mode to get the logs:

   ```bash
   ssh -Tvvv git@<{{ GL }}_instance_domain>
   ```

Ask each member of your group or project to create an SSH key pair this way and assign the public key to their account in {{ GL }}.

## Start using the repository {#start-work-with-git}

To start working with a local copy of your repository using the account you created, follow the steps below on your local computer:

1. [Install the Git client](https://docs.gitlab.com/ee/gitlab-basics/start-using-git.html#install-git).
1. [Clone the repository](https://docs.gitlab.com/ee/gitlab-basics/start-using-git.html#clone-a-repository) using the SSH protocol.

   {% cut "What to do if you get the `Permission denied (publickey)` error" %}

   When cloning, you may get this error:

   ```text
   Cloning into '<project_name>'...
   git@<{{ GL }}_instance_domain>: Permission denied (publickey).
   fatal: Could not read from remote repository.

   Please make sure you have the correct access rights
   and the repository exists.
   ```

   If you get this error:

   1. Create and open a configuration file to set up SSH keys:

      ```bash
      nano ~/.ssh/config
      ```

   1. Add content to it:

      ```bash
      Host <{{ GL }}_instance_domain>
         IdentityFile <private_key_path>
      ```

      In the `IdentityFile` parameter, specify the absolute path to the private key you created for the {{ GL }} project.

   1. Save the file.
   1. Clone the repository again via SSH.

   {% endcut %}

1. Go to the repository folder:

   ```bash
   cd <project_name>
   ```

1. Make changes to the repository files.
1. [Index and apply the changes](https://docs.gitlab.com/ee/gitlab-basics/start-using-git.html#add-and-commit-local-changes) in the local repository:

   ```bash
   git add . && git commit -m "<commit_name>"
   ```

1. Push the changes to the remote repository:

   ```bash
   git push origin main
   ```
