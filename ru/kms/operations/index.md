---
title: Как работать с ключами шифрования. Пошаговые инструкции
description: Пошаговые инструкции по работе с ключами шифрования в {{ yandex-cloud }}. Из статьи вы узнаете, как управлять ключами шифрования и его версиями. Подробно расскажем о шифровании данных с помощью CLI и API {{ yandex-cloud }}.
---

# Пошаговые инструкции для {{ kms-name }}

## Симметричное шифрование {#symmetric-encryption}

### Ключ {#key}

- [Создать ключ](key.md#create)
- [Ротировать ключ](key.md#rotate)
- [Изменить ключ](key.md#update)
- [Удалить ключ](key.md#delete)
- [{#T}](key-access.md)

### Версия ключа {#version}

- [Сделать версию основной](version.md#make-primary)
- [Удалить версию ключа](version.md#delete)

### Шифрование данных {#symmetric-encrypt}

- [{#T}](symmetric-encryption.md)

## Асимметричное шифрование {#symmetric-encryption}

- [{#T}](asymmetric-encryption-key.md)
- [{#T}](asymmetric-encryption.md)
- [{#T}](asymmetric-encryption-key-access.md)

## Электронная подпись {#digital-signature}

- [{#T}](asymmetric-signature-key.md)
- [{#T}](asymmetric-signature-key-access.md)
- [{#T}](signature-verification.md)
- [{#T}](signature-verification-cosign.md)

## Получение дополнительной информации {#get-additional-info}

- [{#T}](operation-logs.md)
