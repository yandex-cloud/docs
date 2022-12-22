# Создание кластера {{ PG }} для <q>1С:Предприятия</q>

{{ mpg-name }} позволяет создавать отказоустойчивые кластеры {{ PG }}, оптимизированные для работы с системой <q>1С:Предприятие</q>. Для этого в сервисе поддерживаются версии PostgreSQL {{ pg.versions.console.str-1c }}, в которых установлены все необходимые [расширения](#extensions) и изменена конфигурация пулера соединений.

{% note warning %}

Систему <q>1С:Предприятие</q> можно подключить только к кластерам версии {{ pg.versions.console.str-1c }}.

{% endnote %}

При выборе [класса хоста](../../managed-postgresql/concepts/instance-types.md) ориентируйтесь на количество пользователей вашей инсталляции <q>1С:Предприятия</q>. На хостах класса **s2.small** смогут одновременно работать до 50 пользователей. Класс **s2.medium** рекомендуется использовать, если с базой будут работать 50 и более пользователей. Размер хранилища следует выбирать исходя из размеров вашей информационной базы — учитывайте возможный рост объемов данных.

## Создайте кластер {{ mpg-name }} {#create-cluster}

{% list tabs %}

- Вручную

    [Создайте](../../managed-postgresql/operations/cluster-create.md#create-cluster) кластер {{ mpg-name }} любой подходящей конфигурации со следующими настройками:

    * **Окружение** — `PRODUCTION`.
    * **Версия** — версия {{ PG }} для работы с системой <q>1С:Предприятия</q>. Название таких версий заканчивается на `-1с`.
    * **Класс хоста** — не ниже `s2.small`.
    * **Хосты** — добавьте не меньше двух дополнительных хостов, разместив их в разных зонах доступности. Это обеспечит отказоустойчивость кластера. Репликация между хостами будет настроена автоматически. Подробнее см. в разделе [{#T}](../../managed-postgresql/concepts/replication.md).

- С помощью {{ TF }}

    1. Если у вас еще нет {{ TF }}, {% if audience != "internal" %}[установите его](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform){% else %}установите его{% endif %}.
    1. Скачайте [файл с настройками провайдера](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf). Поместите его в отдельную рабочую директорию и {% if audience != "internal" %}[укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider){% else %}укажите значения параметров{% endif %}.
    1. Скачайте в ту же рабочую директорию файл конфигурации [postgresql-1c.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/postgresql-1c.tf).

        В этом файле описаны:

        * {% if audience != "internal" %}[сеть](../../vpc/concepts/network.md#network){% else %}сеть{% endif %};
        * {% if audience != "internal" %}[подсеть](../../vpc/concepts/network.md#subnet){% else %}подсеть{% endif %};
        * {% if audience != "internal" %}[группа безопасности](../../vpc/concepts/security-groups.md){% else %}группа безопасности{% endif %} и правило, разрешающее подключение к кластеру;
        * кластер {{ mpg-name }} для <q>1С:Предприятия</q> с базой данных и пользователем.

    1. Укажите параметры инфраструктуры в файле конфигурации `postgresql-1c.tf` в блоке `locals`:

        * `cluster_name` — имя кластера.
        * `pg_version` — версия {{ PG }} для работы с системой <q>1С:Предприятия</q>. Название таких версий заканчивается на `-1с`.
        * `db_name` — имя базы данных.
        * `username` и `password` — имя и пароль пользователя-владельца базы данных.

    1. Выполните команду `terraform init` в директории с конфигурационным файлом. Эта команда инициализирует провайдера, указанного в конфигурационных файлах, и позволяет работать с ресурсами и источниками данных провайдера.
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
* **Сервер баз данных** — `с-<идентификатор кластера>.rw.{{ dns-zone }} port={{ port-mpg }}`.
* **Имя базы данных** — имя базы данных, указанное при создании кластера.
* **Пользователь базы данных** — имя пользователя-владельца базы данных.
* **Пароль пользователя** — пароль пользователя-владельца базы данных.
* **Создать базу данных в случае ее отсутствия** — отключено.

### Расширения {{ PG }} для поддержки системы <q>1С:Предприятие</q> {#extensions}

Список расширений, которые установлены в кластерах PostgreSQL версии {{ pg.versions.console.str-1c }}:

* [online_analyze]{% if lang == "en" %}(https://postgrespro.ru/docs/postgrespro/10/online-analyze?lang=en){% endif %}{% if lang == "ru" %}(https://postgrespro.ru/docs/postgrespro/10/online-analyze){% endif %}

* [plantuner]{% if lang == "en" %}(https://postgrespro.ru/docs/postgrespro/10/plantuner?lang=en){% endif %}{% if lang == "ru" %}(https://postgrespro.ru/docs/postgrespro/10/plantuner){% endif %}

* [fasttrun]{% if lang == "en" %}(https://postgrespro.ru/docs/postgrespro/10/fasttrun?lang=en){% endif %}{% if lang == "ru" %}(https://postgrespro.ru/docs/postgrespro/10/fasttrun){% endif %}

* [fulleq]{% if lang == "en" %}(https://postgrespro.ru/docs/postgrespro/10/fulleq?lang=en){% endif %}{% if lang == "ru" %}(https://postgrespro.ru/docs/postgrespro/10/fulleq){% endif %}

* [mchar]{% if lang == "en" %}(https://postgrespro.ru/docs/postgrespro/10/mchar?lang=en){% endif %}{% if lang == "ru" %}(https://postgrespro.ru/docs/postgrespro/10/mchar){% endif %}

## Удалите созданные ресурсы {#clear-out}

{% list tabs %}

- Вручную

    Если созданные ресурсы вам больше не нужны, [удалите кластер {{ mpg-name }}](../../managed-postgresql/operations/cluster-delete.md).

- С помощью {{ TF }}

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
