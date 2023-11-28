# Выполнение SQL-запросов

{% include notitle [preview](../../_includes/note-preview-by-request.md) %}

Чтобы выполнить запрос к базе данных, с ней должно быть [установлено соединение](connect.md##connect-db). Если соединение неактивно, [активируйте](connect.md#update-connection) его.

{% include notitle [execute-sql](../../_includes/websql/execute-sql.md) %}

  {% note info %}

  При большом количестве строк в таблице ее будет трудно просматривать. Используйте условие `LIMIT` и дополнительные условия для ограничения количества выводимых строк. 

  {% endnote %}
  
Выполенные запросы можно [просматривать в истории запросов](history.md) и [сохранять в качестве шаблонов](templates.md).