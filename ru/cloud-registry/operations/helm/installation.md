---
title: Установить и настроить Helm в {{ cloud-registry-full-name }}
description: Следуя данной инструкции, вы установите и настроите Helm для работы с {{ cloud-registry-name }}.
---

# Установить и настроить Helm в {{ cloud-registry-name }}

Перед началом работы с Helm-чартами в {{ cloud-registry-name }} необходимо установить и настроить [Helm](https://helm.sh/) на локальном компьютере.

## Установка Helm {#install}

1. [Установите](https://helm.sh/ru/docs/intro/install/) клиент Helm версии 3.8.0 или выше.

   {% note info %}

   При установке Helm переменные окружения не обновляются автоматически. Чтобы выполнять команды `helm`, запускайте их в директории установки или вручную добавьте Helm в переменные окружения.

   {% endnote %}

## Настройка поддержки OCI {#oci-support}

Если вы используете версию Helm ниже 3.8.0, включите поддержку [Open Container Initiative](https://opencontainers.org/) в клиенте Helm:

```bash
export HELM_EXPERIMENTAL_OCI=1
```

В версиях Helm 3.8.0 и выше поддержка OCI включена по умолчанию.

#### См. также {#see-also}

* [{#T}](authentication.md)
* [Загрузить Helm-чарт в реестр](push.md)
* [Скачать Helm-чарт из реестра](pull.md)
