# My Dotfiles

To install/update:

```sh
wget --no-check-certificate https://raw.github.com/mattbertolini/profilesettings/master/inithome.sh; \
chmod ugo+x inithome.sh; \
./inithome.sh; \
source ~/.profile
```

If there is no wget command:

```sh
curl --remote-name --insecure https://raw.github.com/mattbertolini/profilesettings/master/inithome.sh; \
chmod ugo+x inithome.sh; \
./inithome.sh; \
source ~/.profile
```
