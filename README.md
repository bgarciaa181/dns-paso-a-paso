# dns-paso-a-paso

Author: Bea Garcia

## What is this project?

In this project I set up a DNS server with Bind9 on Debian. A DNS server changes names (like `debian.bea.test`) into IP addresses. I also made a second DNS server that gets a copy of the zones from the first one.

I create the virtual machines with Vagrant and VirtualBox. Some scripts install and configure everything automatically.

## Machines

| Machine | What it does | IP |
|---|---|---|
| servidor | Main DNS server (primary) | 192.168.56.10 |
| secundario | Second DNS server (secondary) | 192.168.56.11 |

Both machines are in the private network 192.168.56.0/24.

## Files in this repository

```
.
├── Vagrantfile          the two machines and their scripts
├── test.sh              script that checks the server
├── config/              provision scripts for Vagrant
├── files/               Bind configuration files
│   └── secundario/      files for the second server
└── doc/                 step by step documentation with screenshots
```

## What you need

- VirtualBox
- Vagrant (it downloads the Debian box `debian/bookworm64` by itself)

## How to start it

```
vagrant up
```

This creates the two machines, installs Bind, copies the configuration files and restarts the service. At the end, the first machine runs `test.sh`, and the second machine shows that it has the same serial number as the first one.

## Documentation

The step by step documentation, with commands and screenshots, is in [doc/README.md](doc/README.md).
