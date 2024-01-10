# Создание кластера {{ PG }} для <q>1С:Предприятия</q>

{{ mpg-name }} позволяет создавать отказоустойчивые кластеры {{ PG }}, оптимизированные для работы с системой <q>1С:Предприятие</q>. Для этого в сервисе поддерживаются версии PostgreSQL {{ pg.versions.console.str-1c }}, в которых установлены все необходимые [расширения](#extensions) и изменена конфигурация менеджера подключений.

{% note warning %}

Систему <q>1С:Предприятие</q> можно подключить только к кластерам версии {{ pg.versions.console.str-1c }}.

{% endnote %}

При выборе [класса хоста](../../managed-postgresql/concepts/instance-types.md) ориентируйтесь на количество пользователей вашей инсталляции <q>1С:Предприятия</q>. На хостах класса **s2.small** смогут одновременно работать до 50 пользователей. Класс **s2.medium** рекомендуется использовать, если с базой будут работать 50 и более пользователей. Размер хранилища следует выбирать исходя из размеров вашей информационной базы — учитывайте возможный рост объемов данных.

## Создайте кластер {{ mpg-name }} {#create-cluster}

{% list tabs group=instructions %}

- Вручную {#manual}

    [Создайте](../../managed-postgresql/operations/cluster-create.md#create-cluster) кластер {{ mpg-name }} любой подходящей конфигурации со следующими настройками:

    * **{{ ui-key.yacloud.mdb.forms.base_field_environment }}** — `PRODUCTION`.
    * **{{ ui-key.yacloud.mdb.forms.base_field_version }}** — версия {{ PG }} для работы с системой <q>1С:Предприятия</q>. Название таких версий заканчивается на `-1с`.
    * **{{ ui-key.yacloud.mdb.forms.section_resource }}** — не ниже `s2.small`.
    * **{{ ui-key.yacloud.mdb.forms.section_host }}** — добавьте не меньше двух дополнительных хостов, разместив их в разных зонах доступности. Это обеспечит отказоустойчивость кластера. Репликация между хостами будет настроена автоматически. Подробнее см. в разделе [{#T}](../../managed-postgresql/concepts/replication.md).

- {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

    1. Скачайте в ту же рабочую директорию файл конфигурации [postgresql-1c.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/postgresql-1c.tf).

        В этом файле описаны:

        * [сеть](../../vpc/concepts/network.md#network);
        * [подсеть](../../vpc/concepts/network.md#subnet);
        * [группа безопасности](../../vpc/concepts/security-groups.md) и правило, разрешающее подключение к кластеру;
        * кластер {{ mpg-name }} для <q>1С:Предприятия</q> с базой данных и пользователем.

    1. Укажите параметры инфраструктуры в файле конфигурации `postgresql-1c.tf` в блоке `locals`:

        * `cluster_name` — имя кластера.
        * `pg_version` — версия {{ PG }} для работы с системой <q>1С:Предприятия</q>. Название таких версий заканчивается на `-1с`.
        * `db_name` — имя базы данных.
        * `username` и `password` — имя и пароль пользователя-владельца базы данных.

    1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

       ```bash
       terraform validate
       ```

       Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Создайте необходимую инфраструктуру:

       {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

       {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

Создание кластера БД может занять несколько минут.

## Подключите базу к <q>1С:Предприятию</q> {#connect-to-1c}

Подключите созданную базу в качестве информационной базы <q>1С:Предприятия</q>. При добавлении базы используйте следующие параметры:

* **Защищенное соединение** — отключено.
* **Тип СУБД** — `PostgreSQL`.
* **Сервер баз данных** — `с-<идентификатор_кластера>.rw.{{ dns-zone }} port={{ port-mpg }}`.
* **Имя базы данных** — имя базы данных, указанное при создании кластера.
* **Пользователь базы данных** — имя пользователя-владельца базы данных.
* **Пароль пользователя** — пароль пользователя-владельца базы данных.
* **Создать базу данных в случае ее отсутствия** — отключено.

### Расширения {{ PG }} для поддержки системы <q>1С:Предприятие</q> {#extensions}

Список расширений, которые установлены в кластерах PostgreSQL версии {{ pg.versions.console.str-1c }}:

* [online_analyze](https://postgrespro.ru/docs/postgrespro/10/online-analyze)

* [plantuner](https://postgrespro.ru/docs/postgrespro/10/plantuner)

* [fasttrun](https://postgrespro.ru/docs/postgrespro/10/fasttrun)

* [fulleq](https://postgrespro.ru/docs/postgrespro/10/fulleq)

* [mchar](https://postgrespro.ru/docs/postgrespro/10/mchar)

## Удалите созданные ресурсы {#clear-out}

Удалите ресурсы, которые вы больше не будете использовать, чтобы за них не списывалась плата:

{% list tabs group=instructions %}

- Вручную {#manual}

    [Удалите кластер {{ mpg-name }}](../../managed-postgresql/operations/cluster-delete.md).

- {{ TF }} {#tf}

    Чтобы удалить инфраструктуру, [созданную с помощью {{ TF }}](#create-cluster):

    1. В терминале перейдите в директорию с планом инфраструктуры.
    1. Удалите конфигурационный файл `postgresql-1c.tf`.
    1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        Все ресурсы, которые были описаны в конфигурационном файле `postgresql-1c.tf`, будут удалены.

{% endlist %}
