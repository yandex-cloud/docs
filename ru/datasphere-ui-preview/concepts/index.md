# О сервисе {{ ml-platform-name }}

{{ ml-platform-full-name }} — среда для ML-разработки полного цикла, которая сочетает в себе привычные IDE, технологию бессерверных вычислений и возможность бесшовного использования разных конфигураций вычислительных ресурсов {{ yandex-cloud }}. {{ ml-platform-full-name }} является частью платформы данных и предоставляет широкие возможности для простого взаимодействия с сервисами {{ yandex-cloud }}.

{{ ml-platform-name }} помогает значительно сократить стоимость машинного обучения по сравнению с выполнением вычислений на собственном оборудовании или на других облачных платформах за счет автоматического обслуживания вычислительных ресурсов.

В {{ ml-platform-name }} вы можете не только проводить вычисления и обучать модели, но и запускать обученные модели в эксплуатацию.

## Преимущества сервиса {#advantages}

### Среда разработки, готовая к использованию {#ready-to-use}

Вам не нужно тратить время на создание и обслуживание виртуальных машин — при создании нового [проекта](project.md) автоматически выделяются вычислительные ресурсы для решения ваших задач.

На виртуальной машине уже установлена среда разработки JupyterLab и пакеты для анализа данных и машинного обучения (TensorFlow, Keras, NumPy и другие) — вы можете сразу начать их использовать. Полный список [предустановленных пакетов](preinstalled-packages.md).

Если какого-то пакета вам не хватает, вы можете [установить его](../operations/projects/install-dependencies.md) прямо из ноутбука.

### Автоматическое обслуживание вычислительных ресурсов {#auto-service}

Сервис автоматически управляет выделением ресурсов. Если вы не будете производить вычисления, сервис не будет выделять ресурсы. 

### Сохранение состояния при завершении работы {#save-state}

Вам не нужно все время держать открытой вкладку с ноутбуком: запущенные вычисления продолжатся, даже если вы закроете проект, а [состояние интерпретатора](save-state.md), все переменные и результаты вычислений сохранятся. Вы сможете продолжить работу, когда снова откроете проект.

### Гибкий выбор вычислительных ресурсов {#configurations}

Выбирайте необходимые вычислительные ресурсы под конкретные части кода. При [изменении конфигурации](configurations.md) все переменные и состояние интерпретатора будут перенесены на новую виртуальную машину.

## Что нового в новом интерфейсе {{ ml-platform-name }} {#what-is-new}

### Организации и иерархия ресурсов {#organization}

{{ ml-platform-name }} больше не ограничивается одним облаком, а позволяет работать в едином пространстве всем участникам организации под управлением сервиса [{{org-full-name}}]({{ link-org-main }}). Создаваемые ресурсы зависят от проектов, но не ограничены только ими. Подробнее о взаимосвязи ресурсов {{ ml-platform-name }} см. в разделе [{#T}](resource-model.md).

### Совместная работа и управление расходами {#communities}

Для совместной работы над проектами и гибким управлением расходами в {{ ml-platform-name }} появились [сообщества](community.md). К каждому сообществу можно привязать отдельный [платежный аккаунт {{ yandex-cloud }}](../../billing/concepts/billing-account.md), чтобы разделить финансы команд. При этом сообщества не изолируют команды друг от друга и позволяют делиться проектами и созданными ресурсами. 

Управление доступами и видимостью ресурсов осуществляется с помощью новых ролей. Подробнее о ролях см. [{#T}](../security/index.md).

### Новые типы ресурсов {#resources}

Данные для подключения к любому объектному хранилищу больше не нужно каждый раз вводить заново. Для хранения всех сведений появился ресурс **Подключение S3**, который позволяет [подключать и отключать](../operations/data/connect-to-s3.md) бакет прямо в интерфейсе {{ ml-platform-name }}.

[Контрольные точки](secrets.md), хранящие состояние интерпретатора и значения переменных, также стали новым типом ресурсов. Вы можете использовать их для создания нод и [делиться ими](../operations/projects/checkpoints.md#share) в сообществах и по прямой ссылке.

### Бесшовная эксплуатация работающих сервисов {#deployment}

Новые ресурсы значительно расширили инструменты для развертывания и [эксплуатации сервисов](deploy/index.md). 

Алиасы позволяют балансировать нагрузку между несколькими работающими нодами, и публиковать новые версии без необходимости останавливать работающий сервис. [Создать алиас](../operations/deploy/alias-create.md) можно в интерфейсе {{ ml-platform-name }}.

Ноды теперь можно [создавать](../operations/deploy/node-create.md) не только из ячеек с кодом на Python, но и из готовых Docker-образов, собранных вне {{ ml-platform-name }}. На странице нод в интерфейсе {{ ml-platform-name }} можно следить за графиками мониторингов и логами работы развернутых инстансов. Там же можно изменить конфигурацию вычислительных ресурсов и отправить тестовые запросы к API развернутого сервиса.

[Список инструкции](../operations/index.md#deploy) для работы с нодами и алисами.