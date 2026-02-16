---
title: История изменений в {{ resmgr-full-name }}
description: В разделе представлена история изменений сервиса {{ resmgr-name }}.
---

# История изменений в {{ resmgr-full-name }}

{% include [Tags-nosql](../_includes/release-notes-tags-nosql.md) %}


## II квартал 2025 {#q2-2025}

* Добавлена возможность [создания](./operations/cloud/create.md#cli) и [переименования](./operations/cloud/update.md#cli) облака с помощью {{ yandex-cloud }} CLI. {{ tag-cli }}

## I квартал 2024 {#q1-2024}

* Добавлено автоматическое удаление ограничений на каталогах при [удалении](operations/cloud/delete.md) облака.
* Исправлена ошибка удаления ресурсов [{{ cloud-apps-name }}](../cloud-apps/) при удалении ресурсов облака.
* Добавлена поддержка удаления ресурсов [{{ maf-name }}](../managed-airflow/) при удалении ресурсов облака.