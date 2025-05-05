* **Core**{#setting-core} {{ tag-con }} {{ tag-api }}

    Settings of the file system and security rules.

    For more information, see the [Apache Hadoop documentation](https://hadoop.apache.org/docs/stable/hadoop-project-dist/hadoop-common/core-default.xml).

    * **Default Fs**{#setting-default-fs}

        URI that defines the HDFS file system.

    * **Security Auth To Local**{#setting-security-auth-to-local}

        Rules for mapping Kerberos principals to user accounts of the operating system.

* **Kerberos**{#setting-kerberos} {{ tag-con }} {{ tag-api }}

    Settings of the Kerberos network authentication protocol.

    For more information, see the relevant [{{ GP }} documentation]({{ gp.docs.vmware }}/7/greenplum-database/admin_guide-kerberos.html).

    * **Enable**{#setting-enable}

        It defines the use of the Kerberos authentication server. By default, it is not used.

    * **Primary**{#setting-primary}

        Host of the KDC (Key Distribution Center) main server.

    * **Realm**{#setting-realm}

        Kerberos realm for a {{ GP }} database.

    * **Kdc Servers**{#setting-kdc-servers}

        Hosts of KDC servers.

    * **Admin server**{#setting-admin-server}

        Host of the administration server. This is usually the main Kerberos server.

    * **Default domain**{#setting-default-domain}

        Domain that is used to expand host names when translating Kerberos 4 service principals to Kerberos 5 service principals (e.g., when converting `rcmd.hostname` to `host/hostname.domain`).

    * **Keytab Base64**{#setting-keytab-base64}

        Base64-encoded keytab file contents.

* **User Impersonation**{#setting-user-impersonation} {{ tag-con }} {{ tag-api }}

    It defines whether you can authenticate in an external file storage or DBMS on behalf of a {{ GP }} user.

    By default, such authentication is prohibited.

    For more information, see the relevant [{{ GP }} documentation]({{ gp.docs.vmware }}-platform-extension-framework/6-11/gp-pxf/cfg_server.html).

* **Username**{#setting-username} {{ tag-con }} {{ tag-api }}

    Username that is used to connect to an external file storage or DBMS if user impersonation is disabled.

    For more information, see the relevant [{{ GP }} documentation]({{ gp.docs.vmware }}-platform-extension-framework/6-11/gp-pxf/cfg_server.html#about-the-pxfsitexml-configuration-file-3).

* **Sasl Connection Retries**{#setting-sasl-connection-retries} {{ tag-con }} {{ tag-api }}

    Maximum number of retry attempts by PXF to request a SASL connection if the `GSS initiate failed` error occurs.

    The default value is `5`.

    For more information, see the relevant [{{ GP }} documentation]({{ gp.docs.vmware }}-platform-extension-framework/6-11/gp-pxf/cfg_server.html#about-the-pxfsitexml-configuration-file-3).

* **ZK Hosts**{#setting-zk-hosts} {{ tag-con }} {{ tag-api }}

    Hosts of ZooKeeper servers. The values are specified in `<address>:<port>` format.

    For more information, see the [Apache Hadoop documentation](https://hadoop.apache.org/docs/stable/hadoop-project-dist/hadoop-common/core-default.xml).