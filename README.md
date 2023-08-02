# CIF Demonstration Dictionary

This repository is used to show the process of dictionary creation. The "Concept" directory contains
the earliest drafts. Progress of dictionary creation can be followed by selecting the various commit
tags.

## The process

The dictionary topic is "A microsymposium", that is, a conference session that forms part of a larger
conference. The initial list of concepts is fleshed out in `initial_list.md`, which is then converted
into a graph, described in `first_graph.dot` and visualised in `first_graph.svg`. The various
categories and data names are then listed out in a shorthand way (to save typing those long attribute
names) in `detailed.md` before being converted to the dictionary `microsymposium.dic` using the
shorthand-to-dictionary tool in `Tools/abbrev_to_dic.jl`. Note that not all categories in the graph
have been carried across to the dictionary; that remains an exercise for the reader.
