---
title: Getting started with {{ myt-full-name }}
description: To get started with {{ myt-full-name }}, create a service cluster and open the {{ ytsaurus-name }} web interface.
---

# Getting started with {{ myt-full-name }}

{% include notitle [preview](../_includes/note-preview.md) %}

To get started with {{ myt-name }}:

1. [Create a demo cluster](#cluster-create).
1. [Open the {{ ytsaurus-name }} web interface](#web-gui).

## Getting started {#before-you-begin}

1. Navigate to the [management console]({{ link-console-main }}) and either log in to {{ yandex-cloud }} or sign up if you do not have an account yet.

1. If you do not have a folder yet, create one:

   {% include [create-folder](../_includes/create-folder.md) %}

1. [Assign](../iam/operations/roles/grant.md) the following roles to your {{ yandex-cloud }} account:

    * [managed-ytsaurus.editor](security/index.md#managed-ytsaurus-editor): To create a cluster.
    * [{{ roles-vpc-user }}](../vpc/security/index.md#vpc-user): To use the cluster's [network](../vpc/concepts/network.md#network).

    {% include [note-managing-roles](../_includes/mdb/note-managing-roles.md) %}

## Create a demo cluster {#cluster-create}

{% note info %}

Creating a {{ ytsaurus-name }} cluster takes a long time.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  {% include notitle [demo-cluster-create](../_includes/managed-ytsaurus/demo-cluster-create.md) %}

{% endlist %}

## Open the {{ ytsaurus-name }} web interface {#web-gui}

You can manage {{ ytsaurus-name }} through the web interface. This interface is only for users with the [managed-ytsaurus.user](security/index.md#managed-ytsaurus-user) role or higher. To get started with the {{ ytsaurus-name }} web interface:

1. In the [management console]({{ link-console-main }}), open the cluster page.
1. Go to the {{ ytsaurus-name }} web interface page.

## What's next {#whats-next}

* Learn more about [creating](operations/cluster-create.md) a {{ ytsaurus-name }} cluster.