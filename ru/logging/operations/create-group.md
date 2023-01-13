---
title: "Инструкция о том, как создать лог-группу в {{ cloud-logging-name }}"
description: "Из статьи вы узнаете, как создать лог-группу в {{ cloud-logging-name }}."
---

# Создание лог-группы

{% note info %}

Имя [лог-группы по умолчанию](../concepts/log-group.md) — `default`. Она создается автоматически, когда сервис или приложение пишет логи, указав в качестве назначения идентификатор каталога. Вы можете самостоятельно создать лог-группу с именем `default`. Тогда она будет лог-группой по умолчанию для того каталога, в котором ее создали.

{% endnote %}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите создать [лог-группу](../concepts/log-group.md).
    1. Выберите сервис **{{ cloud-logging-name }}**.
    1. Нажмите кнопку **Создать группу**.
    1. (опционально) Введите имя и описание лог-группы. Формат имени:

        {% include [name-format](../../_includes/name-format.md) %}

    1. Укажите срок хранения записей в лог-группе.
    1. Нажмите кнопку **Создать группу**.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы создать лог-группу, выполните команду:

    ```
    yc logging group create \
      --name=group \
      --retention-period=1h \
      --data-stream=<идентификатор_потока>
    ```

    Где:
    * `--name` — имя лог-группы.
    * `--retention-period` — срок хранения записей в лог-группе. Необязательный параметр.

        {% include [retention-period](../../_includes/logging/retention-period.md) %}

        {% include [retention-period](../../_includes/logging/retention-period-format.md) %}

    * `data-stream` — идентификатор [потока данных](../../data-streams/concepts/glossary.md#stream-concepts) {{ yds-full-name }}. Необязательный параметр. В указанный поток автоматически будут перенаправляться записи, которые добавили в лог-группу. Идентификатор потока состоит из зоны доступности, идентификатора каталога, идентификатора базы данных {{ ydb-full-name }} и имени потока.

        >Например, укажите идентификатор потока `/{{ region-id }}/aoeu1kuk2dhtaupdb1es/cc8029jgtuabequtgtbv/aws_stream`, если:
        >* `aws_stream` — имя потока;
        >* `{{ region-id }}` — зона доступности;
        >* `aoeu1kuk2dhtaupdb1es` — идентификатор каталога;
        >* `cc8029jgtuabequtgtbv` — идентификатор базы данных {{ ydb-full-name }}.

    Результат:

    ```
    done (1s)
    id: af3flf29t8**********
    folder_id: aoek6qrs8t**********
    cloud_id: aoegtvhtp8**********
    created_at: "2021-06-24T09:56:38.970Z"
    name: group
    status: ACTIVE
    retention_period: 3600s
    data_stream: /{{ region-id }}/aoeu1kuk2dhtaupdb1es/cc8029jgtuabequtgtbv/aws_stream
    ```

- API

    Создать пользовательскую лог-группу можно с помощью метода API [create](../api-ref/LogGroup/create.md).

- {{ TF }}

  {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

  Если у вас ещё нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

     * `name` — имя лог-группы. Необязательный параметр. Формат имени:

          {% include [name-format](../../_includes/name-format.md) %}

     * `folder_id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md). Необязательный параметр. По умолчанию будет использовано значение, указанное в настройках провайдера.

     * `retention_period` — срок хранения записей в лог-группе. Необязательный параметр.

         {% include [retention-period](../../_includes/logging/retention-period.md) %}

         {% include [retention-period](../../_includes/logging/retention-period-format.md) %}

     Пример структуры конфигурационного файла:

     
     ```hcl
     provider "yandex" {
       token     = "<OAuth>"
       cloud_id  = "<идентификатор облака>"
       folder_id = "<идентификатор каталога>"
       zone      = "{{ region-id }}-a"
     }
     
     resource "yandex_logging_group" "group1" {
       name      = "<имя лог-группы>"
       folder_id = "<идентификатор каталога>"
       retention_period = "5h"
     }
     ```



     Более подробную информацию о параметрах ресурса `yandex_logging_group` в {{ TF }}, см. в [документации провайдера]({{ tf-provider-link }}/logging_group).

  1. Проверьте корректность конфигурационных файлов.

     1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
     1. Выполните проверку с помощью команды:

        ```
        terraform plan
        ```

     Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, {{ TF }} на них укажет. 

  1. Разверните облачные ресурсы.

     1. Если в конфигурации нет ошибок, выполните команду:

        ```
        terraform apply
        ```

     1. Подтвердите создание ресурсов: введите в терминал слово `yes` и нажмите **Enter**.

     После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

        ```
        yc logging group list
        ```

{% endlist %}
