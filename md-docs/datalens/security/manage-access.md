[Документация Yandex Cloud](../../index.md) > [Yandex DataLens](../index.md) > [Управление доступом](index.md) > Доступ к объектам в папках > Права доступа

# Права доступа к объектам


{% note info %}

* Если вы пользуетесь старой навигацией по папкам, в этом разделе вы найдете информацию о разграничении прав доступа к объектам и папкам.

* Если вы работаете с новой объектной моделью DataLens, включающей [воркбуки и коллекции](../workbooks-collections/index.md), перейдите на страницу с описанием [ролей](roles.md).

{% endnote %}


Разграничение прав доступа в DataLens реализовано на уровне папок и объектов. Доступные операции зависят от назначенных прав доступа.

Если вы создаете или копируете папку или объект, то права на них наследуются от родительской папки в момент создания или копирования. Обратите внимание, что права доступа не меняются автоматически при последующем перемещении объектов.


Вы можете предоставить пользователю доступ к папке или к любому объекту сервиса:

* [Подключение](../concepts/connection/index.md)
* [Датасет](../dataset/index.md)
* [Чарт](../concepts/chart/index.md)
* [Дашборд](../concepts/dashboard.md)

{% note info %}

Для разграничения доступа к отдельным полям или их значениям используйте [RLS](row-level-security.md). В этом случае вы сможете, например, на одном дашборде показывать разную информацию для разных пользователей.

{% endnote %}



Права доступа можно назначить отдельным пользователям или группе **Все**, в которую входят пользователи, прошедшие [аутентификацию](../../iam/concepts/authorization/index.md#authentication). Также пользователь может запросить права доступа самостоятельно через форму запроса. Подробнее в разделе [Запрос прав доступа](../operations/permission/request.md).


Вы можете назначить следующие права доступа к объектам и папкам в сервисе DataLens:

* [Исполнение](#permission-execute)
* [Просмотр](#permission-read)
* [Редактирование](#permission-write)
* [Администрирование](#permission-admin)

### Исполнение {#permission-execute}

Пользователь с правом доступа `Исполнение` на подключение может выполнять к нему запросы, но не может создавать датасеты. Независимо от прав доступа к датасету, пользователю недоступен список таблиц в датасете и просмотр SQL-подзапроса, на котором основан датасет.

Пользователь с правом доступа `Исполнение` к датасету может выполнять к нему запросы, но не может создавать или редактировать чарты и просматривать датасет.

{% note warning %}

Вы можете назначить право доступа `Исполнение` только к подключениям и датасетам.

{% endnote %}

Назначение пользователям права доступа `Исполнение` дает возможность:

* Уменьшить число запросов в источник, тем самым уменьшить нагрузку на источник подключения.

* Лучше контролировать данные, которые разрешено показывать из датасета. Можно скрыть часть полей из источника, чтобы пользователь не мог посмотреть весь перечень полей.

* Ограничить создание подзапросов к исходной БД. Пользователь с правом `Исполнение` не может писать подзапросы.

### Просмотр {#permission-read}

Пользователь с правом доступа `Просмотр` может просматривать дашборды, виджеты, датасеты и папки.

{% note warning %}

Право доступа `Просмотр` не позволяет копировать датасеты, потому что они содержат настройки [RLS](row-level-security.md). Копирование датасетов доступно при наличии права `Редактирование` или `Администрирование`.

{% endnote %}

### Редактирование {#permission-write}

Пользователь с правом доступа `Редактирование` может изменять дашборды, виджеты, подключения, датасеты и папки.

Право доступа `Редактирование` включает в себя все разрешения права доступа `Просмотр`.

### Администрирование {#permission-admin}

Пользователь с правом доступа `Администрирование` может изменять доступные объекты и папки, изменять права доступа. Администратор папки может назначать права доступа на все вложенные папки и объекты.

Право доступа `Администрирование` включает в себя все разрешения права доступа `Редактирование`.


## Таблица прав доступа {#permission-table}

Объект доступа<br/>Действие | Исполнение | Просмотр | Редактирование | Администрирование
----|----|----|----|----
**Папка** |
Просмотр папки | N/A | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg)
Редактирование папки | N/A | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg)
Переименование папки | N/A | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg)
Перемещение папки | N/A | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg)
Удаление папки | N/A | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg)
Изменение прав доступа | N/A | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg)
**Подключение** |
Выполнение запросов<br/>к подключению | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg)
Создание датасета<br/>над подключением | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg)
Просмотр параметров<br/>подключения | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg)
Редактирование подключения | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg)
Перемещение подключения | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg)
Удаление подключения | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg)
Изменение прав доступа | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg)
**Датасет** |
Выполнение запросов<br/>к датасету | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg)
Создание чарта<br/>над датасетом | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg)
Просмотр датасета | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg)
Редактирование датасета | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg)
Копирование датасета | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg)
Перемещение датасета | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg)
Удаление датасета | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg)
Изменение прав доступа | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg)
**Чарт** |
Просмотр чарта | N/A | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg)
Редактирование чарта | N/A | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg)
Копирование чарта | N/A | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg)
Удаление чарта | N/A | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg)
Перемещение чарта | N/A | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg)
Изменение прав доступа | N/A | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg)
Предоставить публичный доступ | N/A | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg)
**Дашборд** |
Просмотр дашборда | N/A | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg)
Редактирование дашборда | N/A | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg)
Копирование дашборда | N/A | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg)
Удаление дашборда | N/A | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg)
Перемещение дашборда | N/A | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg)
Изменение прав доступа | N/A | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg)
Предоставить публичный доступ | N/A | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg)
**Отчет** |
Просмотр дашборда | N/A | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg)
Редактирование дашборда | N/A | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg)
Копирование дашборда | N/A | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg)
Удаление дашборда | N/A | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg)
Перемещение дашборда | N/A | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg)
Изменение прав доступа | N/A | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg)

{% note info %}

Дублировать (копировать) папки и подключения нельзя при наличии любых прав.

{% endnote %}


## Аудит доступа к объектам {#audit-access}

Для отслеживания [аудитных логов](../at-ref.md) используется Yandex Audit Trails.




#### Что дальше {#what-is-next}

* [Назначение и изменение прав доступа](../operations/permission/grant.md)
* [Удаление прав доступа](../operations/permission/revoke.md)
* [Запрос прав доступа](../operations/permission/request.md)