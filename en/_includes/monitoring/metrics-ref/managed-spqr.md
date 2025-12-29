The `name` label contains the metric name.

Labels shared by all {{ mspqr-name }} metrics:

Label | Value
----|----
cid | Cluster ID
dc | [Availability zone](../../../overview/concepts/geo-scope.md)
fqdn | Host FQDN
host | Host FQDN
resource_id | Cluster ID
resource_type | Resource type: `cluster`
service | Service ID: `managed-spqr`
shard | Shard ID
subcluster_name | Subcluster name


## CPU metrics {#managed-spqr-cpu-metrics}

These metrics show the processor core workload.

The `cpu` label contains the vCPU ID.

| Name<br/>Type, units | Description |
| ----- | ----- |
| `cpu.usage_guest`<br/>`DGAUGE`, % | CPU core usage, `guest` usage type |
| `cpu.usage_guest_nice`<br/>`DGAUGE`, % | CPU core usage, `guest_nice` usage type |
| `cpu.usage_idle`<br/>`DGAUGE`, % | CPU core usage, `idle` usage type |
| `cpu.usage_iowait`<br/>`DGAUGE`, % | CPU core usage, `iowait` usage type |
| `cpu.usage_irq`<br/>`DGAUGE`, % | CPU core usage, `irq` usage type |
| `cpu.usage_nice`<br/>`DGAUGE`, % | CPU core usage, `nice` usage type |
| `cpu.usage_softirq`<br/>`DGAUGE`, % | CPU core usage, `softirq` usage type |
| `cpu.usage_steal`<br/>`DGAUGE`, % | CPU core usage, `steal` usage type |
| `cpu.usage_system`<br/>`DGAUGE`, % | CPU core usage, `system` usage type |
| `cpu.usage_user`<br/>`DGAUGE`, % | CPU core usage, `user` usage type |


## Disk metrics {#managed-spqr-disk-metrics}

| Name<br/>Type, units | Description |
| ----- | ----- |
| `vd*`<br/>`DGAUGE`, bytes | Virtual disk size |
| `vd**`<br/>`DGAUGE`, bytes | Virtual disk partition size |


## RAM metrics {#managed-spqr-ram-metrics}

| Name<br/>Type, units | Description |
| ----- | ----- |
| `mem.active`<br/>`DGAUGE`, bytes | RAM usage, `active` usage type |
| `mem.available`<br/>`DGAUGE`, bytes | RAM usage, `available` usage type |
| `mem.available_percent`<br/>`DGAUGE`, % | Percentage of available RAM |
| `mem.buffered`<br/>`DGAUGE`, bytes | RAM usage, `buffered` usage type |
| `mem.cached`<br/>`DGAUGE`, bytes | RAM usage, `cached` usage type |
| `mem.commit_limit`<br/>`DGAUGE`, bytes | RAM usage, `commit_limit` usage type |
| `mem.committed_as`<br/>`DGAUGE`, bytes | RAM usage, `committed_as` usage type |
| `mem.dirty`<br/>`DGAUGE`, bytes | RAM usage, `dirty` usage type |
| `mem.free`<br/>`DGAUGE`, bytes | RAM usage, `free` usage type |
| `mem.high_free`<br/>`DGAUGE`, bytes | RAM usage, `high_free` usage type |
| `mem.high_total`<br/>`DGAUGE`, bytes | RAM usage, `high_total` usage type |
| `mem.huge_page_size`<br/>`DGAUGE`, bytes | RAM usage, `huge_page_size` usage type |
| `mem.huge_pages_free`<br/>`DGAUGE`, bytes | RAM usage, `huge_pages_free` usage type |
| `mem.huge_pages_total`<br/>`DGAUGE`, bytes | RAM usage, `huge_pages_total` usage type |
| `mem.inactive`<br/>`DGAUGE`, bytes | RAM usage, `inactive` usage type |
| `mem.low_free`<br/>`DGAUGE`, bytes | RAM usage, `low_free` usage type |
| `mem.low_total`<br/>`DGAUGE`, bytes | RAM usage, `low_total` usage type |
| `mem.mapped`<br/>`DGAUGE`, bytes | RAM usage, `mapped` usage type |
| `mem.page_tables`<br/>`DGAUGE`, bytes | RAM usage, `page_tables` usage type |
| `mem.shared`<br/>`DGAUGE`, bytes | RAM usage, `shared` usage type |
| `mem.slab`<br/>`DGAUGE`, bytes | RAM usage, `slab` usage type |
| `mem.sreclaimable`<br/>`DGAUGE`, bytes | RAM usage, `sreclaimable` usage type |
| `mem.sunreclaim`<br/>`DGAUGE`, bytes | RAM usage, `sunreclaim` usage type |
| `mem.swap_cached`<br/>`DGAUGE`, bytes | RAM usage, `swap_cached` usage type |
| `mem.swap_free`<br/>`DGAUGE`, bytes | RAM usage, `swap_free` usage type |
| `mem.swap_total`<br/>`DGAUGE`, bytes | RAM usage, `swap_total` usage type |
| `mem.total`<br/>`DGAUGE`, bytes | RAM usage, `total` usage type |
| `mem.used`<br/>`DGAUGE`, bytes | RAM usage, `used` usage type |
| `mem.used_percent`<br/>`DGAUGE`, % | Percentage of used RAM |
| `mem.vmalloc_chunk`<br/>`DGAUGE`, bytes | RAM usage, `vmalloc_chunk` usage type |
| `mem.vmalloc_total`<br/>`DGAUGE`, bytes | RAM usage, `vmalloc_total` usage type |
| `mem.vmalloc_used`<br/>`DGAUGE`, bytes | RAM usage, `vmalloc_used` usage type |
| `mem.write_back`<br/>`DGAUGE`, bytes | RAM usage, `write_back` usage type |
| `mem.write_back_tmp`<br/>`DGAUGE`, bytes | RAM usage, `write_back_tmp` usage type |


