.DEFAULT_GOAL := all
.DELETE_ON_ERROR:

TYPST ?= typst
PYTHON ?= python3
OCAML ?= ocaml
TYPST_FLAGS := --root . --ignore-system-fonts
E ?= langage/ensembles-inevitables
F ?= langages
S ?= 22/centrale-2022-mp-informatique
C ?= true
O ?= 1
E_SANS_EXTENSION := $(patsubst %.typ,%,$(E))
E_SANS_PREFIXE := $(patsubst exercices/%,%,$(E_SANS_EXTENSION))
F_SANS_EXTENSION := $(patsubst %.typ,%,$(F))
F_SANS_PREFIXE := $(patsubst feuilles/%,%,$(F_SANS_EXTENSION))
S_SANS_EXTENSION := $(patsubst %.typ,%,$(S))
S_SANS_PREFIXE := $(patsubst concours/%,%,$(S_SANS_EXTENSION))
# Seuls les raccourcis c/w ont un argument de chemin à déclarer .PHONY.
# Les PDF demandés par leurs sous-make doivent conserver leurs règles implicites.
CIBLE := $(if $(filter w c,$(MAKECMDGOALS)),$(filter-out w c,$(MAKECMDGOALS)))
WATCH_CIBLE := $(if $(filter w,$(MAKECMDGOALS)),$(CIBLE))
COMPILE_CIBLE := $(if $(filter c,$(MAKECMDGOALS)),$(CIBLE))
ifeq ($(shell uname -s),Darwin)
O_PDF ?= open -a "Visual Studio Code"
else
O_PDF ?= code --reuse-window
endif

