### OS user login inventory {#logins}

#|
|| **kind** | **severity** | **ID** ||
|| inventory | low | inventory.logins ||
|#

#### Description

This inventory rule collects data on user logins across worker nodes using an inventory agent.

Queries:

serial. Serial console logins in system.

```SELECT ue.auid AS auid, ue.message AS message, ue.type AS event_type, ue.path AS logon_path, ue.terminal AS terminal, ue.pid AS logon_pid, pe.cmdline AS logon_cmdline, u.username AS user, regex_match(pe.cmdline, '/bin/login -p -- (\w+)', 1) AS serial_user, datetime(ue.time, 'unixepoch') AS dt FROM user_events ue LEFT JOIN users u ON ue.auid=u.uid LEFT JOIN process_events pe ON ue.pid=pe.pid WHERE terminal LIKE '/dev/tty%' AND ue.type IN (1112,1105);```

root. Root logins and elevations in system.

```SELECT ue.uid, ue.auid, u.username AS audit_user, u.shell AS shell, ue.pid, ue.message, ue.type, ue.path, ue.address, ue.terminal, pe.cmdline, pe.time, datetime(ue.time, 'unixepoch') AS dt FROM user_events ue LEFT JOIN users u ON ue.auid=u.uid LEFT JOIN process_events pe ON ue.pid=pe.pid WHERE ue.uid=0 AND ue.type=1105 AND ue.auid NOT IN (-1,4294967295) AND (terminal='ssh' OR terminal LIKE '/dev/pts%');```

failed. Multiple failed logins from same IP address.

```SELECT type, message, address, terminal, count() AS count, datetime(min(time), 'unixepoch') AS earliest, datetime(max(time), 'unixepoch') AS latest, count()*60.0/(max(time)-min(time)) AS speed FROM user_events WHERE type=1109 AND time>unixepoch('now', '-30 minutes') GROUP BY address, terminal, message HAVING count >= 5;```

You can analyze the results by exporting event data from [Audit Trails](https://yandex.cloud/ru/docs/security-deck/at-ref) to your SIEM or SOC system.

#### Instructions and solutions

This rule does not require guidance since it is informational and used to collect inventory events within Audit Trails.

You can configure [event collection for Security Deck](https://yandex.cloud/ru/docs/security-deck/at-ref) in Audit Trails and export the data to SIEM or SOC systems to analyze the inventory results.
