The `name` label is for the metric name.

Labels shared by all {{ mgp-name }} metrics:

Label | Value
----|----
service | Service ID: `managed-greenplum`
resource_type | Resource type: `cluster`
resource_id | Cluster name 
cid | Cluster ID
host | Host FQDN
fqdn | Host FQDN

## CPU metrics {#managed-greenplum-cpu-metrics}
These metrics show processor core workload.

| Name<br/>Type, units | Description |
| ----- | ----- |
| `cpu.cpu.fraction`<br/>`DGAUGE`, % | Guaranteed vCPU performance |
| `cpu.cpu.guarantee`<br/>`DGAUGE`, count | Guaranteed number of cores |
| `cpu.cpu.limit`<br/>`DGAUGE`, count | Maximum number of cores in use |
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

## Disk metrics {#managed-greenplum-disk-metrics}
Additional labels: `device` for the disk ID in the system.

| Name<br/>Type, units | Description |
| ----- | ----- |
| `disk.free`<br/>`DGAUGE`, bytes | Free space |
| `disk.inodes_free`<br/>`DGAUGE`, count | Free inodes |
| `disk.inodes_total`<br/>`DGAUGE`, count | Available inodes |
| `disk.inodes_used`<br/>`DGAUGE`, count | Used inodes |
| `disk.total`<br/>`DGAUGE`, bytes | Available space |
| `disk.used`<br/>`DGAUGE`, bytes | Used space |
| `disk.used_percent`<br/>`DGAUGE`, % | Percentage of used space |

## Disk I/O metrics {#managed-greenplum-diskio-metrics}
Additional labels: `dev` for the disk ID in the system.

| Name<br/>Type, units | Description |
| ----- | ----- |
| `diskio.io_time`<br/>`DGAUGE`, milliseconds | Disk I/O time |
| `diskio.iops_in_progress`<br/>`DGAUGE`, count | Number of disk I/O operations in progress |
| `diskio.merged_reads`<br/>`DGAUGE`, count | Number of merged disk reads |
| `diskio.merged_writes`<br/>`DGAUGE`, count | Number of merged disk writes |
| `diskio.read_bytes`<br/>`DGAUGE`, bytes | Disk read size |
| `diskio.read_time`<br/>`DGAUGE`, milliseconds | Disk read time |
| `diskio.reads`<br/>`DGAUGE`, count | Number of disk reads |
| `diskio.weighted_io_time`<br/>`DGAUGE`, milliseconds | I/O wait time |
| `diskio.write_bytes`<br/>`DGAUGE`, bytes | Disk write size  |
| `diskio.write_time`<br/>`DGAUGE`, milliseconds | Disk write time |
| `diskio.writes`<br/>`DGAUGE`, count | Number of disk writes |

## RAM metrics {#managed-greenplum-ram-metrics}
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