EXERCICES := $(patsubst exercices/%.typ,%,$(shell find exercices -mindepth 2 -maxdepth 2 -name '*.typ' | sort))
FS := $(patsubst feuilles/%.typ,%,$(wildcard feuilles/*.typ))
CONCOURS := $(patsubst concours/%.typ,%,$(shell find concours -name '*.typ' | sort))
# Dépendances conservatrices : un import ou une image modifiés déclenchent la compilation.
SOURCES := $(shell find lib templates exercices feuilles concours $(wildcard ressources) -type f | sort)
PDF_EXERCICES := $(foreach ex,$(EXERCICES),build/exercices/$(ex)/enonce.pdf build/exercices/$(ex)/corrige.pdf)
PDF_FS := $(foreach f,$(FS),build/feuilles/$(f).pdf build/feuilles/$(f)-corrige.pdf)
PDF_CONCOURS := $(foreach s,$(CONCOURS),build/concours/$(s)/enonce.pdf build/concours/$(s)/corrige.pdf)

.PHONY: all exercices feuilles concours catalogue check test c w _w-exercice _w-feuille _w-concours clean help $(CIBLE)
all: exercices feuilles concours catalogue
exercices: $(PDF_EXERCICES)
feuilles: $(PDF_FS)
concours: $(PDF_CONCOURS)

build/concours/%/enonce.pdf: concours/%.typ $(SOURCES) Makefile
	@mkdir -p "$(@D)"
	$(TYPST) compile $(TYPST_FLAGS) --input "exercice=/concours/$*.typ" templates/fiche.typ "$@"

build/concours/%/corrige.pdf: concours/%.typ $(SOURCES) Makefile
	@mkdir -p "$(@D)"
	$(TYPST) compile $(TYPST_FLAGS) --input "exercice=/concours/$*.typ" --input corrige=true templates/fiche.typ "$@"

build/exercices/%/enonce.pdf: exercices/%.typ $(SOURCES) Makefile
	@mkdir -p "$(@D)"
	$(TYPST) compile $(TYPST_FLAGS) --input "exercice=/exercices/$*.typ" templates/fiche.typ "$@"

build/exercices/%/corrige.pdf: exercices/%.typ $(SOURCES) Makefile
	@mkdir -p "$(@D)"
	$(TYPST) compile $(TYPST_FLAGS) --input "exercice=/exercices/$*.typ" --input corrige=true templates/fiche.typ "$@"

build/feuilles/%-corrige.pdf: feuilles/%.typ $(SOURCES) Makefile
	@mkdir -p "$(@D)"
	$(TYPST) compile $(TYPST_FLAGS) --input corrige=true "$<" "$@"

build/feuilles/%.pdf: feuilles/%.typ $(SOURCES) Makefile
	@mkdir -p "$(@D)"
	$(TYPST) compile $(TYPST_FLAGS) "$<" "$@"

catalogue:
	@mkdir -p build
	$(PYTHON) scripts/catalogue.py --typst "$(TYPST)" --sortie build/catalogue.json

# Compile aussi les modèles, afin qu'ils restent utilisables lors des évolutions de la bibliothèque.
check: all test
	@mkdir -p build/templates
	$(TYPST) compile $(TYPST_FLAGS) templates/fiche.typ build/templates/exercice.pdf
	$(TYPST) compile $(TYPST_FLAGS) --input corrige=true templates/fiche.typ build/templates/exercice-corrige.pdf
	$(TYPST) compile $(TYPST_FLAGS) templates/feuille.typ build/templates/feuille.pdf
	$(TYPST) compile $(TYPST_FLAGS) --input corrige=true templates/feuille.typ build/templates/feuille-corrige.pdf
	$(TYPST) compile $(TYPST_FLAGS) --input exercice=/templates/sujet-concours.typ templates/fiche.typ build/templates/concours.pdf
	$(TYPST) compile $(TYPST_FLAGS) --input exercice=/templates/sujet-concours.typ --input corrige=true templates/fiche.typ build/templates/concours-corrige.pdf

test:
	@mkdir -p build/ressources/centrale-2022-mp-informatique
	$(TYPST) compile $(TYPST_FLAGS) ressources/centrale-2022-mp-informatique/test.typ build/ressources/centrale-2022-mp-informatique/test.pdf
	$(OCAML) -I ressources/centrale-2022-mp-informatique ressources/centrale-2022-mp-informatique/test.ml
	@mkdir -p build/ressources/mines-ponts-2019-mp-informatique
	$(TYPST) compile $(TYPST_FLAGS) ressources/mines-ponts-2019-mp-informatique/test.typ build/ressources/mines-ponts-2019-mp-informatique/test.pdf
	$(TYPST) compile $(TYPST_FLAGS) --input corrige=true ressources/mines-ponts-2019-mp-informatique/test.typ build/ressources/mines-ponts-2019-mp-informatique/test-corrige.pdf
	$(OCAML) -I ressources/mines-ponts-2019-mp-informatique ressources/mines-ponts-2019-mp-informatique/test.ml
	$(OCAML) -I ressources/grammaires-lineaires ressources/grammaires-lineaires/test.ml
	$(PYTHON) ressources/ens-2018-mp-reparation-langage/test.py

c:
	@case "$(COMPILE_CIBLE)" in \
	  exercices/*) \
	    chemin="$(COMPILE_CIBLE)"; nom="$${chemin#exercices/}"; nom="$${nom%.typ}"; \
	    test -f "exercices/$${nom}.typ" || { echo "Exercice introuvable : $(COMPILE_CIBLE)"; exit 1; }; \
	    $(MAKE) "build/exercices/$${nom}/enonce.pdf" "build/exercices/$${nom}/corrige.pdf" ;; \
	  feuilles/*) \
	    chemin="$(COMPILE_CIBLE)"; nom="$${chemin#feuilles/}"; nom="$${nom%.typ}"; \
	    test -f "feuilles/$${nom}.typ" || { echo "Feuille introuvable : $(COMPILE_CIBLE)"; exit 1; }; \
	    $(MAKE) "build/feuilles/$${nom}.pdf" "build/feuilles/$${nom}-corrige.pdf" ;; \
	  concours/*) \
	    chemin="$(COMPILE_CIBLE)"; nom="$${chemin#concours/}"; nom="$${nom%.typ}"; \
	    test -f "concours/$${nom}.typ" || { echo "Sujet introuvable : $(COMPILE_CIBLE)"; exit 1; }; \
	    $(MAKE) "build/concours/$${nom}/enonce.pdf" "build/concours/$${nom}/corrige.pdf" ;; \
	  "") echo "Indiquer le chemin d'un exercice, d'une feuille ou d'un sujet"; exit 1 ;; \
	  *) echo "Chemin à compiler invalide : $(COMPILE_CIBLE)"; exit 1 ;; \
	esac

w:
	@case "$(WATCH_CIBLE)" in \
	  "") $(MAKE) _w-exercice E="$(E)" C="$(C)" O="$(O)" ;; \
	  exercices/*) $(MAKE) _w-exercice E="$(WATCH_CIBLE)" C="$(C)" O="$(O)" ;; \
	  feuilles/*) $(MAKE) _w-feuille F="$(WATCH_CIBLE)" C="$(C)" O="$(O)" ;; \
	  concours/*) $(MAKE) _w-concours S="$(WATCH_CIBLE)" C="$(C)" O="$(O)" ;; \
	  *) echo "Chemin à surveiller invalide : $(WATCH_CIBLE)"; exit 1 ;; \
	esac

_w-exercice:
	@test -f "exercices/$(E_SANS_PREFIXE).typ" || { echo "Exercice introuvable : $(E)"; exit 1; }
	@mkdir -p "build/exercices/$(E_SANS_PREFIXE)"
	$(TYPST) compile $(TYPST_FLAGS) --input "exercice=/exercices/$(E_SANS_PREFIXE).typ" --input "corrige=$(C)" templates/fiche.typ "build/exercices/$(E_SANS_PREFIXE)/apercu.pdf"
	@if [ "$(O)" = "1" ]; then $(O_PDF) "build/exercices/$(E_SANS_PREFIXE)/apercu.pdf"; fi
	$(TYPST) w $(TYPST_FLAGS) --input "exercice=/exercices/$(E_SANS_PREFIXE).typ" --input "corrige=$(C)" templates/fiche.typ "build/exercices/$(E_SANS_PREFIXE)/apercu.pdf"

_w-feuille:
	@test -f "feuilles/$(F_SANS_PREFIXE).typ" || { echo "Feuille introuvable : $(F)"; exit 1; }
	@mkdir -p "build/feuilles/$(dir $(F_SANS_PREFIXE))"
	$(TYPST) compile $(TYPST_FLAGS) --input "corrige=$(C)" "feuilles/$(F_SANS_PREFIXE).typ" "build/feuilles/$(F_SANS_PREFIXE)-apercu.pdf"
	@if [ "$(O)" = "1" ]; then $(O_PDF) "build/feuilles/$(F_SANS_PREFIXE)-apercu.pdf"; fi
	$(TYPST) w $(TYPST_FLAGS) --input "corrige=$(C)" "feuilles/$(F_SANS_PREFIXE).typ" "build/feuilles/$(F_SANS_PREFIXE)-apercu.pdf"

_w-concours:
	@test -f "concours/$(S_SANS_PREFIXE).typ" || { echo "Sujet introuvable : $(S)"; exit 1; }
	@mkdir -p "build/concours/$(S_SANS_PREFIXE)"
	$(TYPST) compile $(TYPST_FLAGS) --input "exercice=/concours/$(S_SANS_PREFIXE).typ" --input "corrige=$(C)" templates/fiche.typ "build/concours/$(S_SANS_PREFIXE)/apercu.pdf"
	@if [ "$(O)" = "1" ]; then $(O_PDF) "build/concours/$(S_SANS_PREFIXE)/apercu.pdf"; fi
	$(TYPST) w $(TYPST_FLAGS) --input "exercice=/concours/$(S_SANS_PREFIXE).typ" --input "corrige=$(C)" templates/fiche.typ "build/concours/$(S_SANS_PREFIXE)/apercu.pdf"

clean:
	rm -rf build

help:
	@echo "make                  Énoncés, corrigés, feuilles, sujets et catalogue JSON"
	@echo "make concours         Compiler les sujets de concours et leurs corrigés"
	@echo "make check            Tout compiler, modèles inclus ; valider les métadonnées"
	@echo "make c exercices/langages/residuels-minimisation.typ  # Énoncé et corrigé"
	@echo "make c feuilles/td-kleene.typ"
	@echo "make c concours/22/centrale-2022-mp-informatique.typ"
	@echo "make w exercices/langage/ensembles-inevitables.typ [C=true] [O=0]"
	@echo "make w feuilles/td-kleene.typ [C=true] [O=0]"
	@echo "make w concours/22/centrale-2022-mp-informatique.typ [C=true] [O=0]"
	@echo "make catalogue        Régénérer build/catalogue.json"
	@echo "make clean            Supprimer uniquement build/"
