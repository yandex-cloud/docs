Where:
* `name`: ARL profile name.
* `description`: ARL profile description. This is an optional parameter.
* `labels`: ARL profile [labels](../../resource-manager/concepts/labels.md). This is an optional parameter.
* `advanced_rate_limiter_rule`: Rule section.
  * `name`: Rule name.
  * `priority`: Rule priority, a unique number from `1` to `999999`. Rules with smaller numerical values apply first.
  * `description`: Rule description. This is an optional parameter.
  * `dry_run`: Dry run flag. Set to `true` to test the rule and estimate the load on your web service. Requests will not be blocked in this mode. However, rule triggering will be logged. This is an optional parameter.
  * `static_quota`: Request count mode where each request is counted individually without grouping. You can only specify one section, either `static_quota` or `dynamic_quota`.
    * `action`: Action if the limit is exceeded. The only available value is `DENY`.
    * `limit`: Maximum number of allowed queries per period.
    * `period`: Time period in seconds in which the limit applies.
    * `condition`: [Condition](../../smartwebsecurity/concepts/conditions.md) for applying the rule. This is an optional parameter. For more information, see the `advanced_rate_limiter_rule.static_quota.condition` description in [this provider article]({{ tf-provider-resources-link }}/sws_advanced_rate_limiter_profile).
  * `dynamic_quota`: Request count mode where groups of requests sharing one or more properties are counted. You can only specify one section, either `static_quota` or `dynamic_quota`.
    * `action`: Action if the limit is exceeded. The only available value is `DENY`.
    * `limit`: Maximum number of allowed queries per period.
    * `period`: Time period in seconds in which the limit applies.
    * `condition`: Condition for applying the rule. This is an optional parameter. For more information, see the `advanced_rate_limiter_rule.dynamic_quota.condition` description in [this provider article]({{ tf-provider-resources-link }}/sws_advanced_rate_limiter_profile).
    * `characteristic`: Description of properties to group requests by. You can specify one section, either `simple_characteristic` or `key_characteristic`.
      * `case_insensitive`: Case insensitive, if `true`, or sensitive, if `false`. 
      * `key_characteristic`: Section of parameters requiring a key (string) to group requests by.
        * `type`: Grouping type. The possible values are `COOKIE_KEY`, `HEADER_KEY`, and `QUERY_KEY`.
        * `value`: Key value (string) to group requests by.
      *  `simple_characteristic`: Section with parameters for autogrouping, i.e., requests are automatically grouped by the specified parameter.
         *  `type`: Grouping type. The possible values are `REQUEST_PATH`, `HTTP_METHOD`, `IP`, `GEO`, and `HOST`.