[Документация Yandex Cloud](../../../../index.md) > [Yandex Managed Service for YDB](../../../index.md) > Document API, совместимый с Amazon DynamoDB > Инструменты > Работа с AWS CLI > Обзор

# Работа с AWS CLI в Managed Service for YDB. Обзор

В разделе описано, как с использованием AWS CLI выполнить следующие операции в YDB:
* [Создание](create-table.md) таблицы.
* [Добавление](put-item.md), [чтение](get-item.md) и [обновление](update-item.md) данных в таблице.
* [Выполнение](query.md) простых запросов.

## Перед началом работы {#before-you-begin}

1. [Настройте окружение AWS](../aws-setup.md).
1. Подготовьте Document API эндпоинт [созданной БД](../../../operations/manage-databases.md).

   {% cut "Как узнать Document API эндпоинт базы данных" %}

   1. Перейдите в [консоль управления](https://console.yandex.cloud).
   1. Выберите нужный каталог и перейдите в сервис **Managed Service for&nbsp;YDB**.
   1. Выберите БД, к которой планируете сделать запрос.
   1. В меню слева перейдите в раздел **Обзор**.
   1. Значение эндпоинта указано в строке **Document API эндпоинт**.

      >Пример значения эндпоинта:
      >
      >```text
      >https://docapi.serverless.yandexcloud.net/ru-central1/b1gia87mbaom********/etnudu2n9ri3********
      >```

   {% endcut %}

   {% note info %}

   Для работы в режиме совместимости с Amazon DynamoDB используйте бессерверную (Serverless) конфигурацию БД.

   {% endnote %}