## Network metrics {#managed-spqr-net-metrics}

The `interface` label contains the network interface ID.

| Name<br/>Type, units | Description |
| ----- | ----- |
| `net.bytes_recv`<br/>`DGAUGE`, bytes per second | Network data receive rate |
| `net.bytes_sent`<br/>`DGAUGE`, bytes per second | Network data transmit rate |
| `net.drop_in`<br/>`DGAUGE`, count | Dropped receive packets |
| `net.drop_out`<br/>`DGAUGE`, count | Dropped transmit packets |
| `net.err_in`<br/>`DGAUGE`, count | Receive error count |
| `net.err_out`<br/>`DGAUGE`, count | Transmit error count |
| `net.icmp_inaddrmaskreps`<br/>`DGAUGE`, count | Number of ICMP address mask reply messages received from the polled node |
| `net.icmp_inaddrmasks`<br/>`DGAUGE`, count | Number of ICMP address mask request messages received |
| `net.icmp_incsumerrors`<br/>`DGAUGE`, count | Total IP packets with checksum errors |
| `net.icmp_indestunreachs`<br/>`DGAUGE`, count | Number of ICMP destination unreachable messages received |
| `net.icmp_inechoreps`<br/>`DGAUGE`, count | Number of ICMP echo reply messages received |
| `net.icmp_inechos`<br/>`DGAUGE`, count | Number of ICMP echo request messages received |
| `net.icmp_inerrors`<br/>`DGAUGE`, count | Number of bad ICMP packets received, excluding those with checksum errors |
| `net.icmp_inmsgs`<br/>`DGAUGE`, count | Total ICMP messages received |
| `net.icmp_inparmprobs`<br/>`DGAUGE`, count | Number of ICMP parameter problem messages received |
| `net.icmp_inredirects`<br/>`DGAUGE`, count | Number of ICMP redirect messages received |
| `net.icmp_insrcquenchs`<br/>`DGAUGE`, count | Number of ICMP source quench messages received |
| `net.icmp_intimeexcds`<br/>`DGAUGE`, count | Number of ICMP time exceeded messages received | 
| `net.icmp_intimestampreps`<br/>`DGAUGE`, count | Number of ICMP timestamp reply messages received |
| `net.icmp_intimestamps`<br/>`DGAUGE`, count | Number of ICMP timestamp (request) messages received |
| `net.icmp_outaddrmaskreps`<br/>`DGAUGE`, count | Number of ICMP address mask reply messages sent |
| `net.icmp_outaddrmasks`<br/>`DGAUGE`, count | Number of ICMP address mask request messages sent |
| `net.icmp_outdestunreachs`<br/>`DGAUGE`, count | Number of ICMP destination unreachable messages sent |
| `net.icmp_outechoreps`<br/>`DGAUGE`, count | Number of ICMP echo reply messages sent |
| `net.icmp_outechos`<br/>`DGAUGE`, count | Number of ICMP echo request messages sent |
| `net.icmp_outerrors`<br/>`DGAUGE`, count | Number of ICMP messages not sent due to ICMP errors, such as buffer shortages |
| `net.icmp_outmsgs`<br/>`DGAUGE`, count | Total ICMP messages the object in question attempted to send. This includes all messages counted by `icmp_outerrors`. | 
| `net.icmp_outparmprobs`<br/>`DGAUGE`, count | Number of ICMP parameter problem messages sent |
| `net.packets_recv`<br/>`DGAUGE`, packets per second | Network packet receive rate |
| `net.packets_sent`<br/>`DGAUGE`, packets per second | Network packet transmit rate |
| `icmp_outratelimitglobal`<br/>`DGAUGE`, count | Number of ICMP messages throttled by global rate limits |
| `icmp_outratelimithost`<br/>`DGAUGE`, count | Number of ICMP messages throttled by host-specific rate limits |
| `icmp_outredirects`<br/>`DGAUGE`, count | Number of ICMP redirect messages sent | 
| `icmp_outsrcquenchs`<br/>`DGAUGE`, count | Number of ICMP source quench messages sent |
| `icmp_outtimeexcds`<br/>`DGAUGE`, count | Number of ICMP time exceeded messages sent | 
| `icmp_outtimestampreps`<br/>`DGAUGE`, count | Number of ICMP timestamp reply messages sent | 
| `icmp_outtimestamps`<br/>`DGAUGE`, count | Number of ICMP timestamp (request) messages sent | 
| `net.icmpmsg_intype5`<br/>`DGAUGE`, count | Number of ICMP type 5 (redirect) messages received. |
| `net.icmpmsg_intype8`<br/>`DGAUGE`, count | Number of ICMP type 8 (echo request) messages received |
| `net.icmpmsg_intype13`<br/>`DGAUGE`, count | Number of ICMP type 13 (timestamp request) messages received. |
| `net.icmpmsg_outtype0`<br/>`DGAUGE`, count | Number of ICMP type 0 (echo reply) messages sent |
| `net.icmpmsg_outtype3`<br/>`DGAUGE`, count | Number of ICMP type 3 (destination unreachable) messages sent |
| `net.ip_defaultttl`<br/>`DGAUGE`, string | Default TTL value inserted into the IP header for IP packets generated in this object when the transport layer protocol does not provide a TTL. |
| `net.ip_forwarding`<br/>`DGAUGE` | IP forwarding status (SNMP): `0` for disabled, `1` for enabled. |
| `net.ip_forwdatagrams`<br/>`DGAUGE`, count | Number of inbound packets not destined for this object, triggering an attempt to find a forwarding route to the final IP destination. For objects not acting as IP gateways, this count includes only those packets that were source-routed through them and where the source route option was successfully processed. |
| `net.ip_fragcreates`<br/>`DGAUGE`, count | Number of IP packet fragments generated due to fragmentation in the object in question |
| `net.ip_fragfails`<br/>`DGAUGE`, count | Number of IP packets dropped due to failed fragmentation which was required in this object, e.g., because of the `Do not fragment` flag being set. |
| `net.ip_fragoks`<br/>`DGAUGE`, count | Number of successfully fragmented IP packets |
| `net.ip_inaddrerrors`<br/>`DGAUGE`, count | Number of inbound packets dropped due to an invalid destination IP address in the IP header for the object in question. This count includes invalid addresses, such as `0.0.0.0`, and addresses of unsupported classes, e.g., Class E. For objects that do not act as IP gateways and therefore do not forward packets, this counter includes packets dropped because the destination address was not a local one. |
| `net.ip_indelivers`<br/>`DGAUGE`, count | Total IP packets delivered |
| `net.ip_indiscards`<br/>`DGAUGE`, count | Number of inbound IP packets encountering no issues preventing their further processing but still dropped, e.g., due to lack of buffer space. This counter does not include packets dropped while awaiting reassembly. |
| `net.ip_inhdrerrors`<br/>`DGAUGE`, count | Number of inbound packets with header errors |
| `net.ip_inreceives`<br/>`DGAUGE`, count | Total inbound packets received from interfaces, including those received in error |
| `net.ip_inunknownprotos`<br/>`DGAUGE`, count | Number of unknown protocol packets received |
| `net.ip_outdiscards`<br/>`DGAUGE`, count | Number of outgoing IP packets encountering no issues preventing their transmission to the destination but still dropped, e.g., due to lack of buffer space. Note that the counter would include packets counted in `ip_forwdatagrams` if they met this (discretionary) drop criterion. |
| `net.ip_outnoroutes`<br/>`DGAUGE`, count | Number of IP packets dropped because no route to their destination was found. This metric tracks all packets counted in `ip_forwdatagrams` that meet this no-route criterion. This includes any packets a host cannot redirect because all its default gateways are down. |
| `net.ip_outrequests`<br/>`DGAUGE`, count | Total IP packets provided by local IP user-level protocols (including ICMP) to IP in requests for transmission. This metric does not include the packets counted in `ip_forwdatagrams`. |
| `net.ip_reasmfails`<br/>`DGAUGE`, count | Number of failures detected by the IP reassembly algorithm due to reasons, such as timeouts, errors, etc. This is not necessarily a count of dropped IP fragments, since certain algorithms, like the one in RFC 815, may lose count of fragments while reassembling them as they are received. |
| `net.ip_reasmoks`<br/>`DGAUGE`, count | Number of IP packets successfully reassembled |
| `net.ip_reasmreqds`<br/>`DGAUGE`, count | Number of received IP fragments requiring reassembly in the object in question |
| `net.ip_reasmtimeout`<br/>`DGAUGE`, seconds | Maximum time, in seconds, received fragments are kept while awaiting reassembly in the object in question. |
| `net.speed`<br/>`DGAUGE`, bits per second | Maximum network data transfer rate for this interface |
| `net.tcp_activeopens`<br/>`DGAUGE`, count | Number of times TCP connections have made a direct transition from the `CLOSED` state to `SYN-SENT`. |
| `net.tcp_attemptfails`<br/>`DGAUGE`, count | Number of times TCP connections have made a direct transition to the `CLOSED` state from either the `SYN-SENT` or `SYN-RCVD` state, plus the number of direct TCP connection transitions. |
| `net.tcp_currestab`<br/>`DGAUGE`, count | Current number of TCP connections for the `ESTABLISHED` or `CLOSE WAIT` state |
| `net.tcp_estabresets`<br/>`DGAUGE`, count | Number of times TCP connections have made a direct transition to the `CLOSED` state from either the `ESTABLISHED` or `CLOSE-WAIT` state. |
| `net.tcp_incsumerrors`<br/>`DGAUGE`, count | This value increases when a received TCP packet has an invalid checksum. |
| `net.tcp_inerrs`<br/>`DGAUGE`, count | Total segments received with an error, such as invalid TCP checksums |
| `net.tcp_insegs`<br/>`DGAUGE`, count | Total segments received, including those received in error |
| `net.tcp_maxconn`<br/>`DGAUGE`, count | Maximum allowed number of TCP connections |
| `net.tcp_outrsts`<br/>`DGAUGE`, count | Number of TCP segments sent with the `RST` flag |
| `net.tcp_outsegs`<br/>`DGAUGE`, count | Total TCP segments sent |
| `net.tcp_passiveopens`<br/>`DGAUGE`, count | Number of times TCP connections have made a direct transition to the `SYN-RCVD` state from `LISTEN` |
| `net.tcp_retranssegs`<br/>`DGAUGE`, count | Total segments retransmitted, i.e., number of TCP segments sent containing one or more previously transmitted octets. |
| `net.tcp_rtoalgorithm`<br/>`DGAUGE` | Algorithm used to determine the timeout for retransmitting unacknowledged octets |
| `net.tcp_rtomax`<br/>`DGAUGE`, milliseconds | Maximum TCP retransmission timeout, in milliseconds |
| `net.tcp_rtomin`<br/>`DGAUGE`, milliseconds | Minimum TCP retransmission timeout, in milliseconds |
| `net.udp_ignoredmulti`<br/>`DGAUGE`, count | Number of UDP multicast packets ignored |
| `net.udp_incsumerrors`<br/>`DGAUGE`, count | This value increases when a received UDP packet contains an invalid kernel code checksum. |
| `net.udp_indatagrams`<br/>`DGAUGE`, count | Total UDP packets received |
| `net.udp_inerrors`<br/>`DGAUGE`, count | Number of bad UDP packets received, excluding those with checksum errors |
| `net.udp_memerrors`<br/>`DGAUGE`, errors | Number of UDP out-of-memory errors |
| `net.udp_noports`<br/>`DGAUGE`, count | Total UDP packets received with no application on the destination port |
| `net.udp_outdatagrams`<br/>`DGAUGE`, count | Total UDP packets sent from the object in question |
| `net.udp_rcvbuferrors`<br/>`DGAUGE`, count | Number of UDP receive buffer errors |
| `net.udp_sndbuferrors`<br/>`DGAUGE`, count | Number of UDP send buffer errors |
| `net.udplite_ignoredmulti`<br/>`DGAUGE`, count | Number of UDP-Lite multicast packets ignored |
| `net.udplite_incsumerrors`<br/>`DGAUGE`, count | This value increases when a received UDP-Lite packet contains an invalid kernel code checksum. |
| `net.udplite_indatagrams`<br/>`DGAUGE`, count | Total UDP-Lite packets received |
| `net.udplite_inerrors`<br/>`DGAUGE`, count | Total UDP-Lite packet receive errors |
| `net.udplite_memerrors`<br/>`DGAUGE`, errors | Number of UDP-Lite out-of-memory errors |
| `net.udplite_noports`<br/>`DGAUGE`, count | Number of received UDP-Lite packets with no destination port found |
| `net.udplite_outdatagrams`<br/>`DGAUGE`, count | Total UDP-Lite packets sent |
| `net.udplite_rcvbuferrors`<br/>`DGAUGE`, count | Number of UDP-Lite receive buffer errors |
| `net.udplite_sndbuferrors`<br/>`DGAUGE`, count | Number of UDP-Lite send buffer errors |


