---
title: "Как управлять подключениями. Пошаговые инструкции"
description: "Пошаговые инструкции по работе с {{ connection-manager-name }} в {{ yandex-cloud }}. Из статьи вы узнаете, как просматривать подключения."
---

# Просмотр информации о подключении

{% include notitle [preview](../../_includes/note-preview.md) %}

Чтобы посмотреть созданные подключения:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. Выберите сервис **{{ metadata-hub-name }}**.
  1. Hа панели слева выберите ![image](../../_assets/console-icons/plug-connection.svg) **Connection manager**.
  1. Нажмите на строку подключения для просмотра детальной информации о нем.

{% endlist %}

Для выбранного подключения вы можете просмотреть информацию о зависимостях от других сервисов и выполненных операциях.

## Просмотр зависимостей подключения {#dependencies}

{% list tabs group=instructions %}

- Консоль управления {#console}
  
  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. Выберите сервис **{{ metadata-hub-name }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/plug-connection.svg) **Connection manager** и нажмите на имя нужного подключения.
  1. На панели слева выберите ![image](../../_assets/console-icons/nodes-right.svg) **Зависимости**.

     В списке зависимостей показываются кластеры управляемых баз данных и экземпляры сервисов, которые используют {{ connection-manager-name }} для хранения информации о подключениях. Нажмите на строку в списке зависимостей, чтобы перейти к кластеру или экземпляру сервиса.

{% endlist %}

## Просмотр выполненных операций {#operations}

{% list tabs group=instructions %}

- Консоль управления {#console}
  
  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. Выберите сервис **{{ metadata-hub-name }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/plug-connection.svg) **Connection manager** и нажмите на имя нужного подключения.
  1. На панели слева выберите ![image](../../_assets/console-icons/list-check.svg) **Операции**.
  
     В списке операций вы можете просмотреть все операции выбранного подключения с момента его создания:
  
     * `Create` — подключение создано;
     * `Update` — подключение изменено;
     * `Detele` — подключение удалено;
     * `Set access bindings` — назначены роли пользователям данного подключения;
     * `Update access bindings` — изменены роли пользователей данного подключения.
     
     Вы также можете просмотреть технические операции:
     
     * `Bump version` — обновлена версия секрета для подключений MDB;
     * `Update references` — обновлены ссылки на подключение;
     * `Update version references` — обновлены ссылки на версию подключения при создании или удалении бекапа кластера MDB;
     * `Delete version` — удалена версия подключения после удаления последнего бэкапа кластера MDB.
       
{% endlist %}