# Квоты и лимиты в {{ container-registry-name }}

В сервисе {{ container-registry-full-name }} действуют следующие ограничения:

* [_Квоты_]({{ link-console-quotas }}) — организационные ограничения, которые можно изменить по запросу в техническую поддержку.
* _Лимиты_ — технические ограничения, обусловленные особенностями архитектуры {{ yandex-cloud }}. Изменить лимиты невозможно.

Если вам необходимо больше ресурсов, увеличьте квоты одним из способов:

* [Сформируйте запрос на увеличение]({{ link-console-quotas }}).
* Обратитесь в [техническую поддержку]({{ link-console-support }}) и расскажите, какие потребляемые квоты нужно увеличить и на сколько.

Чтобы ваш запрос был рассмотрен, у вас должна быть [роль](../../iam/roles-reference.md#quota-manager-requestoperator) `quota-manager.requestOperator` или выше (`editor` или `admin`).

Управлять квотами позволяет сервис [{{ quota-manager-name }}](../../quota-manager/quickstart.md).

#### Квоты {#container-registry-quotas}

#|
|| Вид ограничения | Значение ||
|| Максимальное количество [реестров](registry.md) в одном [облаке](../../resource-manager/concepts/resources-hierarchy.md#cloud) 
`container-registry.registries.count` | 10 ||
|| Количество одновременных запусков [сканирования](vulnerability-scanner.md) [Docker-образа](docker-image.md) в одном облаке 
`container-registry.parallelScans.count` | 10 ||
|#


#### Лимиты {#container-registry-limits}

Вид ограничения | Значение
--- | ---
Максимальный размер одного слоя Docker-образа | 150 ГБ
Максимальное количество слоев в сканируемом Docker-образе | 127
Максимальное количество Docker-образов в одном [репозитории](repository.md), которое может проверить тестовый запуск [политики автоматического удаления Docker-образов](lifecycle-policy.md) | 50 000
Максимальный размер Docker-образа для сканирования | 4 ГБ
Максимальное количество Docker-образов, которое можно [сканировать](../operations/scanning-docker-image.md) за один запрос | 10 000