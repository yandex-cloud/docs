# Миграция из {{ GL }} в {{ mgl-name }}

Перед началом работы ознакомьтесь с [порядком предоставления услуги](../../concepts/migration.md) по миграции из пользовательской инсталляции {{ GL }} в сервис {{ mgl-name }}.

{% note info %}

Услуга по миграции находится на стадии [Preview](../../../overview/concepts/launch-stages.md).

{% endnote %}

Чтобы перенести данные в облако:

1. [Создайте инстанс](instance-create.md) {{ mgl-name }}.
1. Добавьте в инстанс {{ mgl-name }} те же настройки, что есть в пользовательской инсталляции. Например, [OmniAuth]({{ gl.docs }}/ee/integration/omniauth.html) или [ограничения прав доступа для групп]({{ gl.docs }}/ee/user/group/access_and_permissions.html), если вы их использовали. Такие сущности, как пользователи, группы, пайплайны, будут перенесены позднее во время работы с резервной копией пользовательской инсталляции.
1. Узнайте версию {{ GL }} в пользовательской инсталляции. Для корректной миграции версия пользовательской инсталляции должна совпадать с версией {{ mgl-name }}.

   1. Откройте пользовательскую инсталляцию {{ GL }}.
   1. В меню слева нажмите **Help**.

      Во всплывающем окне отобразится версия {{ GL }}.

1. Протестируйте миграцию:

   1. [Создайте резервную копию]({{ gl.docs }}/ee/administration/backup_restore/backup_gitlab.html#simple-back-up-procedure) пользовательской инсталляции и конфигурационных файлов.
   1. [Передайте технической поддержке]({{ link-console-support }}) полученную резервную копию и версию {{ GL }} в пользовательской инсталляции. Техническая поддержка восстановит инстанс из резервной копии в {{ mgl-name }}.
   1. После того как поддержка сообщит, что инстанс восстановлен, [откройте его](instance-list.md#get) и убедитесь, что в {{ mgl-name }}:

      * присутствуют все нужные настройки, данные и проекты;
      * вы можете отправлять коммиты и обновлять ветки.

1. Выполните промышленную миграцию:

   1. Сообщите технической поддержке дату, когда вы планируете провести миграцию.
   1. Накануне дня миграции [переведите пользовательскую инсталляцию]({{ gl.docs }}/ee/administration/read_only_gitlab.html) {{ GL }} в режим Read only.
   1. Создайте резервную копию пользовательской инсталляции и конфигурационных файлов.
   1. Передайте эту копию технической поддержке.
   1. В назначенный день миграции техническая поддержка восстанавливает инстанс из резервной копии в {{ mgl-name }}.

1. (Опционально) Настройте доменное имя инстанса:

   1. Если для пользовательской инсталляции вы использовали [кастомизированное доменное имя]({{ gl.docs }}/ee/user/project/pages/custom_domains_ssl_tls_certification/) и хотите его сохранить, сообщите это доменное имя технической поддержке. Она настроит его для инстанса {{ mgl-name }}.
   1. В пользовательской инсталляции [настройте DNS-запись]({{ gl.docs }}/ee/user/project/pages/custom_domains_ssl_tls_certification/#for-subdomains) `CNAME`, чтобы перенаправлять пользователей с [домена инстанса](../../concepts/index.md#config) {{ mgl-name }} на ваш кастомизированный домен.
