[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Registry](../../index.md) > [Пошаговые инструкции](../index.md) > Управление артефактами > Python-артефакт > Настроить PyPI

# Настроить PyPI

1. Выберите способ аутентификации:
   
   {% list tabs group=registry_auth %}
   
   - IAM-токен {#iam-token}
   
       Получите [IAM-токен](../../../iam/concepts/authorization/iam-token.md) для [аккаунта на Яндексе](../../../iam/operations/iam-token/create.md) или [сервисного аккаунта](../../../iam/operations/iam-token/create-for-sa.md), от имени которого вы будете выполнять аутентификацию.
   
       {% note info %}
   
       [Время жизни](../../../iam/concepts/authorization/iam-token.md#lifetime) IAM-токена — не больше 12 часов.
   
       {% endnote %}
   
   - API-ключ {#api-key}
   
       [Создайте](../../../iam/operations/authentication/manage-api-keys.md#create-api-key) API-ключ для [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md), от имени которого вы будете выполнять аутентификацию.
   
       При создании ключа задайте его [область действия](*api-key-scope):
       
       * `yc.cloud-registry.artifacts.pull` — для скачивания артефактов из реестра;
       * `yc.cloud-registry.artifacts.push` — для публикации артефактов в реестре.
   
       {% note info %}
   
       [Время жизни](../../../iam/concepts/authorization/api-key.md#scoped-api-keys) API-ключа ограничивается вручную при создании.
   
       {% endnote %}
   
   {% endlist %}
1. В корневой директории пользователя создайте файл `~/.pypirc` со следующим содержимым:

    {% list tabs group=registry_auth %}

    - IAM-токен {#iam-token}

      ```text
      [distutils]
      index-servers =
          cloud-registry

      [cloud-registry]
      repository = https://registry.yandexcloud.net/pypi/<идентификатор_реестра>/legacy/
      username = iam
      password = <IAM-токен>
      ```

    - API-ключ {#api-key}

      ```text
      [distutils]
      index-servers =
          cloud-registry

      [cloud-registry]
      repository = https://registry.yandexcloud.net/pypi/<идентификатор_реестра>/legacy/
      username = api_key
      password = <API-ключ>
      ```

    {% endlist %}

[*api-key-scope]: Область действия — параметр API-ключа, который ограничивает применение ключа определенными операциями в дополнение к правам доступа сервисного аккаунта. Подробнее в разделе [API-ключи с ограничениями области и срока действия](../../../iam/concepts/authorization/api-key.md#scoped-api-keys).