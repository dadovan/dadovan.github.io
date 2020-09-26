# General

## Windows setup

WSL 2 config:

* `Error: 0x1bc` when setting the default WSL version? [Go here](https://aka.ms/wsl2kernel)

```PowerShell
PS C:\WINDOWS\system32> wsl --set-default-version 2
Error: 0x1bc
```

WSL 1 config:

* [Ubuntu 18.04 apt upgrade failure](https://github.com/Microsoft/WSL/issues/3274): sudo apt-mark hold ebtables

* Error installing Ubuntu 20.04? [Go here](https://github.com/microsoft/WSL/issues/5325#issuecomment-654463010)

```PowerShell
Installing, this may take a few minutes...
WslRegisterDistribution failed with error: 0xc03a001a
```

### Powershell

* [Dynamic parameters](http://blogs.technet.com/b/pstips/archive/2014/06/10/dynamic-validateset-in-a-dynamic-parameter.aspx)

[comment]: # (TAGS: configuration, windows)
