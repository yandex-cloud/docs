
  Чтобы аутентифицироваться с помощью [аккаунта на Яндексе](../../iam/concepts/index.md#passport):

  1. Получите OAuth-токен в сервисе [Яндекс ID](https://yandex.ru/dev/id/doc/ru/concepts/ya-oauth-intro): 

     1. Перейдите по [ссылке]({{ link-cloud-oauth }}). Если приложение запрашивает доступ к данным, разрешите. Это нужно для получения токена.

     1. Скопируйте в буфер обмена или сохраните полученный токен.

  1. Если вы аутентифицируетесь впервые, перейдите в [консоль облака]({{ link-console-main }}). Примите условия лицензионного соглашения и политики конфиденциальности.

  1. Чтобы начать настройку профиля CLI, выполните команду:
  
      ```bash
      yc init
      ```


  1. Выберите профиль, для которого вы хотите настроить аутентификацию, или создайте новый. Если вы выполняете команду `yc init` впервые, этот шаг будет отсутствовать.

     ```bash
     Pick desired action:
     [1] Re-initialize this profile 'default' with new settings
     [2] Create a new profile
     Please enter your numeric choice: 1
     ```

  1. По запросу команды введите OAuth-токен, полученный ранее:
     
     ```bash
     Please go to {{ link-cloud-oauth }}
     in order to obtain OAuth token.

     Please enter OAuth token: y0_AgA ... wvs7N4
     ```

  1. Выберите одно из предложенных [облаков](../../resource-manager/concepts/resources-hierarchy.md#cloud), к которым у вас есть доступ:
     
     {% include [include](choose-cloud.md) %}

     Если вам доступно только одно облако, оно будет выбрано автоматически.

  1. Выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder) по умолчанию:

     {% include [include](choose-folder.md) %}

  
  1. Чтобы выбрать [зону доступности](../../overview/concepts/geo-scope.md) по умолчанию для сервиса [{{ compute-name }}](../../compute/), введите `Y`. Чтобы пропустить настройку, введите `n`.
  
     ```bash
     Do you want to configure a default {{ compute-full-name }} availability zone? [Y/n] Y
     ```  

     Если вы ввели `Y`, выберите зону доступности:

     {% include [include](choose-zone.md) %}


  1. Проверьте настройки вашего профиля CLI:
     
     ```bash
     yc config list
     ```

     Результат:

     ```bash
     token: y0_AgA...wvs7N4
     cloud-id: b1g159pa15cd********
     folder-id: b1g8o9jbt58********
     compute-default-zone: {{ region-id }}-b
     ```


