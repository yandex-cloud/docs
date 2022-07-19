## Настройка внешнего CLI {#cli-setup}

{% note warning %}

Приведённая инструкция описывает настройку внешней сборки CLI (из {{ s3-storage-host }}) для работы с внутренним MDB. Это может быть удобным в случае, если вы используете CLI для работы и с внутренним MDB, и с внешним {{ yandex-cloud }}. В случае, если вам достаточно внутренней сборки CLI (из s3.mds.yandex.net), следуйте [этой инструкции](../../../cli/quickstart.md).

Если у вас уже установлен CLI, вы можете понять, какая сборка у вас используется, с помощью команды `yc version`. Если в версии присутствует `+yandex`, то сборка внутренняя. В противном случае сборка внешняя.

{% endnote %}

Для работы с внутренним MDB с помощью внешнего CLI нужно сделать следующее:

1. [Установите CLI](https://cloud.yandex.ru/docs/cli/quickstart#install).

1. Убедитесь что у вас установлен [YandexInternalRootCA.crt](https://crls.yandex.net/YandexInternalRootCA.crt). Для платформ Windows и Mac OS сертификат должен быть предустановлен при выдаче оборудования. Для Linux можно воспользоваться следующей [инструкцией](https://wiki.yandex-team.ru/security/ssl/sslclientfix/#vcli-utilitax).

1. [Получите OAuth-токен](https://oauth.yandex-team.ru/authorize?response_type=token&client_id=8cdb2f6a0dca48398c6880312ee2f78d) для доступа CLI ко внутреннему MDB.

   {% note warning %}

   Токен нужно получать именно по этой ссылке — в выводе внешней сборки CLI предлагается ссылка на внешний OAuth вместо внутреннего.

   {% endnote %}

1. Инициализируйте профиль CLI (понадобится OAuth-токен из предыдущего шага):

   ```bash
   yc init --endpoint gw.db.yandex-team.ru:443
   Welcome! This command will take you through the configuration process.
   Please go to https://oauth.yandex...

   Please enter OAuth token: <полученный OAuth-токен>
   ```
1. Выберите нужное облако из [доступных вам облаков](../../../mdb/access.md):

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
1. Если нужно переключить профиль CLI на другой каталог, [узнайте идентификатор](../../../mdb/access.md#find-id) соответствующего каталога, затем выполните команду:

   ```bash
   yc config set folder-id <идентификатор каталога>
   ```
