---
sourcePath: overlay/getting_started/ydb_recipe.md
---
# Использование рецепта YDB

В разделе приведены инструкции для локального запуска базы YDB. Чаще всего он запускается локально в автоматических тестах, однако также может использоваться и для отладки работы с базой YDB в приложении.

## Введение { #introduction }

Локальный YDB запускается в режиме однонодной конфигурации. В режиме локального запуска предоставляется только API для для работы с базой.
При запуске выбирается временный порт, API для работы с данными разворачивается на этом порту.

В рецепте используется предсобранная сборка YDB. Эта сборка обновляется после очередного релиза YDB. Версия сборки обычно аналогичная той,
что используется в продуктовых инсталяциях, однако может отличаться от фактической.

## Запуск из тестов в Аркадии { #running-from-test }

Для запуска рецепта из теста необходимо указать следующий макрос в файле `ya.make`, который относится к тесту:

```bash
INCLUDE(${ARCADIA_ROOT}/kikimr/public/tools/ydb_recipe/recipe_stable.inc)
```

Рецепт записывает имя базы и адрес для доступа в переменные окружения. Имя базы сохраняется в переменную окружения ``YDB_DATABASE``, адрес доступа в переменную окружения ``YDB_ENDPOINT``.
Пример инициализации драйвера на различных языках программирования:

{% list tabs %}

- Python

  ```python
  import os

  from kikimr.public.sdk.python import client as ydb

  driver = ydb.Driver(
      ydb.DriverConfig(
        endpoint=os.getenv("YDB_ENDPOINT"),
        database=os.getenv("YDB_DATABASE"),
      )
  )
  ```

- C++

  ```cpp
  #include <util/system/env.h>

  NYdb::TDriver GetDriver() {
    auto config = NYdb::TDriverConfig()
        .SetEndpoint(GetEnv("YDB_ENDPOINT"))
        .SetDatabase(GetEnv("YDB_DATABASE"));
    return NYdb::TDriver(config);
  }
  ```

- Java

  ```java
  import com.yandex.ydb.core.grpc.GrpcTransport;

  String ydbDatabase = System.getenv("YDB_DATABASE");
  String ydbEndpoint = System.getenv("YDB_ENDPOINT");
  GrpcTransport = GrpcTransport.forEndpoint(ydbEndpoint, ydbDatabase).build();

  ```

{% endlist %}

## Примеры { #test-local-ydb-examples }

Примеры использования рецепта на разных языках программирования доступны в Аркадии в директории [kikimr/public/tools/ydb_recipe/examples](https://a.yandex-team.ru/arc/trunk/arcadia/kikimr/public/tools/ydb_recipe/examples).
