To decrypt the backup encryption key:

1. Download `gpg-key-<id>-0-of-1.7z` from your bucket.
1. Open the archive and enter the key you previously received via the backup request form. If you did not save this key, you will need to request a new backup export. To extract the archive, use a utility compatible with your OS:

   * Windows: 7-Zip.
   * macOS: Keka.
   * Run the `7z x gpg-key-<id>-0-of-1.7z` command. Enter the password when prompted by 7z.

1. Use the key obtained from the archive to decrypt your backup.