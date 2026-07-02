[Документация Yandex Cloud](../../index.md) > [Yandex Security Deck](../index.md) > Диагностика ошибок > Обзор

# Диагностика ошибок в Yandex Security Deck

В интерфейсе Security Deck собраны все ошибки в работе следующих модулей:

* [Управление уязвимостями (VM)](vm-diagnostic.md)
* [Обнаружение угроз (TD)](td-diagnostics.md)
* [Контроль Kubernetes® (KSPM)](kspm-diagnostics.md)
* [Контроль конфигурации (CSPM)](cspm-diagnostics.md)
* [Контроль данных (DSPM)](dspm-diagnostics.md)

Чтобы посмотреть обнаруженные ошибки:

{% list tabs group=instructions %}

- Интерфейс Security Deck {#cloud-sd}

  1. Перейдите в сервис [Yandex Security Deck](https://center.yandex.cloud/security/).
  1. В верхней части окна выберите [окружение](*popup-1).
  1. На панели слева нажмите ![vector-circle](../../_assets/console-icons/vector-circle.svg) **Окружение**.
  1. Перейдите на вкладку **Уведомления**.
  1. Выберите модуль. Отобразится таблица со следующими столбцами:
     
     * `Сообщение` — текст ошибки.
     * `Источник` — ресурс, в котором была обнаружена ошибка.
     * `Дата` — дата обнаружения ошибки.

{% endlist %}

[*popup-1]: _Окружение Security Deck_ — это контейнер, который содержит настройки и ресурсы модулей Security Deck, перечень контролируемых ресурсов, параметры контроля и другие настройки.