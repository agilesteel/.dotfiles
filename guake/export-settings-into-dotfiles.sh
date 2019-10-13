#!/bin/bash

dconf dump /apps/guake/ > .config
dconf dump /org/gnome/desktop/notifications/application/guake/ > .notifications
