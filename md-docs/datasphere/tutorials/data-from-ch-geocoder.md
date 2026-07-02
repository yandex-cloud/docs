[Документация Yandex Cloud](../../index.md) > [Yandex DataSphere](../index.md) > [Практические руководства](index.md) > Разработка > Геокодинг с помощью API Яндекс Карт для визуализации в DataLens

# Геокодинг с помощью API Яндекс Карт для визуализации в DataLens


В этом практическом руководстве вы научитесь преобразовывать адреса в геокоординаты с помощью API [Геокодера](https://yandex.ru/maps-api/products/geocoder-api) и визуализируете данные в DataLens. Обработка данных выполняется с помощью скриптов на языке Python, описанных в Jupyter ноутбуках в [Yandex DataSphere](../index.md).

В качестве источника данных будут использованы данные из [демонстрационной БД ClickHouse®](../../datalens/quickstart.md#create-connection).

1. [Подготовьте облако к работе](#before-you-begin).
1. [Получите ключ API Геокодера](#get-key).
1. [Преобразуйте данные в DataSphere](#datasphere).
1. [Создайте подключение к файлу в DataLens](#create-connection).
1. [Создайте датасет на базе подключения](#create-dataset).
1. [Создайте чарт](#create-chart).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

Перед началом работы нужно зарегистрироваться в Yandex Cloud, настроить [сообщество](../concepts/community.md) и привязать к нему [платежный аккаунт](../../billing/concepts/billing-account.md):
1. [На главной странице DataSphere](https://datasphere.yandex.cloud) нажмите **Попробовать бесплатно** и выберите аккаунт для входа — Яндекс ID или рабочий аккаунт в федерации (SSO).
1. Выберите [организацию Yandex Identity Hub](../../organization/index.md), в которой вы будете работать в Yandex Cloud.
1. [Создайте сообщество](../operations/community/create.md).
1. [Привяжите платежный аккаунт](../operations/community/link-ba.md) к сообществу DataSphere, в котором вы будете работать. Убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, создайте его в интерфейсе DataSphere.

{% note tip %}

Чтобы Yandex DataLens и Yandex DataSphere могли работать внутри сети Yandex Cloud, создавайте их экземпляры в рамках одной организации.

{% endnote %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость развертывания инфраструктуры входит плата за использование [вычислительных ресурсов DataSphere](../pricing.md).

## Получите ключ API Геокодера {#get-key}

Получите ключ для использования API Геокодера:

1. Перейдите в [Кабинет разработчика](https://developer.tech.yandex.ru) и нажмите кнопку **Подключить API**.

   ![image](../../_assets/datalens/solution-geocoder/developer.png)

1. В открывшемся окне выберите **JavaScript API и HTTP Геокодер** и нажмите **Продолжить**.
1. Заполните форму и нажмите **Продолжить**.
1. В открывшемся окне нажмите **Перейти к API**.
1. В блоке **Ключи API** скопируйте значение ключа.

   ![image](../../_assets/datalens/solution-geocoder/developer-key.png)

## Преобразуйте данные в DataSphere {#datasphere}

### Создайте проект {#create-project}

1. Откройте [главную страницу](https://datasphere.yandex.cloud) DataSphere.
1. На панели слева выберите ![image](../../_assets/console-icons/circles-concentric.svg) **Сообщества**.
1. Выберите сообщество, в котором вы хотите создать проект.
1. На странице сообщества нажмите кнопку ![image](../../_assets/console-icons/folder-plus.svg) **Создать проект**.
1. В открывшемся окне укажите имя и (опционально) описание проекта.
1. Нажмите кнопку **Создать**.

### Создайте секрет {#create-secret}

Создайте [секрет](../concepts/secrets.md) для хранения [ключа API Геокодера](#get-key):

1. В блоке **Ресурсы проекта** на странице проекта нажмите ![secret](../../_assets/datasphere/jupyterlab/secret.svg)**Секрет**.
1. Нажмите кнопку **Создать**.
1. В поле **Имя** задайте имя секрета — `API_KEY`.
1. В поле **Значение** введите значение ключа.
1. Нажмите кнопку **Создать**. Откроется страница с информацией о созданном секрете.

### Создайте ноутбук {#create-notebook}

1. Выберите нужный проект в своем сообществе или на [главной странице](https://datasphere.yandex.cloud) DataSphere во вкладке **Недавние проекты**.
1. Нажмите кнопку **Открыть проект в JupyterLab** и дождитесь окончания загрузки.
1. На верхней панели в окне проекта нажмите **File** и выберите **New** → **Notebook**.
1. Выберите ядро **DataSphere Kernel** и нажмите **Select**.

   ![image](../../_assets/datalens/solution-geocoder/new-notebook.png)

### Установите зависимости {#dependencies}

1. Вставьте в ячейку ноутбука указанный ниже код и нажмите значок ![run](../../_assets/datasphere/jupyterlab/run.svg):

   ```py
   %pip install requests
   %pip install clickhouse-driver
   ```

1. Перезагрузите ядро: на верхней панели в окне проекта нажмите **Kernel** → **Restart Kernel**.

### Установите сертификаты {#certificates}

Установите сертификаты в локальное хранилище проекта:

```bash
#!:bash
mkdir --parents /home/jupyter/datasphere/project/Yandex/

wget "https://storage.yandexcloud.net/cloud-certs/RootCA.pem" \
     --output-document /home/jupyter/datasphere/project/Yandex/RootCA.crt

wget "https://storage.yandexcloud.net/cloud-certs/IntermediateCA.pem" \
     --output-document /home/jupyter/datasphere/project/Yandex/IntermediateCA.crt
```

### Загрузите и преобразуйте данные {#load-and-transform}

1. Создайте класс для работы с Геокодером:

   ```py
   import requests
   from dataclasses import dataclass

   @dataclass
   class YandexGeocoder:
       api_key: str
       geocoder_url: str = 'https://geocode-maps.yandex.ru/1.x'

       def adress_to_geopoint(self, address: str) -> str:

           # Преобразование адреса в геокоординаты в формате DataLens

           response = requests.get(self.geocoder_url, params={
               'apikey': self.api_key,
               'geocode': address,
               'format': 'json',
           })
           response.raise_for_status()

           result = response.json()['response']['GeoObjectCollection']['featureMember']
           if not result:
               return None

           lat, lon = result[0]['GeoObject']['Point']['pos'].split(' ')
           return self._to_datalens_format(lon, lat)

       def _to_datalens_format(self, lon, lat):
           return f'[{lon},{lat}]'
    ```

1. Подключитесь к демонстрационной БД ClickHouse®:

   ```py
   from clickhouse_driver import Client

   ch_client = Client(
       host='rc1a-ckg8nrosr2lim5iz.mdb.yandexcloud.net',
       user='samples_ro',
       password='MsgfcjEhJk',
       database='samples',
       port=9440,
       secure=True,
       verify=True,
       ca_certs='/home/jupyter/datasphere/project/Yandex/RootCA.crt'
   )
   ```

1. Выполните проверку с помощью команды:

   ```py
   print(ch_client.execute('SELECT version()'))
   ```

   Если подключение установлено успешно, в терминале отобразится номер версии ClickHouse®.

1. Выгрузите данные из таблицы с адресами магазинов в переменную `ch_data`:

   ```py
   ch_data = ch_client.execute('SELECT ShopName, ShopAddress FROM MS_Shops')
   ch_data
   ```

1. Преобразуйте адреса магазинов из колонки `ShopAddress` в геокоординаты:

   ```py
   import os

   geocoder = YandexGeocoder(api_key=os.environ['API_KEY'])

   encoded_data = [
       (name, geocoder.adress_to_geopoint(adress))
       for name, adress in ch_data
   ]
   encoded_data
   ```

1. Сохраните полученные данные в файл:

   ```py
   import csv
   import sys

   csv_writer = csv.writer(
       sys.stdout,
       delimiter=',',
       quotechar='"',
       quoting=csv.QUOTE_MINIMAL,
   )

   filename = 'encoded_data.csv'

   with open(filename, 'w') as f:
       csv_writer = csv.writer(
           f,
           delimiter=',',
           quotechar='"',
       )
       csv_writer.writerows(encoded_data)
   ```

   На панели слева появится файл `encoded_data.csv`.

   ![image](../../_assets/datalens/solution-geocoder/encoded-data.png)

1. Скачайте полученный файл — нажмите правой кнопкой мыши и выберите `Download`.

## Создайте подключение к файлу в DataLens {#create-connection}

1. Перейдите на [главную страницу](https://datalens.ru/?skipPromo=true) DataLens.
1. На панели слева выберите ![image](../../_assets/console-icons/thunderbolt.svg) **Подключения** и нажмите кнопку **Создать подключение**.
1. В разделе **Файлы и сервисы** выберите подключение **Файлы**.
1. Нажмите кнопку **Загрузить файлы** и укажите файл `encoded_data.csv`.

   ![image](../../_assets/datalens/solution-geocoder/connection.png)

1. В правом верхнем углу нажмите кнопку **Создать подключение**.
1. Введите название подключения `geocoder_csv` и нажмите кнопку **Создать**.

## Создайте датасет на базе подключения {#create-dataset}

1. В правом верхнем углу нажмите кнопку **Создать датасет**.
1. Перейдите на вкладку **Поля**.
1. Переименуйте поля:

   * `field1` в `Название магазина`;
   * `field2` в `Координаты`.

1. Для поля `Координаты` измените тип данных на **Геоточка**.

   ![image](../../_assets/datalens/solution-geocoder/dataset.png)

1. В правом верхнем углу нажмите кнопку **Сохранить**.
1. Введите название датасета `geocoder_data` и нажмите кнопку **Создать**.

## Создайте чарт {#create-chart}

1. В правом верхнем углу нажмите кнопку **Создать чарт**.
1. Выберите тип визуализации **Карта**.
1. Перетащите поле `Координаты` в секцию **Точки (Геоточки)**.
1. Перетащите поле `Название магазина` в секцию **Тултипы**.

   ![image](../../_assets/datalens/solution-geocoder/chart.png)

1. В правом верхнем углу нажмите кнопку **Сохранить**.
1. Введите название чарта и нажмите кнопку **Сохранить**.

## Как удалить созданные ресурсы {#clear-out}

Если вы больше не планируете работать с проектом в DataSphere, [удалите его](../operations/projects/delete.md#delete-project).

_ClickHouse® является зарегистрированным товарным знаком [ClickHouse, Inc](https://clickhouse.com)._