1. View the description of the CLI command to set up limits:

   ```bash
   yc alb load-balancer autoscale --help
   ```

1. Set limits by running the command below:

   ```bash
   yc alb load-balancer autoscale <load_balancer_name_or_ID> \
     --min-zone-size <minimum_number_of_resource_units_per_zone> \
     --max-size <maximum_total_number_of_resource_units>
   ```

   Where:

   * `--min-zone-size`: Minimum number of resource units in each availability zone. The default minimum is 2. You cannot set the minimum value that is less than 2.
   * `--max-size`: Maximum total number of resource units. By default, this number is unlimited. Make sure the value is not less than the number of load balancer availability zones multiplied by the minimum number of resource units per zone.

   You can set one or both parameters in the command.

   Example:

   ```bash
   yc alb load-balancer autoscale test-balancer2 \
     --min-zone-size 3 \
     --max-size 10
   ```

   Result:

   ```yaml
   id: a5d88ep483cmbfm63g9t
   name: test-balancer2
   folder_id: aoe197919j8elpeg1lkp
   status: ACTIVE
   region_id: {{ region-id }}
   network_id: c64l1c06d15178sa87k0
   allocation_policy:
     locations:
       - zone_id: {{ region-id }}-a
         subnet_id: buc4gsmpj8hvramg61g8
   created_at: "2022-06-02T12:12:13.624832586Z"
   auto_scale_policy:
     min_zone_size: 3
     max_size: 10
   ```
