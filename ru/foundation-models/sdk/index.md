# {{ ml-sdk-full-name }}

{{ ai-studio-full-name }} предоставляет библиотеку инструментов и примеров готового кода для разработки продуктов на языке Python — {{ ml-sdk-full-name }}. {{ ml-sdk-name }} обеспечивает стандартизированный способ взаимодействия с фундаментальными моделями и упрощает интеграцию с другими сервисами {{ yandex-cloud }}.

Библиотека {{ ml-sdk-name }} реализует синхронный и асинхронный интерфейсы Python на основе gRPC-вызовов API сервисов {{ ai-studio-name }}. В {{ ml-sdk-name }} доступны следующие возможности:
* [генерации текста](../concepts/yandexgpt/index.md) от {{ yagpt-name }};
* работа с [эмбеддингами](../concepts/embeddings.md);
* работа с [классификаторами на базе {{ yagpt-name }}](../concepts/classifier/index.md);
* интеграция с [LangСhain](https://www.langchain.com/).

Полный перечень поддерживаемых функций, исходный код библиотеки и примеры использования доступны на [GitHub](https://github.com/yandex-cloud/yandex-cloud-ml-sdk).

## Установка и использование {#install}

Установить библиотеку {{ ml-sdk-name }} можно с помощью менеджера пакетов [pip](https://pip.pypa.io/en/stable/):

```bash
pip install yandex-cloud-ml-sdk
```

При инициализации библиотеки вам потребуется ввести [идентификатор каталога](../../resource-manager/operations/folder/get-id.md), в котором вы будете работать с моделями, и информацию для аутентификации. {{ ml-sdk-name }} поддерживает следующие способы аутентификации:
* [IAM-токен](../../iam/operations/iam-token/create.md)
* [API-ключ](../../iam/operations/api-key/create.md) 
* [OAuth-токен](../../iam/concepts/authorization/oauth-token.md)

Пример ниже отправит в модель {{ gpt-pro }} запрос c промтом «Что такое небо?».

```python
from yandex_cloud_ml_sdk import YCloudML

sdk = YCloudML(folder_id="<идентификатор_каталога>", auth="<токен>")

model = sdk.models.completions('yandexgpt')
model = model.configure(temperature=0.5)
result = model.run("Что такое небо?")

for alternative in result:
    print(alternative)
```