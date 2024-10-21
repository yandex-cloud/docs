The metric name is written in the `name` label.

Common labels for all {{ mgp-name }} metrics:

Label | Value
----|----
service | Service ID: `managed-greenplum`
resource_type | Resource type: `cluster`
resource_id | Cluster name 
cid | Cluster ID
host | Host FQDN
fqdn | Host FQDN

## CPU metrics {#managed-greenplum-cpu-metrics}
Processor core workload.

| Name<br/>Type, units | Description |
| ----- | ----- |
| `cpu.cpu.fraction`<br/>`DGAUGE`, % | Guaranteed vCPU share |
| `cpu.cpu.guarantee`<br/>`DGAUGE`, number | Guaranteed number of cores |
| `cpu.cpu.limit`<br/>`DGAUGE`, number | Limit on CPU cores in use |
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
Additional labels: `device` for disk ID in the system.

| Name<br/>Type, units | Description |
| ----- | ----- |
| `disk.free`<br/>`DGAUGE`, bytes | Free space |
| `disk.inodes_free`<br/>`DGAUGE`, number | Number of free inodes |
| `disk.inodes_total`<br/>`DGAUGE`, number | Available inodes |
| `disk.inodes_used`<br/>`DGAUGE`, number | Number of inodes used |
| `disk.total`<br/>`DGAUGE`, bytes | Available space |
| `disk.used`<br/>`DGAUGE`, bytes | Used space |
| `disk.used_percent`<br/>`DGAUGE`, % | Percentage of used space |

## Disk operation metrics {#managed-greenplum-diskio-metrics}
Additional labels: `dev` for disk ID in the system.

| Name<br/>Type, units | Description |
| ----- | ----- |
| `diskio.io_time`<br/>`DGAUGE`, ms | Disk operation duration |
| `diskio.iops_in_progress`<br/>`DGAUGE`, number | Disk operations in progress |
| `diskio.merged_reads`<br/>`DGAUGE`, number | Number of merged disk reads |
| `diskio.merged_writes`<br/>`DGAUGE`, number | Number of merged disk writes |
| `diskio.read_bytes`<br/>`DGAUGE`, bytes | Bytes read from disk |
| `diskio.read_time`<br/>`DGAUGE`, ms | Disk read time |
| `diskio.reads`<br/>`DGAUGE`, number | Number of disk reads |
| `diskio.weighted_io_time`<br/>`DGAUGE`, ms | Waiting time for I/O operations |
| `diskio.write_bytes`<br/>`DGAUGE`, bytes | Bytes written to disk  |
| `diskio.write_time`<br/>`DGAUGE`, ms | Disk write time |
| `diskio.writes`<br/>`DGAUGE`, number | Number of disk writes |

## RAM metrics {#managed-greenplum-ram-metrics}
| Name<br/>Type, units | Description |
| ----- | ----- |
| `mem.active`<br/>`DGAUGE`, bytes | RAM usage, `active` usage type |
| `mem.available`<br/>`DGAUGE`, bytes | RAM usage, `available` usage type |
| `mem.available_percent`<br/>`DGAUGE`, % | Available RAM, % |
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
| `mem.used_percent`<br/>`DGAUGE`, % | Used RAM, % |
| `mem.vmalloc_chunk`<br/>`DGAUGE`, bytes | RAM usage, `vmalloc_chunk` usage type |
| `mem.vmalloc_total`<br/>`DGAUGE`, bytes | RAM usage, `vmalloc_total` usage type |
| `mem.vmalloc_used`<br/>`DGAUGE`, bytes | RAM usage, `vmalloc_used` usage type |
| `mem.write_back`<br/>`DGAUGE`, bytes | RAM usage, `write_back` usage type |
| `mem.write_back_tmp`<br/>`DGAUGE`, bytes | RAM usage, `write_back_tmp` usage type |

