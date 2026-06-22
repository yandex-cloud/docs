# Миграция из GitLab в Managed Service for GitLab

Существуют следующие способы перенести проекты в Managed Service for GitLab:
* [Самостоятельная миграция](#self-migration) — вы экспортируете по отдельности каждый проект из исходного GitLab и импортируете их в Managed Service for GitLab без участия технической поддержки. При этом переносятся основные сущности: репозитории, задачи (issues) с комментариями, мерж-реквесты, метки, вехи, wiki, CI/CD-пайплайны в архивном виде. Переменные CI/CD, вебхуки, триггеры пайплайнов, артефакты и логи заданий не переносятся.
* [Миграция с помощью технической поддержки](#support-migration) — поддержка восстанавливает инстанс Managed Service for GitLab из резервной копии вашей пользовательской инсталляции. Переносятся все данные и настройки, в том числе проекты, пользователи, [группы](https://docs.gitlab.com/user/group/), права доступа, пайплайны.

## Самостоятельная миграция {#self-migration}

Этот способ подходит для переноса проектов из любого GitLab, в том числе из GitLab.com, выделенного инстанса GitLab.com и инсталляций, управляемых пользователем (self-managed).

1. Экспортируйте проект из исходного инстанса GitLab:
    1. Откройте проект в исходном GitLab.
    1. В левом меню выберите **Settings** → **General**.
    1. Раскройте раздел **Advanced**.
    1. Нажмите **Export project**.
    1. Дождитесь письма со ссылкой на архив экспорта или обновите страницу настроек и в разделе **Export project** нажмите **Download export**.
1. [Создайте](instance-create.md) инстанс Managed Service for GitLab.
1. По умолчанию в инстансе Managed Service for GitLab импорт из внешних источников ограничен. Чтобы включить его:
    1. Откройте административную панель GitLab.
    1. Перейдите в **Admin Area** → **Settings** → **General**.
    1. Раскройте раздел **Import and export settings**.
    1. В разделе **Allowed import sources** убедитесь, что включен источник **GitLab export**. Если источник отсутствует, добавьте его вручную.
    1. Нажмите **Save changes**.
1. Импортируйте проект в инстанс Managed Service for GitLab:
    1. В правом верхнем углу нажмите ![image](../../../_assets/console-icons/plus.svg) **Create new...** и выберите **New project/repository**.
    1. Выберите **Import project**.
    1. В разделе **Import project from** выберите **GitLab export**.
    1. Введите название проекта и URL, затем выберите файл экспорта, полученный на предыдущем шаге.
    1. Нажмите **Import project**.
1. Последовательно перенесите каждый проект GitLab.

Подробности читайте в документации GitLab:
* [Import and export settings](https://docs.gitlab.com/administration/settings/import_and_export_settings/)
* [Migrate GitLab data by using file exports](https://docs.gitlab.com/user/project/settings/import_export/)

## Миграция с помощью технической поддержки {#support-migration}

Перед началом работы ознакомьтесь с [порядком предоставления услуги](../../concepts/migration.md) по миграции из пользовательской инсталляции GitLab в сервис Managed Service for GitLab.

{% note info %}

Услуга по миграции находится на стадии [Preview](../../../overview/concepts/launch-stages.md).

{% endnote %}

Чтобы перенести данные в инстанс Managed Service for GitLab:
1. [Создайте](instance-create.md) инстанс Managed Service for GitLab.
1. Добавьте в инстанс Managed Service for GitLab те же настройки, что есть в пользовательской инсталляции. Например, [OmniAuth](https://docs.gitlab.com/integration/omniauth) или [ограничения прав доступа для групп](https://docs.gitlab.com/user/group/access_and_permissions), если вы их использовали. Такие сущности, как пользователи, группы, пайплайны, будут перенесены позднее во время работы с резервной копией пользовательской инсталляции.
1. Узнайте версию GitLab в пользовательской инсталляции. Для корректной миграции версия пользовательской инсталляции должна совпадать с версией Managed Service for GitLab.

   1. Откройте пользовательскую инсталляцию GitLab.
   1. В меню слева нажмите **Help**.

      Во всплывающем окне отобразится версия GitLab.

1. Протестируйте миграцию:

   1. [Создайте резервную копию](https://docs.gitlab.com/administration/backup_restore/backup_gitlab#simple-back-up-procedure) пользовательской инсталляции и конфигурационных файлов.
   1. [Передайте технической поддержке](https://center.yandex.cloud/support) полученную резервную копию и версию GitLab в пользовательской инсталляции. Техническая поддержка восстановит инстанс из резервной копии в Managed Service for GitLab.
   1. После того как поддержка сообщит, что инстанс восстановлен, [откройте его](instance-list.md#get) и убедитесь, что в Managed Service for GitLab:

      * присутствуют все нужные настройки, данные и проекты;
      * вы можете отправлять коммиты и обновлять ветки.

1. Выполните промышленную миграцию:

   1. Сообщите технической поддержке дату, когда вы планируете провести миграцию.
   1. Накануне дня миграции [переведите пользовательскую инсталляцию](https://docs.gitlab.com/administration/read_only_gitlab) GitLab в режим `Read only`.
   1. Создайте резервную копию пользовательской инсталляции и конфигурационных файлов.
   1. Передайте эту копию технической поддержке.
   1. В назначенный день миграции техническая поддержка восстанавливает инстанс из резервной копии в Managed Service for GitLab.

1. (Опционально) Настройте доменное имя инстанса:

   1. Если для пользовательской инсталляции вы использовали [кастомизированное доменное имя](https://docs.gitlab.com/administration/dedicated/configure_instance/network_security/#custom-domains) и хотите его сохранить, сообщите это доменное имя технической поддержке. Она настроит его для инстанса Managed Service for GitLab.
   1. В пользовательской инсталляции [настройте DNS-запись](https://docs.gitlab.com/omnibus/settings/dns/) `CNAME`, чтобы перенаправлять пользователей с [домена инстанса](../../concepts/index.md#config) Managed Service for GitLab на ваш кастомизированный домен.

#### Полезные ссылки {#see-also}

* [Порядок предоставления услуги по миграции из GitLab в Managed Service for GitLab](../../concepts/migration.md)
* [Взаимосвязь ресурсов в Managed Service for GitLab](../../concepts/index.md)
* [Создание и активация инстанса Yandex Managed Service for GitLab](instance-create.md)
* [Получение информации об инстансах Yandex Managed Service for GitLab](instance-list.md)

#### Документация GitLab {#gl-docs}

* [Import and export settings](https://docs.gitlab.com/administration/settings/import_and_export_settings/)
* [Migrate GitLab data by using file exports](https://docs.gitlab.com/user/project/settings/import_export/)
* [Groups](https://docs.gitlab.com/user/group/)
* [OmniAuth](https://docs.gitlab.com/integration/omniauth)
* [Group access and permissions](https://docs.gitlab.com/user/group/access_and_permissions)
* [Back up GitLab](https://docs.gitlab.com/administration/backup_restore/backup_gitlab)
* [Place GitLab into a read-only state](https://docs.gitlab.com/administration/read_only_gitlab)
* [GitLab Dedicated network access and security](https://docs.gitlab.com/administration/dedicated/configure_instance/network_security/)
* [DNS settings](https://docs.gitlab.com/omnibus/settings/dns/)