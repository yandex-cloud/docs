    
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

  
  1. Выберите зону доступности по умолчанию для сервиса {{ compute-full-name }}:

     {% include [include](choose-zone.md) %}


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




{% endlist %}