## Network metrics {#managed-greenplum-net-metrics}
| Name<br/>Type, units | Description |
| ----- | ----- |
| `net.bytes_recv`<br/>`DGAUGE`, bytes per second | Rate of receiving data over the network |
| `net.bytes_sent`<br/>`DGAUGE`, bytes per second | Rate of sending data over the network |
| `net.drop_in`<br/>`DGAUGE`, number | Packets dropped upon receipt |
| `net.drop_out`<br/>`DGAUGE`, number | Packets dropped when being sent |
| `net.err_in`<br/>`DGAUGE`, number | Number of errors upon receipt |
| `net.err_out`<br/>`DGAUGE`, number | Number of errors at sending |
| `net.packets_recv`<br/>`DGAUGE`, packets per second | Rate of receiving packets over the network |
| `net.packets_sent`<br/>`DGAUGE`, packets per second | Rate of sending packets over the network |
| `net.icmp_inaddrmaskreps`<br/>`DGAUGE`, number | Number of ICMP Address Mask Reply messages received from the interrogated node  |
| `net.icmp_inaddrmasks`<br/>`DGAUGE`, number | Number of ICMP Address Mask Request messages received  |
| `net.icmp_incsumerrors`<br/>`DGAUGE`, number | Total number of IP packets with checksum errors  |
| `net.icmp_indestunreachs`<br/>`DGAUGE`, number | Number of ICMP Destination Unreachable messages received  |
| `net.icmp_inechoreps`<br/>`DGAUGE`, number | Number of ICMP Echo Reply messages received  |
| `net.icmp_inechos`<br/>`DGAUGE`, number | Number of ICMP Echo (request) messages received  |
| `net.icmp_inerrors`<br/>`DGAUGE`, number | Number of bad ICMP packets received, excluding those with checksum errors  |
| `net.icmp_inmsgs`<br/>`DGAUGE`, number | Total number of ICMP messages received  |
| `net.icmp_inparmprobs`<br/>`DGAUGE`, number | Number of ICMP Parameter Problem messages received |
| `net.icmp_inredirects`<br/>`DGAUGE`, number | Number of ICMP redirect messages received  |
| `net.icmp_insrcquenchs`<br/>`DGAUGE`, number | Number of ICMP Source Quench messages received  |
| `net.icmp_intimeexcds`<br/>`DGAUGE`, number | Number of ICMP Time Exceeded messages received is greater than that of messages received  | 
| `net.icmp_intimestampreps`<br/>`DGAUGE`, number | Number of ICMP timestamp reply messages received  |
| `net.icmp_intimestamps`<br/>`DGAUGE`, number | Number of ICMP timestamp messages (requests) received  |
| `net.icmp_outaddrmaskreps`<br/>`DGAUGE`, number | Number of ICMP Address Mask Reply messages sent  |
| `net.icmp_outaddrmasks`<br/>`DGAUGE`, number | Number of ICMP Address Mask Request messages sent  |
| `net.icmp_outdestunreachs`<br/>`DGAUGE`, number | Number of ICMP Destination Unreachable messages sent  |
| `net.icmp_outechoreps`<br/>`DGAUGE`, number | Number of ICMP Echo Reply messages sent  |
| `net.icmp_outechos`<br/>`DGAUGE`, number | Number of ICMP Echo messages (requests) sent  |
| `net.icmp_outerrors`<br/>`DGAUGE`, number | Number of ICMP messages this object did not send due to problems discovered within ICMP, such as a lack of buffers  |
| `net.icmp_outmsgs`<br/>`DGAUGE`, number | Total number of ICMP messages which this object attempted to send. This includes all messages counted by `icmp_outerrors`.  | 
| `net.icmp_outparmprobs`<br/>`DGAUGE`, number | Number of ICMP Parameter Problem messages sent  |
| `net.icmp_outredirects`<br/>`DGAUGE`, number | Number of Redirect Route messages sent  |
| `net.icmp_outsrcquenchs`<br/>`DGAUGE`, number | Number of ICMP Source Quench messages sent  |
| `net.icmp_outtimeexcds`<br/>`DGAUGE`, number | Number of ICMP Time Exceeded messages sent is greater than that of messages sent  |
| `net.icmp_outtimestampreps`<br/>`DGAUGE`, number | Number of ICMP timestamp reply messages sent  |
| `net.icmp_outtimestamps`<br/>`DGAUGE`, number | Number of ICMP timestamp messages sent  |
| `net.icmpmsg_intype0`<br/>`DGAUGE`, number | Number of ICMP Type 0 (Echo Reply) messages received  |
| `net.icmpmsg_intype3`<br/>`DGAUGE`, number | Number of ICMP Type 3 (Destination Unreachable) messages received  |
| `net.icmpmsg_intype8`<br/>`DGAUGE`, number | Number of ICMP Type 8 (Echo Request) messages received  |
| `net.icmpmsg_outtype0`<br/>`DGAUGE`, number | Number of ICMP Type 0 (Echo Reply) messages sent  |
| `net.icmpmsg_outtype3`<br/>`DGAUGE`, number | Number of ICMP Type 3 (Destination Unreachable) messages sent  |
| `net.icmpmsg_outtype8`<br/>`DGAUGE`, number | Total number of ICMP Type 8 (Echo Request) messages sent  |
| `net.ip_defaultttl`<br/>`DGAUGE`, row | Default value inserted into the Time-To-Live field of the IP header of the IP packets created in this object, whenever a TTL value is not supplied by the transport layer protocol  |
| `net.ip_forwarding`<br/>`DGAUGE` | IP forwarding status (SNMP): `0` for disabled, `1` for enabled  |
| `net.ip_forwdatagrams`<br/>`DGAUGE`, number | Number of input packets for which this object was not their final IP destination resulting in an attempt to find a route to forward them to that final destination. In objects which do not act as IP Gateways, this counter will include only those packets that were source-routed through this object, and for which the source route parameter was processed successfully.  |
| `net.ip_fragcreates`<br/>`DGAUGE`, number | Number of IP packet fragments generated as a result of fragmentation in this object  |
| `net.ip_fragfails`<br/>`DGAUGE`, number | Number of IP packets dropped because they were subject to fragmenting in this object but could not be fragmented, e.g., due to the Do Not Fragment flag  |
| `net.ip_fragoks`<br/>`DGAUGE`, number | Number of successfully fragmented IP packets  |
| `net.ip_inaddrerrors`<br/>`DGAUGE`, number | Number of input packets dropped because the IP address in their IP header's destination field was not a valid address to be received in this object. This count includes invalid addresses, such as `0.0.0.0`, and addresses of unsupported classes, e.g., Class E. For objects that are not IP Gateways and, as such, do not forward packets, this counter includes packets dropped because the destination address was not a local one.  |
| `net.ip_indelivers`<br/>`DGAUGE`, number | Total number of IP packets delivered  |
| `net.ip_indiscards`<br/>`DGAUGE`, number | Number of input IP packets encountering no problems preventing their further processing but still dropped, e.g., for lack of buffer space. This counter does not include the packets dropped while awaiting reassembly.  |
| `net.ip_inhdrerrors`<br/>`DGAUGE`, number | Number of input packets with header errors  |
| `net.ip_inreceives`<br/>`DGAUGE`, number | Total number of input packets received from interfaces, including those received through error  |
| `net.ip_inunknownprotos`<br/>`DGAUGE`, number | Number of unknown protocol packets received  |
| `net.ip_outdiscards`<br/>`DGAUGE`, number | Number of output IP packets encountering no problems preventing transmission to their destination but still dropped, e.g., for lack of buffer space. Note that the counter would include packets counted in `ip_forwdatagrams` if they met this (discretionary) discard criterion. |
| `net.ip_outnoroutes`<br/>`DGAUGE`, number | Number of IP packets dropped because no route could be found to transmit them to their destination. This counter includes all the packets counted in `ip_forwdatagrams` that meet this no-route criterion. This includes any packets a host cannot redirect because all its default gateways are down.  |
| `net.ip_outrequests`<br/>`DGAUGE`, number | Total number of IP packets which local IP user protocols (including ICMP) supplied to IP in requests for transmission. This counter does not include the packets counted in `ip_forwdatagrams`.  |
| `net.ip_reasmfails`<br/>`DGAUGE`, number | Number of failures detected by the IP reassembly algorithm (for whatever reason: timed out, errors, etc.). This is not necessarily a count of dropped IP fragments since some algorithms (such as the algorithm in RFC 815) can lose track of the number of fragments, combining them as they are received.  |
| `net.ip_reasmoks`<br/>`DGAUGE`, number | Number of IP packets successfully reassembled  |
| `net.ip_reasmreqds`<br/>`DGAUGE`, number | Number of IP fragments received which needed to be reassembled in this object  |
| `net.ip_reasmtimeout`<br/>`DGAUGE`, seconds | Maximum time, in seconds, the received fragments are held while awaiting reassembly in this object  |
| `net.tcp_activeopens`<br/>`DGAUGE`, number | Number of times TCP connections have made a direct transition from the `CLOSED` state to `SYN-SENT`  |
| `net.tcp_attemptfails`<br/>`DGAUGE`, number | Number of times TCP connections have made a direct transition to the `CLOSED` state from either the `SYN-SENT` or `SYN-RCVD` state, plus the number of times TCP connections have made a direct transition  |
| `net.tcp_currestab`<br/>`DGAUGE`, number | Current number of TCP connections for the `ESTABLISHED` or `CLOSE WAIT` state  |
| `net.tcp_estabresets`<br/>`DGAUGE`, number | Number of times TCP connections have made a direct transition to the `CLOSED` state from either the `ESTABLISHED` or `CLOSE-WAIT` state  |
| `net.tcp_incsumerrors`<br/>`DGAUGE`, number | The value increases if a received TCP packet has an invalid checksum  |
| `net.tcp_inerrs`<br/>`DGAUGE`, number | Total number of segments received with an error, e.g., bad TCP checksums  |
| `net.tcp_insegs`<br/>`DGAUGE`, number | Total number of segments received, including those received through error  |
| `net.tcp_maxconn`<br/>`DGAUGE`, number | Maximum allowed number of TCP connections  |
| `net.tcp_outrsts`<br/>`DGAUGE`, number | Number of sent TCP segments containing the `RST` flag  |
| `net.tcp_outsegs`<br/>`DGAUGE`, number | Total number of TCP segments sent  |
| `net.tcp_passiveopens`<br/>`DGAUGE`, number | Number of times TCP connections have made a direct transition to the `SYN-RCVD` state from `LISTEN`  |
| `net.tcp_retranssegs`<br/>`DGAUGE`, number | Total number of segments retransmitted, i.e., the number of TCP segments transmitted containing one or more previously transmitted octets  |
| `net.tcp_rtoalgorithm`<br/>`DGAUGE` | Algorithm used to determine the timeout value used for retransmitting unacknowledged octets  |
| `net.tcp_rtomax`<br/>`DGAUGE`, ms | Maximum value permitted by a TCP implementation for the retransmission timeout, in milliseconds  |
| `net.tcp_rtomin`<br/>`DGAUGE`, ms | Minimum value permitted by a TCP implementation for the retransmission timeout, in milliseconds  |
| `net.udp_ignoredmulti`<br/>`DGAUGE`, number | Used for UDP multicast  |
| `net.udp_incsumerrors`<br/>`DGAUGE`, number | The value increases when a received UDP packet contains an invalid kernel code checksum  |
| `net.udp_indatagrams`<br/>`DGAUGE`, number | Total number of UDP packets received  |
| `net.udp_inerrors`<br/>`DGAUGE`, number | Number of bad UDP packets received, excluding those with checksum errors  |
| `net.udp_noports`<br/>`DGAUGE`, number | Total number of UDP packets received that had no application on the destination port  |
| `net.udp_outdatagrams`<br/>`DGAUGE`, number | Total number of outgoing UDP packets sent from this object  |
| `net.udp_rcvbuferrors`<br/>`DGAUGE`, number | Number of UDP receive buffer errors  |
| `net.udp_sndbuferrors`<br/>`DGAUGE`, number | Number of UDP send buffer errors  |
| `net.udplite_ignoredmulti`<br/>`DGAUGE`, number | Used for UDP Lite multicast  |
| `net.udplite_incsumerrors`<br/>`DGAUGE`, number | The value increases when a received UDP Lite packet contains an invalid kernel code checksum  |
| `net.udplite_indatagrams`<br/>`DGAUGE`, number | Total number of UDP Lite packets received  |
| `net.udplite_inerrors`<br/>`DGAUGE`, number | Total number of errors when receiving UDP Lite packets  |
| `net.udplite_noports`<br/>`DGAUGE`, number | Number of UDP Lite packets received for which no receiver port was found  |
| `net.udplite_outdatagrams`<br/>`DGAUGE`, number | Total number of UDP Lite packets sent  |
| `net.udplite_rcvbuferrors`<br/>`DGAUGE`, number | Number of UDP Lite receive buffer errors  |
| `net.udplite_sndbuferrors`<br/>`DGAUGE`, number | Number of UDP Lite send buffer errors  |
| `net_response.response_time`<br/>`DGAUGE`, ms | Network response time  |
| `net_response.result_code`<br/>`DGAUGE`, `0`-`10` | Network response result code  |
| `nstat.ipextinbcastoctets`<br/>`DGAUGE`, bytes | Total number of received input broadcast octets with IP addresses  |
| `nstat.ipextinbcastpkts`<br/>`DGAUGE`, number | Total number of received input broadcast packets with IP addresses  |
| `nstat.ipextincepkts`<br/>`DGAUGE`, number | Number of IP packets received containing detailed traffic information  |
| `nstat.ipextincsumerrors`<br/>`DGAUGE`, number | Number of input checksum errors containing IP addresses and detailed traffic information  |
| `nstat.ipextinect0pkts`<br/>`DGAUGE`, number | Number of input packets with IP addresses and detailed traffic information marked as ECN (Explicit Congestion Notification) `0`  |
| `nstat.ipextinect1pkts`<br/>`DGAUGE`, number | Number of input packets with IP addresses and detailed traffic information marked as ECN `1`  |
| `nstat.ipextinmcastoctets`<br/>`DGAUGE`, bytes | Total number of received input multicast octets containing IP addresses and detailed traffic information  |
| `nstat.ipextinmcastpkts`<br/>`DGAUGE`, number | Total number of received input multicast packets containing IP addresses and detailed traffic information  |
| `nstat.ipextinnoectpkts`<br/>`DGAUGE`, number | Number of received input packets with no valid ECN containing IP addresses and detailed traffic information  |
| `nstat.ipextinnoroutes`<br/>`DGAUGE`, number | Number of input packets discarded because no route could be found  |
| `nstat.ipextinoctets`<br/>`DGAUGE`, bytes | Total number of received input octets containing IP addresses and detailed traffic information  |
| `nstat.ipextintruncatedpkts`<br/>`DGAUGE`, number | Number of output packets deleted due to exceeded selection size  |
| `nstat.ipextoutbcastoctets`<br/>`DGAUGE`, bytes | Total number of external broadcast octets sent containing IP addresses and detailed traffic information  |
| `nstat.ipextoutbcastpkts`<br/>`DGAUGE`, number | Total number of external broadcast packets sent containing IP addresses and detailed traffic information  |
| `nstat.ipextoutmcastoctets`<br/>`DGAUGE`, bytes | Total number of sent outside multicast octets with IP addresses and detailed traffic information  |
| `nstat.ipextoutmcastpkts`<br/>`DGAUGE`, number | Total number of external multicast packets sent containing IP addresses and detailed traffic information  |
| `nstat.ipextoutoctets`<br/>`DGAUGE`, bytes | Total number of external octets sent containing IP addresses and detailed traffic information  |
| `nstat.ipextreasmoverlaps`<br/>`DGAUGE`, number | Number of overlapping fragments in defragmented IP packets  |
| `nstat.tcpextarpfilter`<br/>`DGAUGE`, number | Number of ARP-filtered packets in TCP  |
| `nstat.tcpextbusypollrxpackets`<br/>`DGAUGE`, number | Number of packets received through TCP busy polling  |
| `nstat.tcpextdelayedacklocked`<br/>`DGAUGE`, number | Number of TCP delayed acknowledgments (ACK) blocked  |
| `nstat.tcpextdelayedacklost`<br/>`DGAUGE`, number | Number of TCP delayed acknowledgments (ACK) lost  |
| `nstat.tcpextdelayedacks`<br/>`DGAUGE`, number | Number of TCP delayed acknowledgments (ACK)  |
| `nstat.tcpextembryonicrsts`<br/>`DGAUGE`, number | Number of embryonic TCP connections dropped  |
| `nstat.tcpextipreversepathfilter`<br/>`DGAUGE`, number | Number of packets filtered with TCP reverse IP path filtering  |
| `nstat.tcpextlistendrops`<br/>`DGAUGE`, number | Number of TCP listen mode connections dropped  |
| `nstat.tcpextlistenoverflows`<br/>`DGAUGE`, number | Number of TCP listen mode overflows  |
| `nstat.tcpextlockdroppedicmps`<br/>`DGAUGE`, number | Number of ICMP packets dropped because of depleted TCP blocking capacity  |
| `nstat.tcpextofopruned`<br/>`DGAUGE`, number | Number of processed TCP packets excluded from analysis because certain limits were exceeded  |
| `nstat.tcpextoutofwindowicmps`<br/>`DGAUGE`, number | Number of ICMP packets that were outside the TCP window and dropped  |
| `nstat.tcpextpawsactive`<br/>`DGAUGE`, number | Number of active TCP PAWS (Protection Against Wrapped Sequence numbers) timers  |
| `nstat.tcpextpawsestab`<br/>`DGAUGE`, number | Number of TCP PAWS (Protection Against Wrapped Sequence numbers) connections established  |
| `nstat.tcpextpfmemallocdrop`<br/>`DGAUGE`, number | Number of TCP packets dropped because of depleted memory allocation resources  |
| `nstat.tcpextprunecalled`<br/>`DGAUGE`, number | Number of calls to the TCP pruning (discard) function  |
| `nstat.tcpextrcvpruned`<br/>`DGAUGE`, number | Number of input TCP packets dropped from the receive queue due to receive buffer limits  |
| `nstat.tcpextsyncookiesfailed`<br/>`DGAUGE`, number | Number of TCP SYN cookies rejected  |
| `nstat.tcpextsyncookiesrecv`<br/>`DGAUGE`, number | Number of TCP SYN packets received using SYN cookies  |
| `nstat.tcpextsyncookiessent`<br/>`DGAUGE`, number | Number of TCP SYN packets sent using SYN cookies  |
| `nstat.tcpexttcpabortfailed`<br/>`DGAUGE`, number | Number of failed attempts to abort TCP connections  |
| `nstat.tcpexttcpabortonclose`<br/>`DGAUGE`, number | Number of TCP connections aborted when closing  |
| `nstat.tcpexttcpabortondata`<br/>`DGAUGE`, number | Number of TCP connections aborted when transmitting data  |
| `nstat.tcpexttcpabortonlinger`<br/>`DGAUGE`, number | Number of TCP connections aborted on linger  |
| `nstat.tcpexttcpabortonmemory`<br/>`DGAUGE`, number | Number of TCP connections aborted due to memory shortage  |
| `nstat.tcpexttcpabortontimeout`<br/>`DGAUGE`, number | Number of TCP connection timeouts  |
| `nstat.tcpexttcpackcompressed`<br/>`DGAUGE`, number | Number of compressed TCP ACK packets  |
| `nstat.tcpexttcpackskippedchallenge`<br/>`DGAUGE`, number | Number of TCP ACK packets skipped due to a Challenge ACK call  |
| `nstat.tcpexttcpackskippedfinwait2`<br/>`DGAUGE`, number | Number of TCP ACK packets skipped due to connections in the `FIN_WAIT2` state  |
| `nstat.tcpexttcpackskippedpaws`<br/>`DGAUGE`, number | Number of TCP ACK packets skipped due to connections in the `PAWS` state  |
| `nstat.tcpexttcpackskippedseq`<br/>`DGAUGE`, number | Number of TCP ACK packets skipped due to the wrong order of connections  |
| `nstat.tcpexttcpackskippedsynrecv`<br/>`DGAUGE`, number | Number of TCP ACK packets skipped due to connections in the `SYN_RECV` state  |
| `nstat.tcpexttcpackskippedtimewait`<br/>`DGAUGE`, number | Number of TCP ACK packets skipped due to connections in the `TIME_WAIT` state  |
| `nstat.tcpexttcpautocorking`<br/>`DGAUGE`, number | Number of TCP autocorking operations  |
| `nstat.tcpexttcpbacklogcoalesce`<br/>`DGAUGE`, number | Number of coalesced packets in the TCP backlog  |
| `nstat.tcpexttcpbacklogdrop`<br/>`DGAUGE`, number | Number of TCP connections dropped due to the backlog queue overflow  |
| `nstat.tcpexttcpchallengeack`<br/>`DGAUGE`, number | Number of TCP Challenge ACK packets  |
| `nstat.tcpexttcpdeferacceptdrop`<br/>`DGAUGE`, number | Number of TCP connections dropped on deferred accept  |
| `nstat.tcpexttcpdelivered`<br/>`DGAUGE`, number | Number of successfully delivered TCP packets  |
| `nstat.tcpexttcpdeliveredce`<br/>`DGAUGE`, number | Number of TCP packets delivered successfully including those with checksum errors corrected  |
| `nstat.tcpexttcpdsackignorednoundo`<br/>`DGAUGE`, number | Number of input TCP packets reporting duplicate data blocks that were not used on receipt  |
| `nstat.tcpexttcpdsackignoredold`<br/>`DGAUGE`, number | Number of input TCP packets reporting old data that was received  |
| `nstat.tcpexttcpdsackoforecv`<br/>`DGAUGE`, number | Number of output TCP packets reporting duplicate data blocks that were sent  |
| `nstat.tcpexttcpdsackofosent`<br/>`DGAUGE`, number | Number of input TCP packets reporting out-of-order data blocks that were received  |
| `nstat.tcpexttcpdsackoldsent`<br/>`DGAUGE`, number | Number of output TCP packets reporting out-of-order data blocks that were sent  |
| `nstat.tcpexttcpdsackrecv`<br/>`DGAUGE`, number | Number of output TCP packets reporting old data that was sent  |
| `nstat.tcpexttcpdsackundo`<br/>`DGAUGE`, number | Number of input TCP packets reporting out-of-order data blocks that were received  |
| `nstat.tcpexttcpfastopenactive`<br/>`DGAUGE`, number | Number of input TCP packets reporting undo data blocks that were received  |
| `nstat.tcpexttcpfastopenactivefail`<br/>`DGAUGE`, number | Number of failed attempts to activate TCP Fast Open  |
| `nstat.tcpexttcpfastopenblackhole`<br/>`DGAUGE`, number | Number of TCP Fast Open packets sent but not delivered, e.g., lost  |
| `nstat.tcpexttcpfastopencookiereqd`<br/>`DGAUGE`, number | Number of TCP Fast Open packets with cookie requests  |
| `nstat.tcpexttcpfastopenlistenoverflow`<br/>`DGAUGE`, number | Number of TCP Fast Open packets dropped when attempting to receive in the passive mode  |
| `nstat.tcpexttcpfastopenpassive`<br/>`DGAUGE`, number | Number of TCP Fast Open packets successfully received in the passive mode  |
| `nstat.tcpexttcpfastopenpassivealtkey`<br/>`DGAUGE`, number | Number of TCP Fast Open packets successfully received with an alternative key  |
| `nstat.tcpexttcpfastopenpassivefail`<br/>`DGAUGE`, number | Number of failed passive mode attempts to receive TCP Fast Open packets  |
| `nstat.tcpexttcpfastretrans`<br/>`DGAUGE`, number | Number of TCP Fast Retransmission packets  |
| `nstat.tcpexttcpfromzerowindowadv`<br/>`DGAUGE`, number | Number of zero window errors received for outgoing TCP packets  |
| `nstat.tcpexttcpfullundo`<br/>`DGAUGE`, number | Number of complete undo TCP operations  |
| `nstat.tcpexttcphpacks`<br/>`DGAUGE`, number | Number of TCP packets with `PUSH-ACK` (Pushed ACK) flags  |
| `nstat.tcpexttcphphits`<br/>`DGAUGE`, number | Number of TCP packets with `PUSH-ACK` flags and a successful hash match  |
| `nstat.tcpexttcphystartdelaycwnd`<br/>`DGAUGE`, number | Number of TCP connection late starts due to collection of data on delays between the sending and receiving of packets  |
| `nstat.tcpexttcphystartdelaydetect`<br/>`DGAUGE`, number | Number of TCP connection late starts detected  |
| `nstat.tcpexttcphystarttraincwnd`<br/>`DGAUGE`, number | Number of late starts during TCP connection training due to collection of data on packet send and receive delays  |
| `nstat.tcpexttcphystarttraindetect`<br/>`DGAUGE`, number | Number of late starts detected during TCP connection training  |
| `nstat.tcpexttcpkeepalive`<br/>`DGAUGE`, number | Number of keep-alive TCP checks  |
| `nstat.tcpexttcplossfailures`<br/>`DGAUGE`, number | Number of TCP transmission failures  |
| `nstat.tcpexttcplossproberecovery`<br/>`DGAUGE`, number | Number of recoveries performed after TCP transmission failures using the Loss Detection method  |
| `nstat.tcpexttcplossprobes`<br/>`DGAUGE`, number | Number of TCP packet loss probes  |
| `nstat.tcpexttcplossundo`<br/>`DGAUGE`, number | Number of undo operations upon loss of TCP packets  |
| `nstat.tcpexttcplostretransmit`<br/>`DGAUGE`, number | Number TCP packet retransmissions upon loss  |
| `nstat.tcpexttcpmd5failure`<br/>`DGAUGE`, number | Number of TCP MD5 authentication failures  |
| `nstat.tcpexttcpmd5notfound`<br/>`DGAUGE`, number | Number of TCP MD5 keys not found  |
| `nstat.tcpexttcpmd5unexpected`<br/>`DGAUGE`, number | Number of unexpected TCP MD5 authentication errors  |
| `nstat.tcpexttcpmemorypressures`<br/>`DGAUGE`, number | Number of failures due to TCP memory pressure  |
| `nstat.tcpexttcpmemorypressureschrono`<br/>`DGAUGE`, number | Number of failures due to TCP memory pressure, duration considered  |
| `nstat.tcpexttcpminttldrop`<br/>`DGAUGE`, number | Number of TCP connections aborted due to minimum TTL value  |
| `nstat.tcpexttcpmtupfail`<br/>`DGAUGE`, number | Number of failed TCP MTU adjustments  |
| `nstat.tcpexttcpmtupsuccess`<br/>`DGAUGE`, number | Number of successful TCP MTU adjustments  |
| `nstat.tcpexttcpofodrop`<br/>`DGAUGE`, number | Number of dropped out-of-order TCP packets  |
| `nstat.tcpexttcpofomerge`<br/>`DGAUGE`, number | Number of coalesced units ahead of TCP packets  |
| `nstat.tcpexttcpofoqueue`<br/>`DGAUGE`, number | Number of packets ahead of TCP packets in queue  |
| `nstat.tcpexttcporigdatasent`<br/>`DGAUGE`, number | Amount of TCP data forwarded to the destination  |
| `nstat.tcpexttcppartialundo`<br/>`DGAUGE`, number | Number of partial TCP undo operations  |
| `nstat.tcpexttcppureacks`<br/>`DGAUGE`, number | Number of packets with clean TCP ACKs  |
| `nstat.tcpexttcprcvcoalesce`<br/>`DGAUGE`, number | Number of incoming coalesced TCP packets received  |
| `nstat.tcpexttcprcvcollapsed`<br/>`DGAUGE`, number | Number of incoming coalesced TCP packets compressed  |
| `nstat.tcpexttcprcvqdrop`<br/>`DGAUGE`, number | Number of TCP packets dropped from the inbound queue  |
| `nstat.tcpexttcprenofailures`<br/>`DGAUGE`, number | Number of TCP RENO algorithm errors when resending packets  |
| `nstat.tcpexttcprenorecovery`<br/>`DGAUGE`, number | Number of successful recoveries from TCP RENO algorithm errors  |
| `nstat.tcpexttcprenorecoveryfail`<br/>`DGAUGE`, number | Number of failed recoveries from TCP RENO algorithm errors  |
| `nstat.tcpexttcprenoreorder`<br/>`DGAUGE`, number | Number of TCP packets reordered during recovery  |
| `nstat.tcpexttcpreqqfulldocookies`<br/>`DGAUGE`, number | Number of complete TCP RE-ACK cookie requests  |
| `nstat.tcpexttcpreqqfulldrop`<br/>`DGAUGE`, number | Number of complete TCP RE-ACK requests dropped  |
| `nstat.tcpexttcpretransfail`<br/>`DGAUGE`, number | Number of failed TCP packet retransmissions  |
| `nstat.tcpexttcpsackdiscard`<br/>`DGAUGE`, number | Number of dropped TCP SACK (Selective Acknowledgment) blocks  |
| `nstat.tcpexttcpsackfailures`<br/>`DGAUGE`, number | Number of TCP SACK block processing errors  |
| `nstat.tcpexttcpsackmerged`<br/>`DGAUGE`, number | Number of TCP SACK block merges  |
| `nstat.tcpexttcpsackrecovery`<br/>`DGAUGE`, number | Number of TCP SACK block recoveries  |
| `nstat.tcpexttcpsackrecoveryfail`<br/>`DGAUGE`, number | Number of failed TCP SACK block recoveries  |
| `nstat.tcpexttcpsackreneging`<br/>`DGAUGE`, number | Number of refused TCP SACK block recoveries  |
| `nstat.tcpexttcpsackreorder`<br/>`DGAUGE`, number | Number of TCP SACK block reorderings  |
| `nstat.tcpexttcpsackshifted`<br/>`DGAUGE`, number | Number of TCP SACK block shifts  |
| `nstat.tcpexttcpsackshiftfallback`<br/>`DGAUGE`, number | Number of TCP SACK block shift fallbacks  |
| `nstat.tcpexttcpslowstartretrans`<br/>`DGAUGE`, number | Number of TCP slow start retransmissions  |
| `nstat.tcpexttcpspuriousrtos`<br/>`DGAUGE`, number | Number of spurious TCP RTOs (Retransmission Time-Out)  |
| `nstat.tcpexttcpspuriousrtxhostqueues`<br/>`DGAUGE`, number | Number of spurious transmissions to the TCP host queue  |
| `nstat.tcpexttcpsynchallenge`<br/>`DGAUGE`, number | Number of TCP synchronization challenges  |
| `nstat.tcpexttcpsynretrans`<br/>`DGAUGE`, number | Number of retransmitted TCP synchronizations  |
| `nstat.tcpexttcptimeouts`<br/>`DGAUGE`, number | Number of TCP timeouts  |
| `nstat.tcpexttcptimewaitoverflow`<br/>`DGAUGE`, number | Number of TCP TIME_WAIT overflows  |
| `nstat.tcpexttcptozerowindowadv`<br/>`DGAUGE`, number | Number of TCP zero windows in the segment  |
| `nstat.tcpexttcptsreorder`<br/>`DGAUGE`, number | Number of TCP packet reorderings in the segment  |
| `nstat.tcpexttcpwantzerowindowadv`<br/>`DGAUGE`, number | Number of TCP zero windows in the segment  |
| `nstat.tcpexttcpwinprobe`<br/>`DGAUGE`, number | Number of TCP window probe segments  |
| `nstat.tcpexttcpwqueuetoobig`<br/>`DGAUGE`, number | Number of failures due to TCP output queue overflows  |
| `nstat.tcpexttcpzerowindowdrop`<br/>`DGAUGE`, number | Number of zero window segments dropped  |
| `nstat.tcpexttw`<br/>`DGAUGE`, number | Number of TCP sockets in the `TIME_WAIT` state  |
| `nstat.tcpexttwkilled`<br/>`DGAUGE`, number | Number of killed TCP sockets in the `TIME_WAIT` state  |
| `nstat.tcpexttwrecycled`<br/>`DGAUGE`, number | Number of recycled TCP sockets in the `TIME_WAIT` state  |
| `ping.average_response_ms`<br/>`DGAUGE`, ms | Average ping response time |
| `ping.maximum_response_ms`<br/>`DGAUGE`, ms | Maximum ping response time |
| `ping.minimum_response_ms`<br/>`DGAUGE`, ms | Minimum ping response time |
| `ping.packets_received`<br/>`DGAUGE`, number | Number of ping packets received |
| `ping.packets_transmitted`<br/>`DGAUGE`, number | Number of ping packets sent |
| `ping.percent_packet_loss`<br/>`DGAUGE`, % | Percentage of ping packets lost |
| `ping.result_code`<br/>`DGAUGE`, `0`-`4` | Ping result code |
| `ping.standard_deviation_ms`<br/>`DGAUGE`, ms | Standard ping response time deviation |
| `ping.ttl`<br/>`DGAUGE`, number | Ping TTL: Number of hops between network nodes (typically measured by the number of routers) a ping packet should traverse |

