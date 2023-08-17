---
title: "Начало работы с {{ mch-full-name }}"
description: "В этой инструкции вы научитесь создавать кластер {{ CH }} и подключаться к нему."
---

# Как начать работать с {{ mch-name }}

Чтобы начать работу с сервисом:
* [Создайте кластер базы данных](#cluster-create).
* [Подключитесь к БД](#connect).


## Перед началом работы {#before-you-begin}

1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь, если вы еще не зарегистрированы.
1. Если у вас еще нет [каталога](../resource-manager/concepts/resources-hierarchy.md#folder), создайте его:

   {% include [create-folder](../_includes/create-folder.md) %}

1. Подключаться к [кластерам](concepts/index.md) БД можно изнутри и извне {{ yandex-cloud }}:
   * Чтобы подключиться изнутри {{ yandex-cloud }}, создайте [виртуальную машину](../compute/concepts/vm.md) на основе [Linux](../compute/quickstart/quick-create-linux.md) в той же [сети](../vpc/concepts/network.md#network), что и кластер БД.
   * Чтобы подключиться к кластеру из интернета, запросите публичный доступ к хостам при создании кластера.

   {% note info %}

   Следующие шаги предполагают, что подключение к кластеру производится с ВМ на основе [Linux](../compute/quickstart/quick-create-linux.md).

   {% endnote %}

1. [Подключитесь](../compute/operations/vm-connect/ssh.md) к ВМ по [SSH](../glossary/ssh-keygen.md).
1. Подключите [DEB-репозиторий]({{ ch.docs }}/getting-started/install/#install-from-deb-packages) {{ CH }}:

   ```bash
   sudo apt update && sudo apt install --yes apt-transport-https ca-certificates dirmngr && \
   sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 8919F6BD2B48D754 && \
   echo "deb https://packages.{{ ch-domain }}/deb stable main" | sudo tee \
   /etc/apt/sources.list.d/clickhouse.list
   ```

1. Установите зависимости и клиентское приложение `clickhouse-client`:

   ```bash
   sudo apt update && sudo apt install --yes clickhouse-client
   ```

1. Загрузите файл конфигурации для `clickhouse-client`:

   {% include [ClickHouse client config](../_includes/mdb/mch/client-config.md) %}


## Создайте кластер {#cluster-create}

1. В консоли управления выберите каталог, в котором нужно создать кластер БД.
1. Выберите сервис **{{ mch-name }}**.
1. Нажмите кнопку **Создать кластер**.
1. Задайте параметры кластера и нажмите кнопку **Создать кластер**. Процесс подробно рассмотрен в разделе [Создание кластера](operations/cluster-create.md).
1. Дождитесь, когда кластер будет готов к работе: его статус на панели {{ mch-short-name }} сменится на **Running**, а состояние — на **Alive**. Это может занять некоторое время.

## Подключитесь к БД {#connect}


1. Если вы используете [группы безопасности](../vpc/concepts/security-groups.md) для облачной сети, [настройте их](operations/connect.md#configuring-security-groups) так, чтобы был разрешен весь необходимый трафик между кластером и хостом, с которого выполняется подключение.

   {% include [preview-pp.md](../_includes/preview-pp.md) %}


1. Для подключения к серверу БД получите SSL-сертификат:

   {% include [install-certificate](../_includes/mdb/mch/install-certificate.md) %}

1. Используйте для подключения {{ CH }} CLI:
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