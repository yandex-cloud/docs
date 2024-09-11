# Права доступа к объектам

Разграничение прав доступа в {{ datalens-short-name }} реализовано на уровне объектов и папок.
К каждому объекту и папке можно назначать пользователю права доступа, которые определяют допустимые операции. Если вы создали или скопировали папку или объект, то у них будут те же права, что и у родительской папки, в которой они будут размещены.

Вы можете предоставить пользователю доступ к папке или к любому объекту сервиса:

* [Подключение](../concepts/connection.md)
* [Датасет](../dataset/index.md)
* [Чарт](../concepts/chart/index.md)
* [Дашборд](../concepts/dashboard.md)

{% note info %}

Для разграничения доступа к отдельным полям или их значениям используйте [RLS](./row-level-security.md). В этом случае вы сможете, например, на одном дашборде показывать разную информацию для разных пользователей.

{% endnote %}



Права доступа можно назначить отдельным пользователям или группе **Все**, в которую входят пользователи, прошедшие [аутентификацию](../../iam/concepts/authorization/index.md#authentication). Также пользователь может запросить права доступа самостоятельно через форму запроса. Подробнее в разделе [{#T}](../operations/permission/request.md).


Вы можете назначить следующие права доступа к объектам и папкам в сервисе {{ datalens-short-name }}:

* [{{ permission-execute }}](#permission-execute)
* [{{ permission-read }}](#permission-read)
* [{{ permission-write }}](#permission-write)
* [{{ permission-admin }}](#permission-admin)

### {{ permission-execute }} {#permission-execute}

Пользователь с правом доступа `{{ permission-execute }}` на подключение может выполнять к нему запросы, но не может создавать датасеты. Независимо от прав доступа к датасету, пользователю недоступен список таблиц в датасете и просмотр SQL-подзапроса, на котором основан датасет.

Пользователь с правом доступа `{{ permission-execute }}` к датасету может выполнять к нему запросы, но не может создавать или редактировать чарты и просматривать датасет.

{% note warning %}

Вы можете назначить право доступа `{{ permission-execute }}` только к подключениям и датасетам.

{% endnote %}

Назначение пользователям права доступа `{{ permission-execute }}` дает возможность:

* Уменьшить число запросов в источник, тем самым уменьшить нагрузку на источник подключения.

* Лучше контролировать данные, которые разрешено показывать из датасета. Можно скрыть часть полей из источника, чтобы пользователь не мог посмотреть весь перечень полей.

* Ограничить создание подзапросов к исходной БД. Пользователь с правом `{{ permission-execute }}` не может писать подзапросы.

### {{ permission-read }} {#permission-read}

Пользователь с правом доступа `{{ permission-read }}` может просматривать дашборды, виджеты, датасеты и папки.

{% note warning %}

Право доступа `{{ permission-read }}` не позволяет копировать датасеты, потому что они содержат настройки [RLS](row-level-security.md). Копирование датасетов доступно при наличии права `{{ permission-write }}` или `{{ permission-admin }}`.

{% endnote %}

### {{ permission-write }} {#permission-write}

Пользователь с правом доступа `{{ permission-write }}` может изменять дашборды, виджеты, подключения, датасеты и папки.

Право доступа `{{ permission-write }}` включает в себя все разрешения права доступа `{{ permission-read }}`.

### {{ permission-admin }} {#permission-admin}

Пользователь с правом доступа `{{ permission-admin }}` может изменять доступные объекты и папки, изменять права доступа.

Право доступа `{{ permission-admin }}` включает в себя все разрешения права доступа `{{ permission-write }}`.


## Таблица прав доступа {#permission-table}

Объект доступа<br/>Действие | {{ permission-execute }} | {{ permission-read }} | {{ permission-write }} | {{ permission-admin }}
----|----|----|----|----
**Папка** |
Просмотр папки | N/A | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg)
Редактирование папки | N/A | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg)
Переименование папки | N/A | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg)
Удаление папки | N/A | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg)
Изменение прав доступа | N/A | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg)
**Подключение** |
Выполнение запросов<br/>к подключению | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg)
Создание датасета<br/>над подключением | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg)
Просмотр параметров<br/>подключения | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg)
Редактирование подключения | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg)
Удаление подключения | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg)
Изменение прав доступа | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg)
**Датасет** |
Выполнение запросов<br/>к датасету | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg)
Создание чарта<br/>над датасетом | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg)
Просмотр датасета | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg)
Редактирование датасета | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg)
Копирование датасета | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg)
Удаление датасета | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg)
Изменение прав доступа | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg)
**Чарт** |
Просмотр чарта | N/A | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg)
Редактирование чарта | N/A | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg)
Копирование чарта | N/A | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg)
Удаление чарта | N/A | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg)
Изменение прав доступа | N/A | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg)
Предоставить публичный доступ | N/A | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg)
**Дашборд** |
Просмотр дашборда | N/A | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg)
Редактирование дашборда | N/A | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg)
Копирование дашборда | N/A | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg)
Удаление дашборда | N/A | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg)
Изменение прав доступа | N/A | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg)
Предоставить публичный доступ | N/A | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg)

{% note info %}

Дублировать (копировать) папки и подключения нельзя при наличии любых прав.

{% endnote %}


## Аудит доступа к объектам {#audit-access}

Пользователь {{ datalens-short-name }} может получить логи доступа к объектам {{ datalens-short-name }} (просмотр, редактирование, удаление).
Чтобы получить логи, [обратитесь в службу технической поддержки]({{ link-console-support }}).




#### Что дальше {#what-is-next}

* [{#T}](../operations/permission/grant.md)
* [{#T}](../operations/permission/revoke.md)
* [{#T}](../operations/permission/request.md)

