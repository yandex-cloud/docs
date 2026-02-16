1. See the description of the CLI command for setting up limits:

   ```bash
   yc alb load-balancer autoscale --help
   ```

1. Specify limits by running this command:

   ```bash
   yc alb load-balancer autoscale <load_balancer_name_or_ID> \
     --min-zone-size <resource_unit_minimum_per_zone> \
     --max-size <resource_unit_maximum_total>
   ```

   Where:

   * `--min-zone-size`: Resource unit minimum per availability zone The default minimum is 2. You cannot set a minimum below 2.
   * `--max-size`: Resource unit maximum total. By default, it is unlimited. Make sure this value is no less than (number of load balancer availability zones) × (minimum number of resource units per zone).

   You can specify one or both settings at once using this command.

   For example:

   ```bash
   yc alb load-balancer autoscale test-balancer2 \
     --min-zone-size 3 \
     --max-size 10
   ```

   Result:

   ```text
   id: a5d88ep483cm********
   name: test-balancer2
   folder_id: aoe197919j8e********
   status: ACTIVE
   region_id: {{ region-id }}
   network_id: c64l1c06d151********
   allocation_policy:
     locations:
       - zone_id: {{ region-id }}-a
         subnet_id: buc4gsmpj8hv********
   created_at: "2022-06-02T12:12:13.624832586Z"
   auto_scale_policy:
     min_zone_size: 3
     max_size: 10
   ```