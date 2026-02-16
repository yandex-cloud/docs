### Ошибка подключения к пользовательской базе данных {#failed-to-connect}

Текст ошибки (на примере {{ MY }}):

```text
failed to initialize LocalWorker:
failed to create source: unable to create *mysql.MysqlSource:
unable to create new mysql source: failed to create canal: failed to check bin log row format:
failed to connect to the database: handleAuthResult: ERROR 1045 (28000):
Access denied for user '<имя_пользователя>'@'<IP_адрес>' (using password: YES)
```

Ошибка возникает, если в параметрах эндпоинта для пользовательской инсталляции БД не указан сертификат CA.

Он требуется для безопасного TLS-соединения между сервисом {{ data-transfer-name }} и сервером пользовательской БД. При подключении {{ data-transfer-name }} проверяет, что сертификат действителен, а центр сертификации (CA), который его выдал, надежен. Без сертификата подключение завершается ошибкой.


**Решение:** укажите сертификат CA в параметрах эндпоинта для пользовательской инсталляции БД.