* For one-time bucket mounting:

    {% list tabs group=operating_system %}

    - Linux/macOS {#linux}

      1. Create a folder for mounting:

          ```bash
          mkdir <mount_point>
          ```

      1. Mount the bucket:

          ```bash
          geesefs <bucket_name> <mount_point>
          ```

          Specify an existing folder as the mount point.

    - Windows {#windows}

      Mount the bucket:

      ```bash
      geesefs <bucket_name> <mount_point>
      ```

      As the mount point, specify the name of the new folder that will be created when you mount the bucket. You cannot specify the name of an existing folder.

      Result:

      ```text
      2025/10/06 21:14:27.488504 main.INFO File system has been successfully mounted.
      The service geesefs has been started.
      ```

    {% endlist %}

* To automatically mount a bucket at system startup:

    {% list tabs group=operating_system %}

    - Linux {#linux}

      1. Create a folder for automatic mounting:
      
          ```bash
          mkdir <mount_point>
          ```

      1. Open `/etc/fuse.conf`:

          ```bash
          sudo nano /etc/fuse.conf
          ```

      1. Add the following line to it:

          ```text
          user_allow_other
          ```

      1. Open `/etc/fstab`:

          ```bash
          sudo nano /etc/fstab
          ```

      1. Add the following line to the `/etc/fstab` file:

          ```text
          <bucket_name>    /home/<username>/<mount_point>    fuse.geesefs    _netdev,allow_other,--file-mode=0666,--dir-mode=0777,--shared-config=/home/<username>/.aws/credentials    0   0
          ```

          If you had created the `.aws/credentials` file for the `root` user, you do not need to specify the `--shared-config` parameter.

          {% note info %}

          For the bucket to be mounted correctly, provide the full absolute path to the mount point and to the key file without `~`, e.g., `/home/user/`.

          {% endnote %}

      1. Reboot your PC and check that the bucket has been mounted to the specified folder.

      To disable automounting, remove the line with the bucket name from the `/etc/fstab` file.

    - macOS {#macos}

      1. Create a folder for automatic mounting:

          ```bash
          mkdir <mount_point>
          ```

      1. Create a file named `com.geesefs.automount.plist` with the autorun agent configuration:

          ```bash
          nano /Users/<username>/Library/LaunchAgents/com.geesefs.automount.plist
          ```

      1. Set the agent configuration by specifying the name of the bucket and the absolute path to the mount point:

          ```xml
          <?xml version="1.0" encoding="UTF-8"?>
          <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
          <plist version="1.0">
          <dict>
              <key>Label</key>
              <string>com.geesefs.automount</string>
              <key>ProgramArguments</key>
              <array>
                  <string>/usr/local/bin/geesefs</string>
                  <string><bucket_name></string>
                  <string><absolute_path_to_mount_point></string>
              </array>
              <key>RunAtLoad</key>
              <true/>
              <key>KeepAlive</key>
              <dict>
                  <key>NetworkState</key>
                  <true/>
              </dict>
          </dict>
          </plist>
          ```

          {% note info %}

          Specify an existing empty folder as the mount point.

          For the bucket to be mounted correctly, provide the full absolute path to the mount point and to the key file without `~`, e.g., `/home/user/`.

          {% endnote %}

      1. Enable the agent you created:

          ```bash
          launchctl load /Users/<username>/Library/LaunchAgents/com.geesefs.automount.plist
          ```

      1. Reboot your PC and check that the bucket has been mounted to the specified folder.

      To disable agent autorun, use this command:

      ```bash
      launchctl unload /Users/<username>/Library/LaunchAgents/com.geesefs.automount.plist
      ```

    - Windows {#windows}

      Create a Windows service that will automatically run at system startup:

      1. Run `CMD` as an administrator.
      1. Run this command:

          ```cmd
          sc create <service_name> ^
            binPath="<command_for_mounting>" ^
            DisplayName= "<service_name>" ^
            type=own ^
            start=auto
          ```

          Where `binPath` is the path to the `geesefs.exe` file with the required mounting parameters. Here is an example: `C:\geesefs\geesefs.exe <bucket_name> <mount_point>`. As the mount point, specify the name of the new folder that will be created when you mount the bucket. You cannot specify the name of an existing folder.

          Result:

          ```text
          [SC] CreateService: Success
          ```

      1. Click **Start** and start typing `Services` in the Windows search bar. Run the **Services** application as an administrator.
      1. In the window that opens, find the service you created earlier, right-click it, and select **Properties**.
      1. On the **Log on** tab, select **This account** and specify your Windows account name and password.

          If necessary, click **Browse** → **Advanced** → **Search** to find the user you need on the computer.

      1. Click **OK**.

      To delete the created service, open `CMD` as an administrator and run the following command:

      ```cmd
      sc delete <service_name>
      ```

      Result:

      ```text
      [SC] DeleteService: Success
      ```

    {% endlist %}