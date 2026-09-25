.DEFAULT_GOAL := all
.DELETE_ON_ERROR:

TYPST ?= typst
PYTHON ?= python3
TYPST_FLAGS := --root . --ignore-system-fonts
EXO ?= langage/ensembles-inevitables
FEUILLE ?= langages
CORRIGE ?= false
OPEN ?= 1
ifeq ($(shell uname -s),Darwin)
OPEN_PDF ?= open -a "Visual Studio Code"
else
OPEN_PDF ?= code --reuse-window
endif

EXERCICES := $(patsubst exercices/%.typ,%,$(shell find exercices -mindepth 2 -maxdepth 2 -name '*.typ' | sort))
FEUILLES := $(patsubst feuilles/%.typ,%,$(wildcard feuilles/*.typ))
# Dépendances conservatrices : un import ou une image modifiés déclenchent la compilation.
SOURCES := $(shell find lib modeles exercices feuilles $(wildcard ressources) -type f | sort)
PDF_EXERCICES := $(foreach ex,$(EXERCICES),build/exercices/$(ex)/enonce.pdf build/exercices/$(ex)/corrige.pdf)
PDF_FEUILLES := $(foreach f,$(FEUILLES),build/feuilles/$(f).pdf build/feuilles/$(f)-corrige.pdf)

.PHONY: all exercices feuilles catalogue check watch watch-feuille clean help
all: exercices feuilles catalogue
exercices: $(PDF_EXERCICES)
feuilles: $(PDF_FEUILLES)

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

watch:
	@test -f "exercices/$(EXO).typ" || { echo "Exercice introuvable : $(EXO)"; exit 1; }
	@mkdir -p "build/exercices/$(EXO)"
	$(TYPST) compile $(TYPST_FLAGS) --input "exercice=/exercices/$(EXO).typ" --input "corrige=$(CORRIGE)" modeles/fiche.typ "build/exercices/$(EXO)/apercu.pdf"
	@if [ "$(OPEN)" = "1" ]; then $(OPEN_PDF) "build/exercices/$(EXO)/apercu.pdf"; fi
	$(TYPST) watch $(TYPST_FLAGS) --input "exercice=/exercices/$(EXO).typ" --input "corrige=$(CORRIGE)" modeles/fiche.typ "build/exercices/$(EXO)/apercu.pdf"

watch-feuille:
	@test -f "feuilles/$(FEUILLE).typ" || { echo "Feuille introuvable : $(FEUILLE)"; exit 1; }
	@mkdir -p build/feuilles
	$(TYPST) compile $(TYPST_FLAGS) --input "corrige=$(CORRIGE)" "feuilles/$(FEUILLE).typ" "build/feuilles/$(FEUILLE)-apercu.pdf"
	@if [ "$(OPEN)" = "1" ]; then $(OPEN_PDF) "build/feuilles/$(FEUILLE)-apercu.pdf"; fi
	$(TYPST) watch $(TYPST_FLAGS) --input "corrige=$(CORRIGE)" "feuilles/$(FEUILLE).typ" "build/feuilles/$(FEUILLE)-apercu.pdf"

clean:
	rm -rf build

help:
	@echo "make                  Énoncés, corrigés, feuilles et catalogue JSON"
	@echo "make check            Tout compiler, modèles inclus ; valider les métadonnées"
	@echo "make watch EXO=langage/ensembles-inevitables [CORRIGE=true] [OPEN=0]"
	@echo "make watch-feuille FEUILLE=langages [CORRIGE=true] [OPEN=0]"
	@echo "make catalogue        Régénérer build/catalogue.json"
	@echo "make clean            Supprimer uniquement build/"
