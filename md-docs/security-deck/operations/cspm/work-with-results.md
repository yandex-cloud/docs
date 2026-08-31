[Документация Yandex Cloud](../../../index.md) > [Yandex Security Deck](../../index.md) > [Пошаговые инструкции](../index.md) > [Контроль конфигурации (CSPM)](index.md) > Управлять результатами проверок

# Управлять результатами проверок в CSPM

После завершения проверки в интерфейсе доступны следующие операции с ее результатами:

* [просмотр истории](#view);
* [скачивание результатов](#download).

Результаты некоторых проверок могут быть недоступны. Подробнее читайте в разделе [Лимиты модуля CSPM](../../concepts/limits.md#sd-cspm-limits).

## Посмотреть результаты проверки {#view}

{% list tabs group=instructions %}

- Интерфейс Security Deck {#cloud-sd}

  1. Перейдите в сервис [Yandex Security Deck](https://center.yandex.cloud/security/).
  1. На панели слева выберите **Контроль облачной конфигурации**.
  1. На вкладке **История проверок** отобразится список со всеми запущенными и выполненными проверками. По каждой проверке доступны следующие данные:

     * Дата и время проверки.
     * Выявленное количество нарушенных правил.
     * Критичность обнаруженных нарушений:
       * ![cspm-rule-notice-icon](../../../_assets/security-deck/cspm-rule-notice-icon.svg) — Замечание;
       * ![cspm-low-severity-icon](../../../_assets/security-deck/cspm-low-severity-icon.svg) — Низкая критичность.
       * ![cspm-moderate-severity-icon](../../../_assets/security-deck/cspm-moderate-severity-icon.svg) — Средняя критичность.
       * ![cspm-high-severity-icon](../../../_assets/security-deck/cspm-high-severity-icon.svg) — Высокая критичность.
       * ![alt](../../../_assets/common/no.svg) — Максимальная критичность.
     * Количество ресурсов, проверенных в результате платных и бесплатных проверок.
     * Статус проверки.
     * Идентификатор проверки.

   1. Чтобы посмотреть уведомления по проверкам, перейдите на вкладку **Уведомления**.

{% endlist %}

## Скачать результаты проверки {#download}

При скачивании CSV-файл с результатами проверки сохраняется локально на вашем компьютере.

{% note info %}

Файл может содержать не более 10 000 записей о найденных нарушениях.

{% endnote %}

{% list tabs group=instructions %}

- Интерфейс Security Deck {#cloud-sd}

  1. Перейдите в сервис [Yandex Security Deck](https://center.yandex.cloud/security/).
  1. На панели слева выберите **Контроль облачной конфигурации**.
  1. На вкладке **История проверок** справа от проверки нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../../_assets/console-icons/arrow-shape-down-to-line.svg) **Скачать отчёт**.

  Результаты последней проверки также можно получить, нажав на кнопку ![image](../../../_assets/console-icons/chevron-down.svg) **Ещё** → ![image](../../../_assets/console-icons/file-arrow-down.svg) **Скачать отчёт**.

  Информация об обнаруженных проблемах безопасности также отправляется в виде алертов и доступна по кнопке ![alerts](../../../_assets/security-deck/alerts.svg) **Алерты** на панели слева.

{% endlist %}