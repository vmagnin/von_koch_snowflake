# This file is part of the von_koch_snowflake Fortran project.
# Copyright (C) 2023 Vincent MAGNIN
#
# This is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3, or (at your option)
# any later version.
#
# This software is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along with
# this program; see the files LICENSE and LICENSE_EXCEPTION respectively.
# If not, see <http://www.gnu.org/licenses/>.
#------------------------------------------------------------------------------
# Contributed by Vincent Magnin
# Pascal version: 1987 ?
# Python version: 2010
# Fortran version: 2023-06-05
# Last modifications: 2023-06-06
#------------------------------------------------------------------------------

def koch(l,n):
    # Fractale de Koch
    if n<=0:
        forward(l)
    else:
        ll=l/3
        nn=n-1
        koch(ll,nn)
        left(60)
        koch(ll,nn)
        right(120)
        koch(ll,nn)
        left(60)
        koch(ll,nn)

def flocon(l,n):
    # Flocon de Koch
    koch(l,n)
    right(120)
    koch(l,n)
    right(120)
    koch(l,n)

# programme principal
from turtle import *
speed(0)
hideturtle()

etape=int(input("Entrez l'ordre de l'étape du flocon de Von Koch "))
taille1=float(input("Entrez la taille du côté du triangle initial "))
flocon(taille1,etape)

# on utilise une méthode récursive pour programmer les fonctions

print("Appuyez sur Entrée")
pause=input()   # Pour éviter que la fenêtre graphique ne se ferme à la fin du programme !
