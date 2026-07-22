[Документация Yandex Cloud](../../index.md) > [Yandex Cloud Desktop](../index.md) > Концепции > Квоты и лимиты

# Квоты и лимиты в Cloud Desktop

В сервисе Cloud Desktop действуют следующие ограничения:

* [_Квоты_](https://console.yandex.cloud/cloud?section=quotas) — организационные ограничения, которые можно изменить по запросу в техническую поддержку.
* _Лимиты_ — технические ограничения, обусловленные особенностями архитектуры Yandex Cloud. Изменить лимиты невозможно.

Если вам необходимо больше ресурсов, увеличьте квоты одним из способов:

* [Сформируйте запрос на увеличение](https://console.yandex.cloud/cloud?section=quotas).
* Обратитесь в [техническую поддержку](https://center.yandex.cloud/support) и расскажите, какие потребляемые квоты нужно увеличить и на сколько.

Чтобы ваш запрос был рассмотрен, у вас должна быть [роль](../../iam/roles-reference.md#quota-manager-requestoperator) `quota-manager.requestOperator` или выше (`editor` или `admin`).

Управлять квотами позволяет сервис [Cloud Quota Manager](../../quota-manager/quickstart.md).

#### Квоты {#quotas}

#|
|| Вид ограничения | Значение ||
|| Количество рабочих столов
   `vdi.desktops.count` | 10 ||
|| Количество образов рабочих столов
   `vdi.desktopImages.count` | 8 ||
|| Суммарный размер образов рабочих столов
   `vdi.desktopImages.size` | 1 ТБ ||
|| Количество vCPU рабочих столов
   `vdi.desktopCores.count` | 40 ||
|| Общий объём RAM рабочих столов
   `vdi.desktopMemory.size` | 80 ГБ ||
|| Общий объём HDD-дисков 
   `vdi.hddDisks.size` | 600 ГБ ||
|| Общий объём SSD-дисков 
   `vdi.ssdDisks.size` | 600 ГБ ||
|#