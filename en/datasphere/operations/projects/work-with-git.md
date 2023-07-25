# Working with Git

## Getting started {#before-begin}

{% include [before-begin](../../../_includes/datasphere/ui-before-begin.md) %}

## Cloning a public GitHub repository {#clone-public}

To clone an existing public repository:

1. Under ![folder](../../../_assets/datasphere/jupyterlab/folder.svg) **File Browser** in the left-side navigation menu, create or select a folder where you want to clone the repository and change to it.
1. In the top menu, click **Git** and select **Clone**.
1. In the window that opens, enter the repository URI and click **Clone**.

The cloned repository folder appears in the ![folder](../../../_assets/datasphere/jupyterlab/folder.svg) **File Browser** section.

## Cloning a private GitHub repository {#clone-private}

{% include [before-begin-github](../../../_includes/datasphere/before-you-begin-github.md) %}

Clone an existing private repository:

1. Under ![folder](../../../_assets/datasphere/jupyterlab/folder.svg) **File Browser** in the left-side navigation menu, create or select a folder where you want to clone the repository and change to it.
1. In the top menu, click **Git** and select **Clone**.
1. In the window that opens, enter the repository URI and click **Clone**.
1. You will see an error message saying `fatal: could not read Username for 'https://github.com': terminal prompts disabled`. Click **Refine the data**.
1. In the window that opens, enter the username and token to access GitHub, and then click **Submit**.

The cloned repository folder appears in the ![folder](../../../_assets/datasphere/jupyterlab/folder.svg) **File Browser** section.

## Creating a local repository {#init}

To get started with a local repository:

1. Under ![folder](../../../_assets/datasphere/jupyterlab/folder.svg) **File Browser** in the left-side navigation menu, create or select a folder where you want to clone the repository and change to it.
1. In the top menu, click **Git** and select **Init**.
1. In the window that opens, click **Yes**.
1. Create a notebook file in the repository folder.
1. Add the notebook file to version control:

   1. Go to the ![git](../../../_assets/datasphere/jupyterlab/git.svg) **Git** section.
   1. On the **Change** tab, in the **Untracked** drop-down list, find the project file.
   1. Next to the file name, click ![add](../../../_assets/datasphere/jupyterlab/add.svg).

1. Make the initial commit:

   1. In the **Summary** field, enter the commit name.
   1. In the **Description** field, enter a description for the commit.
   1. Click **Commit**.
   1. In the window that opens, enter the name and email address of the commit author.
   1. Click **OK**.

The local repository is ready to go.

## Creating a new branch {#new-branch}

1. Under ![folder](../../../_assets/datasphere/jupyterlab/folder.svg) **File Browser** in the left-side navigation menu, create or select a folder where you want to clone the repository and change to it.
1. Under ![git](../../../_assets/datasphere/jupyterlab/git.svg) **Git**, expand the **Current Branch** drop-down list.
1. Click **New Branch**.
1. In the window that opens:

   1. In the **Name** field, enter a name for the new branch.
   1. In the list, select the branch that the new one will be based on. To quickly search for the desired branch, use a filter.
   1. Click **Create branch**.

The created branch will display in the list and will become active.

## Writing changes to a local repository {#commit}

To edit data and write changes to a repository:

1. Change the file that is under version control.
1. In the top menu, click **File** and select **Save File** to save the changes.
1. In the left-side navigation menu, go to ![git](../../../_assets/datasphere/jupyterlab/git.svg) **Git**.
1. The edited file will be displayed in the **Changes** list on the **Changes** tab. The letter **M** next to the file name means that the file has been changed.

1. Next to the file name, click ![add](../../../_assets/datasphere/jupyterlab/add.svg). The changes are indexed and the file is moved to the **Staged** list.

1. To commit the changes:

   1. In the **Summary** field, enter the commit name.
   1. In the **Description** field, enter a description for the commit.
   1. Click **Commit**.
   1. In the window that opens, enter the name and email address of the commit author.
   1. Click **OK**.

The changes are written to the repository.

## Pushing changes to a remote GitHub repository {#push}

{% include [before-begin-github](../../../_includes/datasphere/before-you-begin-github.md) %}

To push the saved changes to the remote repository:

1. In the left-side navigation menu, go to ![git](../../../_assets/datasphere/jupyterlab/git.svg) **Git**.
1. Click ![git](../../../_assets/datasphere/jupyterlab/push.svg) **Push committed changes**.
1. In the window that opens:

   1. Enter the name of a user with write access to the remote repository.
   1. Enter your personal access token for GitHub.

1. Click **OK**.
1. Wait until **Git Push completed successfully** appears.
1. Click **Dismiss**.

   Changes are pushed to the remote repository.

## Pulling changes from a remote repository {#pull}

1. Go to the ![git](../../../_assets/datasphere/jupyterlab/git.svg) **Git** section.
1. Click ![git](../../../_assets/datasphere/jupyterlab/pull.svg) **Pull latest changes**.
1. Wait until **Git Pull completed successfully** appears.
1. Click **Dismiss**.

   Changes are pulled from the remote repository.

## Saving results to GitHub {#local-to-github}

{% include [before-begin-github](../../../_includes/datasphere/before-you-begin-github.md) %}

To save a project code to a new repository on GitHub:

1. [Create](https://docs.github.com/en/repositories/creating-and-managing-repositories/creating-a-new-repository) a new empty repository on GitHub. You can add README, license, and gitignore files later.
1. Create a local repository in the {{ ml-platform-name }} project:

   1. Under ![folder](../../../_assets/datasphere/jupyterlab/folder.svg) **File Browser** in the left-side navigation menu, create or select a folder where you want to clone the repository and change to it.
   1. In the top menu, click **Git** and select **Init**.
   1. In the window that opens, click **Yes**.

1. Map the local repository to the remote GitHub repository.

   ```
   !git remote add origin https://<GitHub_user_name>:<personal_access_token>@github.com/<repository_address>
   ```

   Where:
   * `<GitHub_user_name_>`: Username of the GitHub user you are going to work under.
   * `<personal_access_token>`: Contents of the token to access GitHub.
   * `<repository_address>`: Path to the repository in `<username>/<repository_name>.git` format.

1. Initialize the local repository once again:

   ```
   !git init
   ```

1. Add all required files to version control:

   1. Go to the ![git](../../../_assets/datasphere/jupyterlab/git.svg) **Git** section.
   1. In the **Untracked** drop-down list under the **Change** tab, find the project file.
   1. Next to the file name, click ![add](../../../_assets/datasphere/jupyterlab/add.svg).

1. Make the initial commit:

   1. In the **Summary** field, enter the commit name.
   1. In the **Description** field, enter a description for the commit.
   1. Click **Commit**.
   1. In the window that opens, enter the name and email address of the commit author.
   1. Click **OK**.

1. Push changes to the remote repository:

   ```
   !git push -u origin master
   ```

   As a result, the GitHub repository should contain the files that you added to version control.