# Посмотреть статистику резервного копирования


Cloud Backup автоматически поставляет метрики количества защищенных виртуальных машин и серверов Yandex BareMetal, а также объема хранилища, занятого резервными копиями, в сервис [Yandex Monitoring](../../monitoring/index.md).

Чтобы посмотреть статистику:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создана [политика](../concepts/policy.md) резервного копирования.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Monitoring**.
  1. Выберите дашборд — **Cloud Backup**
  1. В поле **Resource name** выберите виртуальную машину или сервер BareMetal, для которых вы хотите посмотреть статистику.

     Если в поле выбрано значение `*`, на дашборде будет отображаться обобщенная статистика по всем ВМ и серверам BareMetal в каталоге.

  1. Выберите временной промежуток, за который хотите посмотреть статистику.
  1. Если нужно обновить дашборд, нажмите кнопку ![](../../_assets/console-icons/arrows-rotate-right.svg). Также рядом с кнопкой вы можете задать частоту автообновления статистики.

{% endlist %}

{% note tip %}

Кроме просмотра метрик вы можете [настроить](configure-alerts.md) алерты, чтобы получать уведомления об изменениях метрик.

{% endnote %}

#### См. также {#see-also}

* [Настроить алерты Yandex Monium для ресурсов Yandex Cloud Backup](configure-alerts.md)
* [Справочник метрик Yandex Monitoring](../metrics.md)