## Service metrics {#managed-greenplum-metrics}
| Name<br/>Type, units | Description |
| ----- | ----- |
| `gp.conn_aborted`<br/>`DGAUGE`, number | Number of DB connections. The connection status is `aborted`. |
| `gp.conn_active`<br/>`DGAUGE`, number | Number of DB connections. The connection status is `active`. |
| `gp.conn_count`<br/>`DGAUGE`, number | Number of DB connections. |
| `gp.conn_idle`<br/>`DGAUGE`, number | Number of DB connections. The connection status is `idle`. |
| `gp.conn_idle_in_transaction`<br/>`DGAUGE`, number | Number of DB connections. The connection status is `idle_in_transaction`. |
| `gp.conn_user_count`<br/>`DGAUGE`, number | Number of established user DB connections  |
| `gp.conn_waiting`<br/>`DGAUGE`, number | Number of pending DB connections | 
| `gp.connect_percent`<br/>`DGAUGE`, % | Percentage of connections |
| `gp.has_alive`<br/>`DGAUGE` | Healthy segment indicator. `1` if all segments function properly, `0` if there are no operational segments.  |
| `gp.has_dead`<br/>`DGAUGE` | Dead segment indicator. `1` if there are failed segments, `0` if there are none.  |
| `gp.is_alive`<br/>`DGAUGE` | Host health indicator.<br/>`1` if a DB host is alive, `0` if not. |
| `gp.is_alive_segment`<br/>`DGAUGE` | Segment host health indicator.<br/>`1` if a DB host is alive, `0` if not. |
| `gp.is_dead`<br/>`DGAUGE` | Host health indicator.<br/>`0` if a DB host is alive, `1` if not. |
| `gp.is_master`<br/>`DGAUGE` | Host type indicator.<br/>`1` if it is a DB master host, `0` if not. |
| `gp.master_replication_state`<br/>`DGAUGE` | Master replication state |
| `gp.percent_xid_wraparound`<br/>`DGAUGE`, % | Using a transaction ID sequence.<br/>Additional labels: `db_name` |
| `gp.ping`<br/>`DGAUGE` | <br/>Additional labels: `can_read`, `is_master`, and `can_write`|
| `gp.pxf_is_alive`<br/>`DGAUGE` | PXF extension availability indicator. |
| `gp.replication_lag_mb`<br/>`DGAUGE`, megabytes | Data replication lag between the primary and mirror segments  |
| `gp.rg_cpu_used`<br/>`DGAUGE` | CPU allocation between resource groups.<br/>Additional labels: `resgroup` |
| `gp.rg_mem_available`<br/>`DGAUGE` | Available RAM allocation between resource groups.<br/>Additional labels: `resgroup` |
| `gp.rg_mem_used`<br/>`DGAUGE` | Used RAM allocation across resource groups.<br/>Additional labels: `resgroup` |
| `gp.seg_count`<br/>`DGAUGE`, number | Number of segments in the cluster | 
| `gp.seg_down`<br/>`DGAUGE` | Segments that are down |
| `gp.seg_not_pref_role`<br/>`DGAUGE`, number | Number of segments not operating in their preferred roles (e.g., a primary segment is acting as a mirror segment or vice versa)  |
| `gp.seg_not_synch`<br/>`DGAUGE` | Unsynced segments |
| `gp.segment_conn_aborted`<br/>`DGAUGE`, number | Total number of segment connections aborted  |
| `gp.segment_conn_active`<br/>`DGAUGE`, number | Number of active connections with segments  |
| `gp.segment_conn_count`<br/>`DGAUGE`, number | Total number of connections with segments  |
| `gp.segment_conn_idle`<br/>`DGAUGE`, number | Number of idle connections with segments  |
| `gp.segment_conn_idle_in_transaction`<br/>`DGAUGE`, number | Number of idle connections with segments in transaction  |
| `gp.segment_conn_waiting`<br/>`DGAUGE`, number | Number of connections with segments waiting for request execution  |
| `gp.spill_files_num_per_seghost`<br/>`DGAUGE`, number | Number of temporary files per host |
| `gp.spill_files_size_per_seghost`<br/>`DGAUGE`, bytes | Size of temporary files per host |

