.DEFAULT_GOAL := all
.DELETE_ON_ERROR:

TYPST ?= typst
PYTHON ?= python3
TYPST_FLAGS := --root . --ignore-system-fonts
E ?= langage/ensembles-inevitables
F ?= langages
C ?= true
O ?= 1
E_SANS_EXTENSION := $(patsubst %.typ,%,$(E))
E_SANS_PREFIXE := $(patsubst exercices/%,%,$(E_SANS_EXTENSION))
F_SANS_EXTENSION := $(patsubst %.typ,%,$(F))
F_SANS_PREFIXE := $(patsubst feuilles/%,%,$(F_SANS_EXTENSION))
ifeq ($(shell uname -s),Darwin)
O_PDF ?= open -a "Visual Studio Code"
else
O_PDF ?= code --reuse-window
endif

EXERCICES := $(patsubst exercices/%.typ,%,$(shell find exercices -mindepth 2 -maxdepth 2 -name '*.typ' | sort))
FS := $(patsubst feuilles/%.typ,%,$(wildcard feuilles/*.typ))
# Dépendances conservatrices : un import ou une image modifiés déclenchent la compilation.
SOURCES := $(shell find lib modeles exercices feuilles $(wildcard ressources) -type f | sort)
PDF_EXERCICES := $(foreach ex,$(EXERCICES),build/exercices/$(ex)/enonce.pdf build/exercices/$(ex)/corrige.pdf)
PDF_FS := $(foreach f,$(FS),build/feuilles/$(f).pdf build/feuilles/$(f)-corrige.pdf)

.PHONY: all exercices feuilles catalogue check w wf clean help
all: exercices feuilles catalogue
exercices: $(PDF_EXERCICES)
feuilles: $(PDF_FS)

build/exercices/%/enonce.pdf: exercices/%.typ $(SOURCES) Makefile
	@mkdir -p "$(@D)"
	$(TYPST) compile $(TYPST_FLAGS) --input "exercice=/exercices/$*.typ" modeles/fiche.typ "$@"

build/exercices/%/corrige.pdf: exercices/%.typ $(SOURCES) Makefile
	@mkdir -p "$(@D)"
	$(TYPST) compile $(TYPST_FLAGS) --input "exercice=/exercices/$*.typ" --input corrige=true modeles/fiche.typ "$@"

build/feuilles/%-corrige.pdf: feuilles/%.typ $(SOURCES) Makefile
	@mkdir -p "$(@D)"
	$(TYPST) compile $(TYPST_FLAGS) --input corrige=true "$<" "$@"

build/feuilles/%.pdf: feuilles/%.typ $(SOURCES) Makefile
	@mkdir -p "$(@D)"
	$(TYPST) compile $(TYPST_FLAGS) "$<" "$@"

catalogue:
	@mkdir -p build
	$(PYTHON) scripts/catalogue.py --typst "$(TYPST)" --sortie build/catalogue.json

# Compile aussi les modèles, afin qu’ils restent utilisables lors des évolutions de la bibliothèque.
check: all
	@mkdir -p build/modeles
	$(TYPST) compile $(TYPST_FLAGS) modeles/fiche.typ build/modeles/exercice.pdf
	$(TYPST) compile $(TYPST_FLAGS) --input corrige=true modeles/fiche.typ build/modeles/exercice-corrige.pdf
	$(TYPST) compile $(TYPST_FLAGS) modeles/feuille.typ build/modeles/feuille.pdf
	$(TYPST) compile $(TYPST_FLAGS) --input corrige=true modeles/feuille.typ build/modeles/feuille-corrige.pdf

w:
	@test -f "exercices/$(E_SANS_PREFIXE).typ" || { echo "Exercice introuvable : $(E)"; exit 1; }
	@mkdir -p "build/exercices/$(E_SANS_PREFIXE)"
	$(TYPST) compile $(TYPST_FLAGS) --input "exercice=/exercices/$(E_SANS_PREFIXE).typ" --input "corrige=$(C)" modeles/fiche.typ "build/exercices/$(E_SANS_PREFIXE)/apercu.pdf"
	@if [ "$(O)" = "1" ]; then $(O_PDF) "build/exercices/$(E_SANS_PREFIXE)/apercu.pdf"; fi
	$(TYPST) w $(TYPST_FLAGS) --input "exercice=/exercices/$(E_SANS_PREFIXE).typ" --input "corrige=$(C)" modeles/fiche.typ "build/exercices/$(E_SANS_PREFIXE)/apercu.pdf"

wf:
	@test -f "feuilles/$(F_SANS_PREFIXE).typ" || { echo "Feuille introuvable : $(F)"; exit 1; }
	@mkdir -p build/feuilles
	$(TYPST) compile $(TYPST_FLAGS) --input "corrige=$(C)" "feuilles/$(F_SANS_PREFIXE).typ" "build/feuilles/$(F_SANS_PREFIXE)-apercu.pdf"
	@if [ "$(O)" = "1" ]; then $(O_PDF) "build/feuilles/$(F_SANS_PREFIXE)-apercu.pdf"; fi
	$(TYPST) w $(TYPST_FLAGS) --input "corrige=$(C)" "feuilles/$(F_SANS_PREFIXE).typ" "build/feuilles/$(F_SANS_PREFIXE)-apercu.pdf"

clean:
	rm -rf build

help:
	@echo "make                  Énoncés, corrigés, feuilles et catalogue JSON"
	@echo "make check            Tout compiler, modèles inclus ; valider les métadonnées"
	@echo "make w E=exercices/langage/ensembles-inevitables.typ [C=true] [O=0]"
	@echo "make wf F=langages [C=true] [O=0]"
	@echo "make catalogue        Régénérer build/catalogue.json"
	@echo "make clean            Supprimer uniquement build/"
