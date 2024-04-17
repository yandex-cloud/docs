
* `filter`: Structure describing how the trail processes events. It contains the `path_filter` and `event_filter` objects.
   * `path_filter`: Structure describing how the trail processes management (control plane) events. It may contain a single `root.some_filter` object or a single `root.any_filter` object. If the `path_filter` object is missing in the configuration, the trail will not process control plane events.

      {% include [path-filter-clispec-params](./path-filter-clispec-params.md) %}

   * `event_filter`: Structure describing how the trail processes data (data plane) events. If the `event_filter` object is missing in the configuration, the trail will not process data plane events.
      * `filters.service`: ID of the [service](../../audit-trails/concepts/control-plane-vs-data-plane.md#data-plane-events) whose events the trail will process. A single `filters.service` section is used to configure data plane audit log processing for a single {{ yandex-cloud }} service. To configure the trail processing of data plane events for multiple services, specify the `filters.service` parameter in the configuration as many times as you need.
         The possible values include:
         * `dns`
         * `kms`
         * `lockbox`
         * `mdb.mongodb`
         * `mdb.mysql`
         * `mdb.postgresql`
         * `storage`

      * `filters.categories`: Structure describing the type of events to collect.
         * `plane`: Event plane. For data plane events, specify `DATA_PLANE`.
         * `type`: Type of resource event action. The possible values are `READ` and `WRITE`.

      * `filters.path_filter`: Structure describing how the trail processes data (data plane) events. It may contain a single `root.some_filter` object or a single `root.any_filter` object.

         {% include [path-filter-clispec-params](./path-filter-clispec-params.md) %}