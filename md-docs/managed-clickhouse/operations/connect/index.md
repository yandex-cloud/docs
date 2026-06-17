# Предварительная настройка для подключения к кластеру ClickHouse®

К хостам кластера Managed Service for ClickHouse® можно подключиться:

* Через интернет, если вы [настроили](../hosts.md#update) публичный доступ для нужного хоста. К таким хостам подключиться можно только используя SSL-соединение.

* С виртуальных машин Yandex Cloud, расположенных в той же [облачной сети](../../../vpc/concepts/network.md). Если к хосту нет публичного доступа, для подключения с таких виртуальных машин необязательно использовать SSL-соединение.


К кластеру можно подключиться как с использованием шифрования — через порты `9440` для [clickhouse-client](https://clickhouse.com/docs/ru/interfaces/cli) и `8443` для [HTTP-интерфейса](https://clickhouse.com/docs/ru/interfaces/http), так и без него — через порты `9000` и `8123` соответственно.



## Настройка групп безопасности {#configuring-security-groups}

Для подключения к кластеру необходимо, чтобы [группы безопасности](../../../vpc/concepts/security-groups.md) содержали правила, которые разрешают трафик с определенных портов, IP-адресов или из других групп безопасности.

Настройки правил будут различаться в зависимости от выбранного способа подключения:

{% list tabs group=connection_method %}

- Через интернет {#internet}

  [Настройте все группы безопасности](../../../vpc/operations/security-group-add-rule.md) кластера так, чтобы они разрешали входящий трафик с любых IP-адресов на порты 8443, 9440. Для этого создайте следующие правила для входящего трафика:

    * **Диапазон портов** — `8443`, `9440`.
    * **Протокол** — `TCP`.
    * **Источник** — `CIDR`.
    * **CIDR блоки** — `0.0.0.0/0`.

  На каждый порт создается отдельное правило.

  {% note warning %}

  Чтобы повысить безопасность кластера, укажите в поле **CIDR блоки** только доверенные IP-адреса или подсети.

  {% endnote %}

- С ВМ в Yandex Cloud {#cloud}

    1. [Настройте все группы безопасности](../../../vpc/operations/security-group-add-rule.md) кластера так, чтобы они разрешали входящий трафик из группы безопасности, в которой находится ВМ, на порты 8123, 8443, 9000, 9440. Для этого создайте в этих группах следующие правила для входящего трафика:

        * **Диапазон портов** — `8123` (или другой порт из перечисленных).
        * **Протокол** — `TCP`.
        * **Источник** — `Группа безопасности`.
        * **Группа безопасности** — если кластер и ВМ находятся в одной и той же группе безопасности, выберите значение `Текущая` (`Self`). В противном случае укажите группу безопасности ВМ.

       На каждый порт создается отдельное правило.

    1. [Настройте группу безопасности](../../../vpc/operations/security-group-add-rule.md), в которой находится ВМ так, чтобы можно было подключаться к ВМ и был разрешен трафик между ВМ и хостами кластера.

       Пример правил для ВМ:

        * Для входящего трафика:
            * **Диапазон портов** — `22`.
            * **Протокол** — `TCP`.
            * **Источник** — `CIDR`.
            * **CIDR блоки** — `0.0.0.0/0`.

          Это правило позволяет [подключаться](../../../compute/operations/vm-connect/ssh.md#vm-connect) к ВМ по протоколу [SSH](../../../glossary/ssh-keygen.md).

        * Для исходящего трафика:
            * **Диапазон портов** — `0-65535`.
            * **Протокол** — `Любой` (`Any`).
            * **Назначение** — `CIDR`.
            * **CIDR блоки** — `0.0.0.0/0`.

          Это правило разрешает любой исходящий трафик, что позволяет не только подключаться к кластеру, но и устанавливать на ВМ необходимые для этого сертификаты и утилиты.

{% endlist %}

{% note info %}

Вы можете задать более детальные правила для групп безопасности, например, разрешающие трафик только в определенных подсетях.

Группы безопасности должны быть корректно настроены для всех подсетей, в которых будут размещены хосты кластера. При неполных или некорректных настройках групп безопасности можно потерять доступ к кластеру.

{% endnote %}

Подробнее о группах безопасности в разделе [Сеть и кластеры БД](../../concepts/network.md#security-groups).


## Получение SSL-сертификатов {#get-ssl-cert}

Чтобы использовать шифрованное соединение, получите SSL-сертификаты:

{% list tabs group=operating_system %}

- Linux (Bash) {#linux}

   ```bash
   sudo mkdir --parents /usr/local/share/ca-certificates/Yandex/ && \
   sudo wget "https://storage.yandexcloud.net/cloud-certs/RootCA.pem" \
        --output-document /usr/local/share/ca-certificates/Yandex/RootCA.crt && \
   sudo wget "https://storage.yandexcloud.net/cloud-certs/IntermediateCA.pem" \
        --output-document /usr/local/share/ca-certificates/Yandex/IntermediateCA.crt && \
   sudo chmod 655 \
        /usr/local/share/ca-certificates/Yandex/RootCA.crt \
        /usr/local/share/ca-certificates/Yandex/IntermediateCA.crt && \
   sudo update-ca-certificates
   ```

   Сертификаты будут сохранены в файлах:

   * `/usr/local/share/ca-certificates/Yandex/RootCA.crt`
   * `/usr/local/share/ca-certificates/Yandex/IntermediateCA.crt`

- macOS (Zsh) {#macos}

   ```bash
   sudo mkdir -p /usr/local/share/ca-certificates/Yandex/ && \
   sudo wget "https://storage.yandexcloud.net/cloud-certs/RootCA.pem" \
        --output-document /usr/local/share/ca-certificates/Yandex/RootCA.crt && \
   sudo wget "https://storage.yandexcloud.net/cloud-certs/IntermediateCA.pem" \
        --output-document /usr/local/share/ca-certificates/Yandex/IntermediateCA.crt && \
   sudo chmod 655 \
        /usr/local/share/ca-certificates/Yandex/RootCA.crt \
        /usr/local/share/ca-certificates/Yandex/IntermediateCA.crt && \
   security import /usr/local/share/ca-certificates/Yandex/RootCA.crt -k ~/Library/Keychains/login.keychain; \
   security import /usr/local/share/ca-certificates/Yandex/IntermediateCA.crt -k ~/Library/Keychains/login.keychain
   ```

   Сертификаты будут сохранены в файлах:

   * `/usr/local/share/ca-certificates/Yandex/RootCA.crt`
   * `/usr/local/share/ca-certificates/Yandex/IntermediateCA.crt`

- Windows (PowerShell) {#windows}

   1. Скачайте и импортируйте сертификаты:

      ```powershell
      mkdir -Force $HOME\.yandex; `
      curl.exe https://storage.yandexcloud.net/cloud-certs/RootCA.pem `
        --output $HOME\.yandex\RootCA.crt; `
      curl.exe https://storage.yandexcloud.net/cloud-certs/IntermediateCA.pem `
        --output $HOME\.yandex\IntermediateCA.crt; `
      Import-Certificate `
        -FilePath $HOME\.yandex\RootCA.crt `
        -CertStoreLocation cert:\CurrentUser\Root; `
      Import-Certificate `
        -FilePath $HOME\.yandex\IntermediateCA.crt `
        -CertStoreLocation cert:\CurrentUser\Root
      ```

      Корпоративные политики и антивирус могут блокировать скачивание сертификата. Подробнее в разделе [Вопросы и ответы](../../qa/connection.md#get-ssl-error).

   1. Подтвердите согласие с установкой сертификатов в хранилище <q>Доверенные корневые центры сертификации</q>.

   Сертификаты будут сохранены в файлах:

   * `$HOME\.yandex\RootCA.crt`
   * `$HOME\.yandex\IntermediateCA.crt`

{% endlist %}

Для использования графических IDE [сохраните сертификат](https://storage.yandexcloud.net/cloud-certs/RootCA.pem) в локальную папку и укажите путь к нему в настройках подключения.

## Что дальше {#whats-next}

* [Получите FQDN хоста](fqdn.md), к которому будете подключаться.
* [Подключитесь](clients.md) к кластеру из браузера, графической IDE или интерфейса командной строки.
* [Интегрируйте](code-examples.md) подключение к кластеру в код вашего приложения.

## Полезные ссылки {#see-also}

* [Подключение к ClickHouse® — вопросы и ответы](../../qa/connection.md)

_ClickHouse® является зарегистрированным товарным знаком [ClickHouse, Inc](https://clickhouse.com)._