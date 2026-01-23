# TRND Dotfiles

Personal Arch Linux dotfiles and setup scripts.

This repository contains my **personal dotfiles** and a **fully scripted Arch Linux setup**.
Most of the setup scripts are **adapted from Omarchy**, with all branding and strings renamed to **TRND**.
Over time, the dotfiles themselves will diverge further and become fully custom.

> ⚠️ These scripts are opinionated and tailored to *my* workflow. Use at your own risk.

---

## Installation Guide

This guide assumes you are starting from a **fresh Arch ISO**.

---

### 1. (Optional) Connect to Wi-Fi

If you’re not using Ethernet:

```bash
iwctl
```

Inside `iwctl`:

```text
station <device> list
station <device> get-networks
station <device> connect <wifi>
station <device> show   # verify connection
exit
```

---

### 2. Initialize Pacman & Archinstall

```bash
pacman-key --init
pacman-key --populate archlinux
pacman -Sy archinstall
archinstall
```

---

### 3. Archinstall Configuration

Follow these options inside `archinstall`:

#### 3.1 Language

* **English**

#### 3.2 Locales

* **Keyboard layout:** `la-latin1`
* **Language:** `en_US.UTF-8`
* **Encoding:** `UTF-8`

#### 3.3 Mirrors

* **Mexico**
* **USA**

#### 3.4 Disk Configuration

* **Partitioning:**

  * Best effort
  * `btrfs`
  * Default subvolume layout
  * Enable compression
* **Disk Encryption:**

  * LUKS
  * Encrypt partitions
* **Snapshots:**

  * Snapper

#### 3.5 Bootloader

* **Limine**

#### 3.6 Hostname

* Optional (set whatever you prefer)

#### 3.7 Authentication

* Set **root password**
* Create **user account**

#### 3.8 Profile

* **Type:** Desktop → Hyprland → Polkit
* **Graphics:** Choose according to your hardware
  (Intel / AMD / NVIDIA / Open Source)
* **Greeter:** `sddm`

#### 3.9 Network

* Copy network configuration from ISO

#### 3.10 Additional Packages

* `wget`
* `git`
* `github-cli`
* `chromium`
* `curl`

#### 3.11 Timezone

* `America/Mexico_City`

---

## About Omarchy

Most of the setup scripts in this repository are **derived from Omarchy**.

**Omarchy** is a beautiful, modern, and opinionated Linux distribution created by **DHH**.

Learn more at:
👉 [https://omarchy.org](https://omarchy.org)

---

## License

Omarchy is released under the **MIT License**:
[https://opensource.org/licenses/MIT](https://opensource.org/licenses/MIT)

Any original modifications and dotfiles in this repository follow the same spirit.

---

