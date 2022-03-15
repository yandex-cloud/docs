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

         Результат выполнения команды:

         ```bash
         +----------------------+-----------------------------+
         |          ID          |            NAME             |
         +----------------------+-----------------------------+
         | crp8bu81b5afogqjrg92 | crp0pmf1n68tt345tf02/ubuntu |
         | crps9c63eviioaehqsif | crpl3738e9v1qb3besp7/ubuntu |
         +----------------------+-----------------------------+
         ```

      * Чтобы получить список всех репозиториев определенного реестра, выполните команду:

         ```bash
         yc container repository list --registry-id crp0pmf1n68tt345tf02
         ```

         Где:
         * `--registry-id` — идентификатор реестра.

         Результат выполнения команды:

         ```bash
         +----------------------+-----------------------------+
         |          ID          |            NAME             |
         +----------------------+-----------------------------+
         | crp8bu81b5afogqjrg92 | crp0pmf1n68tt345tf02/ubuntu |
         +----------------------+-----------------------------+
         ```

- API

  Чтобы получить список репозиториев в реестре, воспользуйтесь методом [List](../../api-ref/Repository/list.md) для ресурса [Repository](../../api-ref/Repository/).

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
         yc container repository get --id crp8bu81b5afogqjrg92
         ```

         Где:
         * `--id` — идентификатор репозитория.

         Результат выполнения команды:

         ```bash
         name: crp0pmf1n68tt345tf02/ubuntu
         id: crp8bu81b5afogqjrg92
         ```

      * По имени репозитория:

         ```bash
         yc container repository get --name crp0pmf1n68tt345tf02/ubuntu
         ```

         Где:
         * `--name` — имя репозитория.

         Результат выполнения команды:

         ```bash
         name: crp0pmf1n68tt345tf02/ubuntu
         id: crp8bu81b5afogqjrg92
         ```

         Можно указать не только полное имя Docker-образа, но и префиксы. Например, информацию о репозитории `crpvplula8p3nn86jtnb/myproject/myservice` можно получить, указав `crpvplula8p3nn86jtnb/myproject/myservice`, `crpvplula8p3nn86jtnb/myproject` или `crpvplula8p3nn86jtnb`.

- API

  Получите информацию о репозитории.
  * По ID репозитория:

    Воспользуйтесь методом [Get](../../api-ref/Repository/get.md) для ресурса [Repository](../../api-ref/Repository/). В свойстве `repositoryId` укажите идентификатор репозитория.
  * По имени репозитория:

    Воспользуйтесь методом [GetByName](../../api-ref/Repository/getByName.md) для ресурса [Repository](../../api-ref/Repository/). В свойстве `repositoryName` укажите имя репозитория.

  Получить список репозиториев в реестре можно с помощью метода [List](../../api-ref/Repository/list.md) для ресурса [Repository](../../api-ref/Repository/).

{% endlist %}