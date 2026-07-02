[Документация Yandex Cloud](../../index.md) > [Yandex Cloud Functions](../index.md) > Вопросы и ответы

# Общие вопросы про Cloud Functions

#### Я могу получить логи моей работы в сервисах? {#logs}

Да, вы можете запросить информацию о работе с вашими ресурсами из логов сервисов Yandex Cloud. Для этого обратитесь в [техническую поддержку](https://center.yandex.cloud/support).

#### Как загрузить ZIP-архив с исходным кодом для обновления функции Serverless через CLI? {#version-create}

Чтобы создать версию [функции](../concepts/function.md) из файла с ZIP-архивом, выполните команду:

```bash
yc serverless function version create --source-path
```

Подробнее о загрузке кода читайте в инструкции [Создать версию функции](../operations/function/version-manage.md).

#### Какого размера должен быть архив с исходным кодом для загрузки в Cloud Functions? {#file-size}

Напрямую можно загрузить файл размером до 3,5 МБ. Файл большего размера необходимо [загружать через Yandex Object Storage](../../storage/operations/objects/upload.md). Подробнее в [документации](../operations/function/version-manage.md).

#### Я не владелец облака, но мне предоставили доступ. Какие права/роли мне нужны, чтобы я мог опубликовать функцию? {#roles}

Для управления доступом к функции необходимы роли `admin` или `resource-manager.clouds.owner`. Подробнее в [документации](../security/index.md).

#### Как в функции на Node.js получить доступ к переменной окружения? {#env}

Для доступа к переменным окружения используется глобальная переменная `process.env`. Подробнее в [документации](https://nodejs.org/dist/latest-v8.x/docs/api/process.html#process_process_env).

#### Какие модули Python можно использовать при работе с Cloud Functions? Как подключать новые модули? {#python}

Модули можно загрузить в ZIP-архиве размером до 3,5 МБ. Файл большего размера необходимо [загружать через Object Storage](../../storage/operations/objects/upload.md). Подробнее в [документации](../quickstart/create-function/python-function-quickstart.md).

#### Вызов облачных функций для навыков Яндекс Алисы бесплатный. Если я из облачной функции навыка буду вызывать другую свою облачную функцию — это тоже бесплатно? {#alice-pricing}

Такие вызовы будут тарифицироваться согласно [Правила тарификации для Cloud Functions](../pricing.md).

#### Я хочу увеличить квоты. Как определить подходящие значения для них? {#quotas}

Подробнее о том, какие квоты увеличивать и насколько, в разделе [Взаимосвязь квот](../concepts/limits.md#related-quotas).

#### Почему при попытке отправить запрос к API сервиса возвращается ошибка `Illegal duration format`? {#illegal-duration}

При отправке API-запроса, тело которого содержит параметры в формате `type.googleapis.com/google.protobuf.Duration`, сервис может вернуть ошибку:

```text
Illegal duration format; duration must end with 's' for type type.googleapis.com/google.protobuf.Duration
```

Передавать значения в этом формате необходимо с добавлением суффикса `s`.

Например:

```json
{
  "timeout": "120s"
}
```