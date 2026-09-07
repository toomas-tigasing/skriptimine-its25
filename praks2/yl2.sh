#!/bin/bash
# Aja ja kalendri väljastamine
echo
date +"Today is %A, %B, %Y"
date +"Time is %H %M"
echo
date +"Calender of %B %Y"
ncal -C | tail -7
