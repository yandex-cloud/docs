---
title: "Начало работы с {{ mch-full-name }}"
description: "В этой инструкции вы научитесь создавать {{ CH }}-кластер и подключаться к нему."
---

# Как начать работать с {{ mch-name }}

{% if product == "yandex-cloud" and audience != "internal" %}

{% include [mdb-grant-note](../_includes/mdb/mdb-grant-note.md) %}

{% endif %}

Чтобы начать работу с сервисом:
* [Создайте кластер БД](#cluster-create).
* [Подключитесь к БД](#connect).

{% if audience == "internal" %}

Для внутреннего сервиса MDB развернут [веб-интерфейс]({{ console-link }}), где кластер БД можно накликать. Подробнее про [квоты]({{ link-console-quotas }}) и соответствие ABC-сервисов облакам и каталогам читайте в разделе [{#T}](../mdb/access.md).

{% include [Internal access](../_includes/mdb/internal-access.md) %}

## Настройка CLI {#cli-setup}

Если вы планируете использовать CLI, установите и настройте его согласно [инструкции](../cli/quickstart.md).

Если все сделано правильно, должен заработать запрос списка кластеров:

```bash
{{ yc-mdb-ch }} cluster list
```

{% else %}

## Перед началом работы {#before-you-begin}

1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь, если вы еще не зарегистрированы.

1. Если у вас еще нет каталога, создайте его:

   {% include [create-folder](../_includes/create-folder.md) %}

1. Подключаться к кластерам БД можно как изнутри, так и извне {{ yandex-cloud }}:

   * Чтобы подключиться изнутри {{ yandex-cloud }}, создайте виртуальную машину на основе [Linux](../compute/quickstart/quick-create-linux.md){% if product == "cloud-il" %} или [Windows](../compute/quickstart/quick-create-windows.md){% endif %} в той же сети, что и кластер БД.

   * Чтобы подключиться к кластеру из интернета, запросите публичный доступ к хостам при создании кластера.

   {% note info %}

   Следующие шаги предполагают, что подключение к кластеру производится с ВМ на основе [Linux](../compute/quickstart/quick-create-linux.md).

   {% endnote %}

1. [Подключитесь](../compute/operations/vm-connect/ssh.md) к виртуальной машине по {% if lang == "ru" and audience != "internal" %}[SSH](../glossary/ssh-keygen.md){% else %}SSH{% endif %}.

1. Подключите [DEB-репозиторий]({{ ch.docs }}/getting-started/install/#install-from-deb-packages) {{ CH }}:

   ```bash
   sudo apt update && sudo apt install -y apt-transport-https ca-certificates dirmngr && \
   sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv E0C56BD4 && \
   echo "deb https://repo.{{ ch-domain }}/deb/stable/ main/" | sudo tee \
   /etc/apt/sources.list.d/clickhouse.list
   ```

1. Установите зависимости и клиентское приложение `clickhouse-client`:

   ```bash
   sudo apt update && sudo apt install -y clickhouse-client
   ```

1. Загрузите файл конфигурации для `clickhouse-client`:

   {% include [ClickHouse client config](../_includes/mdb/mch/client-config.md) %}

{% endif %}

## Создайте кластер {#cluster-create}

1. В консоли управления выберите каталог, в котором нужно создать кластер БД.
1. Выберите сервис **{{ mch-name }}**.
1. Нажмите кнопку **Создать кластер**.
1. Задайте параметры кластера и нажмите кнопку **Создать кластер**. Процесс подробно рассмотрен в разделе [{#T}](operations/cluster-create.md).
1. Дождитесь, когда кластер будет готов к работе: его статус на панели {{ mch-short-name }} сменится на **Running**, а состояние — на **Alive**. Это может занять некоторое время.

## Подключитесь к БД {#connect}

{% if audience != "internal" %}

1. Если вы используете группы безопасности для облачной сети, [настройте их](operations/connect.md#configuring-security-groups) так, чтобы был разрешен весь необходимый трафик между кластером и хостом, с которого выполняется подключение.

   {% include [preview-pp.md](../_includes/preview-pp.md) %}

{% endif %}

1. Для подключения к серверу БД получите SSL-сертификат:

    {% include [install-certificate](../_includes/mdb/mch/install-certificate.md) %}

1. Используйте для подключения ClickHouse CLI:

   1. Укажите путь к SSL-сертификату в [конфигурационном файле]({{ ch.docs }}/interfaces/cli/#interfaces_cli_configuration), в элементе `<caConfig>`:

      ```xml
      <config>
        <openSSL>
          <client>
            <loadDefaultCAFile>true</loadDefaultCAFile>
            <caConfig>{{ crt-local-dir }}{{ crt-local-file }}</caConfig>
            <cacheSessions>true</cacheSessions>
            <disableProtocols>sslv2,sslv3</disableProtocols>
            <preferServerCiphers>true</preferServerCiphers>
            <invalidCertificateHandler>
              <name>RejectCertificateHandler</name>
            </invalidCertificateHandler>
          </client>
        </openSSL>
      </config>
      ```

   1. Запустите {{ CH }} CLI со следующими параметрами:

      {% include [default-connstring](../_includes/mdb/mch/default-connstring.md) %}

## Что дальше {#whats-next}

* Изучите [концепции сервиса](concepts/index.md).
* Узнайте подробнее о [создании кластера](operations/cluster-create.md) и [подключении к БД](operations/connect.md).
* Ознакомьтесь с [вопросами и ответами](qa/general.md).
