[Документация Yandex Cloud](../../index.md) > [Yandex Managed Service for PostgreSQL](../index.md) > [Пошаговые инструкции](index.md) > Кластеры > Управление алиасами хостов

# Управление алиасами хостов

Вы можете назначить каждому хосту кластера Managed Service for PostgreSQL алиас — пользовательское сетевое имя. Алиас соответствует отдельной DNS-записи, всегда указывающей на хост, который привязан к алиасу. Это позволит обращаться к хосту по стабильному человекочитаемому имени, независимо от внутреннего FQDN хоста. Алиас должен быть уникален в рамках каталога. Для каждого хоста можно назначить только один алиас.

Формат алиаса:

```
h-<имя_алиаса>-pg-<идентификатор_каталога>.rw.mdb.yandexcloud.net
```

{% note info %}

При создании алиаса задается только его имя.

{% endnote %}

## Получить список алиасов {#list-aliases}

Для получения списка алиасов требуется роль не ниже [managed-postgresql.viewer](../security/index.md#managed-postgresql-viewer) на каталог.


### Получить список алиасов в кластере {#list-aliases-in-cluster}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Перейдите](https://console.yandex.cloud/link/managed-postgresql) в сервис **Managed Service for&nbsp;PostgreSQL**.
  1. Нажмите на имя нужного кластера, затем выберите вкладку **Хосты**.

      Все созданные в кластере алиасы хостов перечислены в списке хостов в колонке **Алиас хоста**.


{% endlist %}


## Получить алиас хоста {#get-host-alias}

Для просмотра алиаса требуется роль не ниже [managed-postgresql.viewer](../security/index.md#managed-postgresql-viewer) на каталог.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Перейдите](https://console.yandex.cloud/link/managed-postgresql) в сервис **Managed Service for&nbsp;PostgreSQL**.
  1. Нажмите на имя нужного кластера, затем выберите вкладку **Хосты** и найдите в списке хостов нужный хост. Алиас хоста указан в колонке **Алиас хоста**.


{% endlist %}


## Создать алиас хоста {#create-alias}

Для создания алиаса требуется роль не ниже [managed-postgresql.editor](../security/index.md#managed-postgresql-editor) на каталог.

{% note warning %}

Между завершением операции и доступностью алиаса может пройти некоторое время, пока не завершится распространение DNS-записей (DNS propagation).

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Перейдите](https://console.yandex.cloud/link/managed-postgresql) в сервис **Managed Service for&nbsp;PostgreSQL**.
  1. Нажмите на имя нужного кластера, затем выберите вкладку **Хосты**.
  1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) в строке нужного хоста и выберите пункт **Создать алиас**.
  1. В открывшемся окне введите алиас и нажмите кнопку **Создать алиас**.

      Имя алиаса может содержать строчные буквы латинского алфавита, цифры и дефисы. Длина алиаса до 63 символов.


{% endlist %}

## Удалить алиас {#delete-alias}

Для удаления алиаса требуется роль не ниже [managed-postgresql.editor](../security/index.md#managed-postgresql-editor) на каталог.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Перейдите](https://console.yandex.cloud/link/managed-postgresql) в сервис **Managed Service for&nbsp;PostgreSQL**.
  1. Нажмите на имя нужного кластера, затем выберите вкладку **Хосты**.
  1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) в строке нужного хоста и выберите пункт **Удалить алиас**.
  1. В открывшемся окне нажмите кнопку **Удалить**.


{% endlist %}