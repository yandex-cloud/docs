[Документация Yandex Cloud](../../index.md) > [Yandex Managed Service for Trino](../index.md) > [Концепции](index.md) > Отказоустойчивое выполнение запросов

# Отказоустойчивое выполнение запросов в кластере Managed Service for Trino

Отказоустойчивое выполнение запросов в кластере Managed Service for Trino обеспечивается механизмом [Fault tolerant execution](https://trino.io/docs/current/admin/fault-tolerant-execution.html). По умолчанию при недостатке ресурсов или ошибке при выполнении запроса [воркер](index.md#workers) прекращает его обработку. Такой запрос нужно перезапустить вручную. При включении Fault tolerant execution запрос или промежуточное задание в составе запроса будут выполнены повторно в случае сбоя.

Чтобы обеспечить отказоустойчивое выполнение запросов при включенном `Fault tolerant execution`, Exchange Manager периодически выгружает промежуточные результаты в бакет Object Storage. Если запрос не был выполнен, то [координатор](index.md#coordinator) назначит повторное выполнение запроса другому воркеру, который сможет использовать ранее обработанные данные.

{% note info %}

Механизм Fault tolerant execution не распространяется на ошибочные или некорректно составленные запросы.

{% endnote %}

Механизм Fault tolerant execution поддерживается только для следующих [коннекторов](index.md#connector):

* Delta Lake
* Hive
* Iceberg
* Oracle <code><b><small>Preview</small></b></code>
* PostgreSQL
* MS SQL Server <code><b><small>Preview</small></b></code>

Чтобы включить Fault tolerant execution, при [создании](../operations/cluster-create.md) или [изменении](../operations/cluster-update.md#change-retry-policy) кластера выберите в блоке **Политика перезапросов** значение параметра **Тип объекта для перезапроса**:

* **Задача** — в рамках запроса повторно выполняется промежуточное задание, вызвавшее сбой воркера.

   {% note warning %}

   При интенсивном потоке простых запросов повторный запуск заданий может привести к более высокой задержке сложных пакетных запросов. Рекомендуется создать выделенный кластер Managed Service for Trino с настройкой повторного выполнения заданий для сложных пакетных запросов.

   {% endnote %}

* **Запрос** — повторно выполняются все [этапы запроса](index.md#query-execution), в котором произошел сбой воркера.

## Типы хранилища для Exchange Manager {#exchange-manager-storage}

В качестве хранилища для промежуточных результатов Exchange Manager можно использовать один из двух типов бакета:

* **Служебный бакет** — бакет создается и обслуживается на стороне Managed Service for Trino. Дополнительная настройка и оплата не требуются, но размер бакета ограничен. При выполнении запросов с большим объемом промежуточных данных места в служебном бакете может не хватить.
* **Пользовательский бакет** — бакет Object Storage, который вы создаете самостоятельно в своем каталоге. Ограничения на размер бакета определяются [квотами](../../storage/concepts/limits.md) Object Storage, оплата за хранение и операции взимается [по тарифам](../../storage/pricing.md) Object Storage.

    Чтобы кластер Managed Service for Trino мог записывать данные в пользовательский бакет, [сервисному аккаунту](../../iam/concepts/users/service-accounts.md) кластера должна быть назначена роль [storage.editor](../../storage/security/index.md#storage-editor) или роль с аналогичными правами на бакет.

По умолчанию используется служебный бакет. Выбрать тип хранилища можно при [создании](../operations/cluster-create.md) или [изменении](../operations/cluster-update.md#change-retry-policy) кластера.

Подробнее об отказоустойчивом выполнении запросов в [официальной документации](https://trino.io/docs/current/admin/fault-tolerant-execution.html).