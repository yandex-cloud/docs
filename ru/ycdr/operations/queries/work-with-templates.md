---
title: Работа с шаблонами запросов в {{ ycdr-full-name }}
description: Следуя данной инструкции, вы научитесь работать с шаблонами запросов в {{ ycdr-name }}.
---

# Работа с шаблонами запросов

{% include [preview-by-request](../../../_includes/note-preview-by-request.md) %}

Шаблоны позволяют сохранять часто используемые запросы и быстро применять их в расследованиях.

Доступны следующие категории шаблонов:

* **{{ ui-key.yacloud_org.security.siem.my_8uT22 }}** — шаблоны, созданные пользователем и доступные ему в разных расследованиях.
* **{{ ui-key.yacloud_org.security.siem.template_type_local_77J2t }}** — доступны всем пользователям, но привязаны к определенному расследованию.
* **{{ ui-key.yacloud_org.security.siem.template_type_global_qSrVE }}** — доступны всем пользователям во всех расследованиях.

## Открытие панели шаблонов {#open-templates-panel}

Чтобы открыть панель шаблонов:

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Откройте расследование.
  1. Нажмите **{{ ui-key.yacloud_org.security.ycdr.query-data-panel.title_xK9v2 }}** в правой части экрана.
  1. Перейдите на вкладку **{{ ui-key.yacloud_org.security.ycdr.query-data-panel.tab-templates_tPl3Q }}**.

{% endlist %}

## Навигация по папкам шаблонов {#navigate-template-folders}

Внутри каждой категории шаблоны могут быть организованы в папки. Папки создаются и называются пользователем для удобной навигации и группировки шаблонов по типу угрозы, источнику событий или этапу расследования.

Чтобы перейти в папку:

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Откройте панель шаблонов.
  1. Выберите категорию в селекторе.
  1. Выберите нужную папку из списка.

{% endlist %}

## Поиск шаблона {#search-template}

Чтобы найти шаблон:

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Откройте панель шаблонов.
  1. Введите поисковый запрос в поле поиска.
  1. Результаты отобразятся автоматически.

  Поиск выполняется по названию и содержимому шаблона.

{% endlist %}

## Вставка шаблона в запрос {#insert-template}

Чтобы вставить шаблон в текущий запрос:

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Откройте панель шаблонов.
  1. Найдите нужный шаблон.
  1. Нажмите на шаблон.
  1. Выберите **{{ ui-key.yacloud_org.security.siem.action_insert_into_query_kR3x1 }}**.

  Текст шаблона будет добавлен в редактор запросов.

{% endlist %}

## Создание нового запроса из шаблона {#create-query-from-template}

Чтобы создать новый запрос из шаблона:

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Откройте панель шаблонов.
  1. Найдите нужный шаблон.
  1. Нажмите на шаблон.
  1. Выберите **{{ ui-key.yacloud_org.security.siem.action_new_query_from_template_pL7m2 }}**.

  Будет создана новая вкладка с запросом на основе шаблона.

{% endlist %}

## Сохранение запроса как шаблон {#save-as-template}

Чтобы сохранить текущий запрос как шаблон:

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Откройте запрос, который хотите сохранить.
  1. В меню действий выберите **Сохранить как шаблон**.
  1. Введите название шаблона.
  1. Выберите папку для сохранения:
     * **{{ ui-key.yacloud_org.security.siem.my_8uT22 }}** — для личного использования;
     * **{{ ui-key.yacloud_org.security.siem.template_type_local_77J2t }}** — для всех пользователей инстанса.
  1. Нажмите **{{ ui-key.yacloud_org.security.siem.title_ap766 }}**.

{% endlist %}

## Создание папки для шаблонов {#create-template-folder}

Чтобы создать папку для шаблонов:

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Откройте панель шаблонов.
  1. Перейдите в категорию **{{ ui-key.yacloud_org.security.siem.my_8uT22 }}** или **{{ ui-key.yacloud_org.security.siem.template_type_local_77J2t }}**.
  1. Нажмите **{{ ui-key.yacloud_org.security.siem.action_new_folder_qmx81 }}**.
  1. Введите название папки.
  1. Нажмите **Создать**.

{% endlist %}

## Управление шаблонами {#manage-templates}

### Переименование шаблона {#rename-template}

Чтобы переименовать шаблон:

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Откройте панель шаблонов.
  1. Найдите нужный шаблон.
  1. Нажмите правой кнопкой мыши на шаблон.
  1. Выберите **{{ ui-key.yacloud_org.security.siem.action_rename_vN4w3 }}**.
  1. Введите новое название.
  1. Нажмите **Сохранить**.

{% endlist %}

### Удаление шаблона {#delete-template}

Чтобы удалить шаблон:

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Откройте панель шаблонов.
  1. Найдите нужный шаблон.
  1. Нажмите правой кнопкой мыши на шаблон.
  1. Выберите **{{ ui-key.yacloud_org.security.siem.action_delete_wM5k5 }}**.
  1. Подтвердите удаление.

  {% note info %}

  Удалить можно только шаблоны из категорий **{{ ui-key.yacloud_org.security.siem.my_8uT22 }}** и **{{ ui-key.yacloud_org.security.siem.template_type_local_77J2t }}**. Общие шаблоны недоступны для удаления.

  {% endnote %}

{% endlist %}

#### См. также {#see-also}

* [{#T}](../../concepts/investigations.md).
* [{#T}](../../concepts/queries.md).
* [{#T}](manage-queries.md).
* [{#T}](work-with-schema-datasets.md).