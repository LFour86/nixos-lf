# nixos-lf
> [!WARNING]
>由于某些原因， ~~（Linux内核？NixOS令人破防的软连接？）~~ 我放弃使用NixOS作为主力系统，所以该配置更新不会很频繁，但该配置在未来几年内大概率是没有任何问题的，如果系统版本或者home-manager版本过低更改就行了。

## 介绍 🚀
### 整体布局
  该配置基于flake和home-manager，借助科学的模块话管理，有较高的可读性和移植性，目前只适用于64位x86平台。 ~~（不会有人用arm等架构的电脑吧）~~ 
  改配置适用于含amd iGPU和NVIDIA的电脑，也对此进行了相关优化，可以在wayland下使用NVIDIA独显或者正常nvidia offload。如果你的电脑只有amd iGPU，在`flake.nix`注释掉`nvidia.nix`即可。 ~~如果是 intel GPU就耗子尾汁吧~~
  系统级的应用主要在**system/programs/systempkgs.nix**下，用户级的应用主要在**home/userpkgs.nix**下。
  办公软件采用`wpsoffice-cn`。
### 相关开发环境
#### C/C++ && Embedded
IDE：`Clion` `Vscode` `arduinoIDE` `zed-editor`等
工具链: `clang/clang++(llvm)` `gcc/gdb` `arm-gcc-embedded` `gnumake` `cmake` `ninja`等
其他工具: `platformio` `openocd` `stm32cubemx` `stlink`等  

#### Python
IDE: `pycharm`
工具链：`python3Full`

#### 其他
此外，该配置还简单包含了rust，nodejs，go等语言的环境以及一些建模以及EDA等的工具。

## 安装 🧷
  NixOS的初始化配置包含`configuration.nix`与`hardware-configuration.nix`，其中第一个是系统的全局配置，第二个是硬件相关的（主要是硬盘分区的配置）。而该项目采用模块化管理，所以`configuration.nix`的设置被分散在**./system**文件夹下的各个子文件，`hardware-configuration.nix`的配置放在 **./system/hardware/partition.nix** 中，移植时复制粘贴进去即可。
安装步骤：
1.获取源文件
``` bash 
git clone https://github.com/LFour86/nixos-lf.git
```
2.覆盖默认配置
``` bash
su
cat /etc/nixos/hardware-configuration.nix >> nixos-lf/nixos/system/hardware/partition.nix
mv /etc/nixos/configuration.nix /etc/nixos/configuration.nix.bak && mv /etc/nixos/hardware-configuration.nix /etc/nixos/hardware-configuration.nix.bak
cp -r nixos-lf/nixos/* /etc/nixos
``` 
3.更新系统
``` bash
cd /etc/nixos && nixos-rebuild switch --flake .#username
```
> [!NOTE]
> 移植配置要注意用户名等配置的修改。对于国内用户，安装好系统后建议先换源再使用该配置，预计会下载三十几G的文件。
