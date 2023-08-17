# Роли и права доступа в {{ tracker-name }}

{{ tracker-full-name }} — один из [сервисов](../organization/concepts/manage-services.md), которые можно подключить к организации {{ yandex-cloud }}. Администратор организации, который подключил {{ tracker-name }}, также становится [администратором {{ tracker-name }}](#admin).

{% note info %}

Если пользователь создает новую организацию при [подключении {{ tracker-name }}](enable-tracker.md), он становится владельцем организации и администратором {{ tracker-name }}.

{% endnote %}

Администратор может добавить в {{ tracker-name }} других пользователей и настроить для них права доступа. Подробнее о добавлении пользователей читайте в разделе [{#T}](add-users.md).

## Управление доступом {#access-management}

Права доступа пользователей к {{ tracker-name }} делятся на два типа:

* Глобальный уровень доступа к {{ tracker-name }}:
    * [Администратор](#admin). 
    * [Сотрудник с полным доступом](access.md#set).
    * [Сотрудник с правом <q>{{ ui-key.startrek.blocks-desktop_roles-table.read }}</q>](access.md#readonly).

* Права доступа к отдельным элементам структуры {{ tracker-name }}:
    * [Задачи очереди](manager/queue-access.md). Права на создание, просмотр и редактирование задач  может настроить владелец очереди или другой пользователь, которому владелец разрешил изменять [настройки очереди](manager/edit-queue-general.md).
    
       Доступ к задачам очереди можно настроить для отдельных пользователей, групп и ролей:
        * **{{ ui-key.startrek-backend.roles.role.name.access }}** — пользователи, перечисленные в поле **{{ ui-key.startrek-backend.fields.issue.access }}** задачи;
        * **{{ ui-key.startrek-backend.roles.role.name.follower-key-value }}** — пользователи, подписавшиеся на задачу;
        * **{{ ui-key.startrek-backend.roles.role.name.author }}** — автор задачи;
        * **{{ ui-key.startrek-backend.roles.role.name.assignee }}** — исполнитель задачи;
        * **{{ ui-key.startrek-backend.roles.role.name.queue-lead }}**;
        * **{{ ui-key.startrek-backend.roles.role.name.team-member }}** — пользователи, добавленные в [команду очереди](manager/queue-team.md).
    
        Чтобы ограничить доступ пользователей к определенным задачам внутри очереди, можно использовать [компоненты](manager/queue-access.md#access-components).

    * [Фильтры](user/create-filter.md#nastroit-dostup-k-filtru) и [дашборды](user/share-dashboard.md#section_k2z_1nk_pz). Права для доступа к фильтрам и дашбордам может настроить их владелец или другой пользователь, которому владелец выдал разрешения.

{% note info %}

При работе с [{{ tracker-full-name }} API](about-api.md) запросы приложений выполняются от имени пользователя {{ tracker-name }}. Чтобы выполнять те или иные действия через API, пользователь, от имени которого выполняется запрос, должен иметь соответствующие права в {{ tracker-name }}. 

Подробнее о получении доступа приложений к {{ tracker-full-name }} API читайте в разделе [{#T}](concepts/access.md).

{% endnote %}

## Уровни доступа {#roles}

Уровень доступа пользователя распространяется на всю структуру {{ tracker-name }}. От уровня доступа зависит, какие действия сможет выполнять пользователь: создавать и редактировать задачи, изменять настройки {{ tracker-name }}. Уровни доступа для пользователей [настраивает администратор](access.md).

#### Администратор {#admin}

Администратор имеет доступ ко всем элементам структуры {{ tracker-name }}. По умолчанию администратором {{ tracker-name }} является пользователь, который создал [организацию {{ yandex-cloud}}](../organization/). 

Чтобы назначить администраторами других сотрудников, используйте [сервис {{ yandex-360 }}](https://yandex.ru/support/business/admin.html).

Действия, доступные администратору:

* Добавление в {{ tracker-name }} [пользователей](add-users.md) и настройка для них [уровня доступа](access.md).
* Управление настройками {{ tracker-name }}: создание новых [статусов](manager/workflow-status-edit.md#create-status), [резолюций](manager/create-resolution.md#create-resolution) и [типов задач](manager/add-ticket-type.md#create-ticket-type), настройка [глобальных полей](user/create-param.md#section_global_field) задач, подключение [репозиториев](manager/add-repository.md).
* Управление [настройками очереди](manager/edit-queue-general.md).
* Привязка к {{ tracker-name }} [платежного аккаунта](billing-account.md), который используется для оплаты услуг. 

    {% note alert %}

    По умолчанию доступ к управлению платежным аккаунтом есть только у его владельца. Для других пользователей [доступ](../billing/security/) к платежному аккаунту можно предоставить через сервис [{{ billing-name }}](../billing/). 

    {% endnote %}


Для создания и редактирования задач администратору также требуется [полный доступ](#full-access) в {{ tracker-name }}.

#### Сотрудники с полным доступом {#full-access}

Сотрудники с полным доступом могут использовать все возможности {{ tracker-full-name }}. 

{% note info %}

Если в вашей организации 6 и более сотрудников с полным доступом, использование сервиса нужно будет [оплачивать](pricing.md) ежемесячно. Небольшие команды могут использовать {{ tracker-name }} бесплатно, если создавать и редактировать задачи будут не более 5 сотрудников.

{% endnote %}

Действия, доступные сотрудникам:

* [Создание](user/create-ticket.md) и [редактирование](user/edit-ticket.md) задач.
* Поиск задач с помощью [конструктора фильтров](user/create-filter.md) и [языка запросов](user/query-filter.md).
* Добавление [комментариев](user/comments.md).
* Создание и настройка [очередей](queue-intro.md). 
  В том числе создание [автодействий](user/autoactions.md), [триггеров](user/trigger.md) и [макросов](manager/create-macroses.md) в очереди.
* Работа с [досками задач](user/agile.md) и [дашбордами](user/dashboard.md).
* Настройка [интерфейса](user/personal.md) и [уведомлений](user/notifications.md).

#### Сотрудники с правом <q>{{ ui-key.startrek.blocks-desktop_roles-table.read }}</q> {#read-only}

Сотрудники, которые работают в режиме <q>{{ ui-key.startrek.blocks-desktop_roles-table.read }}</q>, могут использовать возможности {{ tracker-name }}, связанные с просмотром задач. Для таких сотрудников плата за использование сервиса не взимается.

Если [администратор](#admin) имеет доступ к {{ tracker-name }} в режиме <q>{{ ui-key.startrek.blocks-desktop_roles-table.read }}</q>, он может изменить параметры доступа для своей учетной записи самостоятельно.

Действия, доступные в режиме <q>{{ ui-key.startrek.components_Licenses.department-access-title--readOnly }}</q>:

* Просмотр задач, [дашбордов](user/dashboard.md) и [досок задач](manager/agile.md#sec_boards).
* Поиск задач с помощью [конструктора фильтров](user/create-filter.md) и [языка запросов](user/query-filter.md).
* Просмотр [страниц очередей](manager/quick-filters.md), [статистики](manager/statistics.md) и так далее.
* Настройка [интерфейса](user/personal.md) и [уведомлений](user/notifications.md).