---
title: Серийная консоль в {{ compute-full-name }}
description: Из статьи вы узнаете, что такое серийная консоль виртуальной машины {{ compute-full-name }}, как и для чего ее можно использовать, а также какие риски несет в себе использование серийной консоли ВМ.
---

# Серийная консоль виртуальной машины

{% include [sc-warning](../../_includes/compute/serial-console-warning.md) %}

_Серийная консоль_ позволяет получить доступ к [виртуальной машине](./vm.md) вне зависимости от состояния ее [сети](../../vpc/concepts/network.md#network). Серийная консоль работает на основе интерфейса [IPMI](https://ru.wikipedia.org/wiki/Intelligent_Platform_Management_Interface) с использованием контроллера Baseboard Management Controller (BMC) облачного сервера, на котором размещена виртуальная машина.

Таким образом, вы можете использовать серийную консоль, например, для устранения неисправностей виртуальной машины или при возникновении проблем с доступом к ней по [SSH](../../glossary/ssh-keygen.md) или [{{ oslogin }}](../../organization/concepts/os-login.md).

{% include [serial-console-roles](../../_includes/compute/serial-console-roles.md) %}

К серийной консоли виртуальных машин под управлением операционной системы Linux можно подключиться с помощью консоли управления, а также с использованием стандартного SSH-клиента или {{ yandex-cloud }} CLI. Подробнее читайте в разделе [{#T}](../operations/serial-console/connect-ssh.md).

К серийной консоли виртуальных машин под управлением операционной системы Windows можно подключиться с помощью консоли управления или {{ yandex-cloud }} CLI. Подробнее читайте в разделе [{#T}](../operations/serial-console/windows-sac.md).

По умолчанию доступ к серийной консоли виртуальной машины отключен.

## Последовательные порты {#serial-ports}

{% include [serial-console-os-dependency-warn](../../_includes/compute/serial-console-os-dependency-warn.md) %}

С помощью серийной консоли вы можете подключаться к виртуальным машинам {{ compute-name }} через разные [последовательные порты](https://ru.wikipedia.org/wiki/Последовательный_порт) (COM-порты) — `COM1`, `COM2`, `COM3` или `COM4`.

По умолчанию для подключения используются последовательные порты `COM1` (ОС Linux) и `COM2` (ОС Windows). Чтобы использовать другой порт, необходимо самостоятельно настроить его на стороне операционной системы вашей виртуальной машины.

## Безопасность при использовании SSH {#security}

{% note info %}

{% include [key-without-password-alert](../../_includes/compute/key-without-password-alert.md) %}

{% endnote %}

Важным моментом при удаленном доступе является защита от [атак посредника (MITM-атак)](https://ru.wikipedia.org/wiki/Атака\_посредника). Защититься от MITM-атак можно, используя шифрование между клиентом и сервером.

Установить безопасное подключение можно следующими способами:

* Перед каждым подключением к ВМ вы можете скачивать текущий [SHA256 Fingerprint](https://{{ s3-storage-host }}/cloud-certs/serialssh-fingerprint.txt) (отпечаток) SSH-ключа.

    При первом подключении к ВМ клиент сообщает отпечаток SSH-ключа и ожидает решения по установке соединения:

    * `YES` — установить соединение.
    * `NO` — отказаться.

    Убедитесь, что отпечаток по ссылке совпадает с отпечатком, полученным от клиента.
* Перед каждым подключением к серийной консоли вы можете скачивать публичный [SSH-ключ](https://{{ s3-storage-host }}/serialssh-certs/serialssh-knownhosts) хоста (файл `serialssh-knownhosts`) и использовать его при подключении.

    Рекомендуемые параметры запуска:

    ```bash
    ssh \
      -o ControlPath=none \
      -o IdentitiesOnly=yes \
      -o CheckHostIP=no \
      -o StrictHostKeyChecking=yes \
      -o UserKnownHostsFile=./serialssh-knownhosts \
      -p 9600 \
      -i ~/.ssh/<имя_закрытого_SSH-ключа> \
      <идентификатор_ВМ>.<имя_пользователя>@{{ serial-ssh-host }}
    ```

    
    
    Со временем публичный SSH-ключ хоста может быть изменен.

Чаще сверяйтесь с указанными файлами. Скачивайте их только по протоколу HTTPS, предварительно убедившись в достоверности сертификата сайта `https://{{ s3-storage-host }}`. Если из-за проблем с сертификатом сайт не может обеспечить безопасное шифрование ваших данных, браузер предупредит об этом.

#### Полезные ссылки {#see-also}

* [{#T}](../operations/serial-console/index.md)
* [{#T}](../operations/serial-console/connect-ssh.md)
* [{#T}](../operations/serial-console/windows-sac.md)