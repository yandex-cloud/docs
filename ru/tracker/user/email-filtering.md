# Фильтрация входящей почты

Почтовые уведомления {{ tracker-name }} содержат заголовки (хедеры), которые можно использовать для фильтрации писем.

Фильтрацию входящих писем можно настроить в [Почте](https://mail.yandex-team.ru/#setup/filters).

Заголовок | Комментарий | Пример
----- | ----- | -----
X-Startrek | Заголовок означает, что письмо от {{ tracker-name }} | yes
X-Startrek-Key | Ключ задачи | TEST-1
X-Startrek-Priority | Приоритет | Normal
X-Startrek-Reporter | Автор задачи | cheshire.katze@yandex-team.ru
X-Startrek-IssueType | Тип задачи | Task
X-Startrek-Assignee | Исполнитель | cheshire.katze
X-Startrek-Tags | Теги | Переезды
X-Startrek-From | Пользователь, который инициировал отправку уведомления (например, автор последнего изменения задачи) | cheshire.katze@yandex-team.ru
X-Startrek-Cc | Наблюдатели задачи | cheshire.katze@startrek-cc
X-Startrek-Component | Компоненты задачи | 5075543ae4b03135cc676db1@startrek-component
X-Startrek-QA-Engineer | Значение поля <q>QA-инженер</q>. Присутствует только в том случае, если поле заполнено | cheshire.katze
X-Startrek-Changed | Измененные поля. Присутствует только в том случае, если поля менялись. При создании задачи отсутствует | Followers,Type,Queue,Key,Tags
X-Startrek-Fix-Version | Значение поля <q>Исправить в версиях</q> | Release_05.07.2016
X-Startrek-Affected-Version | Значение поля <q>Найдено в версиях</q> | 0.1.2
X-Startrek-FingerPrint | Хэш MAC-адреса бэкенда | 2b953364
X-Startrek-Old-Status | Старый статус задачи | Testing
X-Startrek-New-Status | Текущий статус задачи | Testing
X-Startrek-Summon | Присутствует, если это письмо о призыве в комментарии | Yes
X-Startrek-Queue | Ключ очереди, в которой находится задача | TEST
X-Startrek-Voted | Присутствует, если вы голосовали за эту задачу | Yes
X-Startrek-Favorite | Присутствует, если задача у вас в избранном | Yes

