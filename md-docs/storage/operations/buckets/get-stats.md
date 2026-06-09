# Просмотр метрик бакета

Object Storage автоматически отправляет метрики работы бакетов в сервис [Yandex Monitoring](../../../monitoring/index.md).

Вы можете посмотреть общую статистику работы на [странице бакета](#storage-ui) или подробно в [интерфейсе Monitoring](#monitoring).

Полный список метрик представлен в [справочнике](../../metrics.md).

## Посмотреть общую статистику на странице бакета {#storage-ui}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
  1. Перейдите в сервис **Object Storage**.
  1. Выберите бакет, статистику которого вы хотите посмотреть.
  1. На панели слева выберите ![image](../../../_assets/console-icons/display-pulse.svg) **Мониторинг**.
  1. Выберите временной промежуток, за который хотите посмотреть статистику: 1 час, 3 часа, 1 день, 1 неделя, 1 месяц. 

      На странице отображаются дашборды:
      
      * ![image](../../../_assets/console-icons/chart-column.svg) **Read Requests** — количество запросов GET, HEAD, LIST и OPTIONS.
      * ![image](../../../_assets/console-icons/chart-column.svg) **Modify Requests** — количество запросов PUT, POST и DELETE.
      * ![image](../../../_assets/console-icons/chart-column.svg) **Traffic** — объем переданного трафика.
      * ![image](../../../_assets/console-icons/chart-column.svg) **Objects counts** — количество объектов в бакете.
      * ![image](../../../_assets/console-icons/chart-column.svg) **Space by object type** — использованный объем хранилища по типу объекта: без разбиения на части, загруженные по частям (multipart) и части объектов.
      * ![image](../../../_assets/console-icons/chart-column.svg) **Space by storage type** — использованный объем хранилища по классу хранилища.

{% endlist %}

## Посмотреть подробную статистику в Monitoring {#monitoring}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
  1. Перейдите в сервис **Object Storage**.
  1. На панели слева выберите ![image](../../../_assets/monitoring/concepts/visualization/legend-goto-chart.svg) **Метрики**.
  1. В строке запроса выберите параметры:
      1. Сервис **Object Storage**.
      1. Метрику, значения которой вы хотите визуализировать.
      1. Метку для метрики.

{% endlist %}