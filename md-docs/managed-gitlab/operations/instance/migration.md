# Миграция из {{ GL }} в {{ mgl-name }}

Существуют следующие способы перенести проекты в {{ mgl-name }}:
* [{#T}](#self-migration) — вы экспортируете по отдельности каждый проект из исходного {{ GL }} и импортируете их в {{ mgl-name }} без участия технической поддержки. При этом переносятся основные сущности: репозитории, задачи (issues) с комментариями, мерж-реквесты, метки, вехи, wiki, CI/CD-пайплайны в архивном виде. Переменные CI/CD, вебхуки, триггеры пайплайнов, артефакты и логи заданий не переносятся.
* [{#T}](#support-migration) — поддержка восстанавливает инстанс {{ mgl-name }} из резервной копии вашей пользовательской инсталляции. Переносятся все данные и настройки, в том числе проекты, пользователи, [группы]({{ gl.docs }}/user/group/), права доступа, пайплайны.

## Самостоятельная миграция {#self-migration}

Этот способ подходит для переноса проектов из любого {{ GL }}, в том числе из {{ GL }}.com, выделенного инстанса {{ GL }}.com и инсталляций, управляемых пользователем (self-managed).

1. Экспортируйте проект из исходного инстанса {{ GL }}:
    1. Откройте проект в исходном {{ GL }}.
    1. В левом меню выберите **Settings** → **General**.
    1. Раскройте раздел **Advanced**.
    1. Нажмите **Export project**.
    1. Дождитесь письма со ссылкой на архив экспорта или обновите страницу настроек и в разделе **Export project** нажмите **Download export**.
1. [Создайте](instance-create.md) инстанс {{ mgl-name }}.
1. По умолчанию в инстансе {{ mgl-name }} импорт из внешних источников ограничен. Чтобы включить его:
    1. Откройте административную панель {{ GL }}.
    1. Перейдите в **Admin Area** → **Settings** → **General**.
    1. Раскройте раздел **Import and export settings**.
    1. В разделе **Allowed import sources** убедитесь, что включен источник **GitLab export**. Если источник отсутствует, добавьте его вручную.
    1. Нажмите **Save changes**.
1. Импортируйте проект в инстанс {{ mgl-name }}:
    1. В правом верхнем углу нажмите ![image](../../../_assets/console-icons/plus.svg) **Create new...** и выберите **New project/repository**.
    1. Выберите **Import project**.
    1. В разделе **Import project from** выберите **GitLab export**.
    1. Введите название проекта и URL, затем выберите файл экспорта, полученный на предыдущем шаге.
    1. Нажмите **Import project**.
1. Последовательно перенесите каждый проект {{ GL }}.

Подробности читайте в документации {{ GL }}:
* [Import and export settings]({{ gl.docs }}/administration/settings/import_and_export_settings/)
* [Migrate {{ GL }} data by using file exports]({{ gl.docs }}/user/project/settings/import_export/)

## Миграция с помощью технической поддержки {#support-migration}

Перед началом работы ознакомьтесь с [порядком предоставления услуги](../../concepts/migration.md) по миграции из пользовательской инсталляции {{ GL }} в сервис {{ mgl-name }}.

{% note info %}

Услуга по миграции находится на стадии [Preview](../../../overview/concepts/launch-stages.md).

{% endnote %}

Чтобы перенести данные в инстанс {{ mgl-name }}:
1. [Создайте](instance-create.md) инстанс {{ mgl-name }}.
1. Добавьте в инстанс {{ mgl-name }} те же настройки, что есть в пользовательской инсталляции. Например, [OmniAuth]({{ gl.docs }}/integration/omniauth) или [ограничения прав доступа для групп]({{ gl.docs }}/user/group/access_and_permissions), если вы их использовали. Такие сущности, как пользователи, группы, пайплайны, будут перенесены позднее во время работы с резервной копией пользовательской инсталляции.
1. Узнайте версию {{ GL }} в пользовательской инсталляции. Для корректной миграции версия пользовательской инсталляции должна совпадать с версией {{ mgl-name }}.

   1. Откройте пользовательскую инсталляцию {{ GL }}.
   1. В меню слева нажмите **Help**.

      Во всплывающем окне отобразится версия {{ GL }}.

1. Протестируйте миграцию:

   1. [Создайте резервную копию]({{ gl.docs }}/administration/backup_restore/backup_gitlab#simple-back-up-procedure) пользовательской инсталляции и конфигурационных файлов.
   1. [Передайте технической поддержке]({{ link-console-support }}) полученную резервную копию и версию {{ GL }} в пользовательской инсталляции. Техническая поддержка восстановит инстанс из резервной копии в {{ mgl-name }}.
   1. После того как поддержка сообщит, что инстанс восстановлен, [откройте его](instance-list.md#get) и убедитесь, что в {{ mgl-name }}:

      * присутствуют все нужные настройки, данные и проекты;
      * вы можете отправлять коммиты и обновлять ветки.

1. Выполните промышленную миграцию:

   1. Сообщите технической поддержке дату, когда вы планируете провести миграцию.
   1. Накануне дня миграции [переведите пользовательскую инсталляцию]({{ gl.docs }}/administration/read_only_gitlab) {{ GL }} в режим `Read only`.
   1. Создайте резервную копию пользовательской инсталляции и конфигурационных файлов.
   1. Передайте эту копию технической поддержке.
   1. В назначенный день миграции техническая поддержка восстанавливает инстанс из резервной копии в {{ mgl-name }}.

1. (Опционально) Настройте доменное имя инстанса:

   1. Если для пользовательской инсталляции вы использовали [кастомизированное доменное имя]({{ gl.docs }}/administration/dedicated/configure_instance/network_security/#custom-domains) и хотите его сохранить, сообщите это доменное имя технической поддержке. Она настроит его для инстанса {{ mgl-name }}.
   1. В пользовательской инсталляции [настройте DNS-запись]({{ gl.docs }}/omnibus/settings/dns/) `CNAME`, чтобы перенаправлять пользователей с [домена инстанса](../../concepts/index.md#config) {{ mgl-name }} на ваш кастомизированный домен.

### См. также {#see-also}

* [{#T}](../../concepts/migration.md)
* [{#T}](../../concepts/index.md)
* [{#T}](instance-create.md)
* [{#T}](instance-list.md)

### Документация {{ GL }} {#gl-docs}

* [Import and export settings]({{ gl.docs }}/administration/settings/import_and_export_settings/)
* [Migrate {{ GL }} data by using file exports]({{ gl.docs }}/user/project/settings/import_export/)
* [Groups]({{ gl.docs }}/user/group/)
* [OmniAuth]({{ gl.docs }}/integration/omniauth)
* [Group access and permissions]({{ gl.docs }}/user/group/access_and_permissions)
* [Back up GitLab]({{ gl.docs }}/administration/backup_restore/backup_gitlab)
* [Place GitLab into a read-only state]({{ gl.docs }}/administration/read_only_gitlab)
* [GitLab Dedicated network access and security]({{ gl.docs }}/administration/dedicated/configure_instance/network_security/)
* [DNS settings]({{ gl.docs }}/omnibus/settings/dns/)