---
title: "Как создать репозиторий в {{ container-registry-full-name }}"
description: "Следуя данной инструкции, вы сможете создать репозиторий." 
---

# Создать репозиторий

{% note info %}

Репозиторий начнет отображаться только после [загрузки](../../operations/docker-image/docker-image-push.md) в него Docker-образа.

{% endnote %}

Чтобы создать [репозиторий](../../concepts/repository.md):

{% list tabs %}

- {{ TF }}

  {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Опишите в конфигурационном файле параметры ресурса `yandex_container_repository`:

     ```hcl
     resource "yandex_container_registry" "my-registry" {
       name = "test-registry"
     }
   
     resource "yandex_container_repository" "my-repository" {
       name = "${yandex_container_registry.my-registry.id}/<имя_репозитория>"
     }
   
     output "my-registry-id" {
       value = yandex_container_registry.my-registry.id
     }
   
     output "my-repository-name" {
       value = yandex_container_repository.my-repository.name
     }
     ```

     Где `name` — имя репозитория в формате `<идентификатор_реестра>/<имя_репозитория>`. Вы можете получить идентификатор [реестра](../../concepts/registry.md) из [списка реестров в каталоге](../registry/registry-list.md#registry-list).

     Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-resources-link }}/container_repository).

  1. Создайте ресурсы:

     {% include [terraform-validate-plan-apply](../../../_tutorials/terraform-validate-plan-apply.md) %}

     {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):
      
     ```bash
     yc container repository list --registry-id <идентификатор_реестра>
     ```

- API

  Чтобы создать репозиторий, воспользуйтесь методом REST API [upsert](../../api-ref/Repository/upsert.md) для ресурса [Repository](../../api-ref/Repository/index.md), или вызовом gRPC API [RepositoryService/Upsert](../../api-ref/grpc/repository_service.md#Upsert).

{% endlist %}