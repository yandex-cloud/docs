---
title: "Информация о кластерах в {{ mms-short-name }}"
description: "Вы можете запросить детальную информацию о каждом созданном вами кластере {{ mms-short-name }}. Чтобы получить список кластеров БД в каталоге, перейдите на страницу каталога и выберите сервис {{ mms-name }}."
---

# Информация об имеющихся кластерах

Вы можете запросить детальную информацию о каждом созданном вами кластере {{ mms-short-name }}.

## Получить список кластеров в каталоге {#list-clusters}

{% list tabs %}

- Консоль управления

  Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ mms-name }}**.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы запросить список кластеров {{ MS }} в каталоге, выполните команду:

    ```bash
    {{ yc-mdb-ms }} cluster list
    ```

- API

  Воспользуйтесь методом API [list](../api-ref/Cluster/list.md): передайте значение идентификатора требуемого каталога в параметре `folderId` запроса.

  В ответе будут содержаться имена и идентификаторы кластеров.

{% endlist %}

## Получить детальную информацию о кластере {#get-cluster}

{% list tabs %}

- Консоль управления

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ mms-name }}**.
  1. Нажмите на имя нужного кластера.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы получить информацию о кластере {{ MS }}, выполните команду:

    ```bash
    {{ yc-mdb-ms }} cluster get <идентификатор или имя кластера>
    ```

    Идентификатор и имя кластера можно запросить со [списком кластеров в каталоге](#list-clusters).

- API

  Воспользуйтесь методом API [get](../api-ref/Cluster/get.md): передайте значение идентификатора требуемого кластера в параметре `clusterId` запроса.

  Чтобы узнать идентификатор кластера, [получите список кластеров в каталоге](#list-clusters).

{% endlist %}

## Посмотреть список операций в кластере {#list-operations}

{% include [list-operations-about](../../_includes/mdb/list-operations-about.md) %}

{% list tabs %}

- Консоль управления

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ mms-name }}**.
  1. Нажмите на имя нужного кластера.
  1. Перейдите на вкладку **Операции**.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы получить список операций, выполните команду:

    ```bash
    {{ yc-mdb-ms }} cluster list-operations <идентификатор или имя кластера>
    ```

    Идентификатор и имя кластера можно запросить со [списком кластеров в каталоге](#list-clusters).

- API

  Воспользуйтесь методом API [listOperations](../api-ref/Cluster/listOperations.md): передайте значение идентификатора требуемого кластера в параметре `clusterId` запроса.

  Чтобы узнать идентификатор кластера, [получите список кластеров в каталоге](#list-clusters).

{% endlist %}
