### Контактные данные ответственного за организацию актуальны {#organization-contacts}

#|
|| **kind** | **severity** | **ID** ||
|| manual | low | procedure.organization-contacts ||
|#

#### Описание

{% note warning "**Ручная проверка**" %}

Данное правило требуется для ручной проверки. После проверки и обновления отметьте ее выполнение вручную.

{% endnote %}

В Yandex Cloud при регистрации облака клиент указывает контактные данные. Например, электронная почта используется для оповещений, связанных с инцидентами, плановыми работами и т. д.

Например, если со стороны облака были обнаружены аномальные активности в организации клиента или облачные ключи IAM становятся доступными во внешних репозиториях GitHub, клиенту будет направлено оповещение. Эта возможность реализована с помощью участия Yandex Cloud в программе [Github Secret scanning partner program](https://docs.github.com/en/developers/overview/secret-scanning-partner-program), а также анализа секретов в поиске Яндекса. В случае компрометации ключей в публичном репозитории удалите секрет из репозитория, его [истории](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/removing-sensitive-data-from-a-repository) и отзовите [ключи](https://yandex.cloud/ru/docs/iam/operations/compromised-credentials).

Убедитесь, что контактные данные актуальны и указанный почтовый ящик рассылает сообщения нескольким ответственным.

#### Инструкции и решения по выполнению

**Инструкции и решения по выполнению:**

Укажите актуальные контактные данные по [инструкции](https://yandex.cloud/ru/docs/billing/operations/change-data#change-address).