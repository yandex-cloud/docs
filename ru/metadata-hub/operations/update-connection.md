---
title: Как изменить подключение {{ metadata-hub-name }}. Пошаговые инструкции
description: Пошаговые инструкции по работе с {{ connection-manager-name }} в {{ yandex-cloud }}. Из статьи вы узнаете, как изменять подключения.
---

# Изменение подключения

{% include notitle [preview](../../_includes/note-preview.md) %}

Для изменения настроек подключения:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. Выберите сервис **{{ metadata-hub-full-name }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_connection-manager }}**.
  1. В списке подключений нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) справа в строке подключения, которое вы хотите изменить.
  1. Выберите пункт **{{ ui-key.yacloud.common.edit }}**.
  1. Измените требуемые параметры подключения, такие как описание, метки, настройки сервера базы данных или данные аутентификации пользователя.
  1. Нажмите **{{ ui-key.yacloud.common.apply }}** для сохранения изменений.

{% endlist %}


