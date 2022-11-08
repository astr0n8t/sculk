<p align="center">
<img src="https://static.wikia.nocookie.net/minecraft_gamepedia/images/6/67/Sculk_JE1_BE1.gif">
<br>
<h2 align="center">sculk</h2>
</p>
A Infrastructure as Code example deploying a VM with WireGuard and vaultwarden plus AdGuard Home.

## Why?

A sculk shrieker in Minecraft is a block that spawns a warden mob when the player comes nearby.

Sculk allows a user to access their own private [vaultwarden](https://github.com/dani-garcia/vaultwarden) instance when they activate their [WireGuard](https://www.wireguard.com/) VPN.  It also provides secure DNS using the [Adguard Home](https://github.com/AdguardTeam/AdGuardHome) instance.  Lastly, [whalewall](https://github.com/capnspacehook/whalewall) provides firewall security for all of the Docker containers running on the host. By design, the only way to access anything running in sculk is via WireGuard.

This project is meant to be a starting point for beginning homelabbers and enthusiasts to build their own secure personal cloud resources.

## Requirements

See [REQUIREMENTS.md](docs/REQUIREMENTS.md)

## Setup

See [SETUP.md](docs/SETUP.md)

## Deployment

See [DEPLOYMENT.md](docs/DEPLOYMENT.md)

