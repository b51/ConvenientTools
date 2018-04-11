# GitSettings
## IP address alias
    eg. alias xx.xxx.xxx.xxx to gitlab.xxx.com
    need .ssh/config and .gitconfig

>.ssh/config

    Host *
        KexAlgorithms +diffie-hellman-group1-sha1

    Host gitlab.xxx.com
    Hostname xx.xxx.xxx.xxx
    User git
>.gitconfig

      [url "ssh://git@gitlab.xxx.com"]
        insteadOf = https://xx.xxx.xxx.xxx
