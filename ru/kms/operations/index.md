---
title: "Как работать с ключами шифрования. Пошаговые инструкции"
description: "Пошаговые инструкции по работе с ключами шифрования в {{ yandex-cloud }}. Из статьи вы узнаете, как управлять ключами шифрования и его версиями. Подробно расскажем о шифровании данных с помощью CLI и API {{ yandex-cloud }}."
---

# Пошаговые инструкции для {{ kms-name }}

## Симметричное шифрование {#symmetric-encryption}

### Ключ {#key}

- [{#T}](key.md#create)
- [{#T}](key.md#rotate)
- [{#T}](key.md#update)
- [{#T}](key.md#delete)
- [{#T}](key-access.md)

### Версия ключа {#version}

- [{#T}](version.md#make-primary)
- [{#T}](version.md#delete)

### Шифрование данных {#symmetric-encrypt}

- [{#T}](symmetric-encryption.md)

## Асимметричное шифрование {#symmetric-encryption}

{% note info %}

{% include [preview-pp.md](../../_includes/preview-pp.md) %}

{% endnote %}

- [{#T}](asymmetric-encryption-key.md)
- [{#T}](asymmetric-encryption.md)

## Электронная подпись {#digital-signature}

{% note info %}

{% include [preview-pp.md](../../_includes/preview-pp.md) %}

{% endnote %}

- [{#T}](asymmetric-signature-key.md)
- [{#T}](signature-verification.md)
- [{#T}](signature-verification-cosign.md)