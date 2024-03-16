#! /usr/bin/env hy

"""
@author: tjdwill
@date: 15 March 2024
@title: Hy Exploration: Basic Matplotlib plotting
"""

(import numpy :as np
        matplotlib :as mpl
        matplotlib.pyplot :as plt)
; mpl config
(try
    (setv (. mpl rcParams ["figure.dpi"]) 200)
    (mpl.use "qtagg")
    (except [e [AttributeError KeyError]]
        (print f"There is a problem.\n{e}")
        (raise)))

; Basic plot
(setv data0 
    {"x" (np.arange 100) "y_data" (* 2 (np.arange 100))})

(setv [fig ax] (plt.subplots))
(ax.set :title "Sample plot" :xlabel "X" :ylabel "Y")
(ax.grid :axis "both")
(ax.plot "x" "y_data" :data data0
    ;:marker "o" :markersize 2
    :color "C0" :linestyle "-")
(. plt (show))