## Network metrics {#managed-greenplum-net-metrics}
| Name<br/>Type, units | Description |
| ----- | ----- |
| `net.bytes_recv`<br/>`DGAUGE`, bytes per second | Network data receive rate |
| `net.bytes_sent`<br/>`DGAUGE`, bytes per second | Network data transmit rate |
| `net.drop_in`<br/>`DGAUGE`, count | Dropped receive packets |
| `net.drop_out`<br/>`DGAUGE`, count | Dropped transmit packets |
| `net.err_in`<br/>`DGAUGE`, count | Receive error count |
| `net.err_out`<br/>`DGAUGE`, count | Transmit error count |
| `net.packets_recv`<br/>`DGAUGE`, packets per second | Network packet receive rate |
| `net.packets_sent`<br/>`DGAUGE`, packets per second | Network packet transmit rate |
| `net.icmp_inaddrmaskreps`<br/>`DGAUGE`, count | Number of ICMP address mask reply messages received from the polled node  |
| `net.icmp_inaddrmasks`<br/>`DGAUGE`, count | Number of ICMP address mask request messages received  |
| `net.icmp_incsumerrors`<br/>`DGAUGE`, count | Total IP packets with checksum errors  |
| `net.icmp_indestunreachs`<br/>`DGAUGE`, count | Number of ICMP destination unreachable messages received  |
| `net.icmp_inechoreps`<br/>`DGAUGE`, count | Number of ICMP echo reply messages received  |
| `net.icmp_inechos`<br/>`DGAUGE`, count | Number of ICMP echo request messages received  |
| `net.icmp_inerrors`<br/>`DGAUGE`, count | Number of bad ICMP packets received, excluding those with checksum errors  |
| `net.icmp_inmsgs`<br/>`DGAUGE`, count | Total ICMP messages received  |
| `net.icmp_inparmprobs`<br/>`DGAUGE`, count | Number of ICMP parameter problem messages received |
| `net.icmp_inredirects`<br/>`DGAUGE`, count | Number of ICMP redirect messages received  |
| `net.icmp_insrcquenchs`<br/>`DGAUGE`, count | Number of ICMP source quench messages received  |
| `net.icmp_intimeexcds`<br/>`DGAUGE`, count | Number of ICMP time exceeded messages received  | 
| `net.icmp_intimestampreps`<br/>`DGAUGE`, count | Number of ICMP timestamp reply messages received  |
| `net.icmp_intimestamps`<br/>`DGAUGE`, count | Number of ICMP timestamp (request) messages received  |
| `net.icmp_outaddrmaskreps`<br/>`DGAUGE`, count | Number of ICMP address mask reply messages sent  |
| `net.icmp_outaddrmasks`<br/>`DGAUGE`, count | Number of ICMP address mask request messages sent  |
| `net.icmp_outdestunreachs`<br/>`DGAUGE`, count | Number of ICMP destination unreachable messages sent  |
| `net.icmp_outechoreps`<br/>`DGAUGE`, count | Number of ICMP echo reply messages sent  |
| `net.icmp_outechos`<br/>`DGAUGE`, count | Number of ICMP echo request messages sent  |
| `net.icmp_outerrors`<br/>`DGAUGE`, count | Number of ICMP messages not sent due to ICMP errors, such as buffer shortages  |
| `net.icmp_outmsgs`<br/>`DGAUGE`, count | Total ICMP messages the object in question attempted to send. This includes all messages counted by `icmp_outerrors`.  | 
| `net.icmp_outparmprobs`<br/>`DGAUGE`, count | Number of ICMP parameter problem messages sent  |
| `net.icmp_outredirects`<br/>`DGAUGE`, count | Number of ICMP redirect messages sent  |
| `net.icmp_outsrcquenchs`<br/>`DGAUGE`, count | Number of ICMP source quench messages sent  |
| `net.icmp_outtimeexcds`<br/>`DGAUGE`, count | Number of ICMP time exceeded messages sent  |
| `net.icmp_outtimestampreps`<br/>`DGAUGE`, count | Number of ICMP timestamp reply messages sent  |
| `net.icmp_outtimestamps`<br/>`DGAUGE`, count | Number of ICMP timestamp (request) messages sent  |
| `net.icmpmsg_intype0`<br/>`DGAUGE`, count | Number of ICMP type 0 (echo reply) messages received  |
| `net.icmpmsg_intype3`<br/>`DGAUGE`, count | Number of ICMP type 3 (destination unreachable) messages received  |
| `net.icmpmsg_intype8`<br/>`DGAUGE`, count | Number of ICMP type 8 (echo request) messages received  |
| `net.icmpmsg_outtype0`<br/>`DGAUGE`, count | Number of ICMP type 0 (echo reply) messages sent  |
| `net.icmpmsg_outtype3`<br/>`DGAUGE`, count | Number of ICMP type 3 (destination unreachable) messages sent  |
| `net.icmpmsg_outtype8`<br/>`DGAUGE`, count | Total number of ICMP type 8 (echo request) messages sent  |
| `net.ip_defaultttl`<br/>`DGAUGE`, string | Default TTL value inserted into the IP header for IP packets generated in this object when the transport layer protocol does not provide a TTL.  |
| `net.ip_forwarding`<br/>`DGAUGE` | IP forwarding status (SNMP): `0` for disabled, `1` for enabled.  |
| `net.ip_forwdatagrams`<br/>`DGAUGE`, count | Number of inbound packets not destined for this object, triggering an attempt to find a forwarding route to the final IP destination. For objects not acting as IP gateways, this count includes only those packets that were source-routed through them and where the source route option was successfully processed.  |
| `net.ip_fragcreates`<br/>`DGAUGE`, count | Number of IP packet fragments generated due to fragmentation in the object in question  |
| `net.ip_fragfails`<br/>`DGAUGE`, count | Number of IP packets dropped due to failed fragmentation which was required in this object, e.g., because of the `Do not fragment` flag being set.  |
| `net.ip_fragoks`<br/>`DGAUGE`, count | Number of successfully fragmented IP packets  |
| `net.ip_inaddrerrors`<br/>`DGAUGE`, count | Number of inbound packets dropped due to an invalid destination IP address in the IP header for the object in question. This count includes invalid addresses, such as `0.0.0.0`, and addresses of unsupported classes, e.g., Class E. For objects that do not act as IP gateways and therefore do not forward packets, this counter includes packets dropped because the destination address was not a local one.  |
| `net.ip_indelivers`<br/>`DGAUGE`, count | Total IP packets delivered  |
| `net.ip_indiscards`<br/>`DGAUGE`, count | Number of inbound IP packets encountering no issues preventing their further processing but still dropped, e.g., due to lack of buffer space. This counter does not include packets dropped while awaiting reassembly.  |
| `net.ip_inhdrerrors`<br/>`DGAUGE`, count | Number of inbound packets with header errors  |
| `net.ip_inreceives`<br/>`DGAUGE`, count | Total inbound packets received from interfaces, including those received in error  |
| `net.ip_inunknownprotos`<br/>`DGAUGE`, count | Number of unknown protocol packets received  |
| `net.ip_outdiscards`<br/>`DGAUGE`, count | Number of outgoing IP packets encountering no issues preventing their transmission to the destination but still dropped, e.g., due to lack of buffer space. Note that the counter would include packets counted in `ip_forwdatagrams` if they met this (discretionary) drop criterion. |
| `net.ip_outnoroutes`<br/>`DGAUGE`, count | Number of IP packets dropped because no route to their destination was found. This metric tracks all packets counted in `ip_forwdatagrams` that meet this no-route criterion. This includes any packets a host cannot redirect because all its default gateways are down.  |
| `net.ip_outrequests`<br/>`DGAUGE`, count | Total IP packets provided by local IP user-level protocols (including ICMP) to IP in requests for transmission. This metric does not include the packets counted in `ip_forwdatagrams`.  |
| `net.ip_reasmfails`<br/>`DGAUGE`, count | Number of failures detected by the IP reassembly algorithm due to reasons, such as timeouts, errors, etc. This is not necessarily a count of dropped IP fragments, since certain algorithms, like the one in RFC 815, may lose count of fragments while reassembling them as they are received.  |
| `net.ip_reasmoks`<br/>`DGAUGE`, count | Number of IP packets successfully reassembled  |
| `net.ip_reasmreqds`<br/>`DGAUGE`, count | Number of received IP fragments requiring reassembly in the object in question  |
| `net.ip_reasmtimeout`<br/>`DGAUGE`, seconds | Maximum time, in seconds, received fragments are kept while awaiting reassembly in the object in question.  |
| `net.tcp_activeopens`<br/>`DGAUGE`, count | Number of times TCP connections have made a direct transition from the `CLOSED` state to `SYN-SENT`.  |
| `net.tcp_attemptfails`<br/>`DGAUGE`, count | Number of times TCP connections have made a direct transition to the `CLOSED` state from either the `SYN-SENT` or `SYN-RCVD` state, plus the number of direct TCP connection transitions.  |
| `net.tcp_currestab`<br/>`DGAUGE`, count | Current number of TCP connections for the `ESTABLISHED` or `CLOSE WAIT` state  |
| `net.tcp_estabresets`<br/>`DGAUGE`, count | Number of times TCP connections have made a direct transition to the `CLOSED` state from either the `ESTABLISHED` or `CLOSE-WAIT` state.  |
| `net.tcp_incsumerrors`<br/>`DGAUGE`, count | This value increases when a received TCP packet has an invalid checksum.  |
| `net.tcp_inerrs`<br/>`DGAUGE`, count | Total segments received with an error, such as invalid TCP checksums  |
| `net.tcp_insegs`<br/>`DGAUGE`, count | Total segments received, including those received in error  |
| `net.tcp_maxconn`<br/>`DGAUGE`, count | Maximum allowed number of TCP connections  |
| `net.tcp_outrsts`<br/>`DGAUGE`, count | Number of TCP segments sent with the `RST` flag  |
| `net.tcp_outsegs`<br/>`DGAUGE`, count | Total TCP segments sent  |
| `net.tcp_passiveopens`<br/>`DGAUGE`, count | Number of times TCP connections have made a direct transition to the `SYN-RCVD` state from `LISTEN`  |
| `net.tcp_retranssegs`<br/>`DGAUGE`, count | Total segments retransmitted, i.e., number of TCP segments sent containing one or more previously transmitted octets.  |
| `net.tcp_rtoalgorithm`<br/>`DGAUGE` | Algorithm used to determine the timeout for retransmitting unacknowledged octets  |
| `net.tcp_rtomax`<br/>`DGAUGE`, milliseconds | Maximum TCP retransmission timeout, in milliseconds  |
| `net.tcp_rtomin`<br/>`DGAUGE`, milliseconds | Minimum TCP retransmission timeout, in milliseconds  |
| `net.udp_ignoredmulti`<br/>`DGAUGE`, count | Number of UDP multicast packets ignored  |
| `net.udp_incsumerrors`<br/>`DGAUGE`, count | This value increases when a received UDP packet contains an invalid kernel code checksum.  |
| `net.udp_indatagrams`<br/>`DGAUGE`, count | Total UDP packets received  |
| `net.udp_inerrors`<br/>`DGAUGE`, count | Number of bad UDP packets received, excluding those with checksum errors  |
| `net.udp_noports`<br/>`DGAUGE`, count | Total UDP packets received with no application on the destination port  |
| `net.udp_outdatagrams`<br/>`DGAUGE`, count | Total UDP packets sent from the object in question  |
| `net.udp_rcvbuferrors`<br/>`DGAUGE`, count | Number of UDP receive buffer errors  |
| `net.udp_sndbuferrors`<br/>`DGAUGE`, count | Number of UDP send buffer errors  |
| `net.udplite_ignoredmulti`<br/>`DGAUGE`, count | Number of UDP-Lite multicast packets ignored  |
| `net.udplite_incsumerrors`<br/>`DGAUGE`, count | This value increases when a received UDP-Lite packet contains an invalid kernel code checksum.  |
| `net.udplite_indatagrams`<br/>`DGAUGE`, count | Total UDP-Lite packets received  |
| `net.udplite_inerrors`<br/>`DGAUGE`, count | Total UDP-Lite packet receive errors  |
| `net.udplite_noports`<br/>`DGAUGE`, count | Number of received UDP-Lite packets with no destination port found  |
| `net.udplite_outdatagrams`<br/>`DGAUGE`, count | Total UDP-Lite packets sent  |
| `net.udplite_rcvbuferrors`<br/>`DGAUGE`, count | Number of UDP-Lite receive buffer errors  |
| `net.udplite_sndbuferrors`<br/>`DGAUGE`, count | Number of UDP-Lite send buffer errors  |
| `net_response.response_time`<br/>`DGAUGE`, milliseconds | Network response time  |
| `net_response.result_code`<br/>`DGAUGE`, `0`-`10` | Network response code  |
| `nstat.ipextinbcastoctets`<br/>`DGAUGE`, bytes | Total inbound broadcast octets received with IP addresses  |
| `nstat.ipextinbcastpkts`<br/>`DGAUGE`, count | Total inbound broadcast packets received with IP addresses  |
| `nstat.ipextincepkts`<br/>`DGAUGE`, count | Number of received IP packets with detailed traffic information  |
| `nstat.ipextincsumerrors`<br/>`DGAUGE`, count | Number of inbound checksum errors with IP addresses and detailed traffic information  |
| `nstat.ipextinect0pkts`<br/>`DGAUGE`, count | Number of inbound packets with IP addresses and detailed traffic information marked with the `0` ECN (Explicit Congestion Notification) code  |
| `nstat.ipextinect1pkts`<br/>`DGAUGE`, count | Number of inbound packets with IP addresses and detailed traffic information marked with the `1` ECN code  |
| `nstat.ipextinmcastoctets`<br/>`DGAUGE`, bytes | Total inbound multicast octets received with IP addresses and detailed traffic information  |
| `nstat.ipextinmcastpkts`<br/>`DGAUGE`, count | Total inbound multicast packets received with IP addresses and detailed traffic information  |
| `nstat.ipextinnoectpkts`<br/>`DGAUGE`, count | Number of inbound packets received with IP addresses and detailed traffic information, excluding those with active ECN  |
| `nstat.ipextinnoroutes`<br/>`DGAUGE`, count | Number of inbound packets dropped for lack of route  |
| `nstat.ipextinoctets`<br/>`DGAUGE`, bytes | Total inbound octets received with IP addresses and detailed traffic information  |
| `nstat.ipextintruncatedpkts`<br/>`DGAUGE`, count | Number of outbound packets dropped due to exceeding the sample size  |
| `nstat.ipextoutbcastoctets`<br/>`DGAUGE`, bytes | Total external broadcast octets sent with IP addresses and detailed traffic information  |
| `nstat.ipextoutbcastpkts`<br/>`DGAUGE`, count | Total external broadcast packets sent with IP addresses and detailed traffic information  |
| `nstat.ipextoutmcastoctets`<br/>`DGAUGE`, bytes | Total external multicast octets sent with IP addresses and detailed traffic information  |
| `nstat.ipextoutmcastpkts`<br/>`DGAUGE`, count | Total external multicast packets sent with IP addresses and detailed traffic information  |
| `nstat.ipextoutoctets`<br/>`DGAUGE`, bytes | Total external octets sent with IP addresses and detailed traffic information  |
| `nstat.ipextreasmoverlaps`<br/>`DGAUGE`, count | Number of overlapping fragments in defragmented IP packets  |
| `nstat.tcpextarpfilter`<br/>`DGAUGE`, count | Number of ARP filter drops for TCP packets  |
| `nstat.tcpextbusypollrxpackets`<br/>`DGAUGE`, count | Number of TCP packets received through busy polling  |
| `nstat.tcpextdelayedacklocked`<br/>`DGAUGE`, count | Number of TCP delayed acknowledgments (ACKs) blocked  |
| `nstat.tcpextdelayedacklost`<br/>`DGAUGE`, count | Number of TCP delayed acknowledgments (ACKs) lost  |
| `nstat.tcpextdelayedacks`<br/>`DGAUGE`, count | Number of TCP delayed acknowledgments (ACKs)  |
| `nstat.tcpextembryonicrsts`<br/>`DGAUGE`, count | Number of embryonic TCP connections dropped  |
| `nstat.tcpextipreversepathfilter`<br/>`DGAUGE`, count | Number of IP reverse path filter drops for TCP packets  |
| `nstat.tcpextlistendrops`<br/>`DGAUGE`, count | Number of TCP listen state connections dropped  |
| `nstat.tcpextlistenoverflows`<br/>`DGAUGE`, count | Number of TCP listen state connection overflows  |
| `nstat.tcpextlockdroppedicmps`<br/>`DGAUGE`, count | Number of ICMP packets dropped due to depleted TCP lock resources  |
| `nstat.tcpextofopruned`<br/>`DGAUGE`, count | Number of processed TCP packets excluded from analysis due to exceeding certain limits  |
| `nstat.tcpextoutofwindowicmps`<br/>`DGAUGE`, count | Number of ICMP packets dropped due to being outside the TCP window  |
| `nstat.tcpextpawsactive`<br/>`DGAUGE`, count | Number of active TCP PAWS (protection against wrapped sequence numbers) timers  |
| `nstat.tcpextpawsestab`<br/>`DGAUGE`, count | Number of TCP PAWS (protection against wrapped sequence numbers) connections established  |
| `nstat.tcpextpfmemallocdrop`<br/>`DGAUGE`, count | Number of TCP packets dropped due to depleted memory allocation resources  |
| `nstat.tcpextprunecalled`<br/>`DGAUGE`, count | Number of TCP pruning function calls  |
| `nstat.tcpextrcvpruned`<br/>`DGAUGE`, count | Number of inbound TCP packets dropped from the receive queue due to receive buffer limits  |
| `nstat.tcpextsyncookiesfailed`<br/>`DGAUGE`, count | Number of TCP SYN cookies rejected  |
| `nstat.tcpextsyncookiesrecv`<br/>`DGAUGE`, count | Number of TCP SYN packets received using SYN cookies  |
| `nstat.tcpextsyncookiessent`<br/>`DGAUGE`, count | Number of TCP SYN packets sent using SYN cookies  |
| `nstat.tcpexttcpabortfailed`<br/>`DGAUGE`, count | Number of failed attempts to abort TCP connections  |
| `nstat.tcpexttcpabortonclose`<br/>`DGAUGE`, count | Number of TCP connections aborted on closure  |
| `nstat.tcpexttcpabortondata`<br/>`DGAUGE`, count | Number of TCP connections aborted when transmitting data  |
| `nstat.tcpexttcpabortonlinger`<br/>`DGAUGE`, count | Number of TCP connections aborted on linger  |
| `nstat.tcpexttcpabortonmemory`<br/>`DGAUGE`, count | Number of TCP connections aborted due to memory shortage  |
| `nstat.tcpexttcpabortontimeout`<br/>`DGAUGE`, count | Number of TCP connections aborted on timeout  |
| `nstat.tcpexttcpackcompressed`<br/>`DGAUGE`, count | Number of compressed TCP ACK packets  |
| `nstat.tcpexttcpackskippedchallenge`<br/>`DGAUGE`, count | Number of TCP ACK packets skipped due to a challenge ACK call  |
| `nstat.tcpexttcpackskippedfinwait2`<br/>`DGAUGE`, count | Number of TCP ACK packets skipped due to connections in the `FIN_WAIT2` state  |
| `nstat.tcpexttcpackskippedpaws`<br/>`DGAUGE`, count | Number of TCP ACK packets skipped due to connections in the `PAWS` state  |
| `nstat.tcpexttcpackskippedseq`<br/>`DGAUGE`, count | Number of TCP ACK packets skipped due to out-of-sequence connections  |
| `nstat.tcpexttcpackskippedsynrecv`<br/>`DGAUGE`, count | Number of TCP ACK packets skipped due to connections in the `SYN_RECV` state  |
| `nstat.tcpexttcpackskippedtimewait`<br/>`DGAUGE`, count | Number of TCP ACK packets skipped due to connections in the `TIME_WAIT` state  |
| `nstat.tcpexttcpautocorking`<br/>`DGAUGE`, count | Number of TCP autocorking operations  |
| `nstat.tcpexttcpbacklogcoalesce`<br/>`DGAUGE`, count | Number of TCP backlog coalesces  |
| `nstat.tcpexttcpbacklogdrop`<br/>`DGAUGE`, count | Number of TCP connections dropped due to the backlog queue overflow  |
| `nstat.tcpexttcpchallengeack`<br/>`DGAUGE`, count | Number of TCP challenge ACK packets  |
| `nstat.tcpexttcpdeferacceptdrop`<br/>`DGAUGE`, count | Number of TCP connections dropped on deferred accept  |
| `nstat.tcpexttcpdelivered`<br/>`DGAUGE`, count | Number of successfully delivered TCP packets  |
| `nstat.tcpexttcpdeliveredce`<br/>`DGAUGE`, count | Number of successfully delivered TCP packets, including those with checksum errors corrected  |
| `nstat.tcpexttcpdsackignorednoundo`<br/>`DGAUGE`, count | Number of TCP packets reporting duplicate data blocks available but unused on receive  |
| `nstat.tcpexttcpdsackignoredold`<br/>`DGAUGE`, count | Number of TCP packets reporting old data available on receive  |
| `nstat.tcpexttcpdsackoforecv`<br/>`DGAUGE`, count | Number of TCP packets reporting duplicate data blocks sent  |
| `nstat.tcpexttcpdsackofosent`<br/>`DGAUGE`, count | Number of TCP packets reporting out-of-order data blocks received  |
| `nstat.tcpexttcpdsackoldsent`<br/>`DGAUGE`, count | Number of TCP packets reporting out-of-order data blocks sent  |
| `nstat.tcpexttcpdsackrecv`<br/>`DGAUGE`, count | Number of TCP packets reporting old data sent  |
| `nstat.tcpexttcpdsackundo`<br/>`DGAUGE`, count | Number of TCP packets reporting out-of-order data blocks received  |
| `nstat.tcpexttcpfastopenactive`<br/>`DGAUGE`, count | Number of TCP packets reporting undo data blocks received  |
| `nstat.tcpexttcpfastopenactivefail`<br/>`DGAUGE`, count | Number of failed active TCP Fast Open attempts  |
| `nstat.tcpexttcpfastopenblackhole`<br/>`DGAUGE`, count | Number of TCP Fast Open packets sent but not delivered (lost)  |
| `nstat.tcpexttcpfastopencookiereqd`<br/>`DGAUGE`, count | Number of TCP Fast Open packets with cookie requests  |
| `nstat.tcpexttcpfastopenlistenoverflow`<br/>`DGAUGE`, count | Number of TCP Fast Open packets dropped when attempting to receive in passive mode  |
| `nstat.tcpexttcpfastopenpassive`<br/>`DGAUGE`, count | Number of TCP Fast Open packets successfully received in passive mode  |
| `nstat.tcpexttcpfastopenpassivealtkey`<br/>`DGAUGE`, count | Number of TCP Fast Open packets successfully received with an alternative key  |
| `nstat.tcpexttcpfastopenpassivefail`<br/>`DGAUGE`, count | Number of failed attempts to receive TCP Fast Open packets in passive mode  |
| `nstat.tcpexttcpfastretrans`<br/>`DGAUGE`, count | Number of TCP Fast Retransmission packets  |
| `nstat.tcpexttcpfromzerowindowadv`<br/>`DGAUGE`, count | Number of TCP zero window advertisements received on transmit  |
| `nstat.tcpexttcpfullundo`<br/>`DGAUGE`, count | Number of complete TCP undo operations  |
| `nstat.tcpexttcphpacks`<br/>`DGAUGE`, count | Number of TCP packets with `PUSH-ACK` flags  |
| `nstat.tcpexttcphphits`<br/>`DGAUGE`, count | Number of TCP packets with `PUSH-ACK` flags and a successful hash match  |
| `nstat.tcpexttcphystartdelaycwnd`<br/>`DGAUGE`, count | Number of TCP connection setup delays due to round-trip time measurement  |
| `nstat.tcpexttcphystartdelaydetect`<br/>`DGAUGE`, count | Number of TCP connection setup delays detected  |
| `nstat.tcpexttcphystarttraincwnd`<br/>`DGAUGE`, count | Number of TCP connection training delays due to round-trip time measurement  |
| `nstat.tcpexttcphystarttraindetect`<br/>`DGAUGE`, count | Number of TCP connection training delays detected  |
| `nstat.tcpexttcpkeepalive`<br/>`DGAUGE`, count | Number of keep-alive TCP checks  |
| `nstat.tcpexttcplossfailures`<br/>`DGAUGE`, count | Number of TCP transmission failures  |
| `nstat.tcpexttcplossproberecovery`<br/>`DGAUGE`, count | Number of TCP transmission failure recoveries using loss detection  |
| `nstat.tcpexttcplossprobes`<br/>`DGAUGE`, count | Number of TCP packet loss probes  |
| `nstat.tcpexttcplossundo`<br/>`DGAUGE`, count | Number of TCP packet loss undo operations  |
| `nstat.tcpexttcplostretransmit`<br/>`DGAUGE`, count | Number TCP packet retransmissions upon loss  |
| `nstat.tcpexttcpmd5failure`<br/>`DGAUGE`, count | Number of TCP MD5 authentication failures  |
| `nstat.tcpexttcpmd5notfound`<br/>`DGAUGE`, count | Number of TCP MD5 keys not found  |
| `nstat.tcpexttcpmd5unexpected`<br/>`DGAUGE`, count | Number of unexpected TCP MD5 authentication errors  |
| `nstat.tcpexttcpmemorypressures`<br/>`DGAUGE`, count | Number of TCP memory pressure failures  |
| `nstat.tcpexttcpmemorypressureschrono`<br/>`DGAUGE`, count | Number of TCP memory pressure failures, duration considered  |
| `nstat.tcpexttcpminttldrop`<br/>`DGAUGE`, count | Number of TCP connections aborted due to minimum TTL value  |
| `nstat.tcpexttcpmtupfail`<br/>`DGAUGE`, count | Number of failed TCP MTU adjustments  |
| `nstat.tcpexttcpmtupsuccess`<br/>`DGAUGE`, count | Number of successful TCP MTU adjustments  |
| `nstat.tcpexttcpofodrop`<br/>`DGAUGE`, count | Number of dropped out-of-order TCP packets  |
| `nstat.tcpexttcpofomerge`<br/>`DGAUGE`, count | Number of out-of-order TCP packets merged  |
| `nstat.tcpexttcpofoqueue`<br/>`DGAUGE`, count | Number of out-of-order TCP packets queued  |
| `nstat.tcpexttcporigdatasent`<br/>`DGAUGE`, count | Number of TCP data segment sent to the destination  |
| `nstat.tcpexttcppartialundo`<br/>`DGAUGE`, count | Number of partial TCP undo operations  |
| `nstat.tcpexttcppureacks`<br/>`DGAUGE`, count | Number of pure TCP ACK packets  |
| `nstat.tcpexttcprcvcoalesce`<br/>`DGAUGE`, count | Number of TCP packets coalesced on receive  |
| `nstat.tcpexttcprcvcollapsed`<br/>`DGAUGE`, count | Number of TCP packets collapsed on receive  |
| `nstat.tcpexttcprcvqdrop`<br/>`DGAUGE`, count | Number of TCP packets dropped from the inbound queue  |
| `nstat.tcpexttcprenofailures`<br/>`DGAUGE`, count | Number of failed TCP RENO retransmissions  |
| `nstat.tcpexttcprenorecovery`<br/>`DGAUGE`, count | Number of successful TCP RENO recoveries  |
| `nstat.tcpexttcprenorecoveryfail`<br/>`DGAUGE`, count | Number of failed TCP RENO recoveries  |
| `nstat.tcpexttcprenoreorder`<br/>`DGAUGE`, count | Number of TCP packets reordered during recovery  |
| `nstat.tcpexttcpreqqfulldocookies`<br/>`DGAUGE`, count | Number of complete TCP RE-ACK cookie requests  |
| `nstat.tcpexttcpreqqfulldrop`<br/>`DGAUGE`, count | Number of complete TCP RE-ACK requests dropped  |
| `nstat.tcpexttcpretransfail`<br/>`DGAUGE`, count | Number of failed TCP packet retransmissions  |
| `nstat.tcpexttcpsackdiscard`<br/>`DGAUGE`, count | Number of TCP SACK (selective acknowledgment) blocks dropped  |
| `nstat.tcpexttcpsackfailures`<br/>`DGAUGE`, count | Number of TCP SACK block processing errors  |
| `nstat.tcpexttcpsackmerged`<br/>`DGAUGE`, count | Number of merged TCP SACK blocks  |
| `nstat.tcpexttcpsackrecovery`<br/>`DGAUGE`, count | Number of recovered TCP SACK blocks  |
| `nstat.tcpexttcpsackrecoveryfail`<br/>`DGAUGE`, count | Number of failed TCP SACK block recoveries  |
| `nstat.tcpexttcpsackreneging`<br/>`DGAUGE`, count | Number of TCP SACK reneging events  |
| `nstat.tcpexttcpsackreorder`<br/>`DGAUGE`, count | Number of reordered TCP SACK blocks  |
| `nstat.tcpexttcpsackshifted`<br/>`DGAUGE`, count | Number of shifted TCP SACK blocks  |
| `nstat.tcpexttcpsackshiftfallback`<br/>`DGAUGE`, count | Number of TCP SACK block shift fallbacks  |
| `nstat.tcpexttcpslowstartretrans`<br/>`DGAUGE`, count | Number of TCP slow start retransmissions  |
| `nstat.tcpexttcpspuriousrtos`<br/>`DGAUGE`, count | Number of spurious TCP RTOs  |
| `nstat.tcpexttcpspuriousrtxhostqueues`<br/>`DGAUGE`, count | Number of spurious TCP retransmissions in host queues  |
| `nstat.tcpexttcpsynchallenge`<br/>`DGAUGE`, count | Number of TCP synchronization challenges  |
| `nstat.tcpexttcpsynretrans`<br/>`DGAUGE`, count | Number of TCP SYN retransmissions  |
| `nstat.tcpexttcptimeouts`<br/>`DGAUGE`, count | Number of TCP timeouts  |
| `nstat.tcpexttcptimewaitoverflow`<br/>`DGAUGE`, count | Number of TCP `TIME_WAIT` overflows  |
| `nstat.tcpexttcptozerowindowadv`<br/>`DGAUGE`, count | Number of TCP zero window advertisements in segments  |
| `nstat.tcpexttcptsreorder`<br/>`DGAUGE`, count | Number of reordered TCP packets in segments  |
| `nstat.tcpexttcpwantzerowindowadv`<br/>`DGAUGE`, count | Number of TCP zero window advertisements in segments  |
| `nstat.tcpexttcpwinprobe`<br/>`DGAUGE`, count | Number of TCP window probe segments  |
| `nstat.tcpexttcpwqueuetoobig`<br/>`DGAUGE`, count | Number of failures due to TCP outbound queue overflows  |
| `nstat.tcpexttcpzerowindowdrop`<br/>`DGAUGE`, count | Number of TCP zero window segments dropped  |
| `nstat.tcpexttw`<br/>`DGAUGE`, count | Number of TCP sockets in the `TIME_WAIT` state  |
| `nstat.tcpexttwkilled`<br/>`DGAUGE`, count | Number of killed TCP sockets in the `TIME_WAIT` state  |
| `nstat.tcpexttwrecycled`<br/>`DGAUGE`, count | Number of recycled TCP sockets in the `TIME_WAIT` state  |
| `ping.average_response_ms`<br/>`DGAUGE`, milliseconds | Average ping response time |
| `ping.maximum_response_ms`<br/>`DGAUGE`, milliseconds | Maximum ping response time |
| `ping.minimum_response_ms`<br/>`DGAUGE`, milliseconds | Minimum ping response time |
| `ping.packets_received`<br/>`DGAUGE`, count | Number of ping packets received |
| `ping.packets_transmitted`<br/>`DGAUGE`, count | Number of ping packets sent |
| `ping.percent_packet_loss`<br/>`DGAUGE`, % | Percentage of ping packets lost |
| `ping.result_code`<br/>`DGAUGE`, `0`-`4` | Ping result code |
| `ping.standard_deviation_ms`<br/>`DGAUGE`, milliseconds | Ping response time standard deviation |
| `ping.ttl`<br/>`DGAUGE`, count | Ping TTL: Number of hops (typically routers) between network nodes a ping packet traverses |

