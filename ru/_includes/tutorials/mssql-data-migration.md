Перенести данные из кластера {{ MS }} в кластер {{ mms-name }} с минимальным временем простоя можно с помощью [репликации транзакций (transactional replication)]{% if lang == "ru" %}(https://docs.microsoft.com/ru-ru/sql/relational-databases/replication/transactional/transactional-replication){% endif %}{% if lang == "en" %}(https://docs.microsoft.com/en-us/sql/relational-databases/replication/transactional/transactional-replication){% endif %}. Такой тип репликации поддерживается с 2016-й версии {{ MS }} и позволяет мигрировать данные на более поздние версии SQL Server в кластере {{ mms-name }}.

При репликации транзакций:

* При инициализации [агент моментальных снимков]{% if lang == "ru" %}(https://docs.microsoft.com/ru-ru/sql/relational-databases/replication/agents/replication-agents-overview#snapshot-agent){% endif %}{% if lang == "en" %}(https://docs.microsoft.com/en-us/sql/relational-databases/replication/agents/replication-agents-overview#snapshot-agent){% endif %} создает снапшот базы данных со  схемой и файлами данных таблиц и других объектов и копирует его с [издателя (publisher)]{% if lang == "ru" %}(https://docs.microsoft.com/ru-ru/sql/relational-databases/replication/publish/replication-publishing-model-overview#publisher){% endif %}{% if lang == "en" %}(https://docs.microsoft.com/en-us/sql/relational-databases/replication/publish/replication-publishing-model-overview#publisher){% endif %} на [распространителя (distributor)]{% if lang == "ru" %}(https://docs.microsoft.com/ru-ru/sql/relational-databases/replication/publish/replication-publishing-model-overview#distributor){% endif %}{% if lang == "en" %}(https://docs.microsoft.com/en-us/sql/relational-databases/replication/publish/replication-publishing-model-overview#distributor){% endif %}, который управляет переносом данных.

   {% note info %}
   
   Так как при создании снапшота используются блокировки таблиц, то рекомендуется выполнять инициализацию в период минимальных нагрузок на базу.
   
   {% endnote %}

*  [Агент чтения журнала (Log Reader Agent)]{% if lang == "ru" %}(https://docs.microsoft.com/ru-ru/sql/relational-databases/replication/agents/replication-agents-overview#log-reader-agent){% endif %}{% if lang == "en" %}(https://docs.microsoft.com/en-us/sql/relational-databases/replication/agents/replication-agents-overview#log-reader-agent){% endif %} переносит транзакции из лога транзакций на распространителя.
* Снапшот и транзакции из распространителя переносятся с помощью [агента распространителя (Distribution Agent)]{% if lang == "ru" %}(https://docs.microsoft.com/ru-ru/sql/relational-databases/replication/agents/replication-agents-overview#distribution-agent){% endif %}{% if lang == "en" %}(https://docs.microsoft.com/en-us/sql/relational-databases/replication/agents/replication-agents-overview#distribution-agent){% endif %} к [подписчику (subscriber)]{% if lang == "ru" %}(https://docs.microsoft.com/ru-ru/sql/relational-databases/replication/publish/replication-publishing-model-overview#subscribers){% endif %}{% if lang == "en" %}(https://docs.microsoft.com/en-us/sql/relational-databases/replication/publish/replication-publishing-model-overview#subscribers){% endif %}.

В такой схеме издатель, распространитель и оба агента располагаются в кластере-источнике, а подписчик — в кластере-приемнике. Возможны и другие варианты распределения ролей, например выделенные сервера для распространителя.

При репликации есть следующие ограничения:

* Однонаправленность — изменения на кластере-приемнике не будут реплицироваться в кластер-источник.
* Во время работы публикации нельзя менять схему на кластере-приемнике.

{% note info %}

Выполнение объемных транзакций на кластере-источнике может замедлить репликацию.

{% endnote %}

Чтобы мигрировать базу данных из кластера-источника {{ MS }} в кластер-приемник {{ mms-name }}:

1. [Создайте публикацию на кластере-источнике](#create-publication).
1. [Создайте подписку на кластере-источнике](#create-subscription).
1. [Остановите процесс репликации и перенесите нагрузку](#transfer-load).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

1. [Создайте кластер {{ mms-name }}](../../managed-sqlserver/operations/cluster-create.md) любой подходящей конфигурации. При этом:

    * Укажите то же имя базы данных, что и на кластере-источнике. 
    * Хост-мастер кластера-приемника должен находиться в публичном доступе для подключения к нему кластера-источника.
    * Версия {{ MS }} должна быть не ниже, чем на кластере-источнике.

1. Проверьте, что вы можете [подключиться к кластеру-приемнику](../../managed-sqlserver/operations/connect.md#connection-ide) и к кластеру-источнику с помощью {{ ssms }}.

## Создайте публикацию на кластере-источнике {#create-publication}

1. Подключитесь к кластеру-источнику из {{ ssms }}.
1. Разверните список объектов сервера в Object Explorer.
1. Откройте контекстное меню для директории **Replication** и выберите **New → Publication**.
1. Пройдите все шаги мастера создания публикации, в том числе:
   1. Укажите, что сам сервер будет выступать в качестве распространителя.
   1. Укажите директорию для снапшота базы данных.
   1. Выберите базу данных, которую необходимо мигрировать.
   1. Выберите тип публикации **Transactional replication**.
   1. Выберите в списке статей для публикации все сущности базы данных, которые требуется реплицировать (таблицы, представления, хранимые процедуры).
   1. Выберите время создания снапшота базы данных.
   
   Подробнее см. в [документации {{ MS }}]{% if lang == "ru" %}(https://docs.microsoft.com/ru-ru/sql/relational-databases/replication/publish/create-a-publication){% endif %}{% if lang == "en" %}(https://docs.microsoft.com/en-us/sql/relational-databases/replication/publish/create-a-publication){% endif %}.

1. Нажмите кнопку **Finish**.

{% note info %}

* При переносе нескольких баз для каждой из них создайте отдельную публикацию.

* Вам потребуются права привилегированного пользователя на все таблицы, выбранные для публикации.

{% endnote %}

## Создайте подписку на кластере-источнике {#create-subscription}

1. Подключитесь к кластеру-источнику из {{ ssms }}.
1. Разверните список объектов сервера в **Object Explorer**.
1. Откройте контекстное меню для директории **Replication** и выберите **New → Subscription**.
1. Пройдите все шаги мастера создания подписки, в том числе:
   1. Для агента-распространителя выберите **Run all agents at the Distributor** (запуск на кластере-источнике).
   1. Добавьте подписчика и укажите [данные для подключения к хосту-мастеру кластера-приемника](../../managed-sqlserver/operations/connect.md#connection-ide).
   1. Выберите для подписчика базу данных кластера-приемника.
   1. В параметрах безопасности **Distribution Agent Security** в блоке **Connect to the Subscriber** укажите имя и пароль учетной записи владельца базы данных на кластере-приемнике.

   Подробнее см. в [документации {{ MS }}]{% if lang == "ru" %}(https://docs.microsoft.com/ru-ru/sql/relational-databases/replication/create-a-push-subscription){% endif %}{% if lang == "en" %}(https://docs.microsoft.com/en-us/sql/relational-databases/replication/create-a-push-subscription){% endif %}.

 1. Нажмите кнопку **Finish**.

Запустится процесс репликации. Чтобы следить за его статусом, [запустите монитор]{% if lang == "ru" %}(https://docs.microsoft.com/ru-ru/sql/relational-databases/replication/monitor/start-the-replication-monitor){% endif %}{% if lang == "en" %}(https://docs.microsoft.com/en-us/sql/relational-databases/replication/monitor/start-the-replication-monitor){% endif %} и [добавьте подписку для отслеживания]{% if lang == "ru" %}(https://docs.microsoft.com/ru-ru/sql/relational-databases/replication/monitor/add-and-remove-publishers-from-replication-monitor){% endif %}{% if lang == "en" %}(https://docs.microsoft.com/en-us/sql/relational-databases/replication/monitor/add-and-remove-publishers-from-replication-monitor){% endif %}.

## Остановите процесс репликации и перенесите нагрузку {#transfer-load}

1. Проверьте, что на кластере-приемнике доступны все перенесенные данные с кластера-источника.
1. Переведите кластер-источник в режим <q>только чтение</q>:
   1. Откройте {{ ssms }}.
   1. Откройте контекстное меню для реплицируемой базы данных, затем выберите пункт **Properties**.
   1. Выберите **Database Properties → Options** и в блоке **State** поменяйте значение **Database Read Only** на **True**.
1. [Остановите репликацию]{% if lang == "ru" %}(https://docs.microsoft.com/ru-ru/sql/relational-databases/replication/agents/start-and-stop-a-replication-agent-sql-server-management-studio){% endif %}{% if lang == "en" %}(https://docs.microsoft.com/en-us/sql/relational-databases/replication/agents/start-and-stop-a-replication-agent-sql-server-management-studio){% endif %} на кластере-источнике.
1. Удалите подписку и публикацию на кластере-источнике. Подтвердите разрешение {{ ssms }} удалить подписчика на кластере-приемнике.
1. Перенесите нагрузку на кластер-приемник.

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы, [удалите](../../managed-sqlserver/operations/cluster-delete.md) их.

Если вы зарезервировали статический публичный IP-адрес, [удалите](../../vpc/operations/address-delete.md) его.
