* `--opensearch-node-group` — конфигурация группы хостов `{{ OS }}`, где:

   * `resource-preset-id` — класс хостов. Он определяет технические характеристики виртуальных машин, на которых будут развернуты узлы {{ OS }}. Все доступные варианты перечислены в разделе [Классы хостов](../../managed-opensearch/concepts/instance-types.md).
   * `disk-size` — размер диска в байтах. Минимальное и максимальное значения зависят от выбранного класса хостов.
   * `disk-type-id` — [тип диска](../../managed-opensearch/concepts/storage.md).
   * `zone-ids` — [зоны доступности](../../overview/concepts/geo-scope.md). Несколько зон указываются через запятую и в квадратных скобках. Например:

      ```bash
      zone-ids=[ru-central1-a,ru-central1-b,ru-central1-d]
      ```

   * `subnet-names` — имена подсетей в указанных зонах доступности. Несколько подсетей указываются через запятую и в квадратных скобках. Например:

      ```bash
      subnet-names=[default-ru-central1-a,default-ru-central1-b,default-ru-central1-d]
      ```

      Вместо параметра `subnet-names` можно указать параметр `subnet-ids` с идентификаторами подсетей. Несколько идентификаторов указываются через запятую и в квадратных скобках. Например:

      ```bash
      subnet-ids=[e9bp8qmchqh2********,e2l963gkhobo********,fl8klaabecc3********]
      ```

   * `roles` — [роли хостов](../../managed-opensearch/concepts/host-roles.md). Возможные значения:

      * `data` — предоставляется только роль `DATA`;
      * `manager` — предоставляется только роль `MANAGER`;
      * `data+manager` или `manager+data` — предоставляются обе роли.

      {% note tip %}

      Не рекомендуется включать публичный доступ для хостов с ролью `MANAGER` — это небезопасно.

      {% endnote %}

* `--dashboards-node-group` — конфигурация группы хостов `Dashboards`. Настраивается так же, как группа хостов `{{ OS }}`, за исключением ролей хостов. Для группы `Dashboards` роли настраивать не нужно.