## Service metrics {#managed-greenplum-metrics}
| Name<br/>Type, units | Description |
| ----- | ----- |
| `gp.conn_aborted`<br/>`DGAUGE`, count | Number of DB connections. The connection status is `aborted`. | 
| `gp.conn_active`<br/>`DGAUGE`, count | Number of DB connections. The connection status is `active`. | 
| `gp.conn_count`<br/>`DGAUGE`, count | Number of DB connections. | 
| `gp.conn_idle`<br/>`DGAUGE`, count | Number of DB connections. The connection status is `idle`. | 
| `gp.conn_idle_in_transaction`<br/>`DGAUGE`, count | Number of DB connections. The connection status is `idle_in_transaction`. | 
| `gp.conn_user_count`<br/>`DGAUGE`, count | Number of established user DB connections  |
| `gp.conn_waiting`<br/>`DGAUGE`, count | Number of pending DB connections | 
| `gp.connect_percent`<br/>`DGAUGE`, % | Percentage of connections | 
| `gp.has_alive`<br/>`DGAUGE` | Live segment indicator. It can be either `1` if all segments are healthy or `0` if there are no healthy segments.  |
| `gp.has_dead`<br/>`DGAUGE` | Dead segment indicator. It can be either `1` if there are failed segments or `0` if there are none.  |
| `gp.is_alive`<br/>`DGAUGE` | Host health indicator.<br/>It can be either `1` if a DB host is alive or `0` if it is not. | 
| `gp.is_alive_segment`<br/>`DGAUGE` | Segment host health indicator.<br/>It can be either `1` if a DB host is healthy or `0` if it is not. | 
| `gp.is_dead`<br/>`DGAUGE` | Host health indicator.<br/>It can be either `0` if a DB host is alive or `1` if it is not. | 
| `gp.is_master`<br/>`DGAUGE` | Host type indicator.<br/>It can be either `1` if it is a DB master host or `0` if it is not. | 
| `gp.master_replication_state`<br/>`DGAUGE` | Master replication state |
| `gp.percent_xid_wraparound`<br/>`DGAUGE`, % | Using a transaction ID sequence.<br/>Additional labels: `db_name`. | 
| `gp.ping`<br/>`DGAUGE` | <br/>Additional labels: `can_read`, `is_master`, and `can_write`.| 
| `gp.pxf_is_alive`<br/>`DGAUGE` | PXF extension availability indicator | 
| `gp.replication_lag_mb`<br/>`DGAUGE`, megabytes | Replication lag between master and mirror segments  |
| `gp.rg_cpu_used`<br/>`DGAUGE` | CPU allocation across resource groups.<br/>Additional labels: `resgroup`. | 
| `gp.rg_mem_available`<br/>`DGAUGE` | Available RAM allocation across resource groups.<br/>Additional labels: `resgroup`. | 
| `gp.rg_mem_used`<br/>`DGAUGE` | Used RAM allocation across resource groups.<br/>Additional labels: `resgroup`. | 
| `gp.seg_count`<br/>`DGAUGE`, count | Number of segments in the cluster | 
| `gp.seg_down`<br/>`DGAUGE` | Segments that are down. |
| `gp.seg_not_pref_role`<br/>`DGAUGE`, count | Number of segments running in a non-preferred role, i.e., master segments acting as mirrors and vice versa  |
| `gp.seg_not_synch`<br/>`DGAUGE` | Unsynced segments | 
| `gp.segment_conn_aborted`<br/>`DGAUGE`, count | Total segment connections aborted  |
| `gp.segment_conn_active`<br/>`DGAUGE`, count | Number of active segment connections  |
| `gp.segment_conn_count`<br/>`DGAUGE`, count | Total segment connections  |
| `gp.segment_conn_idle`<br/>`DGAUGE`, count | Number of idle segment connections  |
| `gp.segment_conn_idle_in_transaction`<br/>`DGAUGE`, count | Number of idle-in-transaction segment connections  |
| `gp.segment_conn_waiting`<br/>`DGAUGE`, count | Number of segment connections currently waiting for query execution  |
| `gp.spill_files_num_per_seghost`<br/>`DGAUGE`, count | Number of spill files per host |
| `gp.spill_files_size_per_seghost`<br/>`DGAUGE`, bytes | Size of spill files per host |

