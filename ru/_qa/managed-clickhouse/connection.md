#### Можно ли подключаться к отдельным хостам {{ CH }}? {#connect-node}

Да. Подключиться к хостам кластера {{ CH }} можно:

* через [HTTPS-интерфейс]({{ ch.docs }}/interfaces/http/):
    * по шифрованному соединению с использованием SSL — порт 8443;
    * без шифрования — порт 8123;

* через [клиент командной строки]({{ ch.docs }}/interfaces/cli/):
    * по шифрованному соединению с использованием SSL — порт 9440;
    * без шифрования — порт 9000.

Подключение по [SSH](../../glossary/ssh-keygen.md) не поддерживается.

#### Почему я не могу подключиться к хосту из интернета? {#fail-connection}

Скорее всего в кластере не включен публичный доступ, поэтому к нему можно подключаться только с ВМ в {{ yandex-cloud }}. Запросить публичный доступ можно только при [создании нового хоста](../../managed-clickhouse/concepts/network.md#public-access-to-a-host) в кластере.

#### Как подключиться к непубличному хосту в {{ yandex-cloud }}? {#private-host}

[Подключитесь](../../managed-clickhouse/operations/connect/clients.md) к хосту с виртуальной машины {{ yandex-cloud }}, расположенной в той же облачной сети, или [добавьте](../../managed-clickhouse/operations/hosts.md#add-host) в кластер еще один хост с публичным доступом и подключайтесь к непубличному хосту через него.

#### Можно ли подключиться к публичному кластеру без SSL? {#without-ssl}

Нет, к публичным хостам подключиться можно только используя SSL-соединение. Подробнее см. в [документации](../../managed-clickhouse/operations/connect/index.md).

#### Почему при подключении возникает ошибка `UNEXPECTED_PACKET_FROM_SERVER`? {#unexpected-packet}

Полный текст ошибки:

```text
Code: 102. DB::NetException:
Unexpected packet from server <FQDN_хоста>.mdb.yandexcloud.net:9440
(expected Hello or Exception, got Unknown packet)
```

Эта ошибка возникает при попытке подключиться к хосту {{ CH }} через порт 9440, не используя шифрование. Подключиться через порт 9440 можно только по шифрованному соединению с использованием SSL.

Убедитесь, что при подключении через порт 9440 вы указываете параметр `--secure`.

Подробнее о способах подключения см. в разделе [Подключение к кластеру {{ CH }}](../../managed-clickhouse/operations/connect/clients.md).

#### Можно ли подключиться к хостам кластера по SSH или получить на хостах права суперпользователя? {#connect-ssh}

{% include [connect-via-ssh](../../_includes/mdb/connect-via-ssh.md) %}

#### Что делать, если при получении SSL-сертификата через PowerShell возникает ошибка проверки отзыва? {#get-ssl-error}

Полный текст ошибки:

```text
curl: (35) schannel: next InitializeSecurityContext failed: Unknown error (0x80092012)
The revocation function was unable to check revocation for the certificate
```
Это означает, что при подключении к веб-сайту не удалось проверить, есть ли его сертификат в списке отозванных.

Чтобы исправить ошибку:

* убедитесь, что проверку не блокируют настройки корпоративной сети;
* выполните команду с параметром `--ssl-no-revoke`.

    ```powershell
    mkdir -Force $HOME\.yandex; `
    curl.exe {{ crt-web-path-root }} `
      --ssl-no-revoke `
      --output $HOME\.yandex\{{ crt-local-file-root }}; `
    curl.exe {{ crt-web-path-int }} `
      --ssl-no-revoke `
      --output $HOME\.yandex\{{ crt-local-file-int }}; `
    Import-Certificate `
      -FilePath $HOME\.yandex\{{ crt-local-file-root }} `
      -CertStoreLocation cert:\CurrentUser\Root; `
    Import-Certificate `
      -FilePath $HOME\.yandex\{{ crt-local-file-int }} `
      -CertStoreLocation cert:\CurrentUser\Root
    ```
