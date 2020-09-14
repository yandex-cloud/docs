## Перед началом работы {#before-you-begin}

Перейдите в [консоль]({{ link-console-main }}) {{ yandex-cloud }} и выберите каталог, в котором будете выполнять операции. Если такого каталога нет, создайте его:

{% list tabs %}

- Консоль управления

  {% include [create-folder](create-folder.md) %}

- CLI

  {% include [cli-install](cli-install.md) %}

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

          {% include [name-format](name-format.md) %}

      * с именем и описанием:

          ```
          $ yc resource-manager folder create \
              --name new-folder \
              --description "my first folder with description"
          ```

- API

  Чтобы создать каталог, воспользуйтесь методом [create](../resource-manager/api-ref/Folder/create.md) для ресурса [Folder](../resource-manager/api-ref/Folder/index.md) сервиса {{ resmgr-full-name }}.

{% endlist %}