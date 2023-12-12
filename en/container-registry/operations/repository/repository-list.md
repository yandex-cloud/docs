---
title: "How to get information about existing repositories in {{ container-registry-full-name }}"
description: "In this tutorial, you will learn how to get information about existing repositories in {{ container-registry-full-name }}."
---

# Getting information about existing repositories

## Getting a list of repositories in a registry {#repository-list}

{% list tabs %}

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View a description of the CLI command to get a list of repositories:

     ```bash
     yc container repository list --help
     ```

  1. Get a list of repositories.
     * To get a list of all the repositories of all the registries in the current folder, run the command:

       ```bash
       yc container repository list
       ```

       Result:

       ```bash
       +----------------------+-----------------------------+
       |          ID          |            NAME             |
       +----------------------+-----------------------------+
       | crp8bu81b5afogqjrg92 | crp0pmf1n68tt345tf02/ubuntu |
       | crps9c63eviioaehqsif | crpl3738e9v1qb3besp7/ubuntu |
       +----------------------+-----------------------------+
       ```

     * To get a list of all the repositories in a particular registry, run the command:

       ```bash
       yc container repository list --registry-id <registry ID>
       ```

       Result:

       ```bash
       +----------------------+-----------------------------+
       |          ID          |            NAME             |
       +----------------------+-----------------------------+
       | crp8bu81b5afogqjrg92 | crp0pmf1n68tt345tf02/ubuntu |
       +----------------------+-----------------------------+
       ```

- API

  To retrieve a list of repositories in a registry, use the [List](../../api-ref/Repository/list.md) method for the [Repository](../../api-ref/Repository/) resource.

{% endlist %}

{% note info %}

The repository appears in the list as soon as at least one [Docker image is pushed to it](../docker-image/docker-image-push.md).

{% endnote %}

## Getting information about a repository {#repository-get}

{% list tabs %}

- CLI

  1. View a description of the CLI command to get repository information:

     ```bash
     yc container repository get --help
     ```

  1. Get information about the repository.
     * By repository ID:

       ```bash
       yc container repository get --id <repository ID>
       ```

       Result:

       ```bash
       name: crp0pmf1n68tt345tf02/ubuntu
       id: crp8bu81b5afogqjrg92
       ```

     * By repository name:

       ```bash
       yc container repository get --name <repository name>
       ```

       Result:

       ```bash
       name: crp0pmf1n68tt345tf02/ubuntu
       id: crp8bu81b5afogqjrg92
       ```

       You can specify both the full name of the Docker image and prefixes. For example, you can get information about the `crpvplula8p3nn86jtnb/myproject/myservice` repository by specifying `crpvplula8p3nn86jtnb/myproject/myservice`, `crpvplula8p3nn86jtnb/myproject`, or `crpvplula8p3nn86jtnb`.

- API

  Get information about the repository.
  * By repository ID:

    Use the [Get](../../api-ref/Repository/get.md) method for the [Repository](../../api-ref/Repository/) resource. Specify the repository ID in the `repositoryId` property.
  * By repository name:

    Use the [GetByName](../../api-ref/Repository/getByName.md) method for the [Repository](../../api-ref/Repository/) resource. In the `repositoryName` property, specify the repository name.

  You can retrieve a list of repositories in a registry by using the [List](../../api-ref/Repository/list.md) method for the [Repository](../../api-ref/Repository/) resource.

{% endlist %}