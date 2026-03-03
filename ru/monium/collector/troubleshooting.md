# Устранение неполадок при поставке данных

Этот раздел поможет самостоятельно диагностировать и устранить большинство проблем, которые могут возникнуть при поставке данных в {{ monium-name }}.

{{ monium-name }} поддерживает данные в формате OTLP без дополнительной конвертации, поэтому сначала ознакомьтесь с [требованиями к конфигурации OTLP](otlp-protocol.md) и [настройкой OTel Collector](opentelemetry.md).

## Общие рекомендации по диагностике {#general-troubleshooting}

При возникновении проблем с отправкой данных в {{ monium-name }} выполните базовые шаги диагностики:

1. **Включите логирование**. Убедитесь, что в вашем OTLP-клиенте включено подробное логирование для просмотра деталей ошибок. Способ включения логов зависит от конкретной реализации.

1. **Проверьте переменные окружения**. Убедитесь, что переменные окружения `MONIUM_PROJECT` и `MONIUM_API_KEY` правильно определены и доступны для вашего приложения или OTel Collector.

    Если вы используете проекты облака или каталога `cloud__<идентификатор_облака>` или `folder__<идентификатор_каталога>`, учитывайте, что после `folder` и `cloud` следуют два нижних подчеркивания.

1. **Проверьте API-ключ**:
    * API-ключ действителен и не истек.
    * API-ключ имеет область действия `yc.monium.telemetry.write`.
    * Сервисный аккаунт, связанный с API-ключом, имеет роль `monium.telemetry.writer`.
    * Заголовок `Authorization` имеет верный формат: `Authorization: Api-Key <API-ключ>`.

1. **Проверьте конфигурацию проекта в OTEL-экспортере**:
    * Переменная `MONIUM_PROJECT` задана и имеет верный формат. Проект должен совпадать с именем в URL на главной странице проекта.
    * В заголовке `x-monium-project` передается значение переменной `MONIUM_PROJECT`.
    * У API-ключа и сервисного аккаунта есть права на запись в проект.

1. **Проверьте сетевую доступность**. Для работы с {{ monium-name }} может потребоваться настройка межсетевого экрана в зависимости от вашей сетевой конфигурации. Если соединения по протоколу gRPC блокируются из вашей сети, сконфигурируйте отправку по протоколу `http/protobuf`.

## Каталог ошибок {#issue-catalog}

В таблице перечислены распространенные ошибки, которые могут возникать при работе с {{ monium-name }} через протокол gRPC.

#|
|| **Код gRPC** | **Тип ошибки** | **Сообщение об ошибке** | **Решение** | **Примечания** ||
|| rpc code 3 - InvalidArgument | Отсутствует заголовок проекта | `rpc error: code = InvalidArgument desc = project must be provided using 'x-monium-project' header` | Добавьте заголовок `x-monium-project` в конфигурацию экспортера | Убедитесь, что переменная `MONIUM_PROJECT` определена и передается в заголовке ||
|| rpc code 7 - Unauthenticated | Отсутствует заголовок проекта (альтернативное сообщение) | `rpc error: code = Unauthenticated desc = missing project header` | Добавьте заголовок `x-monium-project` в конфигурацию экспортера | Убедитесь, что переменная `MONIUM_PROJECT` определена и передается в заголовке ||
|| rpc code 7 - Unauthenticated | Отсутствует авторизация | `rpc error: code = Unauthenticated desc = No valid Authorization header provided` | Проверьте, что заголовок `Authorization` присутствует | Добавьте заголовок `Authorization: Api-Key <ключ>` ||
|| rpc code 7 - Unauthenticated | Отсутствует авторизация | `rpc error: code = Unauthenticated desc = Api-Key token must not be blank` | Заголовок `Authorization` присутствует, но значение токена пусто | Убедитесь, что переменная `MONIUM_API_KEY` задана ||
|| rpc code 16 - PermissionDenied | Устаревший API-ключ | `rpc error: code = PermissionDenied desc = UNAUTHENTICATED: The apikey has expired` | Истек срок действия ключа | Сгенерируйте новый API-ключ и обновите `MONIUM_API_KEY` ||
|| rpc code 16 - PermissionDenied | Неизвестный API-ключ | `rpc error: code = PermissionDenied desc = UNAUTHENTICATED: Unknown api key '****'` | Неизвестный API ключ | Сгенерируйте новый API-ключ и обновите `MONIUM_API_KEY` ||
|| rpc code 16 - PermissionDenied | Невалидный API-ключ | `rpc error: code = PermissionDenied desc = UNAUTHENTICATED: API key is invalid` | Проверьте корректность API-ключа и формат заголовка `Authorization` | API-ключ должен передаваться как `Authorization: Api-Key <ключ>` ||
|| rpc code 16 - PermissionDenied | Недостаточно прав | `rpc error: code = PermissionDenied desc = PERMISSION_DENIED: Permission denied` | Проверьте права API-ключа на каталог | Убедитесь, что указан правильный проект, API-ключ имеет область действия `yc.monium.telemetry.write`, а сервисный аккаунт имеет роль `monium.telemetry.writer` ||
|| rpc code 16 - PermissionDenied | Не найден проект | `rpc error: code = PermissionDenied desc = PERMISSION_DENIED: Project not found` | Проверьте формат имени проекта | Скопируйте имя проекта из URL на главной странице проекта ||
|| rpc code 8 - ResourceExhausted | Превышена квота на количество хранимых метрик | `rpc error: code = ResourceExhausted desc = more than 100000 metrics in shard` | Увеличьте квоту на количество хранимых метрик | Обратитесь в техническую поддержку для увеличения лимита метрик в шарде ||
|| transport | Отсутствует сетевой доступ | `connection error: desc = "transport: Error while dialing: dial tcp [2a0d:d6c1:0:1a::3d0]:443: connect: no route to host` | Убедитесь в сетевой доступности `https://{{ api-host-monium }}` | В случае блокировки протокола gRPC настройте экспорт по протоколу `http/protobuf` ||
|#

## Дополнительная информация {#additional-info}

В случае ошибок конфигурации OTel Collector обратитесь к [официальной документации OpenTelemetry](https://opentelemetry.io/docs/collector/troubleshooting/).

Проверить конфигурацию можно с помощью команды:

```bash
otelcol validate --config=otel-collector.yaml
```