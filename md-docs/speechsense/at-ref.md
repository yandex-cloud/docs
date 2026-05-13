# Справочник аудитных логов Yandex SpeechSense

В Audit Trails для Yandex SpeechSense поддерживается отслеживание [событий уровня конфигурации](../audit-trails/concepts/format.md) (Control Plane) и [событий уровня сервисов](../audit-trails/concepts/format-data-plane.md) (Data Plane).

Общий вид значения поля `event_type` (_тип события_):

```text
yandex.cloud.audit.speechsense.<имя_события>
```

## Справочник событий уровня конфигурации {#control-plane-events}

Имя события | Описание
--- | ---
`CreateProject` | Создание проекта
`CreateSpace` | Создание пространства
`DeleteProject` | Удаление проекта
`DeleteSpace` | Удаление пространства
`SetProjectAccessBindings` | Назначение прав доступа к проекту
`SetSpaceAccessBindings` | Назначение прав доступа к пространству
`UpdateProject` | Изменение проекта
`UpdateProjectAccessBindings` | Изменение прав доступа к проекту
`UpdateSpace` | Изменение пространства
`UpdateSpaceAccessBindings` | Изменение прав доступа к пространству

## Справочник событий уровня сервисов {#data-plane-events}

Имя события | Описание
--- | ---
`CreateTalksReport` | Создание отчета о диалоге
`GetTalk` | Получение диалога
`GetTalkAudio` | Получение аудиозаписи диалога
`SearchTalks` | Поиск диалога
`UploadTalkToConnection` | Загрузка диалога в подключение