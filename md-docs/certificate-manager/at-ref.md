# Справочник аудитных логов Yandex Audit Trails

В Audit Trails для Yandex Certificate Manager поддерживается отслеживание [событий уровня конфигурации](../audit-trails/concepts/format.md) (Control Plane) и [событий уровня сервисов](../audit-trails/concepts/format-data-plane.md) (Data Plane).

Общий вид значения поля `event_type` (_тип события_):

```text
yandex.cloud.audit.certificatemanager.<имя_события>
```

Подробная JSON-структура записи события приведена в справочнике аудитных логов. События в нем отсортированы по алфавиту без разделения на уровни и содержат все возможные поля. В реальных логах набор полей зависит от параметров события и конкретного объекта.

## Справочник событий уровня конфигурации {#control-plane-events}

Имя события | Описание
--- | ---
`CreateCertificate` | Добавление сертификата
`CreateDomain` | Добавление домена
`DeleteCertificate` | Удаление сертификата
`DeleteDomain` | Удаление домена
`SetCertificateAccessBindings` | Назначение прав доступа для сертификата
`SetDomainPrimaryCertificate` | Назначение домену основного сертификата
`UpdateCertificate` | Изменение сертификата
`UpdateCertificateAccessBindings` | Изменение прав доступа для сертификата
`UpdateDomain` | Изменение домена
`UpdateDomainAccessBindings` | Изменение прав доступа для домена

## Справочник событий уровня сервисов {#data-plane-events}

Имя события | Описание
--- | ---
`GetCertificateContent` | Получение содержимого SSL-сертификата
`GetExCertificateContent` | Получение содержимого истекшего SSL-сертификата