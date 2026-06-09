# Устранение ошибки `422 UNPROCESSABLE ENTITY The specified extension <'ext_name'> is not present in shared_preload_libraries`


## Описание проблемы {#issue-description}

При попытке установить нужное расширение на базу данных по этой [инструкции](../../../managed-postgresql/operations/extensions/cluster-extensions.md) возникает ошибка:
```
«422 UNPROCESSABLE ENTITY The specified extension 'EXT_NAME'
is not present in shared_preload_libraries.»
```

## Решение {#issue-resolution}

Указанная ошибка говорит о неустановленном флаге `EXT_NAME` в кластере.

Пожалуйста, установите его следующим образом: **Обзор кластер** → **Изменить кластер** → **Настройки СУБД** → **Shared preload libraries**, затем выберите `EXT_NAME`. После этого можно установить расширение.

{% note alert %}

Внесение изменений в настройки кластера приведет к перезагрузке сервера {{ PG }}.

{% endnote %}

Подробнее об управлении расширениями рассказываем в [документации](../../../managed-postgresql/operations/extensions/cluster-extensions.md).