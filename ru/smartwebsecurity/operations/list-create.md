---
title: Как создать, изменить, удалить черный или белый список IP-адресов
description: Следуя данной инструкции, вы сможете управлять списками IP-адресов.
---

# Управление списками адресов

{% include [lists-preview](../../_includes/smartwebsecurity/lists-preview.md) %}

Вы можете управлять только пользовательскими списками адресов. Предустановленные списки {{ yandex-cloud }} изменять нельзя.

## Создать список

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. На панели слева выберите ![image](../../_assets/smartwebsecurity/list.svg) **Списки** и нажмите **Создать список**.
  1. Введите имя и описание списка.
  1. При необходимости добавьте метку.
  1. Нажмите **Создать список** и затем **Добавить адреса**.
  1. Введите IP-адреса, диапазоны адресов или префиксы в формате [CIDR](https://ru.wikipedia.org/wiki/Бесклассовая_адресация). Дополнительно к каждому адресу можно добавить описание.
  1. Чтобы загрузить готовый список:
     1. Нажмите **Загрузить из файла**.
     1. Выберите файл со списком в формате `txt` или `csv`.
     
        При загрузке файла прежний список не сохранится, а будет заменен на новый.
  1. Нажмите **Сохранить изменения**.

Теперь при добавлении правила в профиле безопасности или ARL вы можете выбрать условие для IP-адреса: **Принадлежит списку** или **Не принадлежит списку**.

{% endlist %}

## Скачать список

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. На панели слева выберите ![image](../../_assets/smartwebsecurity/list.svg) **Списки**.
  1. Нажмите строку с нужным списком.
  1. Слева выберите раздел **IP-адреса**.
  1. Нажмите **Скачать список**.
     
     Список будет сохранен в формате `csv`.

{% endlist %}

## Изменить параметры списка

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. На панели слева выберите ![image](../../_assets/smartwebsecurity/list.svg) **Списки**.
  1. В строке с нужным списком нажмите ![options](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.edit }}**.
  1. Измените имя и описание списка, добавьте или удалите метки.
  1. Нажмите **Сохранить изменения**.

{% endlist %}

## Изменить состав адресов списка

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. На панели слева выберите ![image](../../_assets/smartwebsecurity/list.svg) **Списки**.
  1. Нажмите строку с нужным списком.
  1. Слева выберите раздел **IP-адреса**.
  1. Чтобы изменить описание для одного или нескольких адресов, выберите их в списке и нажмите **Изменить описание**.
  1. Чтобы удалить один или несколько адресов, выберите их в списке и нажмите **Удалить**.
  1. Чтобы отредактировать адреса в текстовом формате или загрузить новый файл с адресами:
     1. Нажмите **Изменить список IP-адресов**.
     1. Отредактируйте список или загрузите новый файл с адресами.
     1. Нажмите **Сохранить изменения**.

{% endlist %}

## Удалить список

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. На панели слева выберите ![image](../../_assets/smartwebsecurity/list.svg) **Списки** 
  1. В строке с нужным списком нажмите ![options](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.delete }}**.

{% endlist %}

### См. также {#see-also}

* [{#T}](../concepts/lists.md)
* [{#T}](../concepts/conditions.md)
* [{#T}](rule-add.md)
* [{#T}](arl-rule-add.md)