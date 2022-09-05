  {% if product == "yandex-cloud" %}
  
  Чтобы аутентифицироваться от имени пользователя:
  1. Получите OAuth-токен в сервисе Яндекс.OAuth. 
     1. Перейдите по [ссылке]({{ link-cloud-oauth }}). Если приложение запрашивает доступ к данным, разрешите. Это необходимо для получения токена.
     1. Скопируйте в буфер обмена или сохраните полученный токен.
  1. Выполните команду `yc init` для настройки вашего профиля CLI. 
  1. По запросу команды введите свой OAuth токен. Если вы выполняете команду `yc init` не в первый раз, этот шаг будет отсутствовать.
     
     ```bash
     Please go to {{ link-cloud-oauth }}
      in order to obtain OAuth token.

     Please enter OAuth token: AaAaBbBbCcCcDdDdEeEeFfFfGgGg
     ```
  1. Выберите одно из предложенных облаков, к которым у вас есть доступ:
     
     {% include [include](choose-cloud.md) %}

     Если вам доступно только одно облако, оно будет выбрано автоматически.
  1. Выберите каталог по умолчанию:

     {% include [include](choose-folder.md) %}

  {% if audience == "internal" %}

  1. Откажитесь от выбора зоны доступности по умолчанию для сервиса {{ compute-full-name }}:
     
     ```bash
     Do you want to configure a default {{ compute-full-name }} availability zone? [Y/n] N
     ```
  {% else %}

  1. Выберите зону доступности по умолчанию для сервиса {{ compute-full-name }}:

     {% include [include](choose-zone.md) %}

  {% endif %}

  1. Проверьте настройки вашего профиля CLI:
     
     ```bash
     yc config list
     ```

     Результат:

     ```bash
     token: AaAaBbBbCcCcDdDdEeEeFfFfGgGg
     cloud-id: b1g159pa15cddlv5mvcr
     folder-id: b1g8o9jbt587mbadu25k
     ```

  {% endif %}

  {% if product == "cloud-il" %}

  1. Запустите интерактивное создание профиля:
 
     ```bash
     yc init \
       --endpoint {{ api-host }}:443 \
       --federation-endpoint {{ console-host }} \
       --federation-id google
     ```
  1. Выберите профиль, для которого вы хотите настроить аутентификацию, или создайте новый.
     
     ```bash
     Welcome! This command will take you through the configuration process.
     Pick desired action:
     [1] Re-initialize this profile 'default' with new settings
     [2] Create a new profile
     ```
  1. CLI выведет сообщение о продолжении аутентификации в браузере. Для продолжения нажмите клавишу **Enter**.
  
     ```bash
     You are going to be authenticated via federation-id 'google'.
     Your federation authentication web site will be opened.
     After your successful authentication, you will be redirected to '{{ link-console-main }}'.
  
     Press 'enter' to continue...
     ```
  
     {% include [include](success-auth-via-federation.md) %}
  
  1. Вернитесь в интерфейс командной строки, чтобы завершить создание профиля.
  
  1. Выберите одно из предложенных облаков, к которым у вас есть доступ:
  
     {% include [include](choose-cloud.md) %}
  
     Если вам доступно только одно облако, оно будет выбрано автоматически.
  
  1. Выберите каталог по умолчанию:
  
     {% include [include](choose-folder.md) %}
  
  1. Выберите зону доступности по умолчанию для сервиса {{ compute-full-name }}:

     ```bash
     Do you want to configure a default {{ compute-full-name }} availability zone? [Y/n] Y
     Which zone do you want to use as a profile default?
     [1] {{ region-id }}-a
     [2] Don't set default zone
     Please enter your numeric choice: 1 
     ```
  
  1. Проверьте настройки вашего профиля CLI:
     
     ```bash
     yc config list
     ```

     Результат:

     ```bash
     federation-id: google
     endpoint: {{ api-host }}:443
     ...
     ```

  {% endif %}


{% endlist %}
