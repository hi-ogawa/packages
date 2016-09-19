#!/bin/bash

apt-mark showmanual | xargs dpkg-query -W > packages.txt
