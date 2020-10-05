# Working with Git

## Creating a local repository {#init}

To get started with a local repository:

1. On the left in the ![folder](../../../_assets/datasphere/jupyterlab/folder.svg) **File Browser** section, select the folder where you want to create a repository and go to it.
1. In the top panel, click **Git** and select **Init**.
1. In the window that opens, click **Yes**.
1. Create a project file in the repository directory.
1. Add the project file to version control:
    1. Go to the ![git](../../../_assets/datasphere/jupyterlab/git.svg) **Git** section.
    1. On the **Change** tab, in the **Untracked** drop-down list, find the project file.
    1. Next to the file name, click ![add](../../../_assets/datasphere/jupyterlab/add.svg).
1. Make the initial commit:
    1. In the **Summary** field, enter a name for the commit.
    1. In the **Description** field, enter a description for the commit.
    1. Click **Commit**.
    1. In the window that opens, enter the name and email address of the commit author.
    1. Click **OK**.

The local repository is ready to go.

## Cloning a repository {#clone}

To clone an existing repository:

1. On the left in the ![folder](../../../_assets/datasphere/jupyterlab/folder.svg) **File Browser** section, select the folder where you want to create a repository clone and go to it.
1. In the top panel, click **Git** and select **Clone**.
1. In the window that opens, enter the repository URI and click **Clone**.

The cloned repository folder appears in the ![folder](../../../_assets/datasphere/jupyterlab/folder.svg) **File Browser** section.

## Creating a new branch {#new-branch}

To create a new branch:

1. On the left in the ![folder](../../../_assets/datasphere/jupyterlab/folder.svg) **File Browser** section, select the folder with the desired repository and go to it.
1. Under ![git](../../../_assets/datasphere/jupyterlab/git.svg) **Git**, expand the **Current Branch** drop-down list.
1. Click **New Branch**.
1. In the window that opens:
    1. In the **Name** field, enter a name for the new branch.
    1. In the list, select the branch that the new one will be based on. To quickly search for the desired branch, use a filter.
    1. Click **Create branch**.

The created branch is displayed in the list as the current one.

## Writing changes to a repository {#commit}

To edit data and write changes to a repository:

1. Change the file that is under version control.

1. In the top panel, click **File** and select **Save File** to save the changes.

1. Go to the ![git](../../../_assets/datasphere/jupyterlab/git.svg) **Git** section.

1. The edited file is displayed on the **Changes** tab in the **Changes** list.

    The letter **M** next to the file name indicates that the file has been changed.

1. Next to the file name, click ![add](../../../_assets/datasphere/jupyterlab/add.svg).

    The changes are indexed and the file is moved to the **Staged** list.

1. To commit the changes:
    1. In the **Summary** field, enter a name for the commit.
    1. In the **Description** field, enter a description for the commit.
    1. Click **Commit**.
    1. In the window that opens, enter the name and email address of the commit author.
    1. Click **OK**.

The changes are written to the repository.

## Pushing changes to a remote repository {#push}

To push the saved changes to the remote repository:

1. Go to the ![git](../../../_assets/datasphere/jupyterlab/git.svg) **Git** section.
1. Click ![git](../../../_assets/datasphere/jupyterlab/push.svg) **Push committed changes**.
1. In the window that opens, enter the name and password of the user who is allowed to commit to the remote repository.
1. Click **OK**.
1. Wait until **Git Push completed successfully** appears.
1. Click **Dismiss**.

Changes are pushed to the remote repository.

## Pulling changes from a remote repository {#pull}

To pull changes from the remote repository:

1. Go to the ![git](../../../_assets/datasphere/jupyterlab/git.svg) **Git** section.
1. Click ![git](../../../_assets/datasphere/jupyterlab/pull.svg) **Pull latest changes**.
1. Wait until **Git Pull completed successfully** appears.
1. Click **Dismiss**.

Changes are pulled from the remote repository.