#### System metrics {#managed-greenplum-config-metrics}
| Name<br/>Type, units | Description |
| ----- | ----- |
| `system.load.avg_1min`<br/>`DGAUGE`, % | Average CPU load over one minute |
| `system.load.avg_5min`<br/>`DGAUGE`, % | Average CPU load over five minutes |
| `system.load.avg_15min`<br/>`DGAUGE`, % | Average CPU load over 15 minutes |
| `system.n_cpus`<br/>`DGAUGE`, count | Maximum number of cores in use |
| `system.n_users`<br/>`DGAUGE`, count | Limit on the number of users |
| `system.uptime`<br/>`DGAUGE`, % | Uptime percentage |

## Cluster expansion metrics {#managed-greenplum-expand-metrics}

These metrics enable monitoring the [cluster expansion](../../../managed-greenplum/concepts/expand.md) progress.

| Name<br/>Type, units | Description |
| ------------------------------ | -------- |
| `gp_expand.bytes_done`<br/>`DGAUGE`, %                | Percentage of redistributed data |
| `gp_expand.bytes_in_progress`<br/>`DGAUGE`, bytes     | Data size currently being redistributed |
| `gp_expand.bytes_left`<br/>`DGAUGE`, bytes            | Data size left to redistribute |
| `gp_expand.bytes_total`<br/>`DGAUGE`, bytes           | Total data size requiring redistribution |
| `gp_expand.in_progress`<br/>`DGAUGE`                  | Data redistribution activity indicator.<br/>It can be either`0` if redistribution is running or `1` if it is not. |
| `gp_expand.tables_done`<br/>`DGAUGE`, %               | Percentage of redistributed tables |
| `gp_expand.tables_in_progress`<br/>`DGAUGE`, count    | Number of tables currently being redistributed |
| `gp_expand.tables_left`<br/>`DGAUGE`, count           | Number of tables left to redistribute |
| `gp_expand.tables_total`<br/>`DGAUGE`, count          | Total number of tables requiring redistribution |

