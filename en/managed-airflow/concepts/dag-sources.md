---
title: DAG file sources in {{ maf-full-name }}
description: Learn how {{ maf-name }} downloads DAG files from an {{ objstorage-name }} bucket or Git repository and what authentication methods are supported.
---

# DAG file sources

A {{ maf-name }} cluster automatically loads [DAG files](index.md#about-the-service) from an external source, such as a {{ objstorage-full-name }} bucket or Git repository. A single source is selected for a cluster. Its type and connection settings are specified when [creating](../operations/cluster-create.md) or [updating the cluster](../operations/cluster-update.md).

## {{ objstorage-name }} bucket {#object-storage}

The bucket stores DAG files as well as additional scripts and modules used in DAG. The files may reside in the bucket root or directory. The cluster automatically downloads them from the selected bucket.

## Git repository {#git}

For connecting to a Git repository, its address, branch name, and path to DAG file folder are specified. The cluster downloads files from the specified folder in the selected branch.

{% include [git-sync-network](../../_includes/mdb/maf/note-git-sync-network.md) %}

### Authentication methods {#git-auth}

The authentication method sets the repository address format and required credentials:

{% list tabs %}

- SSH key

    Connections over SSH use an address in `git@<host>:<path_to_repository>.git` format, such as `git@github.com:<username>/<repository_name>.git`, or a private SSH key for repository access.

    {% include [git-sync-ssh](../../_includes/mdb/maf/note-git-sync-ssh.md) %}

- Username and password

    Connections over HTTP(S) use an address in `https://<host>/<path_to_repository>.git` or `http://<host>/<path_to_repository>.git` format, such as `https://github.com/<username>/<repository_name>.git`, as well as a username and password pair.

    Instead of a password, you can provide an [access token](#git-token) if the service the repository resides in supports such authentication. The username as well as its password or token cannot be empty. Credentials are specified in separate connection settings, not in the repository address.

{% endlist %}

### Token authentication {#git-token}

An access token is provided in the password setting when connecting over HTTPS. The token is created in the service the repository resides in and must grant read permissions for the repository with DAG files. The token allows you to restrict access permissions granted by account password.

The username depends on the service and the token type. See below for examples and links to guides for services:

#|
|| **Service** | **Token type** | **Username**  ||
|| GitHub | [Personal access token](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens#using-a-personal-access-token-on-the-command-line) | GitHub username. The username cannot be empty, despite the fact that the token is used for authentication. ||
|| GitLab | [Personal access token](https://docs.gitlab.com/user/profile/personal_access_tokens/#clone-repository-using-personal-access-token) | Any non-empty string, e.g., GitLab username or `oauth2`. ||
|| GitLab | [Deploy token](https://docs.gitlab.com/user/project/deploy_tokens/) | Name specified when the token was created. The default format is `gitlab+deploy-token-<number>`. ||
|| GitLab | [OAuth access token](https://docs.gitlab.com/api/oauth2/) | `oauth2` ||
|| Bitbucket Cloud | [API token](https://support.atlassian.com/bitbucket-cloud/docs/using-api-tokens/) | Case-sensitive Bitbucket username or `x-bitbucket-api-token-auth`. ||
|| Bitbucket Cloud | Access token of a [repository](https://support.atlassian.com/bitbucket-cloud/docs/using-access-tokens/) or [project](https://support.atlassian.com/bitbucket-cloud/docs/using-project-access-tokens/). | `x-token-auth` ||
|| Azure DevOps | [Personal access token](https://learn.microsoft.com/en-us/azure/devops/repos/git/auth-overview?view=azure-devops#personal-access-tokens-alternative-option) | Any non-empty string, e.g., `git`. ||
|#

If the token expired or was revoked, create a new one and update the connection parameters in the [cluster settings](../operations/cluster-update.md).

## Use cases {#examples}

* [{#T}](../tutorials/data-processing-automation.md)
* [{#T}](../tutorials/airflow-auto-tasks.md)

#### Useful links {#see-also}

[Uploading DAG files to a cluster](../operations/upload-dags.md)
