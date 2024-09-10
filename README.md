[//]: # (Title: Nixdots)  
[//]: # (Description: NixOS configurations with flakes and home-manager for my personal setup.)  
[//]: # (Author: Antonio Sarro)  
[//]: # (Date: 08/09/24)
[//]: # (Version: v1.0.0)

<div align="center">
    <img src="https://raw.githubusercontent.com/anotherhadi/nixy/main/docs/src/logo.png" width="100px" />
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
```

```sh
sudo nix --experimental-features "nix-command flakes" \
run github:nix-community/disko -- \
--mode disko /tmp/disko.nix
```

> [!NOTE]
> Use `lsblk` to check if disk are partitioned correctly.

```sh
git clone https://github.com/antoniosarro/nixdots /mnt/nixdots
```

```sh
nixos-install --root /mnt \
--flake /mnt/nixdots#hostname
```

Reboot

----

```sh
git clone https://github.com/antoniosarro/nixdots ~/.config/nixos
```

```sh
sudo nixos-rebuild switch --flake ~/.config/nixos#hostname
```