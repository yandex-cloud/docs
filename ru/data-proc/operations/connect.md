---
title: Как подключиться к кластеру {{ dataproc-full-name }}
description: Следуя данной инструкции, вы сможете подключиться к кластеру {{ dataproc-name }}.
---

# Подключение к кластеру {{ dataproc-name }}

После создания кластера {{ dataproc-name }} вы можете подключиться к хостам подкластеров:

* Через интернет, если вы настроили публичный доступ для подкластера.
* С [виртуальной машины](../../compute/operations/vm-create/create-linux-vm.md) {{ yandex-cloud }}, расположенной в той же облачной сети.

Чтобы подключиться к кластеру:

1. [Настройте группы безопасности](security-groups.md).
1. [Получите FQDN хоста](fqdn.md).
1. Подключитесь к хосту одним из способов:
    * [по SSH](connect-ssh.md);
    * через {{ oslogin }} с помощью [стандартного SSH-клиента](connect-oslogin.md#os-login-ssh) или [{{ yandex-cloud }} CLI](connect-oslogin.md#os-login-cli);
    * [из графических IDE](connect-ide.md).
