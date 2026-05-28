```hcl
resource_groups = jsonencode(
  {
    "rootGroups" : [
      # Root resource group 1
      {
        "name" : "<resource_group_name>",
        "softMemoryLimit" : "<memory_usage_limit>",
        "softConcurrencyLimit" : <soft_limit_on_the_number_of_running_queries>,
        "hardConcurrencyLimit" : <hard_limit_on_the_number_of_running_queries>,
        "softCpuLimit" : <soft_CPU_time_limit>,
        "hardCpuLimit" : <hard_CPU_time_limit>,
        "maxQueued" : <limit_on_the_number_of_queued_requests>,
        "schedulingPolicy" : "<query_scheduling_policy>",
        "schedulingWeight" : <group_weight>,
        "subGroups" : [
          # Resource sub-group 1
          {
            ...
            "subGroups" : [<list_of_next-level_sub-groups>]
          },
          # Resource sub-group 2
          {
            ...
            "subGroups" : [<list_of_next-level_sub-groups>]
          },
          ...
          # Resource sub-group N
          {
            ...
            "subGroups" : [<list_of_next-level_sub-groups>]
          }
        ]
      },
      # Root resource group 2
      {
        ... 
      },
      ...
      # Root resource group N
      {
        ... 
      }
    ],
    "selectors" : [
      # Selector rule 1
      {
        "user" : "<regular_expression_for_usernames>",
        "userGroup" : "<regular_expression_for_user_groups>",
        "queryType" : "<request_type>",
        "source" : "<regular_expression_for_query_sources>",
        "clientTags" : ["<list_of_tags>"],
        "group" : "<resource_group_name>"
      },
      # Selector rule 2
      {
        ... 
      },
      ...
      # Selector rule N
      {
        ... 
      }
    ],
    "cpuQuotaPeriod" : "<CPU_quota_calculation_period>"
  }
)
```
