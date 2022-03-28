#!/bin/env python3.6

import numpy as np
from datetime import datetime
from typing import Dict

# --- PURE FUNCTIONS ---
# A pure function ALWAYS returns the same output, for a given input
# Which of these functions are definitely pure?

def f1():
    now = datetime.now()
    return now.strftime("%H:%M:%S")

def f2(fpath: str):
    with open(fpath, "r") as host:
        return host.readline()

def f3(a: list[int], b: list[int]):
    return np.add(a, b)

def f4(d: Dict[str, int]):
    return {**d, **{"extra_key": 7}}

