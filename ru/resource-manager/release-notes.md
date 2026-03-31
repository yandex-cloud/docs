---
title: История изменений в {{ resmgr-full-name }}
description: В разделе представлена история изменений сервиса {{ resmgr-name }}.
---

# История изменений в {{ resmgr-full-name }}

{% include [Tags-nosql](../_includes/release-notes-tags-nosql.md) %}


## Март 2026 {#march-2026}

* Добавлена поддержка параметра `--parameters` в следующих командах: {{ tag-cli }}
  * `yc resource-manager folder bind-access-policy`;
  * `yc resource-manager cloud bind-access-policy`.

## Декабрь 2025 {#december-2025}

* Добавлены команды для управления [политиками авторизации](../iam/concepts/access-control/access-policies.md) для [облака](operations/cloud/manage-access-policies.md): {{ tag-cli }}
  * `yc resource-manager cloud list-access-policy-bindings`;
  * `yc resource-manager cloud bind-access-policy`;
  * `yc resource-manager cloud unbind-access-policy`.
* Добавлены команды для управления [политиками авторизации](../iam/concepts/access-control/access-policies.md) для [каталога](operations/folder/manage-access-policies.md): {{ tag-cli }}
  * `yc resource-manager folder list-access-policy-bindings`;
  * `yc resource-manager folder bind-access-policy`;
  * `yc resource-manager folder unbind-access-policy`.

## II квартал 2025 {#q2-2025}

* Добавлена возможность [создания](./operations/cloud/create.md#cli) и [переименования](./operations/cloud/update.md#cli) облака с помощью {{ yandex-cloud }} CLI. {{ tag-cli }}

## I квартал 2024 {#q1-2024}

* Добавлено автоматическое удаление ограничений на каталогах при [удалении](operations/cloud/delete.md) облака.
* Исправлена ошибка удаления ресурсов [{{ cloud-apps-name }}](../cloud-apps/) при удалении ресурсов облака.
* Добавлена поддержка удаления ресурсов [{{ maf-name }}](../managed-airflow/) при удалении ресурсов облака.