* **Пользовательская инсталляция:**
    * **Координатор кластера {{ GP }}** — укажите данные для подключения к хостам-мастерам:
        * **Primary** — данные первичного хоста-мастера:
            * {% include [Field IP FQDN](../../fields/common/ui/host.md) %}
            * {% include [Field Database port](../../fields/common/ui/database-port.md) %}
        * **Mirror** — данные резервного хоста-мастера (в случае наличия только одного хоста-мастера можно не указывать).
    * **Сегменты кластера {{ GP }}** — укажите данные для подключения к хостам-сегментам (при необходимости). Если их не указать, то адреса хостов-сегментов будут получены автоматически из служебной таблицы хоста-мастера.
* {% include [Field Database Name](../../fields/greenplum/ui/database-name.md) %}
* {% include [Field Username](../../fields/common/ui/username.md) %}
* **Параметры аутентификации** — укажите данные для аутентификации:
    * {% include [Field Password](../../fields/common/ui/password.md) %}
    * {% include [Field CA certificate](../../fields/greenplum/ui/ca-certificate.md) %}
