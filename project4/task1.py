#!/usr/bin/env python3

import sys
import os
import numpy as np
import numpy.linalg as LA 
from scipy import misc

def getOutputPngName(path, rank):
    filename, ext = os.path.splitext(path)
    return filename + '.' + str(rank) + '.png'

def getOutputNpyName(path, rank):
    filename, ext = os.path.splitext(path)
    return filename + '.' + str(rank) + '.npy'

if len(sys.argv) < 3:
    sys.exit('usage: task1.py <PNG inputFile> <rank>')

inputfile = sys.argv[1]
T = misc.imread(inputfile, True)
rank = int(sys.argv[2])

U,S,Vh = LA.svd(T, full_matrices = False)
T_new = np.matrix(U[:, :rank]) * np.diag(S[:rank]) * np.matrix(Vh[:rank, :])

outputpng = getOutputPngName(inputfile, rank)
outputnpy = getOutputNpyName(inputfile, rank)

pngfile = open(outputpng, "w") 
npyfile = open(outputnpy, "w")
misc.imsave(outputpng, T_new)
np.save(outputnpy, T_new)

pngfile.close()
npyfile.close()

#
# TODO: The current code just prints out what it is supposed to to
#       Replace the print statement wth your code
#
#print("This program should read %s file, perform rank %d approximation, and save the results in %s and %s files." % (inputfile, rank, outputpng, outputnpy))
