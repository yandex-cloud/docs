{% note info %}

Для пользователей, добавленных через метаданные:

* после включения доступа к ВМ по OS Login из метаданных удаляются ключи, указанные в `user-data` и `ssh-keys`;
* после отключения доступа к ВМ по OS Login удаленные ключи пересоздаются.

{% endnote %}
