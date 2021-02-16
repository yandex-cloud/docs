# Создание каталога

_Каталог_  — это пространство, в котором создаются и группируются ресурсы {{ yandex-cloud }}.

{% note alert %}

Создавая каталоги, учитывайте [квоты и лимиты](../../concepts/limits.md). 

{% endnote %}

{% list tabs %}

- Консоль управления

  {% include [create-folder](../../../_includes/create-folder.md) %}


- CLI

  1. Посмотрите описание команды создания каталога:

      ```
      $ yc resource-manager folder create --help
      ```

  2. Создайте новый каталог:

      * с именем и без описания:
          ```
          $ yc resource-manager folder create \
              --name new-folder
          ```

          {% include [name-format](../../../_includes/name-format.md) %}

      * с именем и описанием:

          ```
          $ yc resource-manager folder create \
              --name new-folder \
              --description "my first folder with description"
          ```

- API

  Чтобы создать каталог, воспользуйтесь методом [create](../../api-ref/Folder/create.md) для ресурса [Folder](../../api-ref/Folder/index.md).

{% endlist %}
