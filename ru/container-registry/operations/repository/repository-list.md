# Получить информацию об имеющихся репозиториях

## Получить список репозиториев в реестре {#repository-list}

{% list tabs %}

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. Посмотрите описание команды CLI для получения списка репозиториев:

      ```bash
      yc container repository list --help
      ```

   1. Получите список репозиториев.

      * Чтобы получить список всех репозиториев всех реестров текущего каталога, выполните команду:

         ```bash
         yc container repository list
         ```

      * Чтобы получить список всех репозиториев определенного реестра, выполните команду:

         ```bash
         yc container repository list --registry-id <ID_реестра>
         ```

- API

   Чтобы получить список репозиториев в реестре, воспользуйтесь методом [list](../../api-ref/Repository/list.md) для ресурса [Repository](../../api-ref/Repository/).
  
{% endlist %}

## Получить информацию о репозитории {#repository-get}

{% list tabs %}

- CLI
  
   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. Посмотрите описание команды CLI для получения информации о репозитории:

      ```bash
      yc container repository get --help
      ```

   1. Получите информацию о репозитории.

      * По ID репозитория:

         ```bash
         yc container repository get --id <ID_репозитория>
         ```

      * По имени репозитория:

         ```bash
         yc container repository get --name <имя_репозитория>
         ```

         Можно указать не только полное имя Docker-образа, но и префиксы. Например, информацию о репозитории `crtckchkc60enhftkbsk/nginx/test` можно получить, указав `crtckchkc20enhfskbtf/nginx/test`, `crtckchkc20enhfskbtf/nginx` или `crtckchkc20enhfskbtf`.

{% endlist %}
