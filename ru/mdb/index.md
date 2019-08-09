# MDB, он же DBaaS, он же PGaaS

Сервисы для управления базами данных, которые предоставляет Яндекс.Облако, также можно и нужно использовать в инфраструктуре сервисов Яндекса.

Внутренние сервисы функционально не отличаются от внешних, но использование их различается в важных деталях, поэтому надежнее читать внутреннюю документацию:

- [{{mch-name}}](../managed-clickhouse/)
- [{{mmg-name}}](../managed-mongodb/)
- [{{mmy-name}}](../managed-mysql/)
- [{{mrd-name}}](../managed-redis/)
- [{{mpg-name}}](../managed-postgresql/)


## Куда обращаться за поддержкой

Если вы не нашли ответа в документации:

- С несрочными вопросами по настройке и эксплуатации MDB внутри Яндекса пишите в рассылку [mdb-support@](mailto:mdb-support@yandex-team.ru) или в [очередь MDBSUPPORT](https://st.yandex-team.ru/MDBSUPPORT).
- Для заказа или дозаказа квоты [используйте Dispenser](../managed-postgresql/pricing.md).
- Со срочными вопросами пишите в [чат mdb-support](https://t.me/joinchat/AAAAAEDje_JvGnMnVZxVvA), если там нет реакции — обзванивайте по порядку ответственных [отсюда](https://a.yandex-team.ru/arc/trunk/arcadia/cloud/mdb/juggler-config/configs/mdb_resps.yml).