## PXF metrics {#managed-greenplum-pxf-metrics}

PXF labels all metrics it returns with the `application` label set to `pxf-service`.

Additional labels:

* `profile`: PXF profile name.
* `segment`: ID of the database segment processing a specific data chunk.
* `server`: Name of the server PXF works with to access data.
* `user`: Name of the user running the operation.

| Name<br/>Type, units | Description |
| ----- | ----- |
| `pxf.jvm_memory_committed_bytes`<br/>`DGAUGE`, bytes | Memory allocated by the operating system to the PXF JVM | 
| `pxf.jvm_memory_max_bytes`<br/>`DGAUGE`, bytes | Maximum available PXF JVM memory | 
| `pxf.jvm_memory_used_bytes`<br/>`DGAUGE`, bytes | PXF JVM memory used | 
| `pxf.jvm_threads_daemon_threads`<br/>`DGAUGE`, count | Number of PXF JVM daemon threads | 
| `pxf.jvm_threads_live_threads`<br/>`DGAUGE`, count | Number of active PXF JVM threads | 
| `pxf.jvm_threads_states_threads`<br/>`DGAUGE`, count | Number of PXF JVM threads in each state | 
| `pxf.log4j2_events_total`<br/>`DGAUGE`, count | Total number of Log4j2 events in PXF JVM | 
| `pxf.process_files_max_files`<br/>`DGAUGE`, count | Maximum number of files simultaneously open in PXF | 
| `pxf.process_files_open_files`<br/>`DGAUGE`, count | Current number of open files in PXF | 
| `pxf.pxf_bytes_receivced_total`<br/>`DGAUGE`, bytes | Number of bytes received by PXF | 
| `pxf.pxf_bytes_sent_total`<br/>`DGAUGE`, bytes | Number of bytes sent by PXF | 
| `pxf.pxf_fragments_sent`<br/>`DGAUGE`, count | Number of data fragments sent by PXF.<br/>Additional label: `outcome`. It can be either `success` if all fragment data is successfully sent or `error` if not. | 
| `pxf.pxf_records_receivced_total`<br/>`DGAUGE`, count | Number of records received by PXF | 
| `pxf.pxf_records_sent_total`<br/>`DGAUGE`, count | Number of records sent by PXF | 
| `pxf.tomcat_connections_config_max_connections`<br/>`DGAUGE`, count | Maximum number of connections in Tomcat PXF settings | 
| `pxf.tomcat_connections_current_connections`<br/>`DGAUGE`, count | Current number of connections in Tomcat PXF | 
| `pxf.tomcat_connections_keepalive_current_connections`<br/>`DGAUGE`, count | Current number of keepalive connections in Tomcat PXF | 
| `pxf.tomcat_threads_busy_threads`<br/>`DGAUGE`, count | Number of busy threads in Tomcat PXF | 
| `pxf.tomcat_threads_config_max_threads`<br/>`DGAUGE`, count | Maximum number of threads in Tomcat PXF settings | 
| `pxf.tomcat_threads_current_threads`<br/>`DGAUGE`, count | Current number of threads in Tomcat PXF | 

