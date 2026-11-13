### 1. Что делать, если уже используется собственная инсталляция Kyverno? {#own-kyverno}

Одним из компонентов модуля [{{ kspm-name }}](../../security-deck/concepts/kspm.md) является [Kyverno](https://kyverno.io/). Если в кластере уже используется собственная инсталляция Kyverno, выберите один из вариантов:

* При [создании](../../security-deck/operations/workspaces/create.md) или [изменении](../../security-deck/operations/workspaces/update.md) окружения в настройках не включайте правила ![cspm-standard-k8s-restricted](../../_assets/security-deck/cspm-standard-k8s-restricted.svg) {{ k8s }} Pod Security Standards (Restricted) и ![cspm-standard-k8s-baseline](../../_assets/security-deck/cspm-standard-k8s-baseline.svg) {{ k8s }} Pod Security Standards (Baseline) и продолжайте использовать собственный Kyverno.
* Перейдите с собственного Kyverno на {{ kspm-name }}.
  
  Чтобы выполнить переход:
  
  1. Создайте резервную копию ваших политик.
  1. [Удалите](../../managed-kubernetes/operations/applications/kyverno.md#uninstall) Kyverno.
  1. [Активируйте](../../security-deck/operations/kspm/enable-kspm.md) модуль {{ kspm-name }}.
  1. Добавьте политики в {{ kspm-name }} одним из способов или комбинируйте их:
     
     * [Создайте](../../security-deck/operations/kspm/create-custom-rule.md) пользовательские правила типа Admission на основе ваших политик и [управляйте](../../security-deck/operations/kspm/manage-rule-modes.md) ими через {{ kspm-name }}. В пользовательских правилах доступны только [политики валидации](*validation-policy).

       {% note info %}
       
       В интерфейсе {{ sd-name }} не поддерживается автоматический импорт политик Kyverno. Необходимо вручную переформулировать их логику в пользовательские правила {{ kspm-name }} перед добавлением.

       {% endnote %}

     * Разверните собственные политики через {{ k8s }} API. Поддерживаются любые типы политик. Подробнее в руководстве [Использование внешних политик Kyverno с {{ kspm-name }}](../../security-deck/tutorials/kspm-external-kyverno-policies.md).

### 2. Какие типы политик доступны в пользовательских правилах {{ kspm-name }}? {#custom-policy-types}

В [пользовательских правилах](../../security-deck/concepts/custom-rules.md#kspm-rules) {{ kspm-name }} доступны только [политики валидации](*validation-policy). Другие типы, например [политики мутации](*mutation-policy), [генерации](*generate-policy) или [проверки образов](*verify-images) не поддерживаются.

Подробнее о механизмах валидации и мутации — в [официальной документации Kubernetes](https://kubernetes.io/docs/reference/access-authn-authz/extensible-admission-controllers/).

### 3. Можно ли использовать не все компоненты {{ kspm-name }} одновременно? {#partial-components}

Да. Например, чтобы использовать только Runtime Sensor, [включите](../../security-deck/operations/workspaces/update.md) проверки по набору правил [Microsoft Threat Matrix для Kubernetes](../../security-deck/concepts/kspm.md) в настройках окружения.

### 4. Как работает тарификация в случае с прерываемыми рабочими узлами в {{ k8s }}? {#preemptible-billing}

Тарификация рассчитывается суммарно по модели «рабочий узел в месяц» (или «рабочий узел в час»). Один рабочий узел в месяц может представлять собой:

* один рабочий узел, который работает весь месяц;
* два рабочих узла, каждый из которых работает по половине месяца.

Привязки к конкретным рабочим узлам нет. Остановленные рабочие узлы не тарифицируются.

Подробнее о правилах тарификации в разделе [{#T}](../../security-deck/pricing.md).

### 5. Можно ли исключить из проверки {{ kspm-name }} определенные ресурсы или кластеры? {#exceptions}

Да. В {{ kspm-name }} есть [механизм исключений](../../security-deck/operations/kspm/manage-exceptions.md), который позволяет исключить из проверки выбранные ресурсы {{ k8s }} или целые кластеры.

### 6. Требует ли {{ kspm-name }} больше ресурсов для установки, чем другие модули {{ sd-name }}? {#resource-demand}

Да. Из всех модулей {{ sd-name }} только {{ kspm-name }} требует ресурсы внутри рабочих нагрузок. Остальные модули ограничиваются дополнительными правами для коннектора.

Подробнее в разделе [{#T}](../../security-deck/operations/kspm/requirements.md).

### 7. Какая нагрузка на ресурсы кластера и какие агенты устанавливает {{ kspm-name }}? {#resource-load}

Системные и технические требования к кластерам, рекомендации по ресурсам, а также информация об устанавливаемых агентах и условиях их установки приведены в разделе [{#T}](../../security-deck/operations/kspm/requirements.md).

Планирование ресурсов кластера входит в зону ответственности владельца кластера. Подробнее в разделе [{#T}](../../security-deck/operations/kspm/requirements.md#resource-planning).