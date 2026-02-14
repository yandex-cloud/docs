---
title: Загрузить Helm-чарт в реестр {{ cloud-registry-full-name }}
description: Инструкция описывает, как загрузить локальный Helm-чарт в реестр {{ cloud-registry-name }}.
---

# Загрузить Helm-чарт в реестр {{ cloud-registry-name }}

Инструкция описывает, как загрузить локальный [Helm-чарт](../../concepts/helm.md) в реестр.

{% note info %}

Чтобы загрузить Helm-чарт, необходимо [установить и настроить](installation.md) Helm и [аутентифицироваться](authentication.md) в реестре.

{% endnote %}

Для загрузки Helm-чарта в реестр необходима [роль](../../security/index.md#cloud-registry-artifacts-pusher) `cloud-registry.artifacts.pusher` или выше.

{% list tabs group=instructions %}

- CLI {#cli}

  1. (Опционально) Посмотрите список упакованных Helm-чартов в текущей директории:

     ```bash
     ls -la *.tgz
     ```

     Результат:

     ```text
     -rw-r--r-- 1 user user 1234 Dec 10 10:00 my-chart-1.0.0.tgz
     -rw-r--r-- 1 user user 2345 Dec 10 11:00 another-chart-2.1.0.tgz
     ```

  1. (Опционально) Если у вас есть исходный Helm-чарт, упакуйте его для загрузки:

     ```bash
     helm package <путь_к_Helm-чарту> --version <версия_Helm-чарта>
     ```

     Результат:

     ```text
     Successfully packaged chart and saved it to: <путь>/<имя_Helm-чарта>-<версия>.tgz
     ```

     {% note info %}

     Загрузить в {{ cloud-registry-name }} можно только упакованные Helm-чарты в формате `.tgz`.

     {% endnote %}

  1. Загрузите Helm-чарт в реестр:

     ```bash
     helm push <имя_Helm-чарта>-<версия>.tgz oci://{{ cloud-registry }}/<идентификатор_реестра>
     ```

     Результат:

     ```text
     Pushed: {{ cloud-registry }}/<идентификатор_реестра>/<имя_Helm-чарта>:<версия>
     Digest: sha256:...
     ```

{% endlist %}
