# Сообщения об ошибках в Managed Service for PostgreSQL

* [Почему при использовании расширения TimescaleDB возникает ошибка?](#timescale)

* [Что делать, если при получении SSL-сертификата через PowerShell возникает ошибка проверки отзыва?](#get-ssl-error)

* [Что делать, если при подключении я получаю ошибку `SSL is required`?](#ssl-req)

* [Что делать, если при подключении я получаю ошибку `too many active clients for user`?](#connection-limit-error)

* [Почему при подключении к пользовательской базе данных возникает ошибка?](#database-error)

* [Почему при создании дампа с помощью pg_dumpall возникает ошибка?](#dump-error)

* [Почему при подключении к базе данных postgres возникает ошибка?](#database-postgres-error)

* [Почему соединение завершается ошибкой `terminating connection due to administrator command`?](#connection-error)

* [Почему не удается подключиться к хостам кластера?](#host-error)

* [Почему возникает ошибка при остановке кластера?](#stop-cluster-error)

* [Почему при изменении кластера возникает ошибка `max_connections is less than sum of users connection limit`?](#max-connections-error)

* [Почему перенос данных через создание и восстановление логического дампа завершается ошибкой?](#backup-error)

* [Что делать, если при выполнении логической репликации возникает ошибка `replication slot already exists`?](#repl-slot-exists)

* [Почему при миграции БД в Managed Service for PostgreSQL возникает ошибка `extension... is not available`?](#extension-is-not-available)

* [Почему при развертывании логического дампа возникает ошибка `must be owner of extension`?](#owner-of-extension)

* [Почему при настройке каскадной репликации возникает ошибка?](#cascade-errors)

* [Почему возникает ошибка `cannot execute <SQL-команда> in a read-only transaction`?](#read-only-error)

* [Что делать, если в логах отображается ошибка `too many connections for role "monitor"`?](#monitor-role-error)

* [Почему установка нескольких расширений в CLI заканчивается ошибкой?](#cli-extensions-errors)

* [Почему возникает ошибка `could not open extension control file "<путь_к_расширению>/vector.control": No such file or directory` при обращении к расширению `vector`?](#vector-error)

#### Почему при использовании расширения TimescaleDB возникает ошибка? {#timescale}

Текст ошибки:

```text
SQL Error [0A000]: ERROR: functionality not supported under the current "apache" license
Hint: Upgrade your license to 'timescale' to use this free community feature.
```

Эта ошибка возникает при попытке использовать функцию, доступную только в TimescaleDB Community Edition.

Community Edition распространяется по лицензии [Timescale License (TSL)](https://www.timescale.com/legal/licenses). Пункт 2.2 лицензии запрещает использовать Community Edition для предоставления услуг DBaaS (Database as a Service), поэтому эта версия недоступна в Yandex Cloud.

В кластер Managed Service for PostgreSQL устанавливается TimescaleDB Apache 2 Edition — по сравнению с Community Edition ее функциональность ограничена.

#### Что делать, если при получении SSL-сертификата через PowerShell возникает ошибка проверки отзыва? {#get-ssl-error}

Полный текст ошибки:

```text
curl: (35) schannel: next InitializeSecurityContext failed: Unknown error (0x80092012)
The revocation function was unable to check revocation for the certificate
```

Это означает, что при подключении к сайту не удалось проверить, есть ли его сертификат в списке отозванных.

Чтобы исправить ошибку:

* убедитесь, что проверку не блокируют настройки корпоративной сети;
* выполните команду с параметром `--ssl-no-revoke`.

    ```powershell
    mkdir $HOME\.postgresql; curl.exe --ssl-no-revoke -o $HOME\.postgresql\root.crt https://storage.yandexcloud.net/cloud-certs/CA.pem
    ```

#### Что делать, если при подключении я получаю ошибку `SSL is required`? {#ssl-req}

Ошибка означает, что вы пытаетесь подключиться к кластеру с [хостом в публичном доступе](../concepts/network.md#public-access-to-a-host). Такие хосты поддерживают только соединения с SSL-сертификатом. Вы можете:

* [Получить SSL-сертификат](../operations/connect/index.md#get-ssl-cert) и добавить его в приложение, которое вы используете для подключения.
* [Отключить публичный доступ для хостов](../operations/hosts.md#update) и подключаться к кластеру с виртуальной машины, расположенной в той же облачной сети.

#### Что делать, если при подключении я получаю ошибку `too many active clients for user`? {#connection-limit-error}

Подключение к хостам кластера может завершиться ошибкой:

```text
too many active clients for user (pool_size for user <имя_пользователя> reached <значение_лимита>)
```

По умолчанию кластер резервирует для каждого пользователя 50 подключений к каждому хосту. Если лимит подключений для пользователя будет исчерпан, то попытка открыть новое подключение завершится ошибкой.

Решение: увеличьте лимит подключений в [настройке **Conn limit**](../concepts/settings-list.md#setting-conn-limit).

О том, как изменить настройки PostgreSQL на уровне пользователя, читайте в [документации](../operations/cluster-users.md#update-settings).

#### Почему при подключении к пользовательской базе данных возникает ошибка? {#database-error}

Подключение к пользовательской базе данных может завершиться ошибкой:

```text
ERROR: odyssey: ce3ea075f4ffa: route for '<имя_БД>.<имя_пользователя>' is not found
```

Ошибка означает, что в параметрах подключения указано неверное имя базы данных.

#### Почему при создании дампа с помощью pg_dumpall возникает ошибка? {#dump-error}

При создании дампа с помощью утилиты `pg_dumpall` возникает ошибка:

```text
ERROR: odyssey: c16b9035a1f78: route for 'template1.<имя_пользователя>' is not found
```

Ошибка возникает из-за того, что утилита `pg_dumpall` пытается выгрузить все базы данных: как пользовательские, так и системные.

Создать дамп одновременно всех баз данных Managed Service for PostgreSQL нельзя. Выгрузите дампы с помощью утилиты `pg_dump` для каждой пользовательской базы данных по одной, исключив системные.

#### Почему при подключении к базе данных postgres возникает ошибка? {#database-postgres-error}

Подключение к базе данных `postgres` завершается ошибкой:

```text
ERROR: odyssey: c76e2c1283a7a: route for 'postgres.<имя_пользователя>' is not found
```

База данных `postgres` является системной, и подключение к ней в Managed Service for PostgreSQL запрещено. Укажите в параметрах подключения другую существующую базу данных.

#### Почему соединение завершается ошибкой `terminating connection due to administrator command`? {#connection-error}

Соединение с кластером Managed Service for PostgreSQL может завершаться сообщением:

```text
FATAL: terminating connection due to administrator command
```

Такое сообщение не является ошибкой, а означает, что длительность сессии/транзакции превысила значение настройки [Session duration timeout](../concepts/settings-list.md#setting-session-duration-timeout) (по умолчанию — 12 часов).

#### Почему не удается подключиться к хостам кластера? {#host-error}

Подключение к хостам кластера может завершиться ошибкой:

```text
could not translate host name "<обычный или специальный FQDN>" to address: Name or service not known
```

Ошибка возникает, если запрещен публичный доступ к хосту или пользователи используют кастомизированные DNS-серверы, которые не разрешают доменные имена в зоне `mdb.yandexcloud.net`.

Решение:

* Включите публичный доступ для хоста, к которому выполняется подключение. При использовании [специального FQDN](../operations/connect/fqdn.md#special-fqdns) включите публичный доступ для хоста, на который указывает специальный FQDN.

  {% note warning %}
  
  Используйте подключение с помощью особого FQDN хоста-мастера только для процессов, которые допускают недоступность базы данных на запись продолжительностью до 10 минут.
  
  {% endnote %}

* Рекомендуется включить публичный доступ для всех хостов кластера. Это позволит избежать ошибок подключения при автоматической смене хоста-мастера.
* Для кастомизированных DNS-серверов настройте DNS-перенаправление для зоны `mdb.yandexcloud.net`.

#### Почему возникает ошибка при остановке кластера? {#stop-cluster-error}

Варианты ошибок:

```text
ERROR: rpc error: code = FailedPrecondition desc = Cluster has no backups
```

```text
cluster has no backups. If you want to stop the cluster, make a backup
```

Ошибка возникает из-за того, что [остановить](../operations/cluster-stop.md#stop-cluster) кластер Managed Service for PostgreSQL можно только при наличии хотя бы одной резервной копии кластера.

Решение: дождитесь создания автоматической резервной копии или [создайте резервную копию вручную](../operations/cluster-backups.md#create-backup).

#### Почему при изменении кластера возникает ошибка `max_connections is less than sum of users connection limit`? {#max-connections-error}

Эта ошибка может возникнуть при уменьшении класса хоста в кластере, если сумма лимитов подключений всех пользователей меньше общего лимита подключений на кластер ([Max connections](../concepts/settings-list.md#setting-max-connections)).

Решение: сначала уменьшите лимиты, установленные для пользователей, чтобы их сумма была меньше, чем `<значение_Max_connections> — 15`, а затем снижайте класс хоста.

#### Почему перенос данных через создание и восстановление логического дампа завершается ошибкой? {#backup-error}

[Восстановление логического дампа](../tutorials/data-migration.md#backup) может завершаться одной из ошибок:

* `ERROR: role "<имя_пользователя_источника>" does not exist`
* `ERROR: must be member of role "<имя_пользователя_источника>"`

Ошибки связаны с отсутствием в кластере-приемнике пользователя или привилегий пользователя, от имени которого был создан логический дамп в кластере-источнике.

Чтобы устранить ошибки:

1. [Добавьте пользователя](../operations/cluster-users.md#adduser) в кластере-приемнике с доступом к базе данных для переноса и таким же именем, что и у пользователя, с помощью которого был создан логический дамп в кластере-источнике.
1. [Восстанавливайте логический дамп](../tutorials/data-migration.md#restore) с помощью этого пользователя или [выдайте его привилегии](../operations/grant.md#grant-privilege) пользователю, с помощью которого вы восстанавливаете логический дамп.

#### Что делать, если при выполнении логической репликации возникает ошибка `replication slot already exists`? {#repl-slot-exists}

По умолчанию при [создании подписки](../../tutorials/dataplatform/postgresql-data-migration.md#create-publication-subscription) создается и слот репликации. Ошибка `replication slot already exists` означает, что слот репликации уже существует.

Устранить ошибку можно одним из способов:

1. Привяжите подписку к существующему слоту репликации. Для этого добавьте в запрос для создания подписки параметр `create_slot = false`.
1. [Удалите существующий слот репликации](../operations/replication-slots.md#delete) и попробуйте создать подписку еще раз.

#### Почему при миграции БД в Managed Service for PostgreSQL возникает ошибка `extension... is not available`? {#extension-is-not-available}

Текст ошибки:

```text
extension "<название_расширения>" is not available
```

Ошибка может возникнуть при миграции БД в Managed Service for PostgreSQL с помощью скрипта, который пытается установить и использовать [расширение PostgreSQL](../operations/extensions/cluster-extensions.md). Причина ошибки в том, что в кластерах Managed Service for PostgreSQL нельзя управлять расширениями PostgreSQL с помощью команд SQL.

Чтобы избежать ошибки:

1. Если скрипт или логический дамп имеют текстовый формат, удалите из них операторы для создания расширений PostgreSQL.
1. [Установите](../operations/extensions/cluster-extensions.md#update-extensions) все необходимые расширения в базе-приемнике с помощью интерфейсов Yandex Cloud.

#### Почему при развертывании логического дампа возникает ошибка `must be owner of extension`? {#owner-of-extension}

[Восстановление логического дампа](../tutorials/data-migration.md#backup) может завершаться ошибкой `ERROR: must be owner of extension`.

Ошибка вызвана тем, что в логическом дампе присутствуют операции установки или обновления [расширений PostgreSQL](../operations/extensions/cluster-extensions.md). В кластерах Managed Service for PostgreSQL нельзя управлять расширениями с помощью команд SQL.

Чтобы устранить ошибку:

1. Перед восстановлением дампа [включите](../operations/extensions/cluster-extensions.md#update-extensions) в базе-приемнике все необходимые расширения.
1. Исключите из дампа любые операции с расширениями. Например, можно закомментировать строки, связанные с установкой расширений.
1. Выполните восстановление логического дампа повторно.

#### Почему при настройке каскадной репликации возникает ошибка? {#cascade-errors}

Текст ошибки:

```text
cluster should have at least 2 HA hosts to use cascade host
```

Ошибка возникает, если вы указываете источник репликации для единственной некаскадной реплики.

Для обеспечения [высокой доступности](../../architecture/fault-tolerance.md#mdb-ha) в кластере должна быть хотя бы одна реплика без источника репликации. Во время технического обслуживания или при сбое хоста-мастера роль мастера переключится на эту реплику.

Подробнее о репликации см. в [соответствующем разделе](../concepts/replication.md).

#### Почему возникает ошибка `cannot execute <SQL-команда> in a read-only transaction`? {#read-only-error}

Варианты ошибок:

```text
ERROR: cannot execute ALTER EXTENSION in a read-only transaction
```

```text
ERROR: cannot execute CREATE TABLE in a read-only transaction
```

```text
ERROR: cannot execute UPDATE in a read-only transaction
```

```text
ERROR: cannot execute INSERT in a read-only transaction
```

Такие ошибки могут возникнуть, если произошло [переключение](../../architecture/fault-tolerance.md#mdb-ha) роли мастера на другой хост и вы подключились к реплике, доступной только для чтения.

Избежать таких ошибок можно любым из способов:

* Подключитесь к кластеру с помощью [особого FQDN](../operations/connect/fqdn.md#special-fqdns), который всегда указывает на текущий мастер.

  {% note warning %}
  
  Используйте подключение с помощью особого FQDN хоста-мастера только для процессов, которые допускают недоступность базы данных на запись продолжительностью до 10 минут.
  
  {% endnote %}

* При подключении укажите параметр `target_session_attrs=read-write` и перечислите все хосты кластера. Так вы подключитесь к хосту-мастеру с возможностью чтения и записи.

Подробнее о способах подключения к хосту-мастеру см. в разделе [Подключение к базе данных](../operations/connect/fqdn.md#automatic-master-host-selection).

#### Что делать, если в логах отображается ошибка `too many connections for role "monitor"`? {#monitor-role-error}

Пользователь `monitor` зарезервирован для нужд мониторинга в кластере Managed Service for PostgreSQL. Сообщения об исчерпании лимита подключений для этого пользователя можно игнорировать.

#### Почему установка нескольких расширений в CLI заканчивается ошибкой? {#cli-extensions-errors}

Установка нескольких расширений в CLI может завершиться одной из ошибок:

* `ERROR: accepts 1 arg(s), received 2`

   Ошибка может возникать из-за неправильного формата команды.

   Решение: проверьте, что все расширения перечислены без пробела, например:

   ```bash
   yc managed-postgresql database update db1 --cluster-id cat0adul1fj0******** --extensions cube,pg_logic,timescaledb
   ```

* `ERROR: rpc error: code = InvalidArgument desc = Invalid extensions '<имя_расширения>', allowed extension: <список_расширений>`

  Ошибка может возникать при несовместимости одного из расширений в списке с версией PostgreSQL в кластере.

  Решение: проверьте совместимость указанных в команде расширений в [списке поддерживаемых расширений](../operations/extensions/cluster-extensions.md#postgresql).

* `ERROR: rpc error: code = InvalidArgument desc = The specified extension '<имя_расширения>' is not present in shared_preload_libraries`

  Ошибка может возникать при отсутствии необходимой библиотеки общего пользования в кластере.

  Решение: проверьте требования к библиотекам общего пользования в [списке поддерживаемых расширений](../operations/extensions/cluster-extensions.md#postgresql). Чтобы подключить нужную библиотеку, при [изменении настроек кластера PostgreSQL](../operations/update.md#change-postgresql-config) укажите ее имя в [параметре Shared preload libraries](../concepts/settings-list.md#setting-shared-libraries).

#### Почему возникает ошибка `could not open extension control file "<путь_к_расширению>/vector.control": No such file or directory` при обращении к расширению `vector`? {#vector-error}

Ошибка возникает из-за того, что в Managed Service for PostgreSQL расширение `vector` называется `pgvector`.

Решение: при обращении к расширению используйте `pgvector` вместо `vector`.