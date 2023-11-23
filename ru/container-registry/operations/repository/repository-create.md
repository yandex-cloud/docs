---
title: "Как создать репозиторий в {{ container-registry-full-name }}"
description: "Следуя данной инструкции, вы сможете создать репозиторий." 
---

# Создать репозиторий

Чтобы создать [репозиторий](../../concepts/repository.md):

{% list tabs %}

- {{ TF }}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}
  1. Опишите в конфигурационном файле параметры ресурса `yandex_container_repository`:
     * `name` — имя репозитория в формате `<id реестра>/<имя Docker-образа>`. Вы можете получить идентификатор [реестра](../../concepts/registry.md) из [списка реестров в каталоге](../registry/registry-list.md#registry-list).

     >Пример структуры конфигурационного файла:
     >
     >```
     >resource "yandex_container_repository" "my-repository" {
     >  name = "abcd12316s9a2t7gd8ef/test-repository"
     >}
     >```

     Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-resources-link }}/container_repository).

  1. Выполните проверку с помощью команды:

     ```
     terraform plan
     ```

     В терминале будет выведен список ресурсов с параметрами. Это проверочный этап: ресурсы не будут созданы. Если в конфигурации есть ошибки, {{ TF }} на них укажет.

     {% note alert %}

     Все созданные с помощью {{ TF }} ресурсы тарифицируются. Внимательно проверьте план.

     {% endnote %}

  1. Чтобы создать ресурсы, выполните команду:

     ```
     terraform apply
     ```

  1. Подтвердите создание ресурсов: введите в терминал слово `yes` и нажмите **Enter**.

     {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов можно в [консоли управления]({{ link-console-main }}) или с помощью команды [YC CLI](../../../cli/):

     ```bash
     yc container repository list --registry-id <id реестра>
     ```

{% endlist %}