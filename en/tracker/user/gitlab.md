---
title: "How links work between {{ tracker-full-name }} and {{ GL }}"
description: "In this tutorial, you will learn how links work between between {{ tracker-name }} and {{ GL }}."
---

# {{ GL }}

## Setting up a link {#relation}


In [{{ tracker-name }} issues](../about-tracker.md#zadacha), you can automatically add links to [merge requests]({{ gl.docs }}/ee/user/project/merge_requests/) from {{ GL }}. To do this, specify the appropriate issue's [key](../glossary.md#key) in the name or description of a new merge request. The links will be placed in [{{ ui-key.startrek.ui_components_issue-links_ExternalLinksCollapse.external-relations}}](../external-links.md).

You can also enable automatic creation of issue comments with information about merge requests. Auto comments are only available for [{{ mgl-name }}](../../managed-gitlab/).

{% include [create hook](../../_includes/managed-gitlab/create-hook.md) %}

{% include [test hook](../../_includes/managed-gitlab/test-hook.md) %}

### See also {#see-also}

* [Manual for integrating {{ GL }} with {{ tracker-full-name }}](../../managed-gitlab/tutorials/tracker-integration.md)

## Connecting a repository {#repo}

To connect your repository on [GitLab](https://gitlab.com) to {{ tracker-name }}:

{% note info %}

Private repositories can only be accessed by users logged in to GitLab (**Internal project**) or the project team (**Private project**).

{% endnote %}

1. {% include [make sure you are admin](../../_includes/tracker/make-sure-admin.md) %}

1. {% include [path to the repository](../../_includes/tracker/repository-path.md) %}

1. Choose GitLab in the **Platform** field.

1. Get an OAuth token for your repository on GitLab. For details on how to get a token, see the [GitLab documentation](https://docs.gitlab.com/ee/user/profile/personal_access_tokens.html#create-a-personal-access-token). For the proper operation of {{ tracker-name }}, enable the **read_repository** and **read_api** options when setting up permissions.

1. Enter the repository address as `https://github.com/<repository_owner_login>/<repository_name>` and specify the access token.

1. Click **Connect**.

1. Make sure that the repository status in {{ tracker-name }} is **Connected**.

{% include [commits](../../_includes/tracker/add_commits.md) %}

## Own server {#on-premise}

{% include [on-premise server](../../_includes/tracker/on-premise-server.md) %}

