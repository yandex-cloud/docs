---
title: "Как подписать файл или артефакт с помощью Cosign"
description: "Следуя данной инструкции, вы сможете подписать файл или артефакт, а также проверить электронную подпись с помощью утилиты Cosign."
---

# Электронная подпись файлов и артефактов с помощью утилиты Cosign

В сервисе {{ kms-name }} можно использовать ключевые пары электронной подписи, созданные с помощью утилиты [Cosign](https://docs.sigstore.dev/signing/quickstart/). Специальная сборка утилиты Cosign позволяет сохранять созданную ключевую пару в сервисе {{ kms-short-name }}, подписывать файлы и артефакты закрытым ключом этой пары и проверять электронную подпись с помощью ее открытого ключа.

## Перед началом работы {#before-you-begin}

1. Установите специальную сборку Cosign для вашей операционной системы:

    {% include [install-cosign](../../_includes/kms/install-cosign.md) %}

1. Получите [IAM-токен](../../iam/concepts/authorization/iam-token.md) и сохраните его в переменную среды `$YC_IAM_TOKEN`:

    {% list tabs group=programming_language %}

    - Bash {#bash}

      ```bash
      export YC_IAM_TOKEN=$(yc iam create-token)
      ```

    - PowerShell {#powershell}

      ```powershell
      $env:YC_IAM_TOKEN = $(yc iam create-token)
      ```

    {% endlist %}

## Подпишите локальный файл {#create-signature}

1. Создайте и сохраните в {{ kms-short-name }} ключевую пару электронной подписи:

    ```bash
    cosign generate-key-pair \
        --kms yckms:///folder/<идентификатор_каталога>/keyname/<имя_ключевой_пары>
    ```

    Где:
    * `<идентификатор_каталога>` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md), в котором будет сохранена создаваемая ключевая пара.
    * `<имя_ключевой_пары>` — имя создаваемой ключевой пары подписи.

    Результат:

    ```bash
    client.go:183: Using IAM Token from 'YC_IAM_TOKEN' environment variable as credentials
    client.go:310: generated yckms KEY_ID: 'abj15qhhh98d********'
    Public key written to cosign.pub
    ```

    Утилита вернет идентификатор созданной ключевой пары подписи и сохранит открытый ключ подписи в локальный файл. Сохраните идентификатор ключевой пары, он понадобится вам на следующих шагах.
    
    Идентификатор ключевой пары подписи всегда можно получить в [консоли управления]({{ link-console-main }}) или с помощью [команды CLI](../../cli/cli-ref/managed-services/kms/asymmetric-signature-key/list.md).

1. Подпишите локальный файл:

    ```bash
    cosign sign-blob \
        --key yckms:///<идентификатор_ключевой_пары> \
        --tlog-upload=false \
        <путь_к_файлу>
    ```

    Где:
    * `<идентификатор_ключевой_пары>` — идентификатор ключевой пары подписи, полученный на предыдущем шаге.
    * `<путь_к_файлу>` — путь к локальному файлу, который требуется подписать.

    Результат:

    ```bash
    Using payload from: <путь_к_файлу>
    client.go:183: Using IAM Token from 'YC_IAM_TOKEN' environment variable as credentials
    <значение_электронной_подписи>
    ```

    Сохраните полученное значение электронной подписи. Оно понадобится вам для проверки подписи на следующем шаге.

## Проверьте электронную подпись {#verify-signature}

Для проверки подписи выполните команду:

```bash
cosign verify-blob \
    --key yckms:///<идентификатор_ключевой_пары> \
    --insecure-ignore-tlog \
    --signature "<значение_электронной_подписи>" \
    <путь_к_файлу>
```

Где:
* `--key` — идентификатор ключевой пары подписи, полученный ранее.
* `--signature` — значение электронной подписи, полученное на предыдущем шаге.
* `<путь_к_файлу>` — путь к локальному файлу, подпись которого требуется проверить.

Результат:

```bash
WARNING: Skipping tlog verification is an insecure practice that lacks of transparency and auditability verification for the blob.
client.go:183: Using IAM Token from 'YC_IAM_TOKEN' environment variable as credentials
Verified OK
```

#### См. также {#see-also}

* [Подпись и проверка Docker-образов {{ container-registry-name }} в {{ managed-k8s-name }}](../../container-registry/tutorials/sign-with-cosign.md).