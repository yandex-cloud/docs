# Как начать работать с {{ mmg-short-name }}

{% if audience == "internal" %}

Для внутреннего сервиса MDB развернут [веб-интерфейс](https://yc.yandex-team.ru), где кластер БД можно накликать. Подробнее про квоты и соответствие ABC-сервисов облакам и каталогам читайте в разделе [{#T}](../mdb/access.md).

## Доступ к кластерам БД

[Запросите доступ](https://puncher.yandex-team.ru/) к макросу `_PGAASINTERNALNETS_`, чтобы подключаться к созданным кластерам. Для подключения к MongoDB запрашивайте доступ к порту 27018.


## Настройка CLI

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

{% if audience != "internal" %}

Чтобы воспользоваться сервисом, нужно создать кластер и подключиться к СУБД:

1. Чтобы создать кластер баз данных, понадобится только доступный вам каталог в Яндекс.Облаке. Если у вас уже есть каталог в Яндекс.Облаке, откройте страницу этого каталога в консоли управления. Если каталога еще нет, создайте его:

    {% include [create-folder](../_includes/create-folder.md) %}

2. Создайте виртуальную машину (на основе [Linux](../compute/quickstart/quick-create-linux.md) или [Windows](../compute/quickstart/quick-create-windows.md)), с которой вы будете обращаться к кластеру БД. Если вы планируете подключаться к базе данных извне Облака, запросите внешние IP-адреса для хостов при создании кластера.

   1. Чтобы подключаться изнутри Облака, создайте виртуальную машину в той же сети, что и кластер БД (на основе [Linux](../compute/quickstart/quick-create-linux.md) или [Windows](../compute/quickstart/quick-create-windows.md))
   1. Чтобы подключаться к кластеру через интернет, запросите внешние IP-адреса для хостов при создании кластера. 

{% endif %}

1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать кластер БД.
1. Выберите сервис **{{ mmg-name }}**.
1. Нажмите кнопку **Создать кластер** и выберите нужную СУБД.
1. Задайте параметры кластера и нажмите кнопку **Создать кластер**. Процесс подробно рассмотрен в разделе [{#T}](operations/cluster-create.md).
1. Когда кластер будет готов к работе, его статус на панели {{ mmg-short-name }} сменится на **RUNNING**.
1. Чтобы подключиться к серверу БД, необходим SSL-сертификат. Подготовить все нужные аутентификационные данные можно, например, так:

    {% if audience != "internal" %}
    
    ```bash
    $ mkdir ~/.mongodb
    $ wget "https://{{ s3-storage-host }}{{ pem-path }}" -O ~/.mongodb/CA.pem
    ```
    
    {% else %}
 
    ```bash
    $ mkdir ~/.mongodb
    $ wget "{{ pem-path }}" -O ~/.mongodb/CA.pem
    ```
    
    {% endif %}
 
 1. Теперь подключитесь к кластеру:
 
    ```bash
    $ mongo --norc \
            --ssl \
            --sslCAFile ~/.mongodb/CA.pem \
            --ipv6 \
            --host 'rs01/<адрес хоста 1>:27018,<адрес хоста 2>:27018,<адрес хоста N>:27018' \
            -u <имя пользователя> \
            -p <пароль пользователя> \
            <имя БД>
    ```
