{% note warning %}

You cannot create or delete databases using SQL commands. However, the `ALTER DATABASE` command can change the properties of existing databases except for [recovery models]{% if lang == "ru" %}(https://docs.microsoft.com/ru-ru/sql/relational-databases/backup-restore/recovery-models-sql-server){% endif %}{% if lang == "en" %}(https://docs.microsoft.com/en-us/sql/relational-databases/backup-restore/recovery-models-sql-server){% endif %}.

{% endnote %}

