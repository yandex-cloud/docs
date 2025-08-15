---
title: How to work with Git in {{ ml-platform-full-name }}
description: In this article, you will learn how to work with Git in {{ ml-platform-name }}.
---

# Working with Git

## Getting started {#before-begin}

{% include [before-begin](../../../_includes/datasphere/ui-before-begin.md) %}

## Cloning a public GitHub repository {#clone-public}

To clone a public repository:

1. Under ![folder](../../../_assets/datasphere/jupyterlab/folder.svg) **File Browser** in the left-hand navigation menu, create or select a folder to host the repository clone and navigate to that folder.
1. In the top menu, click **Git** and select **Clone a Repository**.
1. In the window that opens, specify the repository URI and click **Clone**.

You will see the cloned repository folder in the ![folder](../../../_assets/datasphere/jupyterlab/folder.svg) **File Browser** section.

## Cloning a private GitHub repository {#clone-private}

{% include [before-begin-github](../../../_includes/datasphere/before-you-begin-github.md) %}

To clone a private repository:

1. Under ![folder](../../../_assets/datasphere/jupyterlab/folder.svg) **File Browser** in the left-hand navigation menu, create or select a folder to host the repository clone and navigate to that folder.
1. In the top menu, click **Git** and select **Clone a Repository**.
1. In the window that opens, specify the repository URI and click **Clone**.
1. In the window that opens, enter the username and token to access GitHub, and then click **Submit**.

You will see the cloned repository folder in the ![folder](../../../_assets/datasphere/jupyterlab/folder.svg) **File Browser** section.

## Creating a local repository {#init}

To get started with a local repository:

1. Under ![folder](../../../_assets/datasphere/jupyterlab/folder.svg) **File Browser** in the left-hand navigation menu, create or select a folder to host the repository clone and navigate to that folder.
1. In the top menu, click **Git** and select **Initialize a Repository**.
1. In the window that opens, click **Yes**.
1. Create a notebook file in the repository folder.
1. Add the notebook file to version control:

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

## Creating a new branch {#new-branch}

1. Under ![folder](../../../_assets/datasphere/jupyterlab/folder.svg) **File Browser** in the left-hand navigation menu, create or select a folder to host the repository clone and navigate to that folder.
1. Under ![git](../../../_assets/datasphere/jupyterlab/git.svg) **Git**, expand the **Current Branch** drop-down list.
1. Click **New Branch**.
1. In the window that opens:

    1. In the **Name** field, enter a name for the new branch.
    1. In the list, select the branch to base the new branch on. To quickly find the branch you need, use a filter.
    1. Click **Create branch**.

The created branch will appear in the list and will become active.

## Committing changes to a local repository {#commit}

To edit data and commit the changes to a repository:

1. Modify the files under version control.
1. In the top menu, click **File** and select **Save All** to save the changes.
1. In the left-hand navigation menu, go to ![git](../../../_assets/datasphere/jupyterlab/git.svg) **Git**.
1. The edited files will appear in the **Changes** list of the **Changes** tab. The letter **M** next to the file name means that the file has been modified.
1. Next to the file name, click ![add](../../../_assets/datasphere/jupyterlab/add.svg). This will index the changes and move the file to the **Staged** list.

1. To commit the changes:

    1. In the **Summary** field, enter a name for the commit.
    1. In the **Description** field, enter a description for the commit.
    1. Click **Commit**.
    1. In the window that opens, enter the name and email address of the commit author.
    1. Click **OK**.

The changes are now committed to the repository.

## Pushing changes to a remote GitHub repository {#push}

{% include [before-begin-github](../../../_includes/datasphere/before-you-begin-github.md) %}

To push the saved changes to a remote repository:

1. In the left-hand navigation menu, go to ![git](../../../_assets/datasphere/jupyterlab/git.svg) **Git**.
1. Click ![git](../../../_assets/datasphere/jupyterlab/push.svg) **Push committed changes**.
1. In the window that opens:

    1. Enter your username with commit access to the remote repository.
    1. Enter your personal access token for GitHub.

1. Click **OK**.
1. Wait until **Successfully pushed** appears.

   Changes are now pushed to the remote repository.

## Pulling changes from a remote repository {#pull}

1. Go to the ![git](../../../_assets/datasphere/jupyterlab/git.svg) **Git** section.
1. Click ![git](../../../_assets/datasphere/jupyterlab/pull.svg) **Pull latest changes**.
1. Wait until **Successfully pulled** appears.

   Changes are now pulled from the remote repository.

## Saving results to GitHub {#local-to-github}

{% include [before-begin-github](../../../_includes/datasphere/before-you-begin-github.md) %}

To save your project code to a new GitHub repository:

1. [Create](https://docs.github.com/en/repositories/creating-and-managing-repositories/creating-a-new-repository) a new empty GitHub repository. You can add the `README`, `license`, and `.gitignore` files later.
1. Create a local repository in your {{ ml-platform-name }} project:

   1. Under ![folder](../../../_assets/datasphere/jupyterlab/folder.svg) **File Browser** in the left-hand navigation menu, create or select a folder to host the repository clone and navigate to that folder.
   1. In the top menu, click **Git** and select **Initialize a Repository**.
   1. In the window that opens, click **Yes**.

1. Map your local repository to the remote GitHub repository:

   1. In the top menu, click **Git** and select **Manage Remote Repositories**.
   1. In the window that opens, enter the remote repository name and address and click **Add**.
   1. Close the window for adding remote repositories.

1. Add all required files to version control:

   1. Go to the ![git](../../../_assets/datasphere/jupyterlab/git.svg) **Git** section.
   1. On the **Change** tab, in the **Untracked** drop-down list, find the project file.
   1. Next to the file name, click ![add](../../../_assets/datasphere/jupyterlab/add.svg).

1. Make the initial commit:

   1. In the **Summary** field, enter a name for the commit.
   1. In the **Description** field, enter a description for the commit.
   1. Click **Commit**.
   1. In the window that opens, enter the name and email address of the commit author.
   1. Click **OK**.

1. Push the changes to the remote repository:

   1. In the top menu, click **Git** and select **Push to Remote**.
   1. In the window that opens, enter the GitHub username you will be using and your access token for GitHub.

As a result, the files you added to version control will appear in the GitHub repository.
