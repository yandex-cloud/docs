---
title: "Информация о кластерах в {{ mmy-short-name }}"
description: "Вы можете запросить детальную информацию о каждом созданном вами кластере {{ mmy-short-name }}. Чтобы получить список кластеров БД в каталоге, перейдите на страницу каталога и выберите сервис {{ mmy-name }}."
---

# Информация об имеющихся кластерах

Вы можете запросить детальную информацию о каждом созданном вами кластере {{ mmy-short-name }}.


## Получить список кластеров БД в каталоге {#list-clusters}

{% list tabs %}

- Консоль управления

  Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ mmy-name }}**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы запросить список {{ MY }}-кластеров в каталоге по умолчанию, выполните команду:

  ```
  {{ yc-mdb-my }} cluster list
  ```

  Результат:

  ```
  +----------------------+--------------+---------------------+--------+---------+
  |          ID          |     NAME     |     CREATED AT      | HEALTH | STATUS  |
  +----------------------+--------------+---------------------+--------+---------+
  | c9q5k4ve76jspng95lav | mysql-test   | 2019-07-09 11:05:25 | ALIVE  | RUNNING |
  | ...                                                                          |
  +----------------------+--------------+---------------------+--------+---------+
  ```

- API

  Воспользуйтесь методом API [list](../api-ref/Cluster/list.md) и передайте идентификатор каталога в параметре `folderId` запроса.

{% endlist %}


## Получить детальную информацию о кластере {#get-cluster}

{% list tabs %}

- Консоль управления

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ mmy-name }}**.
  1. Нажмите на имя нужного кластера.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы получить информацию о {{ MY }}-кластере, выполните команду:

  ```
  {{ yc-mdb-my }} cluster get <имя или идентификатор кластера>
  ```

  Идентификатор и имя кластера можно запросить со [списком кластеров в каталоге](#list-clusters).

- API

  Воспользуйтесь методом API [get](../api-ref/Cluster/get.md) и передайте в запросе идентификатор кластера в параметре `clusterId`.

  {% include [Получение идентификатора кластера](../../_includes/mdb/mmy/note-api-get-cluster-id.md) %}

{% endlist %}

## Посмотреть список операций в кластере {#list-operations}

{% include [list-operations-about](../../_includes/mdb/list-operations-about.md) %}

{% list tabs %}

- Консоль управления

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ mmy-name }}**.
  1. Нажмите на имя нужного кластера.
  1. На панели слева выберите ![image](../../_assets/mdb/operations.svg) **Операции**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы получить список операций, выполните команду:

  ```
  {{ yc-mdb-my }} cluster list-operations <имя или идентификатор кластера>
  ```

  Идентификатор и имя кластера можно запросить со [списком кластеров в каталоге](#list-clusters).

- API

  Воспользуйтесь методом API [listOperations](../api-ref/Cluster/listOperations.md) и передайте в запросе идентификатор кластера в параметре `clusterId`.

  {% include [Получение идентификатора кластера](../../_includes/mdb/mmy/note-api-get-cluster-id.md) %}

{% endlist %}
