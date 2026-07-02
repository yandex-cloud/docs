[Документация Yandex Cloud](../index.md) > [Yandex Smart Web Security](index.md) > Аудитные логи Audit Trails

# Справочник аудитных логов Yandex Audit Trails

В Audit Trails для Yandex Smart Web Security поддерживается отслеживание [событий уровня конфигурации](../audit-trails/concepts/format.md) (Control Plane) и [событий уровня сервисов](../audit-trails/concepts/format-data-plane.md) (Data Plane).

Общий вид значения поля `event_type` (_тип события_):

```text
yandex.cloud.audit.smartwebsecurity.<имя_события>
```

## Справочник событий уровня конфигурации {#control-plane-events}

Имя события | Описание
--- | ---
`CreateArlProfile` | Создание профиля ARL
`CreateCustomPage` | Создание [шаблона страницы ответа](concepts/response-templates.md)
`CreateDomain` | Создание домена
`CreateLoadBalancer` | Создание прокси-сервера
`CreateMatchList` | Создание списка адресов
`CreateSecurityProfile` | Создание профиля безопасности
`CreateWafProfile` | Создание профиля WAF
`DeleteArlProfile` | Удаление профиля ARL
`DeleteCustomPage` | Удаление шаблона страницы ответа
`DeleteDomain` | Удаление домена
`DeleteLoadBalancer` | Удаление прокси-сервера
`DeleteMatchList` | Удаление списка адресов
`DeleteSecurityProfile` | Удаление профиля безопасности
`DeleteWafProfile` | Удаление профиля WAF
`StartLoadBalancer` | Запуск прокси-сервера
`StopLoadBalancer` | Остановка прокси-сервера
`UpdateArlProfile` | Изменение профиля ARL
`UpdateCustomPage` | Изменение шаблона страницы ответа
`UpdateDomain` | Изменение домена
`UpdateLoadBalancer` | Изменение прокси-сервера
`UpdateMatchList` | Изменение списка адресов
`UpdateSecurityProfile` | Изменение профиля безопасности
`UpdateWafProfile` | Изменение профиля WAF

## Справочник событий уровня сервисов {#data-plane-events}

Имя события | Описание
--- | ---
`ArlMatchedRequest` | Срабатывание правила из профиля ARL
`SWSMatchedRequest` | Срабатывание правила профиля безопасности
`WafMatchedExclusionRule` | Срабатывание правила-исключения из профиля WAF
`WafMatchedRule` | Срабатывание правила из профиля WAF