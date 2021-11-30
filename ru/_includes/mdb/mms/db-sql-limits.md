{% note warning %}

Создавать и удалять базы данных с помощью команд SQL нельзя. Однако командой `ALTER DATABASE` можно изменять свойства существующих баз данных, кроме [модели восстановления]{% if lang == "ru" %}(https://docs.microsoft.com/ru-ru/sql/relational-databases/backup-restore/recovery-models-sql-server){% endif %}{% if lang == "en" %}(https://docs.microsoft.com/en-us/sql/relational-databases/backup-restore/recovery-models-sql-server){% endif %}.

{% endnote %}
