import sys
import os
import BioSimSpace as BSS

from ._validate import *

def engine_network(engine, file_path):
    """Generate a network file for only the engine specified.

    Args:
        engine (str): engine to generate the network for
        file_path (str): network.dat file containing multiple engines
    """
    engine = validate.engine(engine)
    file_path = validate.file_path(file_path)

    try:
        print("using the folder of the file as the location to write the output file...")
        output_file = f"{file_path.rsplit('.',1)[0]}_{engine.lower()}.dat"

    except:
        print("assuming the file path is just network_combined.dat as not provided...")
        file_path = "network_combined.dat"
        if not os.path.exists(file_path):
            raise ValueError(f"{file_path} does not exist in the current folder.")
        output_file = f"network_combined_{engine.lower()}.dat"

    with open(file_path, "r") as file:
        with open(output_file, "w") as f:
                for line in file:
                        if engine in line:
                                f.write(f"{line}")

