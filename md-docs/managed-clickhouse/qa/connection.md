# Подключение к ClickHouse®

* [Можно ли подключаться к отдельным хостам ClickHouse®?](#connect-node)

* [Можно ли для межсерверного взаимодействия при выполнении распределенных запросов указать произвольный порт?](#connect-port)

* [Почему я не могу подключиться к хосту из интернета?](#fail-connection)

* [Как подключиться к непубличному хосту в Yandex Cloud?](#private-host)

* [Можно ли подключиться к публичному кластеру без SSL?](#without-ssl)

* [Почему при подключении возникает ошибка `UNEXPECTED_PACKET_FROM_SERVER`?](#unexpected-packet)

* [Можно ли подключиться к хостам кластера по SSH или получить на хостах права суперпользователя?](#connect-ssh)

* [Что делать, если при получении SSL-сертификата через PowerShell возникает ошибка проверки отзыва?](#get-ssl-error)

#### Можно ли подключаться к отдельным хостам ClickHouse®? {#connect-node}

Да. Подключиться к хостам кластера ClickHouse® можно:

* через [HTTPS-интерфейс](https://clickhouse.com/docs/ru/interfaces/http/):
    * по шифрованному соединению с использованием [SSL](../../glossary/ssl-certificate.md) — порт 8443;
    * без шифрования — порт 8123;

* через [клиент командной строки](https://clickhouse.com/docs/ru/interfaces/cli/):
    * по шифрованному соединению с использованием SSL — порт 9440;
    * без шифрования — порт 9000.

Подключение по [SSH](../../glossary/ssh-keygen.md) не поддерживается.

#### Можно ли для межсерверного взаимодействия при выполнении распределенных запросов указать произвольный порт? {#connect-port}

Managed Service for ClickHouse® использует Native / TLS протокол (порт 9440) для межсерверного взаимодействия при выполнении распределенных запросов. Возможность менять протокол или порт не предусмотрена.

#### Почему я не могу подключиться к хосту из интернета? {#fail-connection}

Скорее всего в кластере не включен публичный доступ, поэтому к нему можно подключаться только с ВМ в Yandex Cloud. Запросить публичный доступ можно только при [создании нового хоста](../concepts/network.md#public-access-to-a-host) в кластере.

#### Как подключиться к непубличному хосту в Yandex Cloud? {#private-host}

[Подключитесь](../operations/connect/clients.md) к хосту с виртуальной машины Yandex Cloud, расположенной в той же облачной сети, или [добавьте](../operations/hosts.md#add-host) в кластер еще один хост с публичным доступом и подключайтесь к непубличному хосту через него.

#### Можно ли подключиться к публичному кластеру без SSL? {#without-ssl}

Нет, к публичным хостам подключиться можно только используя SSL-соединение. Подробнее см. в [документации](../operations/connect/index.md).

#### Почему при подключении возникает ошибка `UNEXPECTED_PACKET_FROM_SERVER`? {#unexpected-packet}

Полный текст ошибки:

```text
Code: 102. DB::NetException:
Unexpected packet from server <FQDN_хоста>.mdb.yandexcloud.net:9440
(expected Hello or Exception, got Unknown packet)
```

Эта ошибка возникает при попытке подключиться к хосту ClickHouse® через порт 9440, не используя шифрование. Подключиться через порт 9440 можно только по шифрованному соединению с использованием SSL.

Убедитесь, что при подключении через порт 9440 вы указываете параметр `--secure`.

Подробнее о способах подключения см. в разделе [Подключение к кластеру ClickHouse®](../operations/connect/clients.md).

#### Можно ли подключиться к хостам кластера по SSH или получить на хостах права суперпользователя? {#connect-ssh}

Подключиться к хостам через SSH не получится. Это сделано в целях безопасности и отказоустойчивости пользовательских кластеров, так как прямые изменения внутри хоста могут привести к его полной неработоспособности.

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
    curl.exe https://storage.yandexcloud.net/cloud-certs/RootCA.pem `
      --ssl-no-revoke `
      --output $HOME\.yandex\RootCA.crt; `
    curl.exe https://storage.yandexcloud.net/cloud-certs/IntermediateCA.pem `
      --ssl-no-revoke `
      --output $HOME\.yandex\IntermediateCA.crt; `
    Import-Certificate `
      -FilePath $HOME\.yandex\RootCA.crt `
      -CertStoreLocation cert:\CurrentUser\Root; `
    Import-Certificate `
      -FilePath $HOME\.yandex\IntermediateCA.crt `
      -CertStoreLocation cert:\CurrentUser\Root
    ```

_ClickHouse® является зарегистрированным товарным знаком [ClickHouse, Inc](https://clickhouse.com)._