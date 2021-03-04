## Задачи
Таблетка CMS реализует сервисы, помогающие решать следующие задачи:
* Проводить рестарт кластера без потери доступности сервиса (aka rolling restart)
* Автоматизировать замену сломанного оборудования
* Автоматизировать реконфигурацию кластера при выходе дисков из строя
* Прекращать/возобновлять использование дисков до запросу администратора

## Интерфейсы
Интерфейс таблетки CMS описан в [cms.h](https://a.yandex-team.ru/arc/trunk/arcadia/kikimr/core/cms/cms.h). Соответсвующие protobuf сообщения описаны в [cms.proto](https://a.yandex-team.ru/arc/trunk/arcadia/kikimr/core/protos/cms.proto)

CMS также предоставляет несколько внешних интерфейсов:
* GRPC интерфейс позволяет делать запросы, описанные в сообщении [TCmsRequest](https://a.yandex-team.ru/search?search=message%20TCmsRequest,,,arcadia,,200)
* HTTP интерфейс, позволяющий делать часть CMS запросов через отправку соотвествующих protobuf сообщений в JSON формате. Интерфейс описан в [http.cpp](https://a.yandex-team.ru/arc/trunk/arcadia/kikimr/core/cms/http.cpp)
* [HTTP Wall-E CMS](https://wiki.yandex-team.ru/wall-e/guide/cms/) интерфейс. Реализована версия 1.1 протокола для интеграции с сервисом Wall-E

## Запросы на действия с кластером
Пожалуй наиболее часто CMS используется для запроса на проведения какого-либо действия с кластером. Наиболее частое действие - рестарт кластера. Действия с кластером описываются сообщением [TAction](https://a.yandex-team.ru/search?search=message%20TAction,cms.proto,,arcadia,,200)

    message TAction {
      enum EType {
        UNKNOWN           = 0;
        START_SERVICES    = 1;
        RESTART_SERVICES  = 2;
        STOP_SERVICES     = 3;
        ADD_HOST          = 4;
        SHUTDOWN_HOST     = 5;
        DECOMMISSION_HOST = 6;
        ADD_DEVICES       = 7;
        REPLACE_DEVICES   = 8;
        REMOVE_DEVICES    = 9;
      }
    
      optional EType     Type        = 1;
      optional string    Host        = 2;
      repeated string    Services    = 3;
      repeated string    Devices     = 4;
      optional uint64    Duration    = 5;
    }
Использование полей зависит от типа действия:
* **START_SERVICES** – _**не поддерживается**_
* **RESTART_SERVICES** - временная остановка (перезапуск) сервисов. Поле **Host** содержит имя хоста. Поле **Services** содержит список перезапускаемых сервисов. Поле Duration содержит время, на которое останавливаются сервисы. _**Подразумевается, что CMS должен определять, какие сервисы предоставляют ноды на хосте (например, нода хранилища и/или вычислительная нода), но на данный момент считается, что все ноды предоставляют только сервис "storage"**_
* **STOP_SERVICES** – _**не поддерживается**_
* **ADD_HOST** – _**не поддерживается**_
* **SHUTDOWN_HOST** - временное отключение хоста. Поле **Host** содержит имя хоста. Поле **Duration** содержит время, на которое выключается хост
* **DECOMMISSION_HOST** – _**не поддерживается**_
* **ADD_DEVICES** - _**не поддерживается**_
* **REPLACE_DEVICES** - замена устройств. Поле **Devices** содержит имена заменяемых устройств. Поле **Duration** содержит время, которое устройства будут недоступны
* **REMOVE_DEVICES** - _**не поддерживается**_

Сам запрос на действия с кластером описывется сообщением [TPermissionRequest](https://a.yandex-team.ru/search?search=message%20TPermissionRequest,cms.proto,,arcadia,,200)

    message TPermissionRequest {                                                        
      optional string  User                     = 1;
      repeated TAction Actions                  = 2;
      optional bool    PartialPermissionAllowed = 3 [default = false];
      optional bool    Schedule                 = 4;
      optional bool    DryRun                   = 5;
      optional string  Reason                   = 6;
      optional uint64  Duration                 = 7;
      optional ETenantPolicy TenantPolicy       = 8 [default = DEFAULT];
      optional EAvailabilityMode AvailabilityMode = 9 [default = MODE_MAX_AVAILABILITY];
    }
Поля сообщения используются следующим образом:
* **User** содержит имя пользователя. Сам запрос и получаемые разрешения привязаны к пользователю и могут управляться только им
* **Actions** содержит все действия, на которые запрашиваются разрешения
* **PartialPermissionAllowed** выставляется в _true_, если разрешение на часть из перечисленных действий является допустимым. В противном случае клиента интересует только одновременное разрешение на все запрошенные действия. Частичные разрешения могут быть использованы для поэтапного выполнения операций. Например, при обновлении сервиса клиент формирует запрос на временную остановку сервиса на всех хостах кластера, а CMS в ответе укажет, на каких хостах в данный момент сервисы можно отключить. В следующем запросе список хостов будет содержать только не обновленные хосты и т.д., пока не будут обновлены все хосты
* **Schedule** позволяет сохранять в CMS запросы, которые в данный момент нельзя выполнить, но которые можно будет выполнить позднее. Сохранение запросов позволит поставить действия в очередь на исполнение и узнавать статус через команды управления запросами. Запланированные таким образом запросы учитываются при разрешении запрошенных позднее действий и будут иметь над ними преимущество
* **DryRun** позволяет провести симуляцию исполнения запроса. Ответ CMS должен быть таким же, что и при обычном запросе (кроме идентификаторов запроса и разрешений), однако состояние CMS при этом не будет модифицировано 
* **Reason** является информационным полем и может содержать краткое описание и причину предпринимаемых действий
* **Duration** содержит время, на которое запрашивается разрешение
* **TenantPolicy** содержит политику сохранения работоспособности тенанта во время проведения работ по кластеру. Поддерживаемые значения
  * **NONE** - не обращать внимания на доступность нод тенантов. При этом соблюдаются кластерные лимиты, указанные в конфиге CMS
  * **DEFAULT** - следовать тенантным лимитам, указаным в конфиге CMS. Также соблюдаются кластерные лимиты, указанные в конфиге CMS
* **AvailabilityMode** содержит режим доступности кластера, который должен соблюдаться при выполнении запрошенных действий. Поддерживаются селудющие значения
  * **MODE_MAX_AVAILABILITY** - разрешается не более 1 не работающего диска в каждой из storage group
  * **MODE_KEEP_AVAILABLE** - лимит отключенных дисков в группе соответсвует количеству parity parts в этой группе. Разрешения при этом все равно могут выдаваться не более чем на 1 диск в группе. Данный режим позволяет продвинуть рестарт кластера, когда там есть сломанные диски
  * **MODE_FORCE_RESTART** - разрешение выдается не более чем на 1 диск в группе, но при этом в группе может быть сколько угодно недоступных дисков (по причине поломки). В данном режиме допускается деградация кластера. Также игнорируются тенантные и кластерные ограничения, если они мешают выдать разрешение хотя бы на одну ноду тенанта/кластера

В ответ CMS присылает разрешения на действия, либо отвечает отказом. Разрешение описывается сообщением [TPermission](https://a.yandex-team.ru/search?search=message%20TPermission%20,cms.proto,,arcadia,,200):

    message TPermission {                          
      optional string   Id       = 1;
      optional TAction  Action   = 2;
      optional uint64   Deadline = 3;
      repeated TPermissionExtension Extentions = 4;
    }
Поля сообщения используются следующим образом:
* **Id** содержит уникальный идентификатор разрешения. Может быть использован для управления разрешениями
* **Action** содержит разрешаемое действие
* **Deadline** содержит время, когда истекает разрешение. Отключение сервисов и/или хостов после **Deadline** будет расценено как поломка, а не как запланированное отключение. Если отключение продлится дольше указанного в TAction.Duration времени, то это также расценивается как поломка

Ответ на запрос описывается сообщением [TPermissionResponse](https://a.yandex-team.ru/search?search=message%20TPermissionResponse,cms.proto,,arcadia,,200)

    message TStatus {               
        enum ECode {                
            UNKNOWN       = 0;      
            OK            = 1;      
            ALLOW         = 2;      
            ALLOW_PARTIAL = 3;      
            DISALLOW      = 4;      
            DISALLOW_TEMP = 5;      
            WRONG_REQUEST = 6;      
            ERROR         = 7;      
            ERROR_TEMP    = 8;      
            UNAUTHORIZED  = 9;      
        }                           
                                    
        optional ECode   Code   = 1;
        optional string  Reason = 2;
    }   

    message TPermissionResponse {
      optional TStatus     Status       = 1;
      optional string      RequestId    = 2;
      repeated TPermission Permissions  = 3;
      optional uint64      Deadline     = 4;
    }
* **RequestId** присутствует в ответах на запросы, которые были сохранены в CMS. По нему пользователи могут управлять своими запросами
* **Status** содержит код ответа и опционально сообщение об ошибке, использование остальных полей зависит от кода ответа
  * **ALLOW_PARTIAL** – разрешение на выполнение части запрошенных действий. Выдаваемые разрешения перечислены в поле **Permissions**
  * **ALLOW** – разрешение на проведение всех запрошенных действий. Поля заполняются аналогично случаю **ALLOW_PARTIAL**
  * **DISALLOW_TEMP** – временный отказ в проведении действий. Поле **Reason** содержит описание причины отказа. Поле **Deadline** содержит время, когда стоит повторить запрос. Данный ответ может использоваться для отсрочки действий (например, чтобы восстановиться от недавно возникшей поломки или для предварительной реконфигурации кластера)
  * **DISALLOW** – отказ в проведении действий. Повторный запрос при неизменной конфигурации кластера также приведет к отказу. Поле **Reason** содержит описание причины отказа
  * **WRONG_REQUEST** - ошибка в запросе
  * **ERROR** – ошибка при обработке запроса
  * **ERROR_TEMP** – временная ошибка при обработке запроса. Поле **Deadline** содержит время, когда можно сделать повторный запрос

## Управление сохраненными запросами
Если CMS временно не смог разрешить запрошенный набор действий, а запрос был сделан с флагом **Schedule**, то запрос будет сохранен в CMS и запланирован для дальнейшего исполнения. Управление такими запросами происходит по **RequestId**, возвращенному в [TPermissionResponse](https://a.yandex-team.ru/search?search=message%20TPermissionResponse,cms.proto,,arcadia,,200). Команды на управление запросами описываются protobuf сообщениями [TManageRequestRequest](https://a.yandex-team.ru/search?search=message%20TManageRequestRequest,cms.proto,,arcadia,,200) и [TCheckRequest](https://a.yandex-team.ru/search?search=message%20TCheckRequest,cms.proto,,arcadia,,200)

    message TManageRequestRequest {
      enum ECommand {
        UNKNOWN = 0;
        LIST    = 1;
        GET     = 2;
        REJECT  = 3;
      }
    
      optional string   User      = 1;
      optional ECommand Command   = 2;
      optional string   RequestId = 3;
      optional bool     DryRun    = 4;
    }
* **User** содержит имя пользователя. Управлять запросами может только задавший их пользователь
* **Command** содержит команду, которую мы хотим выполнить
  * **LIST** - получить все текущие запросы пользователя
  * **GET** - получить запрос с идентификатором **RequestId**
  * **REJECT** - отменить запрос с идентификатором **RequestId**
* **DryRun** позволяет провести симуляцию исполнения команды. Ответ CMS должен быть таким же, что и при обычном запросе, однако состояние CMS при этом не будет модифицировано

В ответ CMS отправляет [TManageRequestResponse](https://a.yandex-team.ru/search?search=message%20TManageRequestResponse,cms.proto,,arcadia,,200) следующего вида:

    message TManageRequestResponse {
      message TScheduledRequest {
        optional string  RequestId                = 1;
        optional string  Owner                    = 2;
        repeated TAction Actions                  = 3;
        optional bool    PartialPermissionAllowed = 4;
        optional string  Reason                   = 5;
      }
  
      optional TStatus           Status   = 1;
      repeated TScheduledRequest Requests = 2;
    }

* **Status** содержит статус исполнения запроса
* **Requests** содержит запрошенные запланированные запросы пользователя при **GET** и **LIST** запросах. В случае сохраненного запроса, который позволяет частичное разрешение действий, в ответе будут перечислены только те действия, на которые еще не были выданы разрешения

[TCheckRequest](https://a.yandex-team.ru/search?search=message%20TCheckRequest,cms.proto,,arcadia,,200) используется для проверки текущего статуса запроса. CMS проверяет, какие из оставшихся действий можно выполнить, и отвечает сообщением [TPermissionResponse](https://a.yandex-team.ru/search?search=message%20TPermissionResponse,cms.proto,,arcadia,,200)

    message TCheckRequest {
      optional string   User      = 1;
      optional string   RequestId = 2;
      optional bool     DryRun    = 3;
      optional EAvailabilityMode AvailabilityMode = 4 [default = MODE_MAX_AVAILABILITY];
    }

* **User** содержит имя пользователя. Проверить запрос может только задавший его пользователь
* **RequestId** содержит идентификатор проверяемого запроса
* **DryRun** позволяет провести симуляцию проверки запроса. Ответ CMS должен быть таким же, что и при обычном запросе (кроме идентификаторов разрешений), однако состояние CMS при этом не будет модифицировано
* **AvailabilityMode** позволяет переопределить **AvailabilityMode**, который был указан в запросе на разрешение. Может использоваться для ослабления требований к доступности кластера, если выполнения на исходном уровне доступности невозможно из-за поломок в кластере

## Управление выданными разрешениями
CMS хранит у себя информацию о выданных разрешениях, так как их важно учитывать при обработке последующих запросов. Имея разрешение на действие, клиент может отказаться от него или попытаться его продлить. Для управления разрешениями используется запрос [TManagePermissionRequest](https://a.yandex-team.ru/search?search=message%20TManagePermissionRequest,cms.proto,,arcadia,,200)

    message TManagePermissionRequest {
      enum ECommand {
        UNKNOWN = 0;
        LIST    = 1;
        GET     = 2;
        DONE    = 3;
        EXTEND  = 4;
        REJECT  = 5;
      }

      optional string   User        = 1;
      optional ECommand Command     = 2;
      repeated string   Permissions = 3;
      optional uint64   Deadline    = 4;
      optional bool     DryRun      = 5;
    }  
* **User** содержит имя пользователя. Управлять разрешениями может только получивший их пользователь
* **Command** содержит команду, которую мы хотим выполнить для разрешений
  * **LIST** - получить все действующие разрешения пользователя
  * **GET** - получить разрешения, идентификаторы которых перечислены в поле **Permissions**
  * **DONE** - информирование CMS о том, что разрешенное действие было выполнено и разрешение более не нужно. **Permissions** содержит список не нужных более разрешений
  * **EXTEND** - продлить разрешение до срока, указанного в поле **Deadline**. На самом деле можно и сокращать срок разрешения. **Permissions** содержит список модифицируемых разрешений
  * **REJECT** - отказаться от разрешения. Равносильно сокращению срока разрешения до текущего момента. **Permissions** содержит список удаляемых разрешений
* **DryRun** позволяет провести симуляцию исполнения команды. Ответ CMS должен быть таким же, что и при обычном запросе, однако состояние CMS при этом не будет модифицировано

В ответ CMS отправляет [TManagePermissionResponse](https://a.yandex-team.ru/search?search=message%20TManagePermissionResponse,cms.proto,,arcadia,,200) следующего вида:

    message TManagePermissionResponse {
      optional TStatus     Status      = 1;
      repeated TPermission Permissions = 2;
    }
* **Status** содержит статус **OK** для запросов **LIST**, **GET**, **DONE**, **REJECT**. Для запроса **EXTEND** ожидается **ALLOW** или **DISALLOW**
* **Permissions** содержит запрошенные разрешения пользователя для запросов **LIST** и **GET** и измененные разрешения (в случае ответа **ALLOW**) для запроса **EXTEND**

## Возможный сценарий проведения rolling restart кластера с использованием CMS
Приведем один из алгоритмов, по которому можно использовать CMS для проведения rolling restart:
1. Делаем запрос на разрешение рестарта всех хостов кластера. Для этого в запрос [TPermissionRequest](https://a.yandex-team.ru/search?search=message%20TPermissionRequest,cms.proto,,arcadia,,200) добавляем по одному [TAction](https://a.yandex-team.ru/search?search=message%20TAction,cms.proto,,arcadia,,200) на каждый хост с типом действия **SHUTDOWN_HOST**. У запроса выставляются флаги **PartialPermissionAllowed** и **Schedule**
2. Для хостов, на которые было получено разрешение (если таковые имеются) выполняем рестарт и отправляем в CMS команды [TManagePermissionRequest](https://a.yandex-team.ru/search?search=message%20TManagePermissionRequest,cms.proto,,arcadia,,200) с действием **DONE** и идентификаторами ненужных более разрешений
3. Далее мы в цикле делаем запрос [TCheckRequest](https://a.yandex-team.ru/search?search=message%20TCheckRequest,cms.proto,,arcadia,,200) с полученным на первом шаге идентификатором запроса. Если в ответ получаем хосты на рестарт, то действуем аналогично пункту 2. Если хостов на рестарт не получено, то ждем до **Deadline**, указанном в ответе и повторяем запрос. Последняя порция разрешений на рестарт придет со статусом **ALLOW** (предыдущие со статусом **ALOW_PARTIAL**), что позволяет понять, когда все хосты обработаны. Также после обрабтки всех хостов запрос будет удален из CMS и в ответ на [TCheckRequest](https://a.yandex-team.ru/search?search=message%20TCheckRequest,cms.proto,,arcadia,,200) будет получен статус **WRONG_REQUEST**

## Нотификации о запланированных работах
Если в кластере есть какие-то запланированные работы, то можно уведомить об этом CMS. В таком случае запланированные работы могут быть учтены CMS при выдаче разрешений (будет учтено, пересекается ли разрешаемое действие с запланированным). Также CMS может использовать эту информацию для автоматической реконфигурации кластера в качестве реакции на длительные работы в каких-либо узлах кластера

Нотификация CMS описывается сообщением [TNotification](https://a.yandex-team.ru/search?search=message%20TNotification%20,cms.proto,,arcadia,,200)

    message TNotification {
      optional string   User    = 1;
      repeated TAction  Actions = 2;
      optional uint64   Time    = 3;
      optional string   Reason  = 4;
    }
* **User** содержит имя пользователя.
* **Actions** содержит все запланированные действия
* **Time** содержит время, на которое действия запланированы
* **Reason** является информационным полем и может содержать краткое описание предпринимаемых действий

В ответ CMS отправляет сообщение [TNotificationResponse](https://a.yandex-team.ru/search?search=message%20TNotificationResponse,cms.proto,,arcadia,,200) со статусом обработки

    message TNotificationResponse {
      optional TStatus Status = 1;
    }

Загруженными в CMS нотификациями можно управлять. Возможные дейстыия описаны в сообщении [TManageNotificationRequest](https://a.yandex-team.ru/search?search=message%20TManageNotificationRequest,cms.proto,,arcadia,,200)

    message TManageNotificationRequest {   
      enum ECommand {
        UNKNOWN = 0;
        LIST    = 1;
        GET     = 2;
        REJECT  = 3;
      }

      optional string   User           = 1;
      optional ECommand Command        = 2;
      optional string   NotificationId = 3;
      optional bool     DryRun         = 4;
    }
* **User** содержит имя пользователя. Пользователи могут управлять только своими нотификациями
* **Command** содержит запрашиваемое действие
  * **LIST** - вернуть все нотификации пользователя
  * **GET** - вернуть нотификацию с идентификатором **NotificationId**
* **DryRun** - выполнить команду без изменения состояния CMS

Ответ CMS описывается сообщением [TManageNotificationResponse](https://a.yandex-team.ru/search?search=message%20TManageNotificationResponse,cms.proto,,arcadia,,200)

    message TManageNotificationResponse {
      message TStoredNotification {
        optional string  NotificationId = 1;
        optional string  Owner          = 2;
        repeated TAction Actions        = 3;
        optional uint64  Time           = 4;
        optional string  Reason         = 5;
      }

      optional TStatus             Status        = 1;
      repeated TStoredNotification Notifications = 2;
    }
* **Status** содержит статус выполнения запроса (ожидаемые статусы **OK** и **WRONG_REQUEST**)
* **Notifications** содержит нотификации, запрошенные запросами **GET** и **LIST**

## Интеграция с Wall-E
CMS предоставляет внешний HTTP интерфейс, реализующий [Wall-E CMS API](https://wiki.yandex-team.ru/wall-e/guide/cms/) v1.1

В [walle_api_handler.cpp](https://a.yandex-team.ru/arc/trunk/arcadia/kikimr/core/cms/walle_api_handler.cpp) содержится имплементация актора, который принимает HTTP запросы и перенаправляет их в CMS. В CMS в свою очередь для таких запросов заводятся акторы-адаптеры, которые транслируют Wall-E запросы в соотвествующие таблеточные CMS запросы. В CMS существует несколько специализированных запросов для обработки Wall-E запросов:
* [TWalleCreateTaskRequest](https://a.yandex-team.ru/search?search=message%20TWalleCreateTaskRequest,cms.proto,,arcadia,,200)
* [TWalleListTasksRequest](https://a.yandex-team.ru/search?search=message%20TWalleListTasksRequest,cms.proto,,arcadia,,200)
* [TWalleCheckTaskRequest](https://a.yandex-team.ru/search?search=message%20TWalleCheckTaskRequest,cms.proto,,arcadia,,200)
* [TWalleRemoveTaskRequest](https://a.yandex-team.ru/search?search=message%20TWalleRemoveTaskRequest,cms.proto,,arcadia,,200)

Данные запросы обрабатываются соответсвующими акторами адаптерами:
* [TWalleCreateTaskAdapter](https://a.yandex-team.ru/arc/trunk/arcadia/kikimr/core/cms/walle_create_task_adapter.cpp)
* [TWalleListTasksAdapter](https://a.yandex-team.ru/arc/trunk/arcadia/kikimr/core/cms/walle_list_tasks_adapter.cpp)
* [TWalleCheckTaskAdapter](https://a.yandex-team.ru/arc/trunk/arcadia/kikimr/core/cms/walle_check_task_adapter.cpp)
* [TWalleRemoveTaskAdapter](https://a.yandex-team.ru/arc/trunk/arcadia/kikimr/core/cms/walle_remove_task_adapter.cpp)

Имена задач Wall-E задаются снаружи, тогда как имена сохраненных запросов CMS выбираются самим CMS. Это приводит к необходимости маппинга имен, который делается в CMS через таблицу [WalleTask](https://a.yandex-team.ru/search?search=struct%20WalleTask,scheme.h,,arcadia,,200)

## Устройство проверок в CMS
В данном разделе кратко рассматривается, как CMS определяет, можно ли разрешать то или иное действие в кластере

### Получение текущего статуса кластера
Перед принятием решения о разрешении какого-либо действия CMS должен собрать текущее состояние кластера. Для это создается специальный актор [TInfoCollector](https://a.yandex-team.ru/arc/trunk/arcadia/kikimr/core/cms/info_collector.cpp). Цель этого актора - опросить ноды актора о своем состоянии, заполнить структуру [TClusterInfo](https://a.yandex-team.ru/search?search=class%20TClusterInfo,,,arcadia,,200) и отправить ее в CMS

Состояние кластера получается запросами в BlobStorageController, WhiteBoard и TenantPool. У BSC запрашивается базовый конфиг, который содержит инофрмацию о всех группах в кластере. У WhiteBoard запрашивается системное состояние, состояние PDisk-ов, состояние VDisk-ов и состояние таблеток. У TenantPool запрашивается информация о привязке нод к тенантам. После получения всех ответов полученная информация собирается в [TClusterInfo](https://a.yandex-team.ru/search?search=class%20TClusterInfo,,,arcadia,,200) и отправляется в CMS

### Расстановка локов на объектах кластера
Помимо состояния кластера необходимо учитывать состояние самого CMS, а именно сохраненные запросы, нотификации и выданные разрешения

Основными элементами состояния кластера являются ноды, PDisk-и и VDisk-и. Все эти объекты реализуют интерфейс [TLockableItem](https://a.yandex-team.ru/search?search=class%20TLockableItem%20,,,arcadia,,200), который позволяет навешивать на объекты различные локи. Существует несколько типов локов:
* [TLock](https://a.yandex-team.ru/search?search=struct%20TLock,cluster_info.h,,arcadia,,200) - лок, соответсвующий выданному на этот объект разрешению. Хранит соответсвующий **PermissionId**. Такой лок на объекте может быть только один
* [TExternalLock](https://a.yandex-team.ru/search?search=struct%20TExternalLock,cluster_info.h,,arcadia,,200) - лок, соответствующий сохраненной нотификации
* [TScheduledLock](https://a.yandex-team.ru/search?search=struct%20TScheduledLock,cluster_info.h,,arcadia,,200) - лок, соответсвующий сохраненному пользовательскому запросу, который позволяет давать таким запросам приортет перед вновь поступающими запросами
* [TTemporaryLock](https://a.yandex-team.ru/search?search=struct%20TTemporaryLock,cluster_info.h,,arcadia,,200) - лок, используемый для поиска конфликтов между запрашиваемыми действиями в рамках одного запроса на разрешения

После получении текущего состояния кластера CMS навешивает на объекты кластера локи [TLock](https://a.yandex-team.ru/search?search=struct%20TLock,cluster_info.h,,arcadia,,200), [TExternalLock](https://a.yandex-team.ru/search?search=struct%20TExternalLock,cluster_info.h,,arcadia,,200) и [TScheduledLock](https://a.yandex-team.ru/search?search=struct%20TScheduledLock,cluster_info.h,,arcadia,,200) в соответсвии с текущим состоянием CMS

### Анализ возможности действия
Когда приходит запрос на разрешение на действия с кластером, мы последовательно идем по затребованным действиям и проверяем, есть ли поломки в кластере, локи или другие ограничения, которые могут помешать совершить требуемое действие. Объектами действий у нас могут быть VDisk-и, PDisk-и и ноды кластера. Опишем, какие проверки делаются при анализе возможных действий с каждым из этих объектов

**VDisk**
1. Проверяется, есть ли локи на данном VDisk-е
2. Проверяется, есть ли локи на PDisk-е, которому принадлежит данный VDisk
3. Проверяется, есть ли локи на ноде, которой принадлежит данный VDisk
4. Проверяются состояния остальных VDisk-ов в группе данного VDisk-а (смотрим количество недоступных и залоченных VDisk-ов). Полученные данные сопоставляются с используемой политикой доступности кластера

**PDisk**
1. Проверяется, можно ли залочить все VDisk-и данного PDisk-а

**Нода**
1. Проверяется, не нарушит ли лок данной ноды используемые тенантные или кластерные лимиты
2. Проверяется, можно ли залочить все VDisk-и данной ноды

Если проверки прошли успешно, то на проверяемый объект навешивается [TTemporaryLock](https://a.yandex-team.ru/search?search=struct%20TTemporaryLock,cluster_info.h,,arcadia,,200) и переходим к следующему действию. Временные локи позволяют понять, конфликтуют ли запрошенные в одном запросе действия между собой. После завершения анализа запроса все временные локи удаляются

## Автоматическая реконфигурация групп
Регулярно собирая информацию о состоянии кластера и имея информацию о планируемых работах в кластере, CMS может принимать решение о том, что какой-то диск не доступен (или будет не доступен) очень долгое время и стоит реконфигурировать группы таким образом, чтобы этот диск не использовался

Для этого в [TLockableItem](https://a.yandex-team.ru/search?search=class%20TLockableItem%20,,,arcadia,,200) предусмотрена возможность хранить интервал недоступности [TDowntime](https://a.yandex-team.ru/arc/trunk/arcadia/kikimr/core/cms/downtime.h) и актор-монитор. При получении обновлений сосотяния кластера у всех объектов обновляются их интервалы недоступности (котрые при этом сохраняются в локальную базу CMS). Если к объектам приписан актор-монитор, то после такого обновления ему будет отправлена соотвествующая нотификация. При обработке этой нотификации актор-монитор должен проверить, нужно ли предпринять какое-либо действие

Сейчас реализован только [TPDiskMonitor](https://a.yandex-team.ru/arc/trunk/arcadia/kikimr/core/cms/monitor_pdisk.cpp), который следит за состоянием PDisk-а. В случае, если диск слишком долго не доступен или запланирована такая недоступность на будущее, то монитор может пометить диск в BSController как сломанный, провоцируя таким образом реконфигурацию групп. Деятельность данного монитора управляется через конфиг [TMonitorConfig](https://a.yandex-team.ru/search?search=message%20TMonitorConfig,cms.proto,,arcadia,,200), который является частью конфига CMS

На данный момент [TPDiskMonitor](https://a.yandex-team.ru/arc/trunk/arcadia/kikimr/core/cms/monitor_pdisk.cpp) обладает слишком простой логикой и не застрахован от случаев массовой пометки дисков как не рабочих, например, при отключении ДЦ. Поэтому автоматическая реконфигурация групп пока что не используется ни на одном из кластеров

### Отключение дисков в ручном режиме
CMS предоставляет интерфейс пометки объектов кластера (нод, PDsik-ов и VDisk-ов) специальными метками. Запрос на установку меток описывается сообщением [TSetMarkerRequest](https://a.yandex-team.ru/search?search=message%20TSetMarkerRequest,cms.proto,,arcadia,,200)

    message TSetMarkerRequest {
        optional EMarker Marker = 1;
        optional TItems Items = 2;
        optional string UserToken = 10;
    }

Данная функциональность может быть использована для ручного управления статусом PDisk-ов дисков. Для этого используются следующие маркеры:
* **MARKER_DISK_BROKEN** - пометить диск как сломанный (срочно перевезти с него все группы), соотвествует статусу NKikimrBlobStorage::BROKEN
* **MARKER_DISK_FAULTY** - пометить диск как некачественный (при возможности перевезти с него диски), соотвествует статусу NKikimrBlobStorage::FAULTY
* **MARKER_DISK_INACTIVE** - пометить диск как неактивный (не аллоцировать на него новые группы), соотвествует статусу NKikimrBlobStorage::INACTIVE
* **MARKER_DISK_ACTIVE** - пометить диск как активный, соотвествует статусу NKikimrBlobStorage::ACTIVE

Этими маркерами можно пометить как PDisk-и, так и ноды (эквивалентно пометке всех PDisk-ов ноды). [TPDiskMonitor](https://a.yandex-team.ru/arc/trunk/arcadia/kikimr/core/cms/monitor_pdisk.cpp) проверяет данные маркеры и выставляет необходимое состояние диска в BSController

## Логирование событий в CMS
При выдаче CMS полномочий совершать такие важные действия, как изменения статуса диска, важно понимать, какие события в кластере привели к тому или иному действию CMS. Для возможности такого анализа в CMS в локальной базе есть таблица, которая хранит лог важных событий в кластере. Записи лога описываются protobuf сообщением [TLogRecord](https://a.yandex-team.ru/search?search=message%20TLogRecord%20,cms.proto,,arcadia,,200) и хранят информацию о произошедшем событии и его причинах (если применимо)

На данный момент логируется факт загрузки CMS, изменения маркеров и действия [TPDiskMonitor](https://a.yandex-team.ru/arc/trunk/arcadia/kikimr/core/cms/monitor_pdisk.cpp)

Посмотреть лог можно в CMS WEB UI (<ydb-http-url>/cms#page=cms-log)