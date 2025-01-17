---
title: Версионирование дашборда
description: Версионирование дашборда — это возможность хранить историю изменений конфигурации дашборда с помощью версий. Список версий доступен пользователям с минимальным правом доступа **Просмотр** на дашборд.
---

# Версионирование

Версионирование дашборда — это возможность хранить историю изменений конфигурации дашборда с помощью версий. Список версий доступен пользователям с минимальным правом доступа **Просмотр** на дашборд.

Чтобы перейти к списку версий, в верхней части экрана нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите **История изменений**.

![image](../../_assets/datalens/concepts/version-list.png)

Чтобы перейти к выбранной версии, нажмите на нее в списке. Номер версии отобразится в значении параметра `revId` строки адреса дашборда. При переходе по ссылке, содержащей номер версии в параметре `revId`, сразу откроется эта версия дашборда.

## Виды версий {#version-types}

Различают следующие версии:

* **Актуальная**. Последняя сохраненная версия дашборда. Отображается всем пользователям, если открыть дашборд на просмотр из панели навигации. Актуальной может быть только одна версия дашборда.
  
  ![image](../../_assets/datalens/concepts/current-version.png)
  
* **Черновик**. Версия, которая содержит несохраненные изменения дашборда. Основные пользователи не видят изменений, которые вносятся в черновик. Это позволяет скрывать редактирование дашборда до актуализации версии. Дашборд может иметь только один черновик.

  ![image](../../_assets/datalens/concepts/draft-version.png)

* **Неактуальная**. Версия, которая не является актуальной или черновиком.

  ![image](../../_assets/datalens/concepts/old-version.png)

## Создание новой версии {#version-create}

Новая версия автоматически создается после нажатия кнопки **Сохранить** в режиме редактирования дашборда. Изменения конфигурации дашборда, которые приводят к созданию новой версии:

* изменение настроек дашборда, доступных при нажатии на значок ![image](../../_assets/console-icons/gear.svg) вверху экрана;
* добавление, переименование, удаление вкладок дашборда;
* редактирование связей;
* добавление и удаление виджетов;
* редактирование виджетов типа [Заголовок](#title) и [Текст](#text);
* редактирование табов виджетов;
* редактирование настроек селекторов.

## Ограничения {#restrictions}

* История изменений содержит только список версий дашбордов и включает: вид версии, дату и время сохранения и автора редактирования.
* Версии дашбордов не содержат:

  * изменений прав доступа (эта операция производится отдельно от редактирования самого дашборда);
  * изменений настроек графиков — те настройки графика, которые производятся в Визарде, QL-чарте или в Editor;
  * изменений настроек датасетов, которые производятся в интерфейсе датасета;
  * изменений настроек подключения, производимых в интерфейсе редактирования параметров подключения;
  * изменений данных в источнике (добавление, обновление или удаление строк в источнике данных).

* В версиях не отображается список изменений. Доступен лишь просмотр сохраненного состояния конфигурации дашборда.
