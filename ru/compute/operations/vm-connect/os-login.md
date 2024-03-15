---
title: "Как подключиться к виртуальной машине по OS Login"
description: "Следуя данной инструкции, вы сможете подключиться к виртуальной машине по OS Login."
---

# Подключиться к виртуальной машине по OS Login

[OS Login](../../../organization/concepts/os-login.md) используется для предоставления пользователям доступа к ВМ по SSH c помощью {{ iam-short-name }}. Для доступа к ВМ, которая поддерживает OS Login на уровне операционной системы, [назначьте](../../../iam/operations/roles/grant.md) пользователю роль `compute.osLogin` или `compute.osAdminLogin`.

## Перед началом работы {#before-you-begin}

{% include [cli-install](../../../_includes/cli-install.md) %}

{% include [default-catalogue](../../../_includes/default-catalogue.md) %}

При необходимости [создайте](./os-login-create-vm.md) новую виртуальную машину с поддержкой OS Login или [настройте](./enable-os-login.md) доступ по OS Login для существующей ВМ.

## Подключиться к ВМ по OS Login c SSH-сертификатом через YC CLI {#connect-via-cli}

{% include [oslogin-connect-with-cli](../../../_includes/compute/oslogin-connect-with-cli.md) %}

## Подключиться к ВМ по OS Login с SSH-сертификатом через стандартный SSH-клиент {#connect-via-exported-certificate}

{% include [oslogin-connect-with-exported-cert](../../../_includes/compute/oslogin-connect-with-exported-cert.md) %}

{% note info %}

Сертификат действителен один час. По истечении этого времени для подключения к ВМ необходимо [экспортировать](./os-login-export-certificate.md) новый сертификат.

{% endnote %}

## Подключиться к ВМ по OS Login с SSH-ключом через YC CLI {#connect-via-key}

{% include [oslogin-connect-with-key](../../../_includes/compute/oslogin-connect-with-key.md) %}