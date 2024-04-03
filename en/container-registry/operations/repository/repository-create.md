---
title: "How to create a repository in {{ container-registry-full-name }}"
description: "Follow this guide to create a repository."
---

# Creating a repository

{% note info %}

A [repository](../../concepts/repository.md) will only be displayed after you [push](../../operations/docker-image/docker-image-push.md) a [Docker image](../../concepts/docker-image.md) to it.

{% endnote %}

To create a repository:

{% list tabs group=instructions %}

- {{ TF }} {#tf}

   {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

   {% include [terraform-install](../../../_includes/terraform-install.md) %}

   1. Describe the properties of the `yandex_container_repository` resource in a configuration file:

      ```hcl
      resource "yandex_container_registry" "my-registry" {
        name = "test-registry"
      }

      resource "yandex_container_repository" "my-repository" {
        name = "${yandex_container_registry.my-registry.id}/<repository_name>"
      }

      output "my-registry-id" {
        value = yandex_container_registry.my-registry.id
      }

      output "my-repository-name" {
        value = yandex_container_repository.my-repository.name
      }
      ```

      Where `name` is the repository name in `<registry_ID>/<repository_name>` format. You can retrieve the [registry](../../concepts/registry.md) ID from the [folder registry list](../registry/registry-list.md#registry-list).

      For more information about resources that you can create with {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/container_repository).

   1. Create resources:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will create all the required resources. You can check the new resources using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/) command:

      ```bash
      yc container repository list --registry-id <registry_ID>
      ```

- API {#api}

   To create a repository, use the [upsert](../../api-ref/Repository/upsert.md) REST API method for the [Repository](../../api-ref/Repository/index.md) resource or the [RepositoryService/Upsert](../../api-ref/grpc/repository_service.md#Upsert) gRPC API call.

{% endlist %}