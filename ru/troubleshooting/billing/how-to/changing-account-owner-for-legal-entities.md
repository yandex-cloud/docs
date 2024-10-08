# Как сменить владельца аккаунта для юридических лиц


## Описание сценария {#case-description}

Необходимо сменить владельца аккаунта, например передать доступы другому сотруднику компании.

## Решение {#case-resolution}

{% list tabs %}

- Если есть доступ к аккаунту

    Для смены администратора аккаунта необходимо:

    1. Зарегистрировать новый Яндекс ID, которому будут переданы права.
    1. Запросить у [технической поддержки]({{ link-console-support }}) шаблон документа, подписать его, поставить печать и прислать скан-копию в ответном письме.
    1. Прислать документ, подтверждающий полномочия подписанта.
   
    {% note info %}

    При смене администратора старый логин будет изменен на новый.

    {% endnote %}
    
    Рекомендуем ознакомиться с [инструкцией для самостоятельной смены владельца в облаках](../../../resource-manager/concepts/resources-hierarchy.md#owner) и с [инструкцией для самостоятельной смены владельца в организациях](../../../organization/security/index.md#admin).
    
    {% note alert %}
    
    Новый логин должен иметь завершенную регистрацию в Яндекс Паспорте и не должен использоваться для авторизации в других сервисах Яндекса и иметь представительства в Балансе — то есть логин должен быть полностью новый.

    {% endnote %}

    С этого логина необходимо зайти и авторизоваться, но не создавать платежный аккаунт. Для этого:

    1. Перейдите по этой [ссылке](https://yandex.cloud/ru/).
    1. Нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_action-connect }}** → **Войти через Яндекс ID**.
    1. Зайдите с новым логином и согласитесь с условием оферты, но не создавайте платежный аккаунт.

    После выполнения этих шагов с вашей стороны и получения нами подписанной скан-копии заявления мы сможем обновить данные в системе.


- Если нет доступа к аккаунту

    Для смены администратора аккаунта необходимо:

    1. Зарегистрировать новый Яндекс ID, которому будут переданы права.
    1. Запросить у [технической поддержки]({{ link-console-support }}) шаблон документа, подписать его, поставить печать и прислать скан-копию в ответном письме.
    1. Прислать документ, подтверждающий полномочия подписанта.

    При смене администратора старый логин будет изменен на новый, а также будет добавлен новый владелец в облачные организации. После смены владельца платежного аккаунта потребуется самостоятельно отозвать права у старого логина в облаках с ресурсами и облачных организациях по этой [инструкции](../../../iam/operations/users/delete).

    {% note info %}

    Новый логин должен иметь завершенную регистрацию в Яндекс ID, но не должен использоваться для авторизации в других сервисах Яндекса и иметь представительства в Яндекс Балансе — то есть логин должен быть полностью новый.

    {% endnote %}

    С этого логина необходимо только зайти и авторизоваться, но не создавать платежный аккаунт. Для этого:

    1. Перейдите по этой [ссылке](https://yandex.cloud/ru/).
    1. Нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_action-connect }}** → **Войти через Яндекс ID**.
    1. Зайдите с новым логином и согласитесь с условием оферты, но не создавайте платежный аккаунт.

    После выполнения этих шагов с вашей стороны и получения нами подписанной скан-копии заявления мы сможем обновить данные в системе.

{% endlist %}
