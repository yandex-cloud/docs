### API-ключи для сервисов AI Studio должны иметь ограничение срока действия {#api-key-rotation}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | medium | ai.api-key-rotation ||
|#

#### Описание

**Как работает правило**: проверяется, что ключи API-ключи, созданные для работы в AI Studio, имеют установленный срок действия.

Yandex Cloud позволяет задавать [срок действия](https://yandex.cloud/ru/docs/iam/concepts/authorization/api-key#scoped-api-keys) API-ключей, но максимальное время жизни должно определяться организационной политикой.

Рекомендуемое время жизни по умолчанию — 90 дней для обычных систем и 30 дней для высокорисковых ИИ-систем и ИИ-агентов. [Статические ключи доступа](https://yandex.cloud/ru/docs/iam/concepts/authorization/access-key), совместимые с AWS API, и [авторизованные ключи](https://yandex.cloud/ru/docs/iam/concepts/authorization/key) могут не иметь ограничение срока действия, заданное на сервере, поэтому для них требуется ручная или автоматизированная ротация по параметру `createdAt` и удаление неиспользуемых ключей.

#### Инструкции и решения по выполнению

1. Получите все типы ключей для каждого сервисного аккаунта, который используется в компонентах AI, MCP, DataSphere: 

   ```bash
   yc iam api-key list --service-account-id <sa-id> --format json 
   ``` 

1. Если у полученных ключей не задано значение в поле `expires at`, срок действия не ограничен. 
1. [Перевыпустите](https://yandex.cloud/ru/docs/iam/operations/compromised-credentials#api-key-reissue) ключи без ограничения срока действия и обязательно задайте срок действия.
