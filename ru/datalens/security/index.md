# Управление доступом к DataLens


Доступ к сервису {{ datalens-full-name }} регулируется путем назначения прав:

* для экземпляра {{ datalens-short-name }} на уровне организации — через сервис [организации](../concepts/organizations.md);
* для экземпляра {{ datalens-short-name }} на уровне каталога облака — через [консоль]({{ link-console-main }}) {{ yandex-cloud }}.

Чтобы предоставить доступ, назначьте пользователю одну из ролей {{ datalens-short-name }}.



Разграничение прав доступа в {{ datalens-short-name }} реализовано на уровне объектов и папок.
На каждый объект и папку можно назначать пользователю права доступа, которые определяют допустимые операции. Если вы создали или скопировали папку или объект, то у них будут те же права, что и у родительской папки, в которой они будут размещены.

Вы можете предоставить пользователю доступ к папке или к любому объекту сервиса:
* Подключение
* Датасет
* Чарт
* Дашборд


Также пользователь может запросить права доступа самостоятельно через форму запроса. Подробнее в разделе [{#T}](../operations/permission/request.md).

## Пользовательские роли {#users-roles}

Позволяют определить права пользователя в экземпляре {{ datalens-short-name }}:

* `{{ roles-datalens-instances-user }}` — пользователь {{ datalens-short-name }} с правами на создание, чтение и изменение объектов согласно [правам доступа на объекты](#permissions).
* `{{ roles-datalens-instances-admin }}` — администратор экземпляра {{ datalens-short-name }}. Роль автоматически присваивается создателю экземпляра. Администратор обладает правами `{{ roles-datalens-instances-user }}`. Ему доступны настройки [{{ datalens-short-name }}]({{ link-datalens-settings }}).

Пользовательские роли назначаются:

* для экземпляра {{ datalens-short-name }} на уровне организации — через сервис [организации](../concepts/organizations.md);
* для экземпляра {{ datalens-short-name }} на уровне каталога облака — через [консоль]({{ link-console-main }}) {{ yandex-cloud }}.

## Добавление пользователя {#add-new-user}

Добавлять можно [пользователей с аккаунтом на Яндексе](#passport-user) и [федеративных пользователей](#federated-user).

### Добавить пользователя с аккаунтом на Яндексе {#passport-user}

Чтобы добавить пользователя и предоставить ему доступ к сервису {{ datalens-short-name }}:

{% list tabs %}

- В организацию

  {% include [grant-role-console-first-steps](../../_includes/datalens/operations/datalens-add-user-organization.md) %}

- В облако

  1. {% include [grant-role-console-first-steps](../../_includes/iam/grant-role-console-first-steps.md) %}
  1. На странице **Пользователи и роли** в правом верхнем углу нажмите **Добавить пользователя**.
  1. Введите электронную почту пользователя в Яндексе.
  1. Нажмите кнопку **Добавить**. При добавлении нового пользователя в облако ему автоматически назначается роль участника облака — [`resource-manager.clouds.member`](../../iam/concepts/access-control/roles.md#member).

     {% note info %}
    
     Время до появления логина добавленного пользователя в форме выдачи прав доступа может достигать нескольких часов.
    
     {% endnote %}

  1. {% include [configure-roles-console](../../_includes/iam/configure-roles-console.md) %}
  1. Для добавления роли на облако нажмите значок ![image](../../_assets/plus-sign.svg) в блоке **Роли на облако <имя облака>**.

     Для добавления роли на каталог, выберите каталог и нажмите **Назначить роль** в блоке **Роли в каталогах**.
  1. Выберите `{{ roles-datalens-instances-user }}`  или  `{{ roles-datalens-instances-admin }}` из списка.

{% endlist %}

### Добавить федеративных пользователей {#federated-user}

{% include [include](../../_includes/iam/add-federated-users-before-begin.md) %}

#### Добавить федеративных пользователей в организацию {#federated-user-org}

Чтобы добавить пользователей федерации в организацию и предоставить им доступ к сервису {{ datalens-short-name }}:

1. Добавьте федеративных пользователей:

   {% list tabs %}

   - Консоль управления

     1. Убедитесь, что вы авторизованы в {{ yandex-cloud }} как администратор или владелец требуемой организации (у вашего пользователя есть роль `admin` или `owner` в ней). В верхнем левом углу нажмите ![image](../../_assets/datalens/all-services.svg) и выберите **Ресурсы и управление** → **Управление сервисами организации** или перейдите по [ссылке](https://org.cloud.yandex.ru/users).
     1. В правом верхнем углу нажмите на стрелку возле кнопки **Добавить пользователя**. Выберите **Добавить федеративных пользователей**.
     1. Выберите федерацию, из которой необходимо добавить пользователей.
     1. Перечислите Name ID пользователей, разделяя их переносами строк.
     1. Нажмите кнопку **Добавить**. Пользователи будут подключены к организации.

   - CLI

     {% include [cli-install](../../_includes/cli-install.md) %}

     {% include [default-catalogue](../../_includes/default-catalogue.md) %}

     1. Посмотрите описание команды добавления пользователей:

        ```
        yc organization-manager federation saml add-user-accounts --help
        ```

     1. Добавьте пользователей, перечислив их Name ID через запятую:

        ```
        yc organization-manager federation saml add-user-accounts --name my-federation \
          --name-ids=alice@example.com,bob@example.com,charlie@example.com
        ```

   - API

     1.  Сформируйте файл с телом запроса, например `body.json`. В теле запроса укажите массив Name ID пользователей, которых необходимо добавить:

         ```json
         {
           "nameIds": [
             "alice@example.com",
             "bob@example.com",
             "charlie@example.com"
           ]
         }
         ```
     1.  Отправьте запрос, указав в параметрах идентификатор федерации:

         ```bash
         $ curl -X POST \
           -H "Content-Type: application/json" \
           -H "Authorization: Bearer <IAM-токен>" \
           -d '@body.json' \
           https://organization-manager.api.cloud.yandex.net/organization-manager/v1/saml/federations/<ID федерации>:addUserAccounts
         ```

   {% endlist %}

1. Назначьте пользователям роли для доступа к сервису {{ datalens-short-name }}:

     1. {% include [configure-roles-console](../../_includes/iam/configure-roles-console.md) %}
     1. В окне **Настройка прав доступа** нажмите **![image](../../_assets/plus-sign.svg) Добавить роль**. Выберите роль `{{ roles-datalens-instances-user }}` из списка.
     1. Нажмите **Сохранить**. Пользователь получит доступ к сервису {{ datalens-short-name }}.

#### Добавить федеративных пользователей в облако {#federated-user-cloud}

Чтобы добавить пользователей федерации в облако и предоставить им доступ к сервису {{ datalens-short-name }}::

1. Добавьте федеративных пользователей:

   {% include [include](../../_includes/iam/add-federated-users-instruction.md) %}

1. {% include [configure-roles-console](../../_includes/iam/configure-roles-console.md) %}
1. Для добавления роли на облако нажмите значок ![image](../../_assets/plus-sign.svg) в блоке **Роли на облако <имя облака>**.

   Для добавления роли на каталог, выберите каталог и нажмите **Назначить роль** в блоке **Роли в каталогах**.

1. Выберите `{{ roles-datalens-instances-user }}` из списка. 

Подробнее о назначении ролей в {{ yandex-cloud }} в разделе [Роли](../../iam/concepts/access-control/roles.md).


## Права доступа на объекты {#permissions}


Права доступа можно назначить отдельным пользователям или группе **Все**, в которую входят пользователи, прошедшие [аутентификацию](../../iam/concepts/authorization/index.md#authentication).


Вы можете назначить следующие права доступа на объекты и папки в сервисе {{ datalens-short-name }}:

* [{{ permission-execute }}](#permission-execute)
* [{{ permission-read }}](#permission-read)
* [{{ permission-write }}](#permission-write)
* [{{ permission-admin }}](#permission-admin)

### {{ permission-execute }} {#permission-execute}

Пользователь с правом доступа `{{ permission-execute }}` на подключение может выполнять к нему запросы, но не может создавать датасеты. Независимо от прав на датасет, пользователю не доступен список таблиц в датасете и просмотр SQL-подзапроса, на котором основан датасет.

Пользователь с правом доступа `{{ permission-execute }}` на датасет может выполнять к нему запросы, но не может создавать или редактировать чарты и просматривать датасет.  

{% note warning %}

Вы можете назначить право доступа `{{ permission-execute }}` только на подключения и датасеты.

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
Удаление датасета | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg)
Изменение прав доступа | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg)
**Чарт** |
Просмотр чарта | N/A | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg)
Редактирование чарта | N/A | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg)
Удаление чарта | N/A | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg)
Изменение прав доступа | N/A | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg)
Предоставить публичный доступ | N/A | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg)
**Дашборд** |
Просмотр дашборда | N/A | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg)
Редактирование дашборда | N/A | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg)
Удаление дашборда | N/A | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg)
Изменение прав доступа | N/A | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg)
Предоставить публичный доступ | N/A | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg)


## Аудит доступа к объектам {#audit-access}

Пользователь {{ datalens-short-name }} может получить логи доступа к объектам {{ datalens-short-name }} (просмотр, редактирование, удаление).
Чтобы получить логи, [обратитесь в службу технической поддержки]({{ link-console-support }}).




#### Что дальше {#what-is-next}

* [{#T}](../operations/permission/grant.md)
* [{#T}](../operations/permission/revoke.md)
* [{#T}](../operations/permission/request.md)
* [{#T}](../operations/dataset/manage-row-level-security.md)

