---
title: Создать Helm-чарт в {{ cloud-registry-name }}
description: В инструкции описано, как создать Helm-чарт, собрать его и загрузить в {{ cloud-registry-name }}.
---

# Создать Helm-чарт в {{ cloud-registry-name }}

Вы можете загрузить [Helm-чарт](../../concepts/helm.md) в [реестр](../../concepts/registry.md) {{ cloud-registry-name }}.

Перед началом работы [установите и настройте Helm](installation.md).

Чтобы загрузить Helm-чарт:

{% list tabs group=instructions %}

- CLI {#cli}

  1. Создайте Helm-чарт:
  
     ```bash
     helm create <имя_Helm-чарта>
     ```

     Имя должно соответствовать требованиям:

     {% include [name-format](../../../_includes/name-format.md) %}

     Результат:

     ```text
     Creating <имя_Helm-чарта>
     ```

  1. Соберите Helm-чарт для загрузки:

     ```bash
     helm package <имя_Helm-чарта>/. --version <версия_Helm-чарта>
     ```

     Результат:

     ```text
     Successfully packaged chart and saved it to: <путь>/<имя_Helm-чарта>-<версия>.tgz
     ```

  1. Загрузите Helm-чарт в {{ cloud-registry-name }}:

     ```bash
     helm push <имя_Helm-чарта>-<версия>.tgz oci://{{ cloud-registry }}/<идентификатор_реестра>
     ```

     Результат:

     ```text
     Pushed: {{ cloud-registry }}/crp3h07fgv9b********/<имя_Helm-чарта>:<версия>
     Digest: <SHA256...>
     ```

{% endlist %}

## Примеры {#examples}

{% list tabs group=instructions %}

- CLI {#cli}

  1. Создайте Helm-чарт:

     ```bash
     helm create my-chart
     ```

     Результат:

     ```text
     Creating my-chart
     ```

  1. Соберите Helm-чарт для загрузки:

     ```bash
     helm package my-chart/. --version 3.11.2
     ```

     Результат:

     ```text
     Successfully packaged chart and saved it to: C:/my-chart-3.11.2.tgz
     ```

  1. Загрузите Helm-чарт в {{ cloud-registry-name }}:

     ```bash
     helm push my-chart-3.11.2.tgz oci://{{ cloud-registry}}/<идентификатор_реестра>
     ```

     Результат:

     ```text
     Pushed: {{ cloud-registry }}/crp3h07fgv9b********/my-chart:3.11.2
     Digest: sha256:dc44a4e8b686b043b8a88f77ef9dcb998116fab422e8c892a2370da0********
     ```

{% endlist %}