#### System metrics {#managed-greenplum-config-metrics}
| Name<br/>Type, units | Description |
| ----- | ----- |
| `system.load.avg_1min`<br/>`DGAUGE`, % | Average CPU load over 1 minute |
| `system.load.avg_5min`<br/>`DGAUGE`, % | Average CPU load over 5 minutes |
| `system.load.avg_15min`<br/>`DGAUGE`, % | Average CPU load over 15 minutes |
| `system.n_cpus`<br/>`DGAUGE`, number | Limit on CPU cores in use |
| `system.n_users`<br/>`DGAUGE`, number | Limit on the number of users |
| `system.uptime`<br/>`DGAUGE`, % | Uptime percentage |

## Cluster expansion metrics {#managed-greenplum-expand-metrics}

These metrics enable monitoring the [cluster expansion](../../../managed-greenplum/concepts/expand.md) progress.

| Name<br/>Type, units | Description |
| ------------------------------ | -------- |
| `gp_expand.bytes_done`<br/>`DGAUGE`, %                | Data redistribution percentage |
| `gp_expand.bytes_in_progress`<br/>`DGAUGE`, bytes     | Data size currently being redistributed |
| `gp_expand.bytes_left`<br/>`DGAUGE`, bytes            | Data size left to redistribute |
| `gp_expand.bytes_total`<br/>`DGAUGE`, bytes           | Total data size requiring redistribution |
| `gp_expand.in_progress`<br/>`DGAUGE`                  | Data redistribution activity indicator.<br/>`0` if redistribution is running, `1` if it is not. |
| `gp_expand.tables_done`<br/>`DGAUGE`, %               | Table redistribution percentage |
| `gp_expand.tables_in_progress`<br/>`DGAUGE`, number    | Number of tables currently being redistributed |
| `gp_expand.tables_left`<br/>`DGAUGE`, number           | Number of tables left to redistribute |
| `gp_expand.tables_total`<br/>`DGAUGE`, number          | Total number of tables requiring redistribution |

