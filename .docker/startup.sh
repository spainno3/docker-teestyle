#!/bin/sh

# tsの自動コンパイル
tsc -p /webapp/teestyle/htdocs/assets/ts -w &

/usr/sbin/httpd -D FOREGROUND
