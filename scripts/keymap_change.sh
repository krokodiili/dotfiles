#!/bin/bash

layout=$(setxkbmap -query | grep -oP '(?<=layout:).*')
if [ $layout = us ]
then
  $(setxkbmap fi)
else
  $(setxkbmap us)
fi
xmodmap ~/.Xmodmap

