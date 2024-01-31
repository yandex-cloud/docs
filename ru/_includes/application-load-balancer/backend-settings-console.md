* **{{ ui-key.yacloud.common.name }}** бэкенда.
* **{{ ui-key.yacloud.alb.label_backend-weight }}** — относительный вес бэкенда при распределении трафика. Если опция в поле отключена, эндпоинты бэкенда не будут получать трафик (вес будет равен 0).
* **{{ ui-key.yacloud.common.type }}** бэкенда (для группы бэкендов типа `{{ ui-key.yacloud.alb.label_proto-http-plain }}`): `{{ ui-key.yacloud.alb.label_target-group }}` ([целевые группы](../../application-load-balancer/concepts/target-group.md) {{ alb-name }}) или `{{ ui-key.yacloud.alb.label_bucket }}` ([бакет](../../storage/concepts/bucket.md) {{ objstorage-name }}). Для группы бэкендов типа `{{ ui-key.yacloud.alb.label_proto-grpc }}` или Stream тип любого бэкенда — `{{ ui-key.yacloud.alb.label_target-group }}`. Подробнее о типах бэкендов см. в разделе [{#T}](../../application-load-balancer/concepts/backend-group.md#types).

* Следующие настройки доступны только для типа бэкенда **{{ ui-key.yacloud.alb.label_target-group }}**:

  * В блоке **{{ ui-key.yacloud.alb.label_lb-settings }}**:
    
    * **{{ ui-key.yacloud.alb.label_load-balancing-mode }}** — [режим распределения трафика](../../application-load-balancer/concepts/backend-group.md#balancing-mode) между эндпоинтами бэкенда.
    * **{{ ui-key.yacloud.alb.label_panic-threshold }}** — доля работоспособных эндпоинтов, при которой включится [режим паники](../../application-load-balancer/concepts/backend-group.md#panic-mode): балансировщик будет распределять запросы во все эндпоинты, не учитывая результаты проверок состояния.
    * **{{ ui-key.yacloud.alb.label_locality-aware-routing }}** — доля входящего трафика, которую узел балансировщика передает бэкендам из своей зоны доступности. Остальной трафик поровну делится между другими зонами. Подробнее см. в разделе [{#T}](../../application-load-balancer/concepts/backend-group.md#locality).
    * **{{ ui-key.yacloud.alb.label_strict-locality }}** — опция, при которой балансировщик будет отвечать ошибкой (`503 Service Unavailable`), если в зоне доступности, где был принят запрос, нет работающих бэкендов приложения.
 
  * В блоке **{{ ui-key.yacloud.alb.label_protocol-settings }}**:
    
    * Для группы бэкендов типа `{{ ui-key.yacloud.alb.label_proto-http }}`:
      
      * **{{ ui-key.yacloud.alb.label_use-http2 }}** — опция использования протокола HTTP/2 при отправке запросов к бэкенду для группы бэкендов типа `{{ ui-key.yacloud.alb.label_proto-http }}`. По умолчанию используется протокол версии 1.1. Группы бэкендов типа `{{ ui-key.yacloud.alb.label_proto-grpc }}` поддерживают только HTTP/2-соединения.
      * **{{ ui-key.yacloud.alb.label_protocol }}** — протокол соединений с бэкендом: `{{ ui-key.yacloud.alb.label_proto-http-plain }}` (без шифрования) или `{{ ui-key.yacloud.alb.label_proto-http-tls }}` (с TLS-шифрованием). Для протокола `{{ ui-key.yacloud.alb.label_proto-http-tls }}` укажите:
        
        * **{{ ui-key.yacloud.alb.label_sni }}**. Доменное имя хоста для Server Name Indication — расширения TLS.
        * **{{ ui-key.yacloud.alb.label_trusted-ca }}**. Укажите [корневой сертификат](https://en.wikipedia.org/wiki/Root_certificate) (Root CA) для цепочки сертификатов, установленной на эндпоинтах бэкендов. Поддерживаются сертификаты стандарта [X.509](https://ru.wikipedia.org/wiki/X.509) в формате [PEM](https://ru.wikipedia.org/wiki/Почта_с_повышенной_секретностью).
    
    * Для группы бэкендов типа `{{ ui-key.yacloud.alb.label_proto-grpc }}`:

      * **{{ ui-key.yacloud.alb.label_protocol }}** — протокол соединений с бэкендом: `{{ ui-key.yacloud.alb.label_proto-grpc-plain }}` или `{{ ui-key.yacloud.alb.label_proto-grpc-tls }}`. Для зашифрованного протокола укажите **{{ ui-key.yacloud.alb.label_sni }}** и **{{ ui-key.yacloud.alb.label_trusted-ca }}** (см. выше).
    
    * Для группы бэкендов типа `{{ ui-key.yacloud.alb.label_proto-stream }}`:
      
      * **{{ ui-key.yacloud.alb.label_enable-proxy-protocol }}** — опция, при которой балансировщик передает бэкенду метаданные своего соединения с клиентом, в том числе его IP-адрес, по [протоколу PROXY от HAProxy](https://www.haproxy.org/download/1.9/doc/proxy-protocol.txt).
        
      * **{{ ui-key.yacloud.alb.label_protocol }}** — протокол соединений с бэкендом: `{{ ui-key.yacloud.alb.label_proto-grpc-plain }}` или `{{ ui-key.yacloud.alb.label_proto-grpc-tls }}`. Для зашифрованного протокола укажите **{{ ui-key.yacloud.alb.label_sni }}** и **{{ ui-key.yacloud.alb.label_trusted-ca }}** (см. выше).

* Следующие настройки доступны только для типа бэкенда **{{ ui-key.yacloud.alb.label_bucket }}** для типа группы бэкендов **{{ ui-key.yacloud.alb.label_proto-http }}**:

  * **{{ ui-key.yacloud.mdb.forms.config_field_form-bucket-type }}** — выберите одну из опций: `{{ ui-key.yacloud.forms.label_form-list }}` или `{{ ui-key.yacloud.forms.label_form-id }}`.
  * **{{ ui-key.yacloud.alb.label_bucket }}** — выберите из списка или укажите идентификатор нужного бакета.

* В блоке **HTTP проверка состояния**, **gRPC проверка состояния** или **Stream проверка состояния**:
  
  * **{{ ui-key.yacloud.alb.label_timeout }}** — время ожидания ответа.
  * **{{ ui-key.yacloud.alb.label_interval }}** — интервал отправки проверочных запросов.
  * **{{ ui-key.yacloud.alb.label_healthy }}** — количество последовательных успешных проверок, после которых эндпоинт считается работоспособным. Игнорируется в начале работы балансировщика: достаточно одной проверки.
  * **{{ ui-key.yacloud.alb.label_unhealthy }}** — количество последовательных неуспешных проверок, после которых эндпоинт считается неработоспособным. Игнорируется, если бэкенд один раз ответил HTTP-кодом состояния `503 Service Unavailable`: он сразу считается неработоспособным.
  * **{{ ui-key.yacloud.alb.label_port }}**.
  * **{{ ui-key.yacloud.common.type }}** — протокол, по которому будет осуществляться проверка: `{{ ui-key.yacloud.alb.label_hc-type-http }}`, `{{ ui-key.yacloud.alb.label_hc-type-grpc }}` или `{{ ui-key.yacloud.alb.label_hc-type-stream }}`. Тип проверки может не совпадать с типом группы бэкендов. Дополнительно укажите:
    
    * Для типа `{{ ui-key.yacloud.alb.label_hc-type-http }}`:
      
      * **{{ ui-key.yacloud.alb.label_path }}** — путь в URI запроса к эндпоинту.
      * **{{ ui-key.yacloud.alb.label_hc_host }}** — значение заголовка `Host` для HTTP/1.1 или псевдо-заголовка `:authority` для HTTP/2, которое будет передаваться эндпоинтам бэкенда при проверках состояния.
      * **{{ ui-key.yacloud.alb.label_use-http2 }}** — опция использования протокола HTTP версии 2.
     
    * Для типа `{{ ui-key.yacloud.alb.label_hc-type-grpc }}`:
      
      * **{{ ui-key.yacloud.alb.label_service-name }}** — имя проверяемого gRPC-сервиса. Если сервис не указан, проверяется общее состояние бэкенда.
     
    * Для типа `{{ ui-key.yacloud.alb.label_hc-type-stream }}`:
      
      * **{{ ui-key.yacloud.alb.label_send }}** — данные, которые отправляются на эндпоинт для проверки состояния.
      * **{{ ui-key.yacloud.alb.label_receive }}** — данные, которые должны поступить с эндпоинта, чтобы он прошел проверку состояния.
      
  {% include [backend-healthcheck](backend-healthcheck.md) %}

  Чтобы добавить проверку состояния, внизу блока бэкенда нажмите кнопку **{{ ui-key.yacloud.alb.button_add-healthcheck }}** и задайте настройки проверки.

  Чтобы удалить проверку состояния, напротив заголовка **HTTP проверка состояния**, **gRPC проверка состояния** или **Stream проверка состояния** нажмите ![image](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.delete }}**.
