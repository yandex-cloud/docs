# Создание подключения к {{ speechsense-full-name }}

Чтобы создать подключение к {{ speechsense-name }}:

1. Перейдите на [главную страницу]({{ link-datalens-main-skip-promo }}) {{ datalens-short-name }}.
1. На панели слева выберите ![collections](../../../_assets/console-icons/rectangles-4.svg) **Коллекции и воркбуки** и откройте нужный воркбук или [создайте](../../workbooks-collections/workbooks-operations.md#create-workbook) новый. Если вы пользуетесь старой навигацией по папкам, выберите папку или создайте новую для сохранения [подключения](../../concepts/connection/index.md).
1. В правом верхнем углу нажмите **Создать** → ![image](../../../_assets/console-icons/thunderbolt.svg) **Подключение**.
1. В разделе **Файлы и сервисы** выберите подключение **{{ speechsense-name }}**.
1. Выберите режим авторизации и укажите параметры подключения:

   {% list tabs group=authentication %}

   - Текущий пользователь {#user}

     {% note info %}
     
     
     Для создания подключения и использования датасетов и чартов на его основе у пользователя должны быть [роли]({{ link-docs-ai }}speechsense/security/#roles-list) `speech-sense.data.viewer` и `speech-sense.viewer` в нужном проекте [{{ speechsense-name }}]({{ link-docs-ai }}speechsense/).
     
     
     {% endnote %}

     1. Скопируйте идентификатор нужного [проекта]({{ link-docs-ai }}speechsense/concepts/resources-hierarchy#project) {{ speechsense-name }} и вставьте в поле **ID проекта**.
     1. Оставьте опцию **Автоматически создать датасет, чарты и дашборд** включенной, если хотите получить готовый дашборд, датасет и стандартный набор чартов.

        ![image](../../../_assets/datalens/operations/connection/connection-speechsense.png)

     1. Нажмите кнопку **Создать подключение**.
     1. Укажите название подключения и нажмите кнопку **Создать**.

     {% note info %}

     Если проекта с указанным идентификатором не существует или у пользователя нет к нему доступа, подключение не будет создано и отобразится ошибка.

     {% endnote %}

   - Сервисный аккаунт {#service-account}

     {% note info %}
     
     
     Для создания подключения и использования датасетов и чартов на его основе у [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md) и пользователя, создающего подключение, должны быть [роли]({{ link-docs-ai }}speechsense/security/#roles-list) `speech-sense.data.viewer` и `speech-sense.viewer` в нужном проекте [{{ speechsense-name }}]({{ link-docs-ai }}speechsense/).
     
     
     {% endnote %}
 
     1. Скопируйте идентификатор нужного [проекта]({{ link-docs-ai }}speechsense/concepts/resources-hierarchy#project) {{ speechsense-name }} и вставьте в поле **ID проекта**.
     1. Выберите облако и каталог в нем.
     1. Выберите существующий сервисный аккаунт или создайте новый.      
     1. Оставьте опцию **Автоматически создать датасет, чарты и дашборд** включенной, если хотите получить готовый дашборд, датасет и стандартный набор чартов.

        ![image](../../../_assets/datalens/operations/connection/connection-speechsense-sa.png)

     1. Нажмите кнопку **Создать подключение**.
     1. Укажите название подключения и нажмите кнопку **Создать**.

     {% note info %}

     Если проекта с указанным идентификатором не существует или у сервисного аккаунта нет к нему доступа, подключение не будет создано и отобразится ошибка.

     {% endnote %}

   {% endlist %}