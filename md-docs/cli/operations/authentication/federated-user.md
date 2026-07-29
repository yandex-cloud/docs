[Документация Yandex Cloud](../../../index.md) > [Интерфейс командной строки](../../index.md) > [Пошаговые инструкции](../index.md) > Аутентификация > Федеративный пользователь

# Аутентификация в Yandex Cloud CLI от имени федеративного пользователя

Вы можете использовать [федеративный аккаунт](../../../iam/concepts/users/accounts.md#saml-federation) для работы с Yandex Cloud, если ваша компания настроила [федерацию удостоверений](../../../iam/concepts/federations.md). В этом случае не требуется личный [аккаунт на Яндексе](../../../iam/concepts/users/accounts.md#passport).

{% note warning %}

Аутентификация в CLI аккаунтом Яндекса, федеративным аккаунтом и аккаунтом локального пользователя осуществляется с помощью браузера и графического интерфейса.

Предпочтительным способом работы с CLI на сервере без графического интерфейса является [использование сервисного аккаунта](service-account.md).

Если по какой-то причине вы не можете использовать сервисный аккаунт, выполните аутентификацию через [SSH-туннель](auth-without-gui.md#linux-vm-auth) или с помощью [форвардинга X11](auth-without-gui.md#auth-without-gui).

{% endnote %}


{% note tip %}

Если доступ к Yandex Cloud в вашей организации осуществляется через прокси-сервер, перед выполнением команды `yc init` [настройте подключение CLI к прокси-серверу](../../concepts/index.md#cli-via-proxy).

{% endnote %}


Если у вас еще нет интерфейса командной строки Yandex Cloud, [установите его](../install-cli.md).

Чтобы аутентифицироваться с помощью [SAML-совместимой федерации удостоверений](../../../organization/concepts/add-federation.md):

1. Узнайте идентификатор федерации у вашего администратора.
1. Запустите интерактивное создание профиля:

      
   ```bash
   yc init --federation-id=<идентификатор_федерации>
   ```



   {% note info %}

   В случае отсутствия на сервере графического интерфейса и браузера возникает ошибка:
   
   ```text
   ERROR: fill default credentials: federation id authentication is not supported on this system because the browser can not be opened
   ```
   
   [Аутентифицируйтесь сервисным аккаунтом](service-account.md). Также вы можете использовать [SSH-туннель](auth-without-gui.md#linux-vm-auth) или [форвардинг X11](auth-without-gui.md#auth-without-gui).

   {% endnote %}

1. Выберите профиль, для которого вы хотите настроить аутентификацию, или создайте новый.

   ```text
   Welcome! This command will take you through the configuration process.
   Pick desired action:
   [1] Re-initialize this profile 'default' with new settings
   [2] Create a new profile
   ```

1. CLI выведет сообщение о продолжении аутентификации в браузере. Для продолжения нажмите клавишу **Enter**.

   ```text
   You are going to be authenticated via federation-id 'aje1f0hsgds3a********'.
   Your federation authentication web site will be opened.
   After your successful authentication, you will be redirected to 'https://console.yandex.cloud'.

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

   
   ```bash
   federation-id: aje1f0hs6oja********
   subject-id: ajea53egl28l********
   cloud-id: b1g159pa15cd********
   folder-id: b1g8o9jbt58********
   compute-default-zone: ru-central1-b
   ```