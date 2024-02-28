-module(lab1).
-export([
    polyhedrons_classifier/1
]).

% function: polyhedrons_classifier
% (sides_count) -> polyhedron_title

polyhedrons_classifier(4) ->
    'Tetrahedron';
polyhedrons_classifier(6) ->
    'Cube';
polyhedrons_classifier(8) ->
    'Octahedron';
polyhedrons_classifier(12) ->
    'Dodecahedron';
polyhedrons_classifier(20) ->
    'Icosahedron';
polyhedrons_classifier(_) ->
    'Undefined'.
