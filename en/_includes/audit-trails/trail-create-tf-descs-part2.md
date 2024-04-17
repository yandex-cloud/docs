
* `filter`: Structure describing how the trail processes events. It contains the `path_filter` and `event_filters` objects.
   * `path_filter`: Structure describing how the trail processes management (control plane) events. It may contain a single `some_filter` object or a single `any_filter` object. If the `path_filter` object is missing in the configuration, the trail will not process control plane events.

      {% include [path-filter-tf-params](./path-filter-tf-params.md) %}

   * `event_filters`: Structure describing how the trail processes data (data plane) evens. If the `event_filters` object is missing in the configuration, the trail will not process data plane events. A single `event_filters` section is used to configure data plane audit log processing for a single {{ yandex-cloud }} service. To configure the trail processing of data plane events for multiple services, specify the `event_filters` parameter in the configuration as many times as you need.
      * `service`: ID of the [service](../../audit-trails/concepts/control-plane-vs-data-plane.md#data-plane-events) whose events the trail will process.
         The possible values include:
         * `dns`
         * `kms`
         * `lockbox`
         * `mdb.mongodb`
         * `mdb.mysql`
         * `mdb.postgresql`
         * `storage`

      * `categories`: Structure describing the type of events to collect.
         * `plane`: Event plane. For data plane events, specify `DATA_PLANE`.
         * `type`: Type of resource event action. The possible values are `READ` and `WRITE`.

      * `path_filter`: Structure describing how the trail processes data (data plane) events. It may contain a single `some_filter` object or a single `any_filter` object.

         {% include [path-filter-tf-params](./path-filter-tf-params.md) %}