Роль `backup.editor` предназначена для управления ресурсами сервиса Cloud Backup. Пользователи с этой ролью могут:

* просматривать все ресурсы и их списки, как с ролью `backup.viewer`;
* создавать, изменять и удалять политики резервного копирования;
* изменять список ресурсов Yandex Cloud, привязанных к политике;
* восстанавливать ресурсы из резервных копий;
* удалять копии;
* подключать провайдеров резервного копирования, доступных в Cloud Backup.

Выдать данную роль в облаке может администратор облака (роль `admin`), в каталоге — администратор облака или пользователь с ролью `backup.admin` в каталоге.