# Создание профиля

Создать профиль можно двумя способами:

- [Интерактивное создание профиля с базовыми параметрами](#interactive-create).

    CLI будет поэтапно предлагать задать базовые параметры профиля. С помощью этого способа можно переопределить параметры уже существующего профиля. Способ не подходит для сервисных аккаунтов.

- [Создание пустого профиля и добавление параметров вручную](#create).

    Будет создан и активирован пустой профиль — все необходимые [параметры нужно задать отдельно](manage-properties.md).

## Интерактивное создание профиля с базовыми параметрами {#interactive-create}

При интерактивном создании профиля CLI будет поэтапно предлагать задать базовые параметры:
* Имя профиля.
* Облако, в котором у вас есть права доступа.
* Каталог по умолчанию.
* Зона доступности по умолчанию, в которой будут создаваться ресурсы сервиса Yandex Compute Cloud.

Вы можете прервать процесс создания профиля в любой момент. В профиле будут сохранены настройки, которые вы успели задать до прерывания.


Если вы еще не подключены к консоли управления, войдите в [консоль](https://console.yandex.cloud) и примите пользовательское соглашение (нажмите **Войти**).

{% list tabs group=authentication %}

- Аккаунт на Яндексе {#yandex-account}

    Чтобы аутентифицироваться с помощью [аккаунта на Яндексе](../../../iam/concepts/users/accounts.md#passport):
    
    1. Получите адрес электронной почты:
      
       1. Перейдите в ваш аккаунт на [Яндексе](https://id.yandex.ru/personal).
       1. В блоке **Контакты** скопируйте адрес электронной почты.
    
    1. Запустите интерактивное создание профиля:
      
            
        ```bash
        yc init --username=<электронная_почта>
        ```
    
    
    
    1. Выберите профиль, для которого вы хотите настроить аутентификацию, или создайте новый.
    
       ```text
       Welcome! This command will take you through the configuration process.
       Pick desired action:
       [1] Re-initialize this profile 'default' with new settings
       [2] Create a new profile
       ```
    
    1. CLI выведет сообщение о продолжении аутентификации в браузере. Для продолжения нажмите клавишу **Enter**.
    
       ```text
       You are going to be authenticated via username '<электронная_почта>'.
       Authentication web site will be opened.
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
       subject-id: b1g159pa15cd********
       username: <электронная_почта>
       folder-id: b1g8o9jbt58********
       compute-default-zone: ru-central1-b
       ```

- Федеративный аккаунт {#federated-account}

    Чтобы аутентифицироваться с помощью [SAML-совместимой федерации удостоверений](../../../organization/concepts/add-federation.md):
    
    1. Узнайте идентификатор федерации у вашего администратора.
    1. Запустите интерактивное создание профиля:
    
          
       ```bash
       yc init --federation-id=<идентификатор_федерации>
       ```
    
    
    
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

- Аккаунт локального пользователя {#local-account}

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

{% endlist %}

## Создание пустого профиля и добавление параметров вручную {#create}

Создайте профиль с именем `test`:
1. Выполните команду: 
  
   ```bash
   yc config profile create test
   ```

   Результат:

   ```text
   Profile 'test' created and activated
   ```

1. Добавьте необходимые параметры профиля, например, каталог:

    ```bash
    yc config set folder-id <ID каталога>
    ```

    Ознакомьтесь с полным [списком параметров](../../concepts/core-properties.md) профиля, а также как ими [управлять](manage-properties.md).