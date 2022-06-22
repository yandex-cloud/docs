# Перенос данных с использованием сервиса {{ data-transfer-full-name }} {#data-transfer}

1. [Подготовьте базу данных кластера-источника](../../data-transfer/operations/prepare.md#source-my).
1. [Подготовьте базу данных кластера-приемника](../../data-transfer/operations/prepare.md#target-my).
1. Создайте эндпоинты и трансфер:

    {% list tabs %}

    * Вручную

        1. [Создайте эндпоинт для источника](../../data-transfer/operations/endpoint/index.md#create):

            * **Тип базы данных** — `{{ MY }}`.
            * **Настройки подключения** — `Кластер MDB`.

                Укажите идентификатор кластера-источника.

        1. [Создайте эндпоинт для приемника](../../data-transfer/operations/endpoint/index.md#create):

            * **Тип базы данных** — `{{ MY }}`.
            * **Настройки подключения** — `Пользовательская инсталляция`.
                
                Укажите параметры подключения к кластеру-приемнику.

        1. [Создайте трансфер](../../data-transfer/operations/transfer.md#create) типа _{{ dt-type-copy-repl }}_, использующий созданные эндпоинты.

        1. [Активируйте трансфер](../../data-transfer/operations/transfer.md#activate).

    * С помощью {{ TF }}

        1. Если у вас еще нет {{ TF }}, {% if audience != "internal" %}[установите его](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform){% else %}установите его{% endif %}.
        1. Скачайте [файл с настройками провайдера](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf). Поместите его в отдельную рабочую директорию и {% if audience != "internal" %}[укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider){% else %}укажите значения параметров{% endif %}.
        1. Скачайте в ту же рабочую директорию файл конфигурации трансфера и эндпоинтов [data-transfer-mmy-mysql.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/data-transfer/data-transfer-mmy-mysql.tf).

        1. Укажите в файле конфигурации:

            * [параметры эндпоинта-источника](../../data-transfer/operations/endpoint/source/mysql.md#managed-service);
            * [параметры эндпоинта-приемника](../../data-transfer/operations/endpoint/target/mysql.md#on-premise).

        1. Выполните команду `terraform init` в директории с конфигурационными файлами. Эта команда инициализирует провайдер, указанный в конфигурационных файлах, и позволяет работать с ресурсами и источниками данных провайдера.
        1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

            ```bash
            terraform validate
            ```

            Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

        1. Создайте необходимую инфраструктуру:

            {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

            {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

            Трансфер активируется автоматически после создания.

    {% endlist %}

    {% note warning %}

    Избегайте любых изменений в схеме данных на кластере-источнике и кластере-приемнике во время работы трансфера. Подробнее см. в разделе [{#T}](../../data-transfer/operations/db-actions.md).

    {% endnote %}

1. Дождитесь перехода трансфера в статус {{ dt-status-repl }}.
1. Переведите кластер-источник в режим <q>только чтение</q> и переключите нагрузку на кластер-приемник.
1. На странице [мониторинга трансфера](../../data-transfer/operations/monitoring.md) дождитесь снижения до нуля характеристики **Maximum lag on delivery, [s]**. Это значит, что в кластер-приемник перенесены все изменения, произошедшие в кластере-источнике после завершения копирования данных.
1. [Деактивируйте](../../data-transfer/operations/transfer.md#deactivate-transfer) трансфер и дождитесь его перехода в статус {{ dt-status-stopped }}.

    Подробнее о статусах трансфера см. в разделе [Жизненный цикл трансфера](../../data-transfer/concepts/transfer-lifecycle.md#statuses).

1. Удалите созданные эндпоинты и трансфер:

    {% list tabs %}

    * Вручную

      Если вы создали эндпоинты и трансфер вручную, то:

        1. [Удалите остановленный трансфер](../../data-transfer/operations/transfer.md#delete-transfer).
        1. [Удалите эндпоинты для источника и приемника](../../data-transfer/operations/endpoint/index.md#delete).

    * С помощью {{ TF }}

      Если вы создали эндпоинты и трансфер с помощью {{ TF }}, то:

        1. В командной строке перейдите в каталог, в котором расположен актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.
        1. Удалите конфигурационный файл `data-transfer-mmy-mysql.tf`.
        1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

            ```bash
            terraform validate
            ```

            Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

        1. Подтвердите изменение ресурсов.

            {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

            Все ресурсы, которые были описаны в конфигурационном файле `data-transfer-mmy-mysql.tf`, будут удалены.

    {% endlist %}
