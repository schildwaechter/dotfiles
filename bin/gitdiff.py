#!/usr/bin/env python
"""This script wraps meld for use with git
since git diff passes too many arguments"""

import sys
import os

os.system('meld "%s" "%s"' % (sys.argv[2], sys.argv[5]))

