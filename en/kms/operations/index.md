---
title: "How to work with encryption keys. Step-by-step guide"
description: "Step-by-step guide for working with encryption keys in {{ yandex-cloud }}. In this tutorial, you will learn how to manage encryption keys and their versions. Find out how to encrypt data using the {{ yandex-cloud }} CLI and API."
---

# Step-by-step guide for {{ kms-name }}

## Symmetric encryption {#symmetric-encryption}

### Key {#key}

- [{#T}](key.md#create)
- [{#T}](key.md#rotate)
- [{#T}](key.md#update)
- [{#T}](key.md#delete)
- [{#T}](key-access.md)

### Key version {#version}

- [{#T}](version.md#make-primary)
- [{#T}](version.md#delete)

### Data encryption {#symmetric-encrypt}

- [{#T}](symmetric-encryption.md)

## Asymmetric encryption {#symmetric-encryption}

{% note info %}

{% include [preview-pp.md](../../_includes/preview-pp.md) %}

{% endnote %}

- [{#T}](asymmetric-encryption-key.md)
- [{#T}](asymmetric-encryption.md)

## Digital signature {#digital-signature}

{% note info %}

{% include [preview-pp.md](../../_includes/preview-pp.md) %}

{% endnote %}

- [{#T}](asymmetric-signature-key.md)
- [{#T}](signature-verification.md)