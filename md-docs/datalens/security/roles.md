[Документация Yandex Cloud](../../index.md) > [Yandex DataLens](../index.md) > [Управление доступом](index.md) > Роли в DataLens

# Роли в Yandex DataLens


Роли в DataLens бывают двух типов:

* Для доступа к сервису — назначаются на [организацию](../concepts/organizations.md) и предоставляют доступ к сервису DataLens.
* На [воркбуки и коллекции](../workbooks-collections/index.md) — определяют уровень доступа непосредственно к каждому воркбуку или коллекции. Эти роли действуют для пользователей, которые [перешли на воркбуки и коллекции](../workbooks-collections/index.md#enable-workbooks) для хранения своих объектов в DataLens.

## Роли для доступа к сервису {#service-roles}

Чтобы предоставить пользователю доступ к DataLens, [назначьте](../../organization/security/index.md#add-role) ему одну из ролей. Роли можно назначить аккаунту на Яндексе, [сервисному аккаунту](../../iam/concepts/users/service-accounts.md), [федеративным](../../iam/concepts/users/accounts.md#saml-federation) или [локальным](../../iam/concepts/users/accounts.md#local) пользователям, [группе пользователей](../../organization/operations/manage-groups.md), [системной группе](../../iam/concepts/access-control/system-group.md) или [публичной группе](../../iam/concepts/access-control/public-group.md).

{% list tabs group=datalens_roles %}

- После перехода на воркбуки и коллекции {#after-workbooks-collections}

  #### datalens.visitor {#datalens-visitor}

  Роль `datalens.visitor` предоставляет доступ к сервису DataLens. Просмотр или редактирование [воркбуков и коллекций](../workbooks-collections/index.md) возможны при наличии соответствующих [ролей](#workbooks-collections-roles) для доступа к этим воркбукам и коллекциям.

  #### datalens.creator {#datalens-creator}

  Роль `datalens.creator` предоставляет доступ к сервису DataLens с правами на создание [воркбуков и коллекций](../workbooks-collections/index.md) в корне DataLens. Просмотр или редактирование воркбуков и коллекций, созданных другими пользователями, возможны только при наличии [прав доступа](#workbooks-collections-roles) к этим воркбукам и коллекциям.
  
  Включает разрешения, предоставляемые ролью `datalens.visitor`.

  #### datalens.admin {#datalens-admin}

  Роль `datalens.admin` предоставляет полный доступ к сервису DataLens и всем [воркбукам и коллекциям](../workbooks-collections/index.md) в нем.
  
  Включает разрешения, предоставляемые ролями `datalens.creator` и `datalens.metaReader`.

- До перехода на воркбуки и коллекции {#before-workbooks-collections}

  #### datalens.instances.user {#datalens-instances-user}

  Роль `datalens.instances.user` предоставляет доступ к сервису DataLens в качестве пользователя с правами на создание, чтение и изменение [объектов](../concepts/index.md#component-interrelation) согласно правам доступа к ним, а также позволяет просматривать информацию о [каталогах](../../resource-manager/concepts/resources-hierarchy.md#folder).
  
  После назначения сервисной роли вы можете [назначить](../operations/permission/grant.md) пользователю права доступа к объектам и папкам в сервисе DataLens.
  
  {% note tip %}
  
  Рекомендуем использовать роль `datalens.creator` вместо `datalens.instances.user`. При аналогичном наборе разрешений она более безопасна, так как предоставляет доступ только к экземпляру DataLens и не дает прав на просмотр всех каталогов в организации.
  
  {% endnote %}

  #### datalens.instances.admin {#datalens-instances-admin}

  Роль `datalens.instances.admin` предоставляет доступ к сервису DataLens в качестве администратора экземпляра DataLens. Администратор получает полные права на все [объекты](../concepts/index.md#component-interrelation) и папки в сервисе DataLens, доступ к настройкам DataLens, а также может просматривать информацию о [каталогах](../../resource-manager/concepts/resources-hierarchy.md#folder).
  
  Включает разрешения, предоставляемые ролью `datalens.instances.user`.
  
  {% note tip %}
  
  Рекомендуем использовать роль `datalens.admin` вместо `datalens.instances.admin`. При аналогичном наборе разрешений она более безопасна, так как предоставляет доступ только к экземпляру DataLens и не дает прав на просмотр всех каталогов в организации.
  
  {% endnote %}

{% endlist %}

## Роли для работы с API {#api-roles}

#### datalens.metaReader {#datalens-metaReader}

Роль `datalens.metaReader` позволяет выполнять запросы в [DataLens Public API](../operations/api-start.md) из раздела [Audit](https://api.datalens.tech/#/Audit), а также запросы для получения сущностей DataLens.

Доступно получение следующих сущностей:

* подключение — [метод](https://api.datalens.tech/#/Connection/post_rpc_getConnection) `getConnection`;
* датасет — [метод](https://api.datalens.tech/#/Dataset/post_rpc_getDataset) `getDataset`;
* чарт в Wizard — [метод](https://api.datalens.tech/#/Wizard/post_rpc_getWizardChart) `getWizardChart`;
* чарт в Editor — [метод](https://api.datalens.tech/#/Editor/post_rpc_getEditorChart) `getEditorChart`;
* QL-чарт — [метод](https://api.datalens.tech/#/QL/post_rpc_getQLChart) `getQLChart`;
* дашборд — [метод](https://api.datalens.tech/#/Dashboard/post_rpc_getDashboard) `getDashboard`;
* отчет — [метод](https://api.datalens.tech/#/Reports/post_rpc_getReport) `getReport`.

{% note warning %}

Получение сущностей работает, только если в запросе передан заголовок `x-dl-audit-mode` со значением `true`.

{% endnote %}

## Роли на воркбуки, коллекции и общие объекты {#workbooks-collections-roles}

Эти роли действуют для пользователей, которые перешли на новый подход к организации объектов DataLens — в [воркбуках и коллекциях](../workbooks-collections/index.md). Роли позволяют определить уровень доступа для пользователя или группы пользователей к каждому воркбуку, коллекции или общему объекту.

### Роли на воркбуки {#workbook-roles}

Вы можете [назначить](../workbooks-collections/workbooks-operations.md#wb-coll-grant) пользователю роли на воркбуки.

#### datalens.workbooks.limitedViewer {#datalens-workbooks-limitedViewer}

Роль `datalens.workbooks.limitedViewer` назначается на [воркбук](../workbooks-collections/index.md) и позволяет просматривать вложенные в него [чарты](../concepts/chart/index.md), [дашборды](../concepts/dashboard.md) и [отчеты](../reports/index.md), а также информацию о назначенных [правах доступа](../../iam/concepts/access-control/index.md) к нему. В интерфейсе DataLens эта роль называется `Ограниченный просмотр`. Рекомендуем выдавать эту роль только через интерфейс DataLens.

#### datalens.workbooks.viewer {#datalens-workbooks-viewer}

Роль `datalens.workbooks.viewer` назначается на [воркбук](../workbooks-collections/index.md) и позволяет просматривать все вложенные в него [объекты](../concepts/index.md#component-interrelation), а также информацию о назначенных [правах доступа](../../iam/concepts/access-control/index.md) к нему. В интерфейсе DataLens эта роль называется `Просмотр`. Рекомендуем выдавать эту роль только через интерфейс DataLens.

Включает разрешения, предоставляемые ролью `datalens.workbooks.limitedViewer`.

#### datalens.workbooks.editor {#datalens-workbooks-editor}

Роль `datalens.workbooks.editor` назначается на воркбук и позволяет редактировать его и все вложенные в него объекты. В интерфейсе DataLens эта роль называется `Редактирование`. Рекомендуем выдавать эту роль только через интерфейс DataLens.

Пользователи с этой ролью могут:
* редактировать [воркбук](../workbooks-collections/index.md) и создавать его копии;
* просматривать все вложенные в воркбук [объекты](../concepts/index.md#component-interrelation) и редактировать их;
* просматривать информацию о назначенных [правах доступа](../../iam/concepts/access-control/index.md) к воркбуку.

Включает разрешения, предоставляемые ролью `datalens.workbooks.viewer`.

#### datalens.workbooks.admin {#datalens-workbooks-admin}

Роль `datalens.workbooks.admin` назначается на воркбук и позволяет управлять им, доступом к нему и всеми вложенными в него объектами. В интерфейсе DataLens эта роль называется `Администрирование`. Рекомендуем выдавать эту роль только через интерфейс DataLens.

Пользователи с этой ролью могут:
* просматривать информацию о назначенных [правах доступа](../../iam/concepts/access-control/index.md) к [воркбуку](../workbooks-collections/index.md) и изменять такие права доступа;
* редактировать, перемещать воркбук, создавать копии и удалять его;
* просматривать все вложенные в воркбук [объекты](../concepts/index.md#component-interrelation) и редактировать их;
* [встраивать](private-embedded-objects.md) вложенные в воркбук непубличные объекты на сайты и в приложения;
* [публиковать](../concepts/datalens-public.md#how-to-publish) вложенные в воркбук объекты.

Включает разрешения, предоставляемые ролью `datalens.workbooks.editor`.

{% note info %}

При создании воркбука автору автоматически назначается роль `datalens.workbooks.admin` (`Администрирование`) на этот воркбук.

{% endnote %}

### Роли на коллекции {#collection-roles}

Вы можете [назначить](../workbooks-collections/collections-operations.md#wb-coll-grant) пользователю роли на коллекцию.

#### datalens.collections.visitor {#datalens-collections-visitor}

Роль `datalens.collections.visitor` назначается на коллекцию и позволяет просматривать информацию о текущей коллекции без доступа ко вложенным в нее объектам. В интерфейсе DataLens эта роль называется `Посещение коллекции`. Рекомендуем выдавать эту роль только через интерфейс DataLens.

#### datalens.collections.limitedViewer {#datalens-collections-limitedViewer}

Роль `datalens.collections.limitedViewer` назначается на коллекцию и позволяет просматривать информацию о ней и вложенных в нее коллекциях и воркбуках, в том числе просматривать чарты, дашборды и отчеты вложенных воркбуков. В интерфейсе DataLens эта роль называется `Ограниченный просмотр`. Рекомендуем выдавать эту роль только через интерфейс DataLens.

Пользователи с этой ролью могут:
* просматривать информацию о текущей коллекции и вложенных в нее [воркбуках и коллекциях](../workbooks-collections/index.md);
* просматривать информацию о назначенных [правах доступа](../../iam/concepts/access-control/index.md) к текущей коллекции, а также к вложенным в нее коллекциям и воркбукам;
* просматривать [чарты](../concepts/chart/index.md), [дашборды](../concepts/dashboard.md) и [отчеты](../reports/index.md), вложенные в воркбуки, которые относятся к текущей и вложенным коллекциям.

Включает разрешения, предоставляемые ролью `datalens.workbooks.limitedViewer`.

#### datalens.collections.viewer {#datalens-collections-viewer}

Роль `datalens.collections.viewer` назначается на коллекцию и позволяет просматривать информацию о ней и вложенных в нее коллекциях и воркбуках, а также просматривать все объекты вложенных воркбуков. В интерфейсе DataLens эта роль называется `Просмотр`. Рекомендуем выдавать эту роль только через интерфейс DataLens.

Пользователи с этой ролью могут:
* просматривать информацию о текущей коллекции и вложенных в нее [воркбуках и коллекциях](../workbooks-collections/index.md);
* просматривать информацию о назначенных [правах доступа](../../iam/concepts/access-control/index.md) к текущей коллекции, а также к вложенным в нее коллекциям и воркбукам;
* просматривать все [объекты](../concepts/index.md#component-interrelation), вложенные в воркбуки, которые относятся к текущей и вложенным коллекциям.

Включает разрешения, предоставляемые ролями `datalens.collections.limitedViewer` и `datalens.workbooks.viewer`.

#### datalens.collections.limitedEntryBindingCreator {#datalens-collections-limitedEntryBindingCreator}

Роль `datalens.collections.limitedEntryBindingCreator` назначается на коллекцию и позволяет переиспользовать общие объекты из этой коллекции без делегации прав доступа. В интерфейсе DataLens эта роль называется `Привязки без делегаций`. Рекомендуем выдавать эту роль только через интерфейс DataLens.

Включает разрешения, предоставляемые ролью `datalens.sharedEntries.limitedEntryBindingCreator`.

#### datalens.collections.entryBindingCreator {#datalens-collections-entryBindingCreator}

Роль `datalens.collections.entryBindingCreator` назначается на коллекцию и позволяет переиспользовать общие объекты из этой коллекции как без делегации прав доступа, так и с делегацией. В интерфейсе DataLens эта роль называется `Привязки с делегацией`. Рекомендуем выдавать эту роль только через интерфейс DataLens.

Включает разрешения, предоставляемые ролью `datalens.sharedEntries.entryBindingCreator`.

#### datalens.collections.creator {#datalens-collections-creator}

Роль `datalens.collections.creator` назначается на коллекцию и позволяет просматривать коллекцию, а также создавать объекты внутри нее без доступа к другим объектам, существующим внутри коллекции. В интерфейсе DataLens эта роль называется `Создание в коллекции`. Рекомендуем выдавать эту роль только через интерфейс DataLens.

Включает разрешения, предоставляемые ролью `datalens.collections.visitor`.

#### datalens.collections.editor {#datalens-collections-editor}

Роль `datalens.collections.editor` назначается на коллекцию и позволяет редактировать ее и все вложенные в нее коллекции, воркбуки, а также все объекты в таких воркбуках. В интерфейсе DataLens эта роль называется `Редактирование`. Рекомендуем выдавать эту роль только через интерфейс DataLens.

Пользователи с этой ролью могут:
* просматривать информацию о текущей коллекции и вложенных в нее [коллекциях и воркбуках](../workbooks-collections/index.md);
* редактировать текущую коллекцию и все вложенные в нее коллекции и воркбуки;
* создавать копии воркбуков, вложенных в текущую коллекцию;
* создавать новые коллекции и воркбуки внутри текущей и всех вложенных коллекций;
* просматривать и редактировать все [объекты](../concepts/index.md#component-interrelation), вложенные в воркбуки, которые относятся к текущей и вложенным коллекциям;
* просматривать информацию о назначенных [правах доступа](../../iam/concepts/access-control/index.md) к текущей коллекции, а также к вложенным в нее коллекциям и воркбукам.

Включает разрешения, предоставляемые ролями `datalens.collections.viewer` и `datalens.workbooks.editor`.

#### datalens.collections.admin {#datalens-collections-admin}

Роль `datalens.collections.admin` назначается на коллекцию и позволяет управлять ей, доступом к ней, а также всеми вложенными в нее коллекциями, воркбуками и объектами в таких воркбуках. В интерфейсе DataLens эта роль называется `Администрирование`. Рекомендуем выдавать эту роль только через интерфейс DataLens.

Пользователи с этой ролью могут:
* просматривать информацию о назначенных [правах доступа](../../iam/concepts/access-control/index.md) к текущей коллекции, к вложенным в нее [коллекциям и воркбукам](../workbooks-collections/index.md), а также изменять такие права доступа;
* просматривать информацию о текущей коллекции и вложенных в нее коллекциях и воркбуках;
* редактировать текущую коллекцию и все вложенные в нее коллекции и воркбуки;
* создавать копии воркбуков, вложенных в текущую коллекцию;
* перемещать и удалять текущую коллекцию и все вложенные в нее коллекции и воркбуки;
* создавать новые коллекции и воркбуки внутри текущей коллекции;
* просматривать и редактировать все [объекты](../concepts/index.md#component-interrelation), вложенные в воркбуки, которые относятся к текущей и вложенным коллекциям;
* [встраивать](private-embedded-objects.md) на сайты и в приложения непубличные объекты, вложенные в воркбуки, которые относятся к текущей и вложенным коллекциям;
* [публиковать](../concepts/datalens-public.md#how-to-publish) объекты, вложенные в воркбуки, которые относятся к текущей и вложенным коллекциям.

Включает разрешения, предоставляемые ролями `datalens.collections.editor` и `datalens.workbooks.admin`.

Включает разрешения, предоставляемые ролями `datalens.collections.editor` и `datalens.workbooks.admin`.

{% note info %}

Роль, выданная на коллекцию, распространяется на все коллекции и воркбуки внутри нее. При создании коллекции автору автоматически назначается роль `datalens.collections.admin` (`Администрирование`) на эту коллекцию.

{% endnote %}

### Роли на общие объекты {#shared-entry-roles}

#### datalens.sharedEntries.limitedViewer {#datalens-sharedEntries-limitedViewer}

Роль `datalens.sharedEntries.limitedViewer` назначается на общий объект и позволяет просматривать [чарты](../concepts/chart/index.md) и [дашборды](../concepts/dashboard.md), которые используют его, без прямого доступа к самому общему объекту. В интерфейсе DataLens эта роль называется `Ограниченный просмотр`. Рекомендуем выдавать эту роль только через интерфейс DataLens.

#### datalens.sharedEntries.viewer {#datalens-sharedEntries-viewer}

Роль `datalens.sharedEntries.viewer` назначается на общий объект и позволяет просматривать его, а также назначенные права доступа к нему. В интерфейсе DataLens эта роль называется `Просмотр`. Рекомендуем выдавать эту роль только через интерфейс DataLens.

Включает разрешения, предоставляемые ролью `datalens.sharedEntries.limitedViewer`.

#### datalens.sharedEntries.limitedEntryBindingCreator {#datalens-sharedEntries-limitedEntryBindingCreator}

Роль `datalens.sharedEntries.limitedEntryBindingCreator` назначается на общий объект и позволяет переиспользовать его в воркбуках без делегации прав доступа. В интерфейсе DataLens эта роль называется `Привязки без делегаций`. Рекомендуем выдавать эту роль только через интерфейс DataLens.

#### datalens.sharedEntries.entryBindingCreator {#datalens-sharedEntries-entryBindingCreator}

Роль `datalens.sharedEntries.entryBindingCreator` назначается на общий объект и позволяет переиспользовать его в воркбуках как без делегации прав доступа, так и с делегацией. В интерфейсе DataLens эта роль называется `Привязки с делегацией`. Рекомендуем выдавать эту роль только через интерфейс DataLens.

Включает разрешения, предоставляемые ролью `datalens.sharedEntries.limitedEntryBindingCreator`.

#### datalens.sharedEntries.editor {#datalens-sharedEntries-editor}

Роль `datalens.sharedEntries.editor` назначается на общий объект и позволяет редактировать этот объект, а также просматривать его и назначенные права доступа к нему. В интерфейсе DataLens эта роль называется `Редактирование`. Рекомендуем выдавать эту роль только через интерфейс DataLens.

Включает разрешения, предоставляемые ролью `datalens.sharedEntries.viewer`.

#### datalens.sharedEntries.admin {#datalens-sharedEntries-admin}

Роль `datalens.sharedEntries.admin` назначается на общий объект и позволяет просматривать его и полностью управлять им: редактировать, перемещать, удалять и настраивать права доступа к нему. В интерфейсе DataLens эта роль называется `Администрирование`. Рекомендуем выдавать эту роль только через интерфейс DataLens.

Включает разрешения, предоставляемые ролями `datalens.sharedEntries.editor` и `datalens.sharedEntries.entryBindingCreator`.