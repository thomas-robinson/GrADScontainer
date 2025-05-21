#!/bin/bash -fx

cd /tom
gribmap -v -i plottrak.ctl
grads -bcl "run tom.gs"

