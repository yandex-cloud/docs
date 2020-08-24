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

- С несрочными вопросами по настройке и эксплуатации MDB внутри Яндекса рисуйте задачи в [очередь MDBSUPPORT](https://st.yandex-team.ru/MDBSUPPORT).
- Для заказа или дозаказа квоты [используйте Dispenser](../managed-postgresql/quotas.md).
- Со срочными вопросами пишите в [чат mdb-support](https://t.me/joinchat/CCDG-0Dje_KWvyMQ-bFMtA), если там нет реакции — обзванивайте по порядку дежурных, которых показывает [бот Yandex.Cloud Duty](https://t.me/ycloud_duty_bot) по следующим командам:

  - `/duty mdb-clickhouse`
  - `/duty mdb-mongodb`
  - `/duty mdb-mysql`
  - `/duty mdb-redis`
  - `/duty mdb-postgresql`
