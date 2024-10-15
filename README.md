[//]: # (Title: Nixdots)  
[//]: # (Description: NixOS configurations with flakes and home-manager for my personal setup.)  
[//]: # (Author: Antonio Sarro)  
[//]: # (Date: 08/09/24)
[//]: # (Version: v1.0.0)

<div align="center">
    <img src="https://raw.githubusercontent.com/antoniosarro/nixdots/main/.github/assets/logo.png" width="100px" />
</div>

<br>

# Nixdots

<br>
<div>
</div>
<br>

**Nixdots** is a **NixOS** configurations with flakes and home-manager for my personal setup.

## Table of Content

  - [Table of Content](#table-of-content)
  - [Gallery](#gallery)
  - [Architecture](#architecture)
    - [🏠 `desktop`](#-home)
    - [💻 `laptop`](#-hosts)
  - [Installation](#installation)

## Installation

```sh
curl https://raw.githubusercontent.com/antoniosarro/nixdots/main/hosts/<hostname>/disko.nix \
-O /tmp/disko.nix

nano /tmp/secret.key

sudo nix --experimental-features "nix-command flakes" \
run github:nix-community/disko -- \
--mode disko /tmp/disko.nix
```

> [!NOTE]
> Use `lsblk -f` to check if disk are partitioned correctly.

```sh
nix-shell -p git

git clone https://github.com/antoniosarro/nixdots /tmp/nixdots

sudo nixos-install --root /mnt \
--flake /mnt/nixdots#hostname
```

Reboot