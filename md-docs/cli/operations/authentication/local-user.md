[Документация Yandex Cloud](../../../index.md) > [Интерфейс командной строки](../../index.md) > [Пошаговые инструкции](../index.md) > Аутентификация > Аутентификация от имени локального пользователя

# Аутентификация от имени локального пользователя

Вы можете использовать аккаунт [локального пользователя](../../../iam/concepts/users/accounts.md#local) для работы с Yandex Cloud, если в вашей [организации](../../../organization/concepts/organization.md) настроен [пул пользователей](../../../organization/concepts/user-pools.md). В этом случае для аутентификации не требуется личный [аккаунт на Яндексе](../../../iam/concepts/users/accounts.md#passport).

{% note warning %}

Аутентификация в CLI аккаунтом Яндекса, федеративным аккаунтом и аккаунтом локального пользователя осуществляется с помощью браузера и графического интерфейса.

Предпочтительным способом работы с CLI на сервере без графического интерфейса является [использование сервисного аккаунта](service-account.md).

Если по какой-то причине вы не можете использовать сервисный аккаунт, выполните аутентификацию через [SSH-туннель](auth-without-gui.md#linux-vm-auth) или с помощью [форвардинга X11](auth-without-gui.md#auth-without-gui).

{% endnote %}

Если у вас еще нет интерфейса командной строки Yandex Cloud, [установите его](../install-cli.md).

Чтобы аутентифицироваться с помощью [аккаунта локального пользователя](../../../iam/concepts/users/accounts.md#local):

1. Запустите интерактивное создание профиля:

   {% list tabs %}

   - Пул пользователей
   
     1. Узнайте идентификатор пула пользователей у вашего администратора.
     1. Запустите интерактивное создание профиля:

                  
         ```bash
         yc init --userpool-id=<идентификатор_пула_пользователей>
         ```



   - Электронная почта

      1. Получите адрес электронной почты:
         1. Перейдите в портал [Мой аккаунт](https://myaccount.yandex.cloud/).
         1. На панели слева выберите ![alt](../../../_assets/console-icons/passport.svg) **Профиль**.
         1. В блоке **Контакты** скопируйте адрес электронной почты.
      1. Запустите интерактивное создание профиля:

                  
         ```bash
         yc init --username=<электронная_почта>
         ```



   {% endlist %}

1. Выберите профиль, для которого вы хотите настроить аутентификацию, или создайте новый.

   ```text
   Welcome! This command will take you through the configuration process.
   Pick desired action:
   [1] Re-initialize this profile 'default' with new settings
   [2] Create a new profile
   ```

1. CLI выведет сообщение о продолжении аутентификации в браузере. Для продолжения нажмите клавишу **Enter**.

   ```text
   You are going to be authenticated via userpool-id 'ek0auknfc0mh********'.
   Your userpool authentication web site will be opened.
   After your successful authentication, you will be redirected to cloud console.

   Press 'enter' to continue...
   ```

   После успешной аутентификации в профиле сохранится [IAM-токен](../../../iam/concepts/authorization/iam-token.md). При каждой операции аутентификация будет происходить с помощью этого IAM-токена, пока не истечет [время его жизни](../../../iam/concepts/authorization/iam-token.md) (не более 12 часов). После этого CLI снова выведет сообщение о необходимости пройти аутентификацию в браузере.
   
   Чтобы продлить срок, в течение которого не нужно аутентифицироваться в браузере, используйте [refresh-токены](../../../iam/concepts/authorization/refresh-token.md), позволяющие перевыпускать IAM-токены без перехода в браузер. Для этого разрешите использовать refresh-токены [на уровне организации](../../../iam/concepts/authorization/refresh-token.md#token-enabling) и [инициализируйте DPoP-защиту](../../../iam/concepts/authorization/refresh-token.md#enabling-dpop) в CLI.

1. Вернитесь в интерфейс командной строки, чтобы завершить создание профиля.

1. Выберите одно из предложенных [облаков](../../../resource-manager/concepts/resources-hierarchy.md#cloud), в которых у вас есть права доступа:

   ```text
      Please select cloud to use:
       [1] cloud1 (id = aoe2bmdcvata********)
       [2] cloud2 (id = dcvatao4faoe********)
      Please enter your numeric choice: 2
      ```

   Если вам доступно только одно облако, оно будет выбрано автоматически.

1. Выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder) по умолчанию:

   ```text
      Please choose a folder to use:
       [1] folder1 (id = cvatao4faoe2********)
       [2] folder2 (id = tao4faoe2cva********)
       [3] Create a new folder
      Please enter your numeric choice: 1
      ```

1. Чтобы выбрать [зону доступности](../../../overview/concepts/geo-scope.md) по умолчанию для сервиса [Compute Cloud](../../../compute/index.md), введите `Y`. Чтобы пропустить настройку, введите `n`.

   ```bash
   Do you want to configure a default Yandex Compute Cloud availability zone? [Y/n] Y
   ```

   Если вы ввели `Y`, выберите зону доступности:

   
   ```text
   Which zone do you want to use as a profile default?
    [1] ru-central1-a
    [2] ru-central1-b
    [3] ru-central1-d
    [4] Do not set default zone
   Please enter your numeric choice: 2
   ```



1. Проверьте настройки вашего профиля CLI:

   ```bash
   yc config list
   ```

   Результат:
   
   {% list tabs %}

   - Пул пользователей
   
      
      ```bash
      userpool-id: ek0auknfc0mh********
      subject-id: ek00cd1m8hdd8********
      cloud-id: b1g159pa15cd********
      folder-id: b1g8o9jbt58********
      compute-default-zone: ru-central1-b
      ```



   - Электронная почта
      
      ```bash
      subject-id: b1g159pa15cd********
      username: <электронная_почта>
      folder-id: b1g8o9jbt58********
      compute-default-zone: ru-central1-b
      ```



   {% endlist %}