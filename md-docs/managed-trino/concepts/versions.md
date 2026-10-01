[Документация Yandex Cloud](../../index.md) > [Yandex Managed Service for Trino](../index.md) > [Концепции](index.md) > Версионирование в Managed Service for Trino

# Версионирование в Managed Service for Trino

## Доступные версии Trino {#available-versions}

Сервис Managed Service for Trino поддерживает следующие версии Trino:

#|
|| **Версия Trino** | **История изменений** ||
|| `461` | [Описание версии](https://trino.io/docs/current/release/release-461.html) ||
|| `468` | [Описание версии](https://trino.io/docs/current/release/release-468.html) ||
|| `476` | [Описание версии](https://trino.io/docs/current/release/release-476.html) ||
|| `483` | [Описание версии](https://trino.io/docs/current/release/release-483.html) ||
|#

При создании кластера по умолчанию используется версия `483`.

## Обновление версий {#update}

Версию Trino можно повысить или понизить до любой поддерживаемой версии. Перед обновлением изучите [историю изменений Trino](https://trino.io/docs/current/release.html) и проверьте новую версию на тестовом кластере.

Обновления и исправления внутри одной версии устанавливаются автоматически во время [технического обслуживания](maintenance.md).

Чтобы изменить версию Trino, воспользуйтесь [инструкцией](../operations/cluster-version-update.md).