## SNMP metrics {#managed-greenplum-snmp-metrics}
| Name<br/>Type, units | Description |
| ----- | ----- |
| `snmp.icmpinaddrmaskreps`<br/>`DGAUGE`, count | Number of ICMP address mask reply messages received from the polled node (SNMP) |
| `snmp.icmpinaddrmasks`<br/>`DGAUGE`, count | Number of ICMP address mask request messages received (SNMP) |
| `snmp.icmpincsumerrors`<br/>`DGAUGE`, count | This value increases when a received ICMP packet has an invalid checksum (SNMP). |
| `snmp.icmpindestunreachs`<br/>`DGAUGE`, count | Number of ICMP destination unreachable messages received (SNMP) |
| `snmp.icmpinechoreps`<br/>`DGAUGE`, count | Number of ICMP echo reply messages received (SNMP) |
| `snmp.icmpinechos`<br/>`DGAUGE`, count | Number of ICMP echo request messages received (SNMP) |
| `snmp.icmpinerrors`<br/>`DGAUGE`, count | Number of bad ICMP packets received, excluding those with checksum errors (SNMP) |
| `snmp.icmpinmsgs`<br/>`DGAUGE`, count | Total ICMP messages received (SNMP) |
| `snmp.icmpinparmprobs`<br/>`DGAUGE`, count | Number of ICMP parameter problem messages received (SNMP) |
| `snmp.icmpinredirects`<br/>`DGAUGE`, count | Number of ICMP redirect messages received (SNMP) |
| `snmp.icmpinsrcquenchs`<br/>`DGAUGE`, count | Number of ICMP source quench messages received (SNMP) |
| `snmp.icmpintimeexcds`<br/>`DGAUGE`, count | Number of ICMP time exceeded messages received (SNMP) |
| `snmp.icmpintimestampreps`<br/>`DGAUGE`, count | Number of ICMP timestamp reply messages received (SNMP) |
| `snmp.icmpintimestamps`<br/>`DGAUGE`, count | Number of ICMP timestamp (request) messages received (SNMP) |
| `snmp.icmpmsgintype0`<br/>`DGAUGE`, count | Number of ICMP type 0 (echo reply) messages (SNMP) |
| `snmp.icmpmsgintype3`<br/>`DGAUGE`, count | Number of ICMP type 3 (destination unreachable) messages (SNMP) |
| `snmp.icmpmsgintype8`<br/>`DGAUGE`, count | Number of ICMP type 8 (echo request) messages (SNMP) |
| `snmp.icmpmsgouttype0`<br/>`DGAUGE`, count | Number of ICMP type 0 (echo reply) messages sent (SNMP) |
| `snmp.icmpmsgouttype3`<br/>`DGAUGE`, count | Number of ICMP type 3 (destination unreachable) messages sent (SNMP) |
| `snmp.icmpmsgouttype8`<br/>`DGAUGE`, count | Number of ICMP type 8 (echo request) messages sent (SNMP) |
| `snmp.icmpoutaddrmaskreps`<br/>`DGAUGE`, count | Number of ICMP address mask reply messages sent (SNMP) |
| `snmp.icmpoutaddrmasks`<br/>`DGAUGE`, count | Number of ICMP address mask request messages sent (SNMP) |
| `snmp.icmpoutdestunreachs`<br/>`DGAUGE`, count | Number of ICMP destination unreachable messages sent (SNMP) |
| `snmp.icmpoutechoreps`<br/>`DGAUGE`, count | Number of ICMP echo reply messages sent (SNMP) |
| `snmp.icmpoutechos`<br/>`DGAUGE`, count | Number of ICMP echo request messages sent (SNMP) |
| `snmp.icmpouterrors`<br/>`DGAUGE`, count | Number of ICMP messages not sent due to ICMP errors, such as buffer shortages (SNMP) |
| `snmp.icmpoutmsgs`<br/>`DGAUGE`, count | Total ICMP messages the object in question attempted to send. This includes all messages counted by `snmp.icmpouterrors` (SNMP). |
| `snmp.icmpoutparmprobs`<br/>`DGAUGE`, count | Number of ICMP parameter problem messages sent (SNMP) |
| `snmp.icmpoutredirects`<br/>`DGAUGE`, count | Number of ICMP redirect messages sent (SNMP) |
| `snmp.icmpoutsrcquenchs`<br/>`DGAUGE`, count | Number of ICMP source quench messages sent (SNMP) |
| `snmp.icmpouttimeexcds`<br/>`DGAUGE`, count | Number of ICMP time exceeded messages sent (SNMP) |
| `snmp.icmpouttimestampreps`<br/>`DGAUGE`, count | Number of ICMP timestamp reply messages sent (SNMP) |
| `snmp.icmpouttimestamps`<br/>`DGAUGE`, count | Number of ICMP timestamp messages sent (SNMP) |
| `snmp.ipdefaultttl`<br/>`DGAUGE`, count | Default TTL value inserted into the IP header for IP packets generated in this object when the transport layer protocol does not provide a TTL. |
| `snmp.ipforwarding`<br/>`DGAUGE` | IP forwarding status (SNMP): `0` for disabled, `1` for enabled. |
| `snmp.ipforwdatagrams`<br/>`DGAUGE`, count | Number of incoming packets not destined for the object in question, triggering an attempt to find a forwarding route to the final IP destination. For objects not acting as IP routers, this count includes only those packets that were source-routed through them and where the source route option was successfully processed (SNMP). |
| `snmp.ipfragcreates`<br/>`DGAUGE`, count | Number of IP packet fragments generated due to fragmentation in the object in question (SNMP) |
| `snmp.ipfragfails`<br/>`DGAUGE`, count | Number of IP packets dropped due to failed fragmentation which was required in this object, e.g., because of the `Do not fragment` flag being set (SNMP). |
| `snmp.ipfragoks`<br/>`DGAUGE`, count | Number of successfully fragmented IP packets (SNMP) |
| `snmp.ipinaddrerrors`<br/>`DGAUGE`, count | Number of inbound packets dropped due to an invalid destination IP address in the IP header for the object in question. This count includes invalid addresses, such as `0.0.0.0`, and addresses of unsupported classes, e.g., Class E. For objects that do not act as IP gateways and therefore do not forward packets, this counter includes packets dropped because the destination address was not a local one (SNMP). |
| `snmp.ipindelivers`<br/>`DGAUGE`, count | Total IP packets delivered (SNMP) |
| `snmp.ipindiscards`<br/>`DGAUGE`, count | Number of inbound IP packets encountering no issues preventing their further processing but still dropped, e.g., due to lack of buffer space. This counter does not include packets dropped while awaiting reassembly (SNMP). |
| `snmp.ipinhdrerrors`<br/>`DGAUGE`, count | Number of inbound packets with header errors (SNMP) |
| `snmp.ipinreceives`<br/>`DGAUGE`, count | Total inbound packets received from interfaces, including those received in error (SNMP) |
| `snmp.ipinunknownprotos`<br/>`DGAUGE`, count |Number of unknown protocol packets received (SNMP) |
| `snmp.ipoutdiscards`<br/>`DGAUGE`, count | Number of outgoing IP packets encountering no issues preventing their transmission to the destination but still dropped, e.g., due to lack of buffer space. Note that the counter would include packets counted in `snmp.ipforwdatagrams` if they met this (discretionary) drop criterion (SNMP). |
| `snmp.ipoutnoroutes`<br/>`DGAUGE`, count | Number of IP packets dropped because no route to their destination was found. This metric tracks all packets counted in `snmp.ipforwdatagrams` that meet this no-route criterion. This includes any packets a host cannot redirect because all its default gateways are down. |
| `snmp.ipoutrequests`<br/>`DGAUGE`, count | Total IP packets provided by local IP user-level protocols (including ICMP) to IP in requests for transmission. This metric does not include the packets counted in `snmp.ipforwdatagrams` (SNMP). |
| `snmp.ipreasmfails`<br/>`DGAUGE`, count | Number of failures detected by the IP reassembly algorithm due to reasons, such as timeouts, errors, etc. This is not necessarily a count of dropped IP fragments, since certain algorithms, like the one in RFC 815, may lose count of fragments while reassembling them as they are received (SNMP). |
| `snmp.ipreasmoks`<br/>`DGAUGE`, count | Number of IP packets successfully reassembled (SNMP) |
| `snmp.ipreasmreqds`<br/>`DGAUGE`, count | Number of received IP fragments requiring reassembly in the object in question (SNMP) |
| `snmp.ipreasmtimeout`<br/>`DGAUGE`, seconds | Maximum time, in seconds, received fragments are kept while awaiting reassembly in the object in question (SNMP). |
| `snmp.tcpactiveopens`<br/>`DGAUGE`, count | Number of times TCP connections have made a direct transition from the `CLOSED` state to `SYN-SENT` (SNMP). |
| `snmp.tcpattemptfails`<br/>`DGAUGE`, count | Number of times TCP connections have made a direct transition to the `CLOSED` state from either the `SYN-SENT` or `SYN-RCVD` state, plus the number of direct TCP connection transitions (SNMP). |
| `snmp.tcpcurrestab`<br/>`DGAUGE`, count | Current number of TCP connections for the `ESTABLISHED` or `CLOSE WAIT` state (SNMP) |
| `snmp.tcpestabresets`<br/>`DGAUGE`, count | Number of times TCP connections have made a direct transition to the `CLOSED` state from either the `ESTABLISHED` or `CLOSE-WAIT` state (SNMP). |
| `snmp.tcpincsumerrors`<br/>`DGAUGE`, count | This value increases when a received TCP packet has an invalid checksum (SNMP). |
| `snmp.tcpinerrs`<br/>`DGAUGE`, count | Total segments received with an error, such as invalid TCP checksums (SNMP) |
| `snmp.tcpinsegs`<br/>`DGAUGE`, count | Total segments received, including those received in error (SNMP) |
| `snmp.tcpmaxconn`<br/>`DGAUGE`, count | Maximum allowed number of TCP connections (SNMP) |
| `snmp.tcpoutrsts`<br/>`DGAUGE`, count | Number of TCP segments sent with the `RST` flag (SNMP) |
| `snmp.tcpoutsegs`<br/>`DGAUGE`, count | Number of outgoing TCP segments (SNMP) |
| `snmp.tcppassiveopens`<br/>`DGAUGE`, count | Number of times TCP connections have made a direct transition from the `LISTEN` state to `SYN-RCVD` (SNMP). |
| `snmp.tcpretranssegs`<br/>`DGAUGE`, count | Total segments retransmitted, i.e., number of TCP segments sent containing one or more previously transmitted octets (SNMP). |
| `snmp.tcprtoalgorithm`<br/>`DGAUGE` | Algorithm used to determine the timeout for retransmitting unacknowledged octets |
| `snmp.tcprtomax`<br/>`DGAUGE`, milliseconds | Maximum TCP retransmission timeout, in milliseconds (SNMP) |
| `snmp.tcprtomin`<br/>`DGAUGE`, milliseconds | Minimum TCP retransmission timeout, in milliseconds (SNMP) |
| `snmp.udpignoredmulti`<br/>`DGAUGE`, count | Number of UDP multicast packets ignored (SNMP) |
| `snmp.udpincsumerrors`<br/>`DGAUGE`, count | This value increases when a received UDP packet contains an invalid kernel code checksum (SNMP). |
| `snmp.udpindatagrams`<br/>`DGAUGE`, count | Total UDP packets received (SNMP) |
| `snmp.udpinerrors`<br/>`DGAUGE`, count | Number of bad UDP packets received, excluding those with checksum errors (SNMP) |
| `snmp.udpliteignoredmulti`<br/>`DGAUGE`, count | Number of UDP-Lite multicast packets ignored (SNMP) |
| `snmp.udpliteincsumerrors`<br/>`DGAUGE`, count | This value increases when a received UDP-Lite packet contains an invalid kernel code checksum (SNMP). |
| `snmp.udpliteindatagrams`<br/>`DGAUGE`, count | Total UDP-Lite packets received (SNMP) |
| `snmp.udpliteinerrors`<br/>`DGAUGE`, count | Total UDP-Lite packet receive errors (SNMP) |
| `snmp.udplitenoports`<br/>`DGAUGE`, count | Total UDP-Lite packets received without a listener on the destination port (SNMP) |
| `snmp.udpliteoutdatagrams`<br/>`DGAUGE`, count | Total UDP-Lite packets sent from the object in question (SNMP) |
| `snmp.udplitercvbuferrors`<br/>`DGAUGE`, count | This value increases when no memory can be allocated to handle an inbound UDP-Lite packet (SNMP). |
| `snmp.udplitesndbuferrors`<br/>`DGAUGE`, count | This value increases when no memory can be allocated to send an inbound UDP-Lite packet (SNMP). |
| `snmp.udpnoports`<br/>`DGAUGE`, count | Total UDP packets received without a listener on the destination port (SNMP) |
| `snmp.udpoutdatagrams`<br/>`DGAUGE`, count | Total UDP packets sent from the object in question (SNMP) |
| `snmp.udprcvbuferrors`<br/>`DGAUGE`, count | Number of UDP receive buffer errors (SNMP) |
| `snmp.udpsndbuferrors`<br/>`DGAUGE`, count | Number of UDP send buffer errors (SNMP) |
| `snmp6.icmp6incsumerrors`<br/>`DGAUGE`, count | This value increases when a received ICMPv6 packet contains an invalid kernel code checksum (SNMP). |
| `snmp6.icmp6indestunreachs`<br/>`DGAUGE`, count | Number of ICMPv6 destination unreachable messages received (SNMP) |
| `snmp6.icmp6inechoreplies`<br/>`DGAUGE`, count | Number of incoming replies to an ICMPv6 echo request (SNMP) |
| `snmp6.icmp6inechos`<br/>`DGAUGE`, count | Number of ICMPv6 echo request messages received (SNMP) |
| `snmp6.icmp6inerrors`<br/>`DGAUGE`, count | Number of bad ICMPv6 packets received, excluding those with checksum errors (SNMP) |
| `snmp6.icmp6ingroupmembqueries`<br/>`DGAUGE`, count | Number of ICMPv6 multicast listener queries (SNMP) |
| `snmp6.icmp6ingroupmembreductions`<br/>`DGAUGE`, count | Number of ICMPv6 multicast listener reductions (SNMP) |
| `snmp6.icmp6ingroupmembresponses`<br/>`DGAUGE`, count | Number of responses to ICMPv6 multicast listener queries (SNMP) |
| `snmp6.icmp6inmldv2reports`<br/>`DGAUGE`, count | Number of ICMPv6 MLDv2 reports (SNMP) |
| `snmp6.icmp6inmsgs`<br/>`DGAUGE`, count | Total ICMPv6 messages received (SNMP) |
| `snmp6.icmp6inneighboradvertisements`<br/>`DGAUGE`, count | Number of ICMPv6 neighbor advertisements (SNMP) |
| `snmp6.icmp6inneighborsolicits`<br/>`DGAUGE`, count | Number of ICMPv6 neighbor solicitations (SNMP) |
| `snmp6.icmp6inparmproblems`<br/>`DGAUGE`, count | Number of errors when receiving ICMPv6 parameter problem messages (SNMP) |
| `snmp6.icmp6inpkttoobigs`<br/>`DGAUGE`, count | Number of incoming ICMPv6 packet too big messages (SNMP) |
| `snmp6.icmp6inredirects`<br/>`DGAUGE`, count | Number of ICMPv6 redirect messages received (SNMP) |
| `snmp6.icmp6inrouteradvertisements`<br/>`DGAUGE`, count | Number of ICMPv6 router advertisements (SNMP) |
| `snmp6.icmp6inroutersolicits`<br/>`DGAUGE`, count | Number of ICMPv6 router solicitations (SNMP) |
| `snmp6.icmp6intimeexcds`<br/>`DGAUGE`, count | Number of ICMPv6 time exceeded messages received (SNMP) |
| `snmp6.icmp6intype1`<br/>`DGAUGE`, count | Number of incoming ICMPv6 type 1 (Destination unreachable) messages (SNMP) |
| `snmp6.icmp6intype128`<br/>`DGAUGE`, count | Number of incoming ICMPv6 type 128 (echo request) messages (SNMP) |
| `snmp6.icmp6intype134`<br/>`DGAUGE`, count | Number of incoming ICMPv6 type 134 (router solicitation) messages (SNMP) |
| `snmp6.icmp6intype135`<br/>`DGAUGE`, count | Number of incoming ICMPv6 type 135 (neighbor solicitation) messages (SNMP) |
| `snmp6.icmp6intype136`<br/>`DGAUGE`, count | Number of incoming ICMPv6 type 136 (neighbor advertisement) messages (SNMP) |
| `snmp6.icmp6outdestunreachs`<br/>`DGAUGE`, count | Number of outgoing ICMPv6 type 1 (destination unreachable) messages (SNMP) |
| `snmp6.icmp6outechoreplies`<br/>`DGAUGE`, count | Number of outgoing replies to an ICMPv6 echo request (SNMP) |
| `snmp6.icmp6outechos`<br/>`DGAUGE`, count | Number of ICMPv6 messages sent (SNMP) |
| `snmp6.icmp6outerrors`<br/>`DGAUGE`, count | Number of ICMPv6 messages not sent due to ICMP errors, such as buffer shortages (SNMP) |
| `snmp6.icmp6outgroupmembqueries`<br/>`DGAUGE`, count | Number of ICMPv6 multicast listener queries sent (SNMP) |
| `snmp6.icmp6outgroupmembreductions`<br/>`DGAUGE`, count | Number of ICMPv6 multicast listener reductions sent (SNMP) |
| `snmp6.icmp6outgroupmembresponses`<br/>`DGAUGE`, count | Number of sent responses to ICMPv6 multicast listener queries (SNMP) |
| `snmp6.icmp6outmldv2reports`<br/>`DGAUGE`, count | Number of ICMPv6 MLDv2 reports sent (SNMP) |
| `snmp6.icmp6outmsgs`<br/>`DGAUGE`, count | Total ICMPv6 messages the object in question attempted to send. This includes all messages counted by `snmp6.icmp6outerrors` (SNMP). |
| `snmp6.icmp6outneighboradvertisements`<br/>`DGAUGE`, count | Number of ICMPv6 neighbor advertisements sent (SNMP) |
| `snmp6.icmp6outneighborsolicits`<br/>`DGAUGE`, count | Number of ICMPv6 neighbor solicitations sent (SNMP) |
| `snmp6.icmp6outparmproblems`<br/>`DGAUGE`, count | Number of errors when sending ICMPv6 parameter problem messages (SNMP) |
| `snmp6.icmp6outpkttoobigs`<br/>`DGAUGE`, count | Number of errors when sending ICMPv6 packet too big messages (SNMP) |
| `snmp6.icmp6outredirects`<br/>`DGAUGE`, count | Number of ICMPv6 redirect route messages sent (SNMP) |
| `snmp6.icmp6outrouteradvertisements`<br/>`DGAUGE`, count | Number of ICMPv6 router advertisements sent (SNMP) |
| `snmp6.icmp6outroutersolicits`<br/>`DGAUGE`, count | Number of ICMPv6 router solicitations sent (SNMP) |
| `snmp6.icmp6outtimeexcds`<br/>`DGAUGE`, count | Number of ICMPv6 time exceeded messages sent (SNMP) |
| `snmp6.icmp6outtype1`<br/>`DGAUGE`, count | Number of ICMPv6 type 1 (destination unreachable) messages sent (SNMP) |
| `snmp6.icmp6outtype129`<br/>`DGAUGE`, count | Number of ICMPv6 type 129 messages sent (SNMP) |
| `snmp6.icmp6outtype133`<br/>`DGAUGE`, count | Number of ICMPv6 type 133 (router solicitation) messages sent (SNMP) |
| `snmp6.icmp6outtype135`<br/>`DGAUGE`, count | Number of ICMPv6 type 135 (neighbor solicitation) messages sent (SNMP) |
| `snmp6.icmp6outtype136`<br/>`DGAUGE`, count | Number of ICMPv6 type 136 (neighbor advertisement) messages sent (SNMP) |
| `snmp6.icmp6outtype143`<br/>`DGAUGE`, count | Number of ICMPv6 type 143 messages sent (SNMP) |
| `snmp6.ip6fragcreates`<br/>`DGAUGE`, count | Number of IPv6 packet fragments generated due to fragmentation in the object in question (SNMP) |
| `snmp6.ip6fragfails`<br/>`DGAUGE`, count | Number of IPv6 packets dropped due to failed fragmentation which was required in this object, e.g., because of the `Do not fragment` flag being set (SNMP). |
| `snmp6.ip6fragoks`<br/>`DGAUGE`, count | Number of successfully fragmented IPv6 packets (SNMP) |
| `snmp6.ip6inaddrerrors`<br/>`DGAUGE`, count | Number of inbound packets dropped due to an invalid destination IP address in the IPv6 header for the object in question. This count includes invalid addresses, such as `0.0.0.0`, and addresses of unsupported classes, e.g., Class E. For objects that do not act as IP gateways and therefore do not forward packets, this counter includes packets dropped because the destination address was not a local one (SNMP). |
| `snmp6.ip6inbcastoctets`<br/>`DGAUGE`, count | Total inbound broadcast octets received with IPv6 addresses (SNMP) |
| `snmp6.ip6incepkts`<br/>`DGAUGE`, count | Number of IPv6 packets received with detailed traffic information (SNMP) |
| `snmp6.ip6indelivers`<br/>`DGAUGE`, count | Total IPv6 packets delivered (SNMP) |
| `snmp6.ip6indiscards`<br/>`DGAUGE`, count | Number of inbound IPv6 packets encountering no issues preventing their further processing but still dropped, e.g., due to lack of buffer space. This counter does not include packets dropped while awaiting reassembly (SNMP). |
| `snmp6.ip6inect0pkts`<br/>`DGAUGE`, count | Number of received IPv6 packets of traffic class `0` (SNMP) |
| `snmp6.ip6inect1pkts`<br/>`DGAUGE`, count | Number of received IPv6 packets of traffic class `1` (SNMP) |
| `snmp6.ip6inhdrerrors`<br/>`DGAUGE`, count | Number of inbound packets with IPv6 header errors (SNMP) |
| `snmp6.ip6inmcastoctets`<br/>`DGAUGE`, count | Total inbound multicast octets received with IPv6 addresses and detailed traffic information (SNMP) |
| `snmp6.ip6inmcastpkts`<br/>`DGAUGE`, count | Total inbound multicast packets received with IPv6 addresses and detailed traffic information (SNMP) |
| `snmp6.ip6innoectpkts`<br/>`DGAUGE`, count | Number of IPv6 packets received with no traffic class (SNMP) |
| `snmp6.ip6innoroutes`<br/>`DGAUGE`, count | Number of inbound IPv6 packets dropped for lack of route (SNMP) |
| `snmp6.ip6inoctets`<br/>`DGAUGE`, count | Total inbound octets received with IPv6 addresses and detailed traffic information (SNMP) |
| `snmp6.ip6inreceives`<br/>`DGAUGE`, count | Total inbound IPv6 packets received from interfaces, including those received in error (SNMP) |
| `snmp6.ip6intoobigerrors`<br/>`DGAUGE`, count | Number of received IPv6 packets with a `Packet too big` error (SNMP) |
| `snmp6.ip6intruncatedpkts`<br/>`DGAUGE`, count | Number of outbound IPv6 packets dropped due to exceeding the sample size (SNMP) |
| `snmp6.ip6inunknownprotos`<br/>`DGAUGE`, count | Number of unknown protocol IPv6 packets received (SNMP) |
| `snmp6.ip6outbcastoctets`<br/>`DGAUGE`, count | Total external broadcast octets sent with IPv6 addresses and detailed traffic information (SNMP) |
| `snmp6.ip6outdiscards`<br/>`DGAUGE`, count | Number of outgoing IPv6 packets encountering no issues preventing their transmission to the destination but still dropped, e.g., due to lack of buffer space. |
| `snmp6.ip6outforwdatagrams`<br/>`DGAUGE`, count | Number of outbound IPv6 packets to transmit to the network (SNMP) |
| `snmp6.ip6outmcastoctets`<br/>`DGAUGE`, count | Total external multicast octets sent with IPv6 addresses and detailed traffic information (SNMP) |
| `snmp6.ip6outmcastpkts`<br/>`DGAUGE`, count | Total external multicast packets sent with IPv6 addresses and detailed traffic information (SNMP) |
| `snmp6.ip6outnoroutes`<br/>`DGAUGE`, count | Number of IPv6 packets dropped because no route to their destination was found (SNMP). |
| `snmp6.ip6outoctets`<br/>`DGAUGE`, count | Total external octets sent with IPv6 addresses and detailed traffic information (SNMP) |
| `snmp6.ip6outrequests`<br/>`DGAUGE`, count | Total IPv6 packets provided by local IPv6 user-level protocols (including ICMP) to IPv6 in requests for transmission (SNMP). |
| `snmp6.ip6reasmfails`<br/>`DGAUGE`, count | Number of failures detected by the IPv6 reassembly algorithm due to reasons, such as timeouts, errors, etc. This is not necessarily a count of dropped IPv6 fragments, since certain algorithms, like the one in RFC 815, may lose count of fragments while reassembling them as they are received (SNMP). |
| `snmp6.ip6reasmoks`<br/>`DGAUGE`, count | Number of IPv6 packets successfully reassembled (SNMP) |
| `snmp6.ip6reasmreqds`<br/>`DGAUGE`, count | Number of received IPv6 fragments requiring reassembly in the object in question (SNMP) |
| `snmp6.ip6reasmtimeout`<br/>`DGAUGE`, count | Maximum time, in seconds, received IPv6 fragments are kept while awaiting reassembly in the object in question (SNMP). |
| `snmp6.udp6ignoredmulti`<br/>`DGAUGE`, count | Number of multicast UDPv6 packets ignored (SNMP) |
| `snmp6.udp6incsumerrors`<br/>`DGAUGE`, count | This value increases when a received UDPv6 packet contains an invalid kernel code checksum (SNMP). |
| `snmp6.udp6indatagrams`<br/>`DGAUGE`, count | Total UDPv6 packets received (SNMP) |
| `snmp6.udp6inerrors`<br/>`DGAUGE`, count | Number of bad UDPv6 packets received, excluding those with checksum errors (SNMP) |
| `snmp6.udp6noports`<br/>`DGAUGE`, count | Total UDPv6 packets received with no application on the destination port (SNMP) |
| `snmp6.udp6outdatagrams`<br/>`DGAUGE`, count | Total UDPv6 packets sent from the object in question (SNMP) |
| `snmp6.udp6rcvbuferrors`<br/>`DGAUGE`, count | Number of UDPv6 receive buffer errors (SNMP) |
| `snmp6.udp6sndbuferrors`<br/>`DGAUGE`, count | Number of UDPv6 send buffer errors (SNMP) |
| `snmp6.udplite6incsumerrors`<br/>`DGAUGE`, count | This value increases when a received UDP-Litev6 packet contains an invalid kernel code checksum (SNMP). |
| `snmp6.udplite6indatagrams`<br/>`DGAUGE`, count | Total UDP-Litev6 packets received (SNMP) |
| `snmp6.udplite6inerrors`<br/>`DGAUGE`, count | Total UDP-Litev6 packet receive errors (SNMP) |
| `snmp6.udplite6noports`<br/>`DGAUGE`, count | Number of received UDP-Litev6 packets with no destination port found (SNMP) |
| `snmp6.udplite6outdatagrams`<br/>`DGAUGE`, count | Total UDP-Litev6 packets sent from the object in question (SNMP) |
| `snmp6.udplite6rcvbuferrors`<br/>`DGAUGE`, count | Number of UDP-Litev6 receive buffer errors (SNMP) |
| `snmp6.udplite6sndbuferrors`<br/>`DGAUGE`, count | Number of UDP-Litev6 send buffer errors (SNMP) |

## Other metrics {#managed-greenplum-other-metrics}
| Name<br/>Type, units | Description |
| ----- | ----- |
| `core_dump.count`<br/>`DGAUGE`, count | Number of core dumps |