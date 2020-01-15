Flight Radar

Mapa świata z zaznaczonymi lotniskami, lotami, samolotami, helikopterami, wszystkim co lata.
Trochę jak www.flightradar24.com

Funkcjonalności:

Wizualizuje aktualne loty.
Generuje nowe loty pseudolosowo.
Generuje losowo wydarzenia pogodowe które wykluczają lotniska z użycia.
Może najpierw 2d a jak się uda to 3d, zobaczymy jak to będzie.
Samoloty kołują nad lotniskiem jeżeli nie ma dostępnych pasów startowych.
Zdarzenia losowe (wypadki, awaryjne lądowania).

language: Python (flask) + SQL
GUI: JavaScript + HTML + CSS

encje:
-flight
    name/code
    origin
    destination
    estimated flight time

-aircraft
    name/code
    type
    registration num
    country of registration

-aircraft_type
    specs

-airport
    name
    code
    location
    country
    timezone

-aircraft carrier
    name
    code
...
