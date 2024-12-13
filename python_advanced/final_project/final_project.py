import pandas as pd
import numpy as np
from numpy import loadtxt

input_path = "input_data/"
file_names = [
    "ce", "cp", "eps1", "se", "vs1", 
    "fs1", "fs2", 
    "ps1", "ps2", "ps3", "ps4", "ps5", "ps6",
    "ts1", "ts2", "ts3", "ts4"
]

data = {}

for file_name in file_names:
    data[file_name] = loadtxt(f"{input_path}{file_name}.txt")
    