## PXF metrics {#managed-greenplum-pxf-metrics}

PXF labels all metrics it returns with the `application` label set to `pxf-service`.

Additional labels:

* `profile`: PXF profile name.
* `segment`: ID of the database segment processing a specific data part.
* `server`: Name of the server PXF works with to access data.
* `user`: Name of the user running the operation.

| Name<br/>Type, units | Description |
| ----- | ----- |
| `pxf.jvm_memory_committed_bytes`<br/>`DGAUGE`, bytes | JVM PFX memory allocated by the OS |
| `pxf.jvm_memory_max_bytes`<br/>`DGAUGE`, bytes | Maximum available JVM PXF memory |
| `pxf.jvm_memory_used_bytes`<br/>`DGAUGE`, bytes | JVM PFX memory used |
| `pxf.jvm_threads_daemon_threads`<br/>`DGAUGE`, number | Number of JVM PXF daemon threads |
| `pxf.jvm_threads_live_threads`<br/>`DGAUGE`, number | Number of active JVM PXF threads |
| `pxf.jvm_threads_states_threads`<br/>`DGAUGE`, number | Number of JVM PXF threads in each state |
| `pxf.log4j2_events_total`<br/>`DGAUGE`, number | Total number of Log4j2 events in JVM PXF |
| `pxf.process_files_max_files`<br/>`DGAUGE`, number | Maximum number of simultaneously open files during the PXF process |
| `pxf.process_files_open_files`<br/>`DGAUGE`, number | Current number of open files during the PXF process |
| `pxf.pxf_bytes_receivced_total`<br/>`DGAUGE`, bytes | Number of bytes received by PXF |
| `pxf.pxf_bytes_sent_total`<br/>`DGAUGE`, bytes | Number of bytes sent by PXF |
| `pxf.pxf_fragments_sent`<br/>`DGAUGE`, number | Number of data fragments sent by PXF.<br/>Additional label: `outcome`. It takes the `success` value if all fragment data is successfully sent, and the `error` value, if not. |
| `pxf.pxf_records_receivced_total`<br/>`DGAUGE`, number | Number of records received by PXF |
| `pxf.pxf_records_sent_total`<br/>`DGAUGE`, number | Number of records sent by PXF |
| `pxf.tomcat_connections_config_max_connections`<br/>`DGAUGE`, number | Maximum number of connections in Tomcat PXF settings |
| `pxf.tomcat_connections_current_connections`<br/>`DGAUGE`, number | Current number of connections in Tomcat PXF |
| `pxf.tomcat_connections_keepalive_current_connections`<br/>`DGAUGE`, number | Current number of keepalive connections in Tomcat PXF |
| `pxf.tomcat_threads_busy_threads`<br/>`DGAUGE`, number | Number of busy threads in Tomcat PXF |
| `pxf.tomcat_threads_config_max_threads`<br/>`DGAUGE`, number | Maximum number of threads in Tomcat PXF settings |
| `pxf.tomcat_threads_current_threads`<br/>`DGAUGE`, number | Current number of threads in Tomcat PXF |

