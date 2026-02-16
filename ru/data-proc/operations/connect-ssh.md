---
title: Как подключиться к хосту кластера {{ dataproc-full-name }} по SSH
description: Следуя данной инструкции, вы сможете подключиться к хосту {{ dataproc-name }} по SSH.
---

# Подключение к хосту {{ dataproc-name }} по SSH

Вы можете подключиться к кластеру {{ dataproc-name }} по [SSH](../../glossary/ssh-keygen.md).

Перед подключением:

1. [Настройте группы безопасности](security-groups.md).
1. [Получите FQDN хоста](fqdn.md).

## Подключитесь с помощью стандартного SSH-клиента {#connection-ssh}

Чтобы подключиться к хосту {{ dataproc-name }}, на локальной машине или промежуточной ВМ должен быть доступен SSH-ключ, который вы указали при создании кластера {{ dataproc-name }}. Вы можете скопировать ключ на машину, с которой будет производиться подключение к кластеру, или подключаться к ней с запущенным SSH-агентом.

1. Если вы не настраивали публичный доступ для подкластера, [подключитесь](../../compute/operations/vm-connect/ssh.md) к промежуточной виртуальной машине по протоколу SSH.

1. Запустите SSH-агент:

    ```bash
    eval `ssh-agent -s`
    ```

1. Добавьте нужный ключ в список доступных агенту:
 
   ```bash
   ssh-add ~/.ssh/example-key
   ```

1. Откройте SSH-соединение с хостом {{ dataproc-name }}, указав его [FQDN](fqdn.md) или IP-адрес, если для хоста включен публичный доступ. Для образа 2.0 укажите пользователя `ubuntu`, для образа 1.4 — `root`, например:

   ```bash
   ssh ubuntu@rc1b-dataproc-m-fh4y4nur********.{{ dns-zone }}
   ```

   Результат:

   ```text
   ubuntu@rc1b-dataproc-m-fh4y4nur********:~#
   ```

1. Проверьте, что команды Hadoop выполняются, например:

    ```bash
    hadoop version
    ```

    Результат:

    ```text
    Hadoop 2.8.5
    Subversion https://github.yandex-team.ru/mdb/bigtop.git -r 78508f2a4b4f3dc8b3d295ccb50a45a4********
    Compiled by robot-pgaas-ci on 2019-04-16T10:35Z
    Compiled with protoc 2.5.0
    From source with checksum 9942ca5c745417c14e31883********
    This command was run using /usr/lib/hadoop/hadoop-common-2.8.5.jar
    ```