## Service metrics {#managed-spqr-metrics}

#### Cluster metrics {#managed-spqr-cluster-metrics}

| Name<br/>Type, units | Description |
| ----- | ----- |
| `connections_to_host.<host_fqdn>`<br/>`DGAUGE`, count | Number of active connections to the host with the specified FQDN |
| `core_dump.count`<br/>`DGAUGE`, count | Number of core dumps |
| `dbaas_conf.cpu.fraction`<br/>`DGAUGE`, fractions | Fraction of available CPU resources allocated by the service |
| `dbaas_conf.cpu.guarantee`<br/>`DGAUGE`, fractions | Guaranteed fraction of CPU resources allocated by the service |
| `dbaas_conf.cpu.limit`<br/>`DGAUGE`, fractions | Maximum allowed fraction of CPU resource usage |
| `dbaas_conf.hosts.ha`<br/>`DGAUGE`, hosts | Number of hosts set up for high availability |
| `dbaas_conf.hosts.subcluster.spqr_coordinator.total`<br/>`DGAUGE`, count | Number of hosts in the SPQR Coordinator subcluster |
| `dbaas_conf.hosts.subcluster.spqr_infra.total`<br/>`DGAUGE`, count | Number of hosts in the SPQR Infra subcluster |
| `dbaas_conf.hosts.subcluster.spqr_router.total`<br/>`DGAUGE`, count | Number of hosts in the SPQR Router subcluster |
| `dbaas_conf.hosts.total`<br/>`DGAUGE`, count | Total hosts used by the service |
| `etcd_health.etcd-is_alive`<br/>`DGAUGE`, count | `etcd` health status: `1` if it is enabled and operational, `0`, if unavailable or not responding. |


#### SPQR native metrics {#native-spqr-metrics}

| Name<br/>Type, units | Description |
| ----- | ----- |
| `spqr_health.spqr_coordinator-is_alive`<br/>`DGAUGE`, units | SPQR Coordinator health status: `1` if the host is active and operational, `0` if it is unavailable or not responding. |
| `spqr_health.spqr_router-is_alive`<br/>`DGAUGE`, units | SPQR Router health status: `1` if the host is active and operational, `0` if it is unavailable or not responding. |
| `spqr_router_stats.active_connections`<br/>`DGAUGE`, count | Number of active connections via SPQR Router |
| `spqr_router_stats.clients_count`<br/>`DGAUGE`, count | Number of clients connected to SPQR Router |
| `spqr_router_stats.connections_count`<br/>`DGAUGE`, count | Total number of connections processed by SPQR Router |
| `spqr_router_stats.connection_usage`<br/>`DGAUGE`, fractions | Fraction of connections used by SPQR Router from the available limit |
| `spqr_router_stats.router_time_0.5`<br/>`DGAUGE`, milliseconds | Median query processing time by SPQR Router, 50th percentile |
| `spqr_router_stats.router_time_0.75`<br/>`DGAUGE`, milliseconds | Query processing time by SPQR Router, 75th percentile |
| `spqr_router_stats.router_time_0.9`<br/>`DGAUGE`, milliseconds | Query processing time by SPQR Router, 90th percentile |
| `spqr_router_stats.router_time_0.95`<br/>`DGAUGE`, milliseconds | Query processing time by SPQR Router, 95th percentile |
| `spqr_router_stats.router_time_0.99`<br/>`DGAUGE`, milliseconds | Query processing time by SPQR Router, 99th percentile |
| `spqr_router_stats.router_time_0.999`<br/>`DGAUGE`, milliseconds | Query processing time by SPQR Router, 99.9th percentile |
| `spqr_router_stats.router_time_0.9999`<br/>`DGAUGE`, milliseconds | Query processing time by SPQR Router, 99.99th percentile |
| `spqr_router_stats.shard_time_0.5`<br/>`DGAUGE`, milliseconds | Median query processing time on the shard, 50th percentile |
| `spqr_router_stats.shard_time_0.75`<br/>`DGAUGE`, milliseconds | Query processing time on the shard, 75th percentile |
| `spqr_router_stats.shard_time_0.9`<br/>`DGAUGE`, milliseconds | Query processing time on the shard, 90th percentile |
| `spqr_router_stats.shard_time_0.95`<br/>`DGAUGE`, milliseconds | Query processing time on the shard, 95th percentile |
| `spqr_router_stats.shard_time_0.99`<br/>`DGAUGE`, milliseconds | Query processing time on the shard, 99th percentile |
| `spqr_router_stats.shard_time_0.999`<br/>`DGAUGE`, milliseconds | Query processing time on the shard, 99.9th percentile |
| `spqr_router_stats.shard_time_0.9999`<br/>`DGAUGE`, milliseconds | Query processing time on the shard, 99.99th percentile |
| `spqr_router_stats.total_cancel_requests`<br/>`DGAUGE`, count | Total number of canceled queries via SPQR Router. |
| `spqr_router_stats.total_connections_count`<br/>`DGAUGE`, count | Total number of established connections via SPQR Router. |


#### System metrics {#managed-spqr-config-metrics}

| Name<br/>Type, units | Description |
| ----- | ----- |
| `system.load.avg_1min`<br/>`DGAUGE`, % | Average CPU load over one minute |
| `system.load.avg_5min`<br/>`DGAUGE`, % | Average CPU load over five minutes |
| `system.load.avg_15min`<br/>`DGAUGE`, % | Average CPU load over 15 minutes |
| `system.n_cpus`<br/>`DGAUGE`, count | Maximum number of cores in use |
| `system.n_unique_users`<br/>`DGAUGE`, users | Number of unique users or accounts engaging with the system |
| `system.n_users`<br/>`DGAUGE`, count | Limit on the number of users |
| `system.uptime`<br/>`DGAUGE`, % | Uptime percentage |