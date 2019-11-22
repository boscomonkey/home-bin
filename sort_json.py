#!/usr/bin/env python

import fileinput
import json

lines = ''.join([line for line in fileinput.input()])
obj = json.loads(lines)

print(json.dumps(obj, sort_keys=True, indent=2))
