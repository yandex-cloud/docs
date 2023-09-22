# Устранение ошибки 422 UNPROCESSABLE ENTITY The specified extension <'ext_name'> is not present in shared_preload_libraries


## Описание проблемы {#issue-description}

При попытке установить нужное расширение на базу данных по [инструкции](../../../managed-postgresql/operations/extensions/cluster-extensions) возникает ошибка:
```
«422 UNPROCESSABLE ENTITY The specified extension 'EXT_NAME'
is not present in shared_preload_libraries.»
```

## Решение {#issue-resolution}

Указанная ошибка говорит о неустановленном флаге `EXT_NAME` в кластере.

Пожалуйста, установите его следующим образом: **Обзор кластера** -> **Изменить кластер** -> **Настройки СУБД** -> **Shared preload libraries**, выбрать `EXT_NAME`. После можно установить расширение.

{% note alert %}

Внесение изменений в настройки кластера приведёт к перезагрузке сервера PostgreSQL.

{% endnote %}

Подробнее об управлении расширениями рассказываем в [документации](../../../managed-postgresql/operations/extensions/cluster-extensions).