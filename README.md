<div align="center">
  <h1
    style="font-size: 3rem; font-weight: bold; color: rgb(108, 108, 108);"
    >
      Starship Update
    </h1>
    <h3 style="color: rgb(230, 40, 40)">
      Install and update the Starship prompt on for Debian/Ubuntu based systems.
    </h3>
</div>

The [Starship](https://starship.rs/) prompt is a minimal, blazing-fast, and extremely customizable prompt for any shell. It is written in Rust and is designed to be fast and efficient.

## Installation

### Using DPKG/APT

You can install the project using the following command on Debian/Ubuntu based distributions add the repository.

Add the source list:

```bash
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/HowToNebie.gpg] https://michaelschaecher.github.io/mls stable main" |
sudo tee /etc/apt/sources.list.d/howtonebie.list
```

Add the repository key:

```bash
wget -qO - https://raw.githubusercontent.com/MichaelSchaecher/mls/refs/heads/main/key/HowToNebie.gpg |
gpg --dearmor | sudo dd of=/usr/share/keyrings/HowToNebie.gpg
```

Update the package list and install: `sudo apt update` & `sudo apt install btrfs-fstab`



### Other Linux Distributions

Installing the project is straightforward. Follow these steps:

1. Clone the repository:

   ```bash
   git clone https://github.com/MichaelSchaecher/starship-update.git
   ```

2. Install the project:

   ```bash
   sudo make install
   ```

## Usage

The application is designed to check for the latest version of the Starship prompt and update it if necessary. However, can be ran manually using the following command: `starship-update`.

## Adding the prompt to your shell
To add the Starship prompt to your shell, you need to add the following line to the bottom  your shell configuration file:

- Bash:

   ```bash
   eval "$(starship init bash)"
   ```
- Zsh:

   ```bash
   eval "$(starship init zsh)"
   ```
- Fish:

   ```bash
   starship init fish | source
   ```
- PowerShell:

   ```powershell
   Invoke-Expression (&starship init powershell)
   ```

Once you have added the line to your shell configuration file, you need to restart your shell for the changes to take effect. The best way is to close the terminal and open a new one.