## SNMP metrics {#managed-greenplum-snmp-metrics}
| Name<br/>Type, units | Description |
| ----- | ----- |
| `snmp.icmpinaddrmaskreps`<br/>`DGAUGE`, number | Number of ICMP Address Mask Reply messages received from the interrogated node (SNMP) |
| `snmp.icmpinaddrmasks`<br/>`DGAUGE`, number | Number of ICMP Address Mask Request messages received (SNMP) |
| `snmp.icmpincsumerrors`<br/>`DGAUGE`, number | The value increases if a received ICMP packet has an invalid checksum (SNMP) |
| `snmp.icmpindestunreachs`<br/>`DGAUGE`, number | Number of ICMP Destination Unreachable messages received (SNMP) |
| `snmp.icmpinechoreps`<br/>`DGAUGE`, number | Number of ICMP Echo Reply messages received (SNMP) |
| `snmp.icmpinechos`<br/>`DGAUGE`, number | Number of ICMP Echo messages (requests) received (SNMP) |
| `snmp.icmpinerrors`<br/>`DGAUGE`, number | Number of bad ICMP packets received, excluding those with checksum errors (SNMP) |
| `snmp.icmpinmsgs`<br/>`DGAUGE`, number | Total number of ICMP messages received (SNMP) |
| `snmp.icmpinparmprobs`<br/>`DGAUGE`, number | Number of ICMP Parameter Problem messages received (SNMP) |
| `snmp.icmpinredirects`<br/>`DGAUGE`, number | Number of ICMP redirect messages received (SNMP) |
| `snmp.icmpinsrcquenchs`<br/>`DGAUGE`, number | Number of ICMP Source Quench messages received (SNMP) |
| `snmp.icmpintimeexcds`<br/>`DGAUGE`, number | Number of ICMP Time Exceeded messages received is greater than that of messages received (SNMP) |
| `snmp.icmpintimestampreps`<br/>`DGAUGE`, number | Number of ICMP timestamp reply messages received (SNMP) |
| `snmp.icmpintimestamps`<br/>`DGAUGE`, number | Number of ICMP timestamp messages (requests) received (SNMP) |
| `snmp.icmpmsgintype0`<br/>`DGAUGE`, number | Number of ICMP Type 0 (Echo Reply) messages (SNMP) |
| `snmp.icmpmsgintype3`<br/>`DGAUGE`, number | Number of ICMP Type 3 (Destination Unreachable) messages (SNMP) |
| `snmp.icmpmsgintype8`<br/>`DGAUGE`, number | Number of ICMP Type 8 (Echo Request) messages (SNMP) |
| `snmp.icmpmsgouttype0`<br/>`DGAUGE`, number | Number of ICMP Type 0 (Echo Reply) messages sent (SNMP) |
| `snmp.icmpmsgouttype3`<br/>`DGAUGE`, number | Number of ICMP Type 3 (Destination Unreachable) messages sent (SNMP) |
| `snmp.icmpmsgouttype8`<br/>`DGAUGE`, number | Number of ICMP Type 8 (Echo Request) messages sent (SNMP) |
| `snmp.icmpoutaddrmaskreps`<br/>`DGAUGE`, number | Number of ICMP Address Mask Reply messages sent (SNMP) |
| `snmp.icmpoutaddrmasks`<br/>`DGAUGE`, number | Number of ICMP Address Mask Request messages sent (SNMP) |
| `snmp.icmpoutdestunreachs`<br/>`DGAUGE`, number | Number of ICMP Destination Unreachable messages sent (SNMP) |
| `snmp.icmpoutechoreps`<br/>`DGAUGE`, number | Number of ICMP Echo Reply messages sent (SNMP) |
| `snmp.icmpoutechos`<br/>`DGAUGE`, number | Number of ICMP Echo (messages (requests) sent (SNMP) |
| `snmp.icmpouterrors`<br/>`DGAUGE`, number | Number of ICMP messages this object did not send due to problems discovered within ICMP, such as a lack of buffers (SNMP) |
| `snmp.icmpoutmsgs`<br/>`DGAUGE`, number | Total number of ICMP messages which this object attempted to send. This includes all messages counted by `snmp.icmpouterrors` (SNMP). |
| `snmp.icmpoutparmprobs`<br/>`DGAUGE`, number | Number of ICMP Parameter Problem messages sent (SNMP) |
| `snmp.icmpoutredirects`<br/>`DGAUGE`, number | Number of Redirect Route messages sent (SNMP) |
| `snmp.icmpoutsrcquenchs`<br/>`DGAUGE`, number | Number of ICMP Source Quench messages sent (SNMP) |
| `snmp.icmpouttimeexcds`<br/>`DGAUGE`, number | Number of ICMP Time Exceeded messages sent is greater than that of messages sent (SNMP) |
| `snmp.icmpouttimestampreps`<br/>`DGAUGE`, number | Number of ICMP timestamp reply messages sent (SNMP) |
| `snmp.icmpouttimestamps`<br/>`DGAUGE`, number | Number of ICMP timestamp messages sent (SNMP) |
| `snmp.ipdefaultttl`<br/>`DGAUGE`, number | Default value inserted into the Time-To-Live field of the IP header of the IP packets created in this object, whenever a TTL value is not supplied by the transport layer protocol |
| `snmp.ipforwarding`<br/>`DGAUGE` | IP forwarding status (SNMP): `0` for disabled, `1` for enabled |
| `snmp.ipforwdatagrams`<br/>`DGAUGE`, number | Number of input packets for which this object was not their final IP destination resulting in an attempt to find a route to forward them to that final destination. In objects which do not act as IP Gateways, this counter will include only those packets that were source-routed through this object, and for which the source route parameter was processed successfully (SNMP). |
| `snmp.ipfragcreates`<br/>`DGAUGE`, number | Number of IP packet fragments generated as a result of fragmentation in this object (SNMP) |
| `snmp.ipfragfails`<br/>`DGAUGE`, number | Number of IP packets dropped because they were subject to fragmenting in this object but could not be fragmented, e.g., due to the Do Not Fragment flag (SNMP) |
| `snmp.ipfragoks`<br/>`DGAUGE`, number | Number of successfully fragmented IP packets (SNMP) |
| `snmp.ipinaddrerrors`<br/>`DGAUGE`, number | Number of input packets dropped because the IP address in their IP header's destination field was not a valid address to be received in this object. This count includes invalid addresses, such as `0.0.0.0`, and addresses of unsupported classes, e.g., Class E. For objects that are not IP Gateways and, as such, do not forward packets, this counter includes packets dropped because the destination address was not a local one (SNMP). |
| `snmp.ipindelivers`<br/>`DGAUGE`, number | Total number of IP packets delivered (SNMP) |
| `snmp.ipindiscards`<br/>`DGAUGE`, number | Number of input IP packets encountering no problems preventing their further processing but still dropped, e.g., for lack of buffer space. This counter does not include the packets dropped while awaiting reassembly (SNMP). |
| `snmp.ipinhdrerrors`<br/>`DGAUGE`, number | Number of input packets with header errors (SNMP) |
| `snmp.ipinreceives`<br/>`DGAUGE`, number | Total number of input packets received from interfaces, including those received through error (SNMP) |
| `snmp.ipinunknownprotos`<br/>`DGAUGE`, number |Number of unknown protocol packets received (SNMP) |
| `snmp.ipoutdiscards`<br/>`DGAUGE`, number | Number of output IP packets encountering no problems preventing transmission to their destination but still dropped, e.g., for lack of buffer space. Note that the counter would include packets counted in `snmp.ipforwdatagrams` if they met this (discretionary) discard criterion (SNMP). |
| `snmp.ipoutnoroutes`<br/>`DGAUGE`, number | Number of IP packets dropped because no route could be found to transmit them to their destination. This counter includes all the packets counted in `snmp.ipforwdatagrams` that meet this no-route criterion. This includes any packets a host cannot redirect because all its default gateways are down. |
| `snmp.ipoutrequests`<br/>`DGAUGE`, number | Total number of IP packets which local IP user protocols (including ICMP) supplied to IP in requests for transmission. This counter does not include the packets counted in `snmp.ipforwdatagrams` (SNMP). |
| `snmp.ipreasmfails`<br/>`DGAUGE`, number | Number of failures detected by the IP reassembly algorithm (for whatever reason: timed out, errors, etc.). This is not necessarily a count of dropped IP fragments, as some algorithms (such as the one in RFC 815) can lose track of the number of fragments, combining them as they are received (SNMP). |
| `snmp.ipreasmoks`<br/>`DGAUGE`, number | Number of IP packets successfully reassembled (SNMP) |
| `snmp.ipreasmreqds`<br/>`DGAUGE`, number | Number of IP fragments received that were to be reassembled in this object (SNMP) |
| `snmp.ipreasmtimeout`<br/>`DGAUGE`, seconds | Maximum time, in seconds, the received fragments are held while awaiting reassembly in this object (SNMP) |
| `snmp.tcpactiveopens`<br/>`DGAUGE`, number | Number of times TCP connections have made a direct transition from the `CLOSED` state to `SYN-SENT` (SNMP) |
| `snmp.tcpattemptfails`<br/>`DGAUGE`, number | Number of times TCP connections have made a direct transition to the `CLOSED` state from either the `SYN-SENT` or `SYN-RCVD` state, plus the number of times TCP connections have made a direct transition (SNMP) |
| `snmp.tcpcurrestab`<br/>`DGAUGE`, number | Current number of TCP connections for the `ESTABLISHED` or `CLOSE WAIT` state (SNMP) |
| `snmp.tcpestabresets`<br/>`DGAUGE`, number | Number of times TCP connections have made a direct transition to the `CLOSED` state from either the `ESTABLISHED` or `CLOSE-WAIT` state (SNMP) |
| `snmp.tcpincsumerrors`<br/>`DGAUGE`, number | The value increases if a received TCP packet has an invalid checksum (SNMP) |
| `snmp.tcpinerrs`<br/>`DGAUGE`, number | Total number of segments received with an error, e.g., bad TCP checksums (SNMP) |
| `snmp.tcpinsegs`<br/>`DGAUGE`, number | Total number of segments received, including those received through error (SNMP) |
| `snmp.tcpmaxconn`<br/>`DGAUGE`, number | Maximum TCP connections allowed (SNMP) |
| `snmp.tcpoutrsts`<br/>`DGAUGE`, number | Number of sent TCP segments containing the `RST` flag (SNMP) |
| `snmp.tcpoutsegs`<br/>`DGAUGE`, number | Number of outgoing TCP segments (SNMP) |
| `snmp.tcppassiveopens`<br/>`DGAUGE`, number | Number of times TCP connections have made a direct transition to the `SYN-RCVD` state from `LISTEN` (SNMP) |
| `snmp.tcpretranssegs`<br/>`DGAUGE`, number | Total number of segments retransmitted, i.e., the number of TCP segments transmitted containing one or more previously transmitted octets (SNMP) |
| `snmp.tcprtoalgorithm`<br/>`DGAUGE` | Algorithm used to determine the timeout value used for retransmitting unacknowledged octets |
| `snmp.tcprtomax`<br/>`DGAUGE`, ms | Maximum value permitted by a TCP implementation for the retransmission timeout, in milliseconds (SNMP) |
| `snmp.tcprtomin`<br/>`DGAUGE`, ms | Minimum value permitted by a TCP implementation for the retransmission timeout, in milliseconds (SNMP) |
| `snmp.udpignoredmulti`<br/>`DGAUGE`, number | Used for UDP multicast (SNMP) |
| `snmp.udpincsumerrors`<br/>`DGAUGE`, number | The value increases when a received UDP packet contains an invalid kernel code checksum (SNMP) |
| `snmp.udpindatagrams`<br/>`DGAUGE`, number | Total number of UDP packets received (SNMP) |
| `snmp.udpinerrors`<br/>`DGAUGE`, number | Number of bad UDP packets received, excluding those with checksum errors (SNMP) |
| `snmp.udpliteignoredmulti`<br/>`DGAUGE`, number | Used for UDP Lite multicast (SNMP) |
| `snmp.udpliteincsumerrors`<br/>`DGAUGE`, number | The value increases when a received UDP Lite packet contains an invalid kernel code checksum (SNMP) |
| `snmp.udpliteindatagrams`<br/>`DGAUGE`, number | Total number of UDP Lite packets received (SNMP) |
| `snmp.udpliteinerrors`<br/>`DGAUGE`, number | Total number of errors when receiving UDP Lite packets (SNMP) |
| `snmp.udplitenoports`<br/>`DGAUGE`, number | Total number of UDP Lite packets received that had no listener on the destination port (SNMP) |
| `snmp.udpliteoutdatagrams`<br/>`DGAUGE`, number | Total number of outgoing UDP Lite packets sent from this object (SNMP) |
| `snmp.udplitercvbuferrors`<br/>`DGAUGE`, number | The value increases when no memory can be allocated to handle an incoming UDP Lite packet (SNMP). |
| `snmp.udplitesndbuferrors`<br/>`DGAUGE`, number | The value increases when no memory can be allocated to send a UDP Lite packet (number). |
| `snmp.udpnoports`<br/>`DGAUGE`, number | Total number of UDP Lite packets received that had no listener on the destination port (SNMP) |
| `snmp.udpoutdatagrams`<br/>`DGAUGE`, number | Total number of outgoing UDP packets sent from this object (SNMP) |
| `snmp.udprcvbuferrors`<br/>`DGAUGE`, number | Number of UDP Lite receive buffer errors (SNMP) |
| `snmp.udpsndbuferrors`<br/>`DGAUGE`, number | Number of UDP send buffer errors (SNMP) |
| `snmp6.icmp6incsumerrors`<br/>`DGAUGE`, number | The value increases when a received ICMPv6 packet contains an invalid kernel code checksum (SNMP). |
| `snmp6.icmp6indestunreachs`<br/>`DGAUGE`, number | Number of ICMPv6 Destination Unreachable messages received (SNMP) |
| `snmp6.icmp6inechoreplies`<br/>`DGAUGE`, number | Number of incoming replies to an ICMPv6 Echo Request (SNMP) |
| `snmp6.icmp6inechos`<br/>`DGAUGE`, number | Number of ICMPv6 Echo messages (requests) received (SNMP) |
| `snmp6.icmp6inerrors`<br/>`DGAUGE`, number | Number of bad ICMPv6 packets received, excluding those with checksum errors (SNMP) |
| `snmp6.icmp6ingroupmembqueries`<br/>`DGAUGE`, number | Number of ICMPv6 Multicast Listener queries (SNMP) |
| `snmp6.icmp6ingroupmembreductions`<br/>`DGAUGE`, number | Number of ICMPv6 Multicast Listener reductions (SNMP) |
| `snmp6.icmp6ingroupmembresponses`<br/>`DGAUGE`, number | Number of responses to ICMPv6 Multicast Listener queries (SNMP) |
| `snmp6.icmp6inmldv2reports`<br/>`DGAUGE`, number | Number of MLDv2 ICMPv6 reports (SNMP) |
| `snmp6.icmp6inmsgs`<br/>`DGAUGE`, number | Total number of ICMPv6 messages received (SNMP) |
| `snmp6.icmp6inneighboradvertisements`<br/>`DGAUGE`, number | Number of ICMPv6 Neighbor Advertisements (SNMP) |
| `snmp6.icmp6inneighborsolicits`<br/>`DGAUGE`, number | Number of ICMPv6 Neighbor Solicitation requests (SNMP) |
| `snmp6.icmp6inparmproblems`<br/>`DGAUGE`, number | Number of errors when receiving ICMPv6 Parameter Problem messages (SNMP) |
| `snmp6.icmp6inpkttoobigs`<br/>`DGAUGE`, number | Number of incoming ICMPv6 Packet Too Big messages (SNMP) |
| `snmp6.icmp6inredirects`<br/>`DGAUGE`, number | Number of ICMPv6 Redirect messages received (SNMP) |
| `snmp6.icmp6inrouteradvertisements`<br/>`DGAUGE`, number | Number of ICMPv6 Router Advertisements (SNMP) |
| `snmp6.icmp6inroutersolicits`<br/>`DGAUGE`, number | Number of ICMPv6 Router Solicitation requests (SNMP) |
| `snmp6.icmp6intimeexcds`<br/>`DGAUGE`, number | Number of ICMPv6 Time Exceeded messages received is greater than that of messages received (SNMP) |
| `snmp6.icmp6intype1`<br/>`DGAUGE`, number | Number of incoming ICMPv6 Type 1 (Destination Unreachable) messages (SNMP) |
| `snmp6.icmp6intype128`<br/>`DGAUGE`, number | Number of incoming ICMPv6 Type 128 (Echo Request) messages (SNMP) |
| `snmp6.icmp6intype134`<br/>`DGAUGE`, number | Number of incoming ICMPv6 Type 134 (Router Solicitation) messages (SNMP) |
| `snmp6.icmp6intype135`<br/>`DGAUGE`, number | Number of incoming ICMPv6 Type 135 (Neighbor Solicitation) messages (SNMP) |
| `snmp6.icmp6intype136`<br/>`DGAUGE`, number | Number of incoming ICMPv6 Type 136 (Neighbor Advertisement) messages (SNMP) |
| `snmp6.icmp6outdestunreachs`<br/>`DGAUGE`, number | Number of outgoing ICMPv6 Type 1 (Destination Unreachable) messages (SNMP) |
| `snmp6.icmp6outechoreplies`<br/>`DGAUGE`, number | Number of outgoing replies to an ICMPv6 Echo Request (SNMP) |
| `snmp6.icmp6outechos`<br/>`DGAUGE`, number | Number of ICMPv6 messages sent (SNMP) |
| `snmp6.icmp6outerrors`<br/>`DGAUGE`, number | Number of ICMPv6 messages this object did not send due to problems discovered within ICMPv6, such as a lack of buffers (SNMP) |
| `snmp6.icmp6outgroupmembqueries`<br/>`DGAUGE`, number | Number of ICMPv6 Multicast Listener queries sent (SNMP) |
| `snmp6.icmp6outgroupmembreductions`<br/>`DGAUGE`, number | Number of ICMPv6 Multicast Listener reductions sent (SNMP) |
| `snmp6.icmp6outgroupmembresponses`<br/>`DGAUGE`, number | Number of sent responses to ICMPv6 Multicast Listener queries (SNMP) |
| `snmp6.icmp6outmldv2reports`<br/>`DGAUGE`, number | Number of MLDv2 ICMPv6 reports sent (SNMP) |
| `snmp6.icmp6outmsgs`<br/>`DGAUGE`, number | Total number of ICMPv6 messages this object attempted to send. This includes all messages counted by `snmp6.icmp6outerrors` (SNMP). |
| `snmp6.icmp6outneighboradvertisements`<br/>`DGAUGE`, number | Number of ICMPv6 Neighbor Advertisements sent (SNMP) |
| `snmp6.icmp6outneighborsolicits`<br/>`DGAUGE`, number | Number of ICMPv6 Neighbor Solicitation requests sent (SNMP) |
| `snmp6.icmp6outparmproblems`<br/>`DGAUGE`, number | Number of errors when sending ICMPv6 Parameter Problem messages (SNMP) |
| `snmp6.icmp6outpkttoobigs`<br/>`DGAUGE`, number | Number of errors when sending ICMPv6 Packet Too Big messages (SNMP) |
| `snmp6.icmp6outredirects`<br/>`DGAUGE`, number | Number of ICMPv6 Redirect Route messages sent (SNMP) |
| `snmp6.icmp6outrouteradvertisements`<br/>`DGAUGE`, number | Number of ICMPv6 Router Advertisements sent (SNMP) |
| `snmp6.icmp6outroutersolicits`<br/>`DGAUGE`, number | Number of ICMPv6 Router Solicitation requests sent (SNMP) |
| `snmp6.icmp6outtimeexcds`<br/>`DGAUGE`, number | Number of ICMPv6 Time Exceeded messages sent is greater than that of messages sent (SNMP) |
| `snmp6.icmp6outtype1`<br/>`DGAUGE`, number | Number of ICMPv6 Type 1 (Destination Unreachable) messages sent (SNMP) |
| `snmp6.icmp6outtype129`<br/>`DGAUGE`, number | Number of ICMPv6 Type 129 messages sent (SNMP) |
| `snmp6.icmp6outtype133`<br/>`DGAUGE`, number | Number of ICMPv6 Type 133 (Router Solicitation) messages sent (SNMP) |
| `snmp6.icmp6outtype135`<br/>`DGAUGE`, number | Number of ICMPv6 Type 135 (Neighbor Solicitation) messages sent (SNMP) |
| `snmp6.icmp6outtype136`<br/>`DGAUGE`, number | Number of ICMPv6 Type 136 (Neighbor Advertisement) messages sent (SNMP) |
| `snmp6.icmp6outtype143`<br/>`DGAUGE`, number | Number of ICMPv6 Type 143 messages sent (SNMP) |
| `snmp6.ip6fragcreates`<br/>`DGAUGE`, number | Number of IPv6 packet fragments generated as a result of fragmentation in this object (SNMP) |
| `snmp6.ip6fragfails`<br/>`DGAUGE`, number | Number of Ipv6 packets dropped because they were subject to fragmenting in this object but could not be fragmented, e.g., due to the Do Not Fragment flag (SNMP) |
| `snmp6.ip6fragoks`<br/>`DGAUGE`, number | Number of successfully fragmented IPv6 packets (SNMP) |
| `snmp6.ip6inaddrerrors`<br/>`DGAUGE`, number | Number of input packets dropped because the IP address in their IPv6 header's destination field was not a valid address to be received in this object. This count includes invalid addresses, such as `0.0.0.0`, and addresses of unsupported classes, e.g., Class E. For objects that are not IP Gateways and, as such, do not forward packets, this counter includes packets dropped because the destination address was not a local one (SNMP). |
| `snmp6.ip6inbcastoctets`<br/>`DGAUGE`, number | Total number of input broadcast octets received which contain IPv6 addresses (SNMP) |
| `snmp6.ip6incepkts`<br/>`DGAUGE`, number | Number of input IPv6 packets received which contain detailed traffic information (SNMP) |
| `snmp6.ip6indelivers`<br/>`DGAUGE`, number | Total number of IPv6 packets delivered (SNMP) |
| `snmp6.ip6indiscards`<br/>`DGAUGE`, number | Number of input IPv6 packets encountering no problems preventing their further processing but still dropped, e.g., for lack of buffer space. This counter does not include the packets dropped while awaiting reassembly (SNMP). |
| `snmp6.ip6inect0pkts`<br/>`DGAUGE`, number | Number of received IPv6 packets of traffic class `0` (SNMP) |
| `snmp6.ip6inect1pkts`<br/>`DGAUGE`, number | Number of received IPv6 packets of traffic class `1` (SNMP) |
| `snmp6.ip6inhdrerrors`<br/>`DGAUGE`, number | Number of input packets with IPv6 header errors (SNMP) |
| `snmp6.ip6inmcastoctets`<br/>`DGAUGE`, number | Total number of input multicast octets received which contain IPv6 addresses and detailed traffic information (SNMP) |
| `snmp6.ip6inmcastpkts`<br/>`DGAUGE`, number | Total number of input multicast packets received which contain IPv6 addresses and detailed traffic information (SNMP) |
| `snmp6.ip6innoectpkts`<br/>`DGAUGE`, number | Number of IPv6 packets received that have no traffic class (SNMP) |
| `snmp6.ip6innoroutes`<br/>`DGAUGE`, number | Number of input IPv6 packets discarded because no route could be found (SNMP) |
| `snmp6.ip6inoctets`<br/>`DGAUGE`, number | Total number of input octets received which contain IPv6 addresses and detailed traffic information (SNMP) |
| `snmp6.ip6inreceives`<br/>`DGAUGE`, number | Total number of input IPv6 packets received from interfaces, including those received through error (SNMP) |
| `snmp6.ip6intoobigerrors`<br/>`DGAUGE`, number | Number of received IPv6 packets with a `Packet Too Big` error (SNMP) |
| `snmp6.ip6intruncatedpkts`<br/>`DGAUGE`, number | Number of outgoing IPv6 packets deleted due to exceeded selection size (SNMP) |
| `snmp6.ip6inunknownprotos`<br/>`DGAUGE`, number | Number of unknown protocol IPv6 packets received (SNMP) |
| `snmp6.ip6outbcastoctets`<br/>`DGAUGE`, number | Total number of external broadcast octets sent which contain IPv6 addresses and detailed traffic information (SNMP) |
| `snmp6.ip6outdiscards`<br/>`DGAUGE`, number | Number of output IPv6 packets encountering no problems preventing transmission to their destination but still dropped, e.g., for lack of buffer space (SNMP) |
| `snmp6.ip6outforwdatagrams`<br/>`DGAUGE`, number | Number of outgoing IPv6 packets that need to be forwarded to the network (SNMP) |
| `snmp6.ip6outmcastoctets`<br/>`DGAUGE`, number | Total number of external multicast octets sent which contain IPv6 addresses and detailed traffic information (SNMP) |
| `snmp6.ip6outmcastpkts`<br/>`DGAUGE`, number | Total number of external multicast packets sent which contain IPv6 addresses and detailed traffic information (SNMP) |
| `snmp6.ip6outnoroutes`<br/>`DGAUGE`, number | Number of IPv6 packets dropped because no route could be found to transmit them to their destination (SNMP) |
| `snmp6.ip6outoctets`<br/>`DGAUGE`, number | Total number of external octets sent which contain IPv6 addresses and detailed traffic information (SNMP) |
| `snmp6.ip6outrequests`<br/>`DGAUGE`, number | Total number of IPv6 packets which local IPv6 user protocols (including ICMP) have supplied to IPv6 in requests for transmission (SNMP) |
| `snmp6.ip6reasmfails`<br/>`DGAUGE`, number | Number of failures detected by the IPv6 reassembly algorithm (for whatever reason: timeout, errors, etc.). This is not necessarily a count of dropped IPv6 fragments, as some algorithms (such as the one in RFC 815) can lose track of the number of fragments, combining them as they are received (SNMP). |
| `snmp6.ip6reasmoks`<br/>`DGAUGE`, number | Number of IPv6 packets successfully reassembled (SNMP) |
| `snmp6.ip6reasmreqds`<br/>`DGAUGE`, number | Number of IPv6 fragments received that were to be reassembled in this object (SNMP) |
| `snmp6.ip6reasmtimeout`<br/>`DGAUGE`, number | Maximum time, in seconds, the received IPv6 fragments are held while awaiting reassembly in this object (SNMP) |
| `snmp6.udp6ignoredmulti`<br/>`DGAUGE`, number | Number of multicast UDPv6 packets ignored (SNMP) |
| `snmp6.udp6incsumerrors`<br/>`DGAUGE`, number | The value increases when a received UDPv6 packet contains an invalid kernel code checksum (SNMP) |
| `snmp6.udp6indatagrams`<br/>`DGAUGE`, number | Total number of UDPv6 packets received (SNMP) |
| `snmp6.udp6inerrors`<br/>`DGAUGE`, number | Number of bad UDPv6 packets received, excluding those with checksum errors (SNMP) |
| `snmp6.udp6noports`<br/>`DGAUGE`, number | Total number of UDPv6 packets received that had no application on the destination port (SNMP) |
| `snmp6.udp6outdatagrams`<br/>`DGAUGE`, number | Total number of outgoing UDPv6 packets sent from this object (SNMP) |
| `snmp6.udp6rcvbuferrors`<br/>`DGAUGE`, number | Number of UDPv6 receive buffer errors (SNMP) |
| `snmp6.udp6sndbuferrors`<br/>`DGAUGE`, number | Number of UDPv6 send buffer errors (SNMP) |
| `snmp6.udplite6incsumerrors`<br/>`DGAUGE`, number | The value increases when a received UDP Litev6 packet contains an invalid kernel code checksum (SNMP) |
| `snmp6.udplite6indatagrams`<br/>`DGAUGE`, number | Total number of UDP Litev6 packets received (SNMP) |
| `snmp6.udplite6inerrors`<br/>`DGAUGE`, number | Total number of errors when receiving UDP Litev6 packets (SNMP) |
| `snmp6.udplite6noports`<br/>`DGAUGE`, number | Number of UDP Litev6 packets received for which no receiver port was found (SNMP) |
| `snmp6.udplite6outdatagrams`<br/>`DGAUGE`, number | Total number of outgoing UDP Litev6 packets sent from this object (SNMP) |
| `snmp6.udplite6rcvbuferrors`<br/>`DGAUGE`, number | Number of UDP Litev6 receive buffer errors (SNMP) |
| `snmp6.udplite6sndbuferrors`<br/>`DGAUGE`, number | Number of UDP Litev6 send buffer errors (SNMP) |