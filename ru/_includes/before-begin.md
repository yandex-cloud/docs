## Перед началом работы {#before-you-begin}

Перейдите в [консоль]({{ link-console-main }}) {{ yandex-cloud }} и выберите каталог, в котором будете выполнять операции. Если такого каталога нет, создайте его:

{% list tabs group=instructions %}

- Консоль управления {#console}

  {% include [create-folder](create-folder.md) %}

- CLI {#cli}

  {% include [cli-install](cli-install.md) %}

  1. Посмотрите описание команды создания каталога:

      ```bash
      yc resource-manager folder create --help
      ```

  1. Создайте новый каталог:

      * с именем и без описания:

          ```bash
          yc resource-manager folder create \
             --name new-folder
          ```

          {% include [name-format](name-format.md) %}

      * с именем и описанием:

          ```bash
          yc resource-manager folder create \
             --name new-folder \
             --description "my first folder with description"
          ```

- API {#api}

  Воспользуйтесь методом [create](../resource-manager/api-ref/Folder/create.md) для ресурса [Folder](../resource-manager/api-ref/Folder/index.md) сервиса {{ resmgr-full-name }}.

{% endlist %}
