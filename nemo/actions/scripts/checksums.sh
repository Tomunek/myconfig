#!/bin/bash
sha1=($(sha1sum "$1"))
sha256=($(sha256sum "$1"))
sha512=($(sha512sum "$1"))
md5=($(md5sum "$1"))
zenity --info --width=700 --height=150 --title="Checksums" --text="MD5: \t\t$md5\nSHA1: \t\t$sha1\nSHA256: \t$sha256\nSHA512: \t$sha512"
