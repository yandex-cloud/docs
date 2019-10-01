## Настройка CLI {#cli-setup}

Для работы с MDB нужно использовать CLI внешнего Облака:

1. [Установите CLI](../../../cli/quickstart.md).
1. [Получите OAuth-токен](https://oauth.yandex-team.ru/authorize?response_type=token&client_id=8cdb2f6a0dca48398c6880312ee2f78d) для доступа CLI ко внутреннему MDB.

   {% note important %}

   Токен нужно получать именно по этой ссылке — в выводе CLI предлагается ссылка на внешнее приложение MDB.

   {% endnote %}

1. Инициализируйте профиль CLI (понадобится OAuth-токен из предыдущего шага):

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
