To make sure we're keeping up-to-date with our upgrades on the Debian system, we can enable automatic unattended-upgrades. This can be set to run daily, so that we are on top of our security.

Firstly, we want to make sure the packages are installed for unattended-upgrades, as well as apt-config-auto-update (ensures the underlying APT auto-update scripts are present).

```bash
sudo apt install unattended-upgrades
sudo apt install apt-config-auto-update
```

When the packages are installed, we can setup the daily scheduling tasks, to run every day:

```bash
printf '%s\n' 'APT::Periodic::Update-Package-Lists "1";' 'APT::Periodic::Unattended-Upgrade "1";' | sudo tee /etc/apt/apt.conf.d/20auto-upgrades > /dev/null
```

The `1` explicitly tells APT to run these tasks every 1 day.

For the basic setup, we can lastly run through verification steps, so that we can confirm APT acknowledges the new settings.

```bash
apt-config dump | grep -E 'APT::Periodic::(Update-Package-Lists|Unattended-Upgrade)'
```

We can also confirm that the `systemd` timers are actively scheduled to run them:

```bash
systemctl list-timers --all 'apt-daily*' --no-pager
```


