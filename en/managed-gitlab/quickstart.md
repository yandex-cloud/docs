# Getting started with {{ mgl-name }}

To get started with the service:
1. [Create an instance](#instance-create).
1. [Set up a working environment](#configure-mgl).
1. [Get started with the repository](#start-work-with-git).

## Before you start {#before-you-begin}

1. Go to the [management console]({{ link-console-main }}) and log in to {{ yandex-cloud }} or register if you don't have an account yet.
1. If you don't have a folder yet, create one:

   {% include [create-folder](../_includes/create-folder.md) %}

## Create an instance {#instance-create}

1. In the management console, select the folder where you want to create an instance {{ GL }}.
1. Select **{{ mgl-name }}**.
1. Click **Create instance**.
1. Enter the instance name in the **Name** field. It must be unique within the folder.
1. (Optional) Enter a description of the instance.
1. Select the instance type.
1. Select the disk size.
1. Specify the public address of the instance.
2. Specify the subnet where the instance will be hosted.
1. In the **Administrator Data** block specify:
   * **Email** — the email address of the administrator of your instance {{ GL }}.
   * **Login** — the username for the administrative account.
1. Click **Create**.
1. Wait until the cluster is ready: its status on the {{ mgl-name }} dashboard will change to **Running** and its state to **Alive**. This may take some time.

## Set up a working environment {#configure-mgl}

In this section, you will learn how to prepare an instance {{ mgl-name }} to work.
1. Activate your instance {{ mgl-name }}:
   1. Follow the link sent to the administrator's email address when registering the instance.
   1. Change the password for the administrative account.
   1. Log in using your administrative account username and password.
1. [Create a group](https://docs.gitlab.com/ee/ssh/#add-an-ssh-key-to-your-gitlab-account) that will host your project.
1. [Create a user](https://docs.gitlab.com/ee/user/profile/account/create_accounts.html) and [add them to the group](https://docs.gitlab.com/ee/user/group/#add-users-to-a-group).
1. Create and SSH key and [assign it to the user account](https://docs.gitlab.com/ee/ssh/#add-an-ssh-key-to-your-gitlab-account).
1. [Create an empty project](https://docs.gitlab.com/ee/user/project/working_with_projects.html#blank-projects) to host your repository.

## Get started with the repository {#start-work-with-git}

In this section, you will learn how to get started with a local copy of your repository. Perform these steps on the local computer:
1. [Install the git client](https://docs.gitlab.com/ee/gitlab-basics/start-using-git.html#install-git).
1. [Clone the repository](https://docs.gitlab.com/ee/gitlab-basics/start-using-git.html#clone-a-repository) to the local machine.
1. Get started with the repository. Create a `README.md` file, and save it in the repository directory:

   ```bash
   echo "This is my new project" > README.md
   ```

1. Add the file to the repository using the command:

   ```bash
   git add README.md
   ```

1. Apply the changes to the local repository using the command:

   ```bash
   git commit -m "File added README.md"
   ```

   For more information, see the [GitLab documentation](https://docs.gitlab.com/ee/gitlab-basics/start-using-git.html#add-and-commit-local-changes).
1. [Push the changes](https://docs.gitlab.com/ee/gitlab-basics/start-using-git.html#add-and-commit-local-changes) to {{ mgl-name }}:

   ```bash
   git push origin master
   ```