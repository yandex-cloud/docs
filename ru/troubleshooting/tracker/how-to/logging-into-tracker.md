# Как войти в {{ tracker-name }}


## Описание сценария {#case-description}

Необходимо войти в {{ tracker-name }} и начать в нем работу.

## Решение {#case-resolution}

{% note info %}

Подключение и вход в {{ tracker-name }} доступно только пользователям, у которых есть аккаунт на Яндексе.

{% endnote %}

{% list tabs %}

- Первая авторизация
    
    Необходимо проверить, что вы вошли в Яндекс под логином, которым вы представлены в своей организации. 
    
    Если вы авторизованы в каком-либо другом аккаунте: 

    1. Перейдите на главную страницу Яндекса.
    1. Нажмите на свой аватар справа вверху. 
    1. Выберите **{{ ui-key.startrek.ui_components_navigation.invite-user }}**. 
    1. В открывшемся окне введите ваш логин и пароль.
    1. Перейдите на [страницу {{ tracker-name }}]({{ link-tracker }}).

- Повторная авторизация
    
    1. Перейдите по этой [ссылке](https://tracker.yandex.ru/connect/clear_organization?retpath=https://tracker.yandex.ru/hi-there).
    1. Нажмите на свой аватар справа вверху.
    1. Нажмите на кнопку **{{ ui-key.startrek.ui_components_Gantt.exit }}**. 
    1. Перейдите на [страницу {{ tracker-name }}](https://yandex.cloud/ru/services/tracker).
    1. Выберите **Открыть сервис**.
    1. Авторизуйтесь заново.

{% endlist %}