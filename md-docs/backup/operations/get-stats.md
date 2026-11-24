[Документация Yandex Cloud](../../index.md) > [Yandex Cloud Backup](../index.md) > [Пошаговые инструкции](index.md) > Посмотреть статистику резервного копирования

# Посмотреть статистику резервного копирования


Cloud Backup автоматически передает в [Monium Metrics](../../monium/metrics/overview.md) метрики количества [защищаемых ресурсов](../concepts/index.md#protected-resources) и объема хранилища, занятого резервными копиями.

Чтобы посмотреть статистику:

{% list tabs group=instructions %}

- Интерфейс Monium {#console}

  1. [Перейдите](https://monium.yandex.cloud) в Monium.
  1. На панели сверху выберите [проект](../../monium/concepts/glossary.md#project), соответствующий [каталогу](../../resource-manager/concepts/resources-hierarchy.md#folder) с защищаемыми ресурсами.

      Идентификатор проекта имеет вид `folder__<идентификатор_каталога>`.
  1. На панели слева выберите ![layout-cells-large](../../_assets/console-icons/layout-cells-large.svg) **Дашборды** и перейдите на вкладку **Сервисные дашборды**.
  1. В открывшемся списке выберите сервисный дашборд **Cloud Backup**.
  1. В поле **Resource name** выберите защищаемый ресурс, для которого вы хотите посмотреть статистику.

      Чтобы посмотреть общую статистику по всем защищаемым ресурсам в каталоге, выберите `*`.
  1. Выберите временной промежуток, за который хотите посмотреть статистику.
  1. Если нужно обновить дашборд, нажмите кнопку ![arrows-rotate-right](../../_assets/console-icons/arrows-rotate-right.svg). Также рядом с кнопкой вы можете задать частоту автообновления статистики.

{% endlist %}

{% note tip %}

Кроме просмотра метрик вы можете [настроить](configure-alerts.md) алерты, чтобы получать уведомления об изменениях метрик.

{% endnote %}

#### Полезные ссылки {#see-also}

* [Настроить алерты Yandex Monium для ресурсов Yandex Cloud Backup](configure-alerts.md)
* [Справочник метрик Monium Metrics](../metrics.md)