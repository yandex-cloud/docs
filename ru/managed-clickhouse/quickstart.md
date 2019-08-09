# Как начать работать с {{ mch-short-name }}

{% if audience == "internal" %}

Для внутреннего сервиса MDB развернут [веб-интерфейс]({{console-link}}), где кластер БД можно накликать. Подробнее про квоты и соответствие ABC-сервисов облакам и каталогам читайте в разделе [{#T}](../mdb/access.md).

## Доступ к кластерам БД

[Запросите доступ](https://puncher.yandex-team.ru/) к макросу `_PGAASINTERNALNETS_`, чтобы подключаться к созданным кластерам. Для доступа к хостам ClickHouse нужен доступ к портам 8443 (HTTPS) и 9440 (нативный протокол с TLS). 

{% endif %}

{% if audience != "internal" %}

Чтобы воспользоваться сервисом, нужно создать кластер и подключиться к СУБД:

1. Чтобы создать кластер баз данных, понадобится только доступный вам каталог в Яндекс.Облаке. Если у вас уже есть каталог в Яндекс.Облаке, откройте страницу этого каталога в консоли управления. Если каталога еще нет, создайте его:

    {% include [create-folder](../_includes/create-folder.md) %}

2. Подключаться к кластерам БД можно как изнутри, так и извне Облака:

    1. Чтобы подключаться изнутри Облака, создайте виртуальную машину в той же сети, что и кластер БД (на основе [Linux](../compute/quickstart/quick-create-linux.md) или [Windows](../compute/quickstart/quick-create-windows.md))

    2. Чтобы подключаться к кластеру через интернет, запросите внешние IP-адреса для хостов при создании кластера.

1. В консоли управления выберите каталог, в котором нужно создать кластер БД.

{% endif %}

{% if audience == "internal" %}

1. В [консоли управления](https://yc.yandex-team.ru) выберите каталог, в котором нужно создать кластер БД.

{% endif %}

1. Нажмите кнопку **Создать ресурс** и выберите пункт **Кластер {{ CH }}**.
1. Задайте параметры кластера и нажмите кнопку **Создать кластер**. Процесс подробно рассмотрен в разделе [{#T}](operations/cluster-create.md).
1. Когда кластер будет готов к работе, его статус на панели {{ mch-name }} сменится на **RUNNING**.
1. Чтобы подключиться к серверу БД, необходим SSL-сертификат. Скачайте его:

    {% if audience != "internal" %}
    
    ```bash
    $ wget "https://{{ s3-storage-host }}{{ pem-path }}"
    ```
   
    {% else %}
    
    ```bash
    $ wget "https://{{ pem-path }}"
    ```
    
    {% endif %}

1. Отправьте запрос, указав путь к полученному SSL-сертификату, атрибуты базы данных и текст запроса в формате urlencoded:
    ```
    $ curl --cacert <путь к SSL-сертификату> \
         -H "X-ClickHouse-User: <имя пользователя БД>" \
         -H "X-ClickHouse-Key: <пароль пользователя БД>" \
         'https://<адрес хоста>:8443/?database=<имя БД>&query=SELECT%20now()'
    ```

{% if audience == "internal" %}

## Настройка CLI {#setup}

Для работы с MDB нужно использовать CLI внешнего Облака:

1. [Установите CLI](../cli/index.md).
1. [Получите OAuth-токен](https://oauth.yandex-team.ru/authorize?response_type=token&client_id=8cdb2f6a0dca48398c6880312ee2f78d) для авторизации.

  {% note important %}

  Токен нужно получать именно по этой ссылке — в выводе CLI ссылка на внешнее приложение MDB.

  {% endnote %}
 
1. Инициализируйте профиль CLI:

   ```bash
   $ yc init --endpoint gw.db.yandex-team.ru:443
   Welcome! This command will take you through the configuration process.
   Please go to https://oauth.yandex...
   
   Please enter OAuth token: <полученный OAuth-токен>
   ```
1. Выберите нужное облако из [доступных вам облаков](../mdb/access.md):

   ```bash
    Please select cloud to use:
     [1] mdb-junk-cloud (id = foorkhlv2jt6khpv69ik)
     [2] ...
    
    Please enter your numeric choice: 1
    Your current cloud has been set to 'mdb-junk-cloud' (id = foorkhlv2jt6khpv69ik).
   ```
1. Выберите ваш каталог (ABC-сервис) из списка.

   Если в списке нет нужного каталога, введите номер любого имеющегося каталога, чтобы переключиться на нужный каталог позже.

    ```bash
    Please choose folder to use:
     [1] mdb-junk (id = b1go5vsme2m9353j40o5)
     [2] ...
    Please enter your numeric choice: 1
    Your current folder has been set to 'mdb-junk' (id = mdb-junk).
    ```
1. Откажитесь от выбора зоны по умолчанию:

    ```bash
    Do you want to configure a default Compute zone? [Y/n] n
    ```
1. Если нужно переключить профиль CLI на другой каталог, [узнайте идентификатор](../mdb/access.md#find-id) соответствующего каталога, затем выполните команду:

   ```bash
   yc config set folder-id <идентификатор каталога>
   ```

   Если все сделано правильно, должен заработать запрос списка кластеров:

   ```bash
   {{ yc-mdb-ch }} cluster list
   ```

{% endif %}

