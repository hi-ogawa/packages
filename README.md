# packages.txt

This is to log which deb packages are manually installed.

This is also to get familiar with apt, dpkg and systemd, casually.

## Commands

```
$ systemd --version
systemd 229
+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ -LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN
```

- Install

```
$ sudo cp packages.{service,timer} /etc/systemd/system
$ sudo systemctl enable packages.timer
Created symlink from /etc/systemd/system/timers.target.wants/packages.timer to /etc/systemd/system/packages.timer.
$ sudo systemctl start packages.timer
$ systemctl status packages.timer -l
● packages.timer - Daily packages.txt (timer)
   Loaded: loaded (/etc/systemd/system/packages.timer; enabled; vendor preset: enabled)
   Active: active (waiting) since Mon 2016-09-19 13:02:25 JST; 8s ago

Sep 19 13:02:25 hiogawa-xenial-tp13 systemd[1]: Started Daily packages.txt (timer).
$ systemctl list-timers | awk 'NR==1 || /packages\.timer/'
NEXT                         LEFT          LAST                         PASSED        UNIT                         ACTIVATES
Tue 2016-09-20 11:00:00 JST  21h left      Mon 2016-09-19 12:55:11 JST  11min ago     packages.timer               packages.service
```

- Update

```
$ (edit service or timer files)
$ sudo cp packages.{service,timer} /etc/systemd/system
$ sudo systemctl reenable packages.timer
$ sudo systemctl restart packages.timer
```

- Uninstall

```
$ sudo systemctl stop packages.timer
$ sudo systemctl disable packages.timer
Removed symlink /etc/systemd/system/timers.target.wants/packages.timer.
$ sudo rm /etc/systemd/system/packages.{service,timer}
```

## Reference

- systemd.timer(5), systemd.service(5)
  - example: /lib/systemd/system/apt-daily.{service,timer}
  - https://wiki.archlinux.org/index.php/Systemd/Timers
- systemctl(1)
  - issue and fix for link/enable: https://github.com/systemd/systemd/issues/3010
- apt-mark(8), dpkg-query(1)
- apt.conf(5)
  - I tried to hook the script into apt, but I gave up doing it because of the inflexibility.
