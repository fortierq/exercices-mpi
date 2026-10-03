.DEFAULT_GOAL := all
.DELETE_ON_ERROR:

TYPST ?= typst
PYTHON ?= python3
OCAML ?= ocaml
TYPST_FLAGS := --root . --ignore-system-fonts
C ?= true
O ?= 1
CIBLE := $(if $(filter w c,$(MAKECMDGOALS)),$(filter-out w c,$(MAKECMDGOALS)))
VARIANTE := $(if $(filter true,$(C)),corrige,enonce)
ifeq ($(shell uname -s),Darwin)
O_PDF ?= open -a "Visual Studio Code"
else
O_PDF ?= code --reuse-window
endif

# Le contenu détermine la catégorie, jamais le dossier.
EXERCICES := $(shell $(PYTHON) scripts/sources.py --list exercices)
DOCUMENTS := $(shell $(PYTHON) scripts/sources.py --list documents)
SOURCES := $(shell find . -type f \( -name '*.typ' -o -name '*.py' -o -name '*.json' -o -name '*.png' -o -name '*.svg' -o -name '*.ml' \) -not -path './build/*' -not -path './.git/*')
pdfs = $(foreach source,$(1),build/$(patsubst %.typ,%,$(source))/enonce.pdf build/$(patsubst %.typ,%,$(source))/corrige.pdf)

.PHONY: all exercices documents feuilles devoirs concours catalogue check test c w clean help $(CIBLE)
all: exercices documents catalogue
exercices: $(call pdfs,$(EXERCICES))
documents: $(call pdfs,$(DOCUMENTS))
# Compatibilité des anciens raccourcis ; documents est désormais la cible commune.
feuilles devoirs concours: documents

build/%/enonce.pdf: %.typ $(SOURCES) Makefile
	$(PYTHON) scripts/sources.py --typst "$(TYPST)" --source "$<" --output "$@" --variant enonce

build/%/corrige.pdf: %.typ $(SOURCES) Makefile
	$(PYTHON) scripts/sources.py --typst "$(TYPST)" --source "$<" --output "$@" --variant corrige

# Anciens chemins PDF des TD, encore utilisables depuis des liens existants.
build/feuilles/%-corrige.pdf: feuilles/%.typ $(SOURCES) Makefile
	$(PYTHON) scripts/sources.py --typst "$(TYPST)" --source "$<" --output "$@" --variant corrige

build/feuilles/%.pdf: feuilles/%.typ $(SOURCES) Makefile
	$(PYTHON) scripts/sources.py --typst "$(TYPST)" --source "$<" --output "$@" --variant enonce

catalogue:
	@mkdir -p build
	$(PYTHON) scripts/catalogue.py --typst "$(TYPST)" --sortie build/catalogue.json

# Compile aussi les modèles, afin qu'ils restent utilisables lors des évolutions de la bibliothèque.
check: all test docs
	@mkdir -p build/templates
	$(TYPST) compile $(TYPST_FLAGS) templates/fiche.typ build/templates/exercice.pdf
	$(TYPST) compile $(TYPST_FLAGS) --input corrige=true templates/fiche.typ build/templates/exercice-corrige.pdf
	$(TYPST) compile $(TYPST_FLAGS) templates/feuille.typ build/templates/feuille.pdf
	$(TYPST) compile $(TYPST_FLAGS) --input corrige=true templates/feuille.typ build/templates/feuille-corrige.pdf
	$(TYPST) compile $(TYPST_FLAGS) templates/devoir.typ build/templates/devoir.pdf
	$(TYPST) compile $(TYPST_FLAGS) --input corrige=true templates/devoir.typ build/templates/devoir-corrige.pdf
	$(TYPST) compile $(TYPST_FLAGS) --input exercice=/templates/sujet-concours.typ templates/fiche.typ build/templates/concours.pdf
	$(TYPST) compile $(TYPST_FLAGS) --input exercice=/templates/sujet-concours.typ --input corrige=true templates/fiche.typ build/templates/concours-corrige.pdf
	$(TYPST) compile $(TYPST_FLAGS) templates/copie.typ build/templates/copie.pdf
	$(TYPST) compile $(TYPST_FLAGS) --input corrige=true templates/copie.typ build/templates/copie-corrige.pdf

test:
	@mkdir -p build/ressources/api
	$(PYTHON) ressources/api/test_sources.py
	$(PYTHON) ressources/api/test_notes.py
	$(TYPST) compile $(TYPST_FLAGS) ressources/api/copies.typ build/ressources/api/copies.pdf
	$(TYPST) compile $(TYPST_FLAGS) ressources/api/points.typ build/ressources/api/points.pdf
	$(TYPST) compile $(TYPST_FLAGS) --input corrige=true ressources/api/points.typ build/ressources/api/points-corrige.pdf
	$(TYPST) compile $(TYPST_FLAGS) ressources/api/test.typ build/ressources/api/test.pdf
	$(TYPST) compile $(TYPST_FLAGS) ressources/api/bareme.typ build/ressources/api/bareme.pdf
	$(TYPST) compile $(TYPST_FLAGS) --input corrige=true ressources/api/bareme.typ build/ressources/api/bareme-corrige.pdf
	$(OCAML) -I ressources/centrale-2022-mp-informatique ressources/centrale-2022-mp-informatique/test.ml
	$(OCAML) -I ressources/mines-ponts-2019-mp-informatique ressources/mines-ponts-2019-mp-informatique/test.ml
	$(OCAML) -I ressources/grammaires-lineaires ressources/grammaires-lineaires/test.ml
	$(PYTHON) ressources/ens-2018-mp-reparation-langage/test.py

c:
	@test -n "$(CIBLE)" || { echo "Indiquer le chemin du fichier Typst"; exit 1; }
	$(MAKE) "build/$(patsubst %.typ,%,$(CIBLE))/enonce.pdf" "build/$(patsubst %.typ,%,$(CIBLE))/corrige.pdf"

w:
	@test -n "$(CIBLE)" || { echo "Indiquer le chemin du fichier Typst"; exit 1; }
	$(PYTHON) scripts/sources.py --typst "$(TYPST)" --source "$(CIBLE)" --output "build/$(patsubst %.typ,%,$(CIBLE))/apercu.pdf" --variant $(VARIANTE)
	@if [ "$(O)" = "1" ]; then $(O_PDF) "build/$(patsubst %.typ,%,$(CIBLE))/apercu.pdf"; fi
	$(PYTHON) scripts/sources.py --typst "$(TYPST)" --source "$(CIBLE)" --output "build/$(patsubst %.typ,%,$(CIBLE))/apercu.pdf" --variant $(VARIANTE) --watch

clean:
	rm -rf build

.PHONY: docs
docs: build/docs/api.pdf

build/docs/api.pdf: docs/api.typ lib/exercices.typ lib/meta.typ
	@mkdir -p "$(@D)"
	$(TYPST) compile $(TYPST_FLAGS) "$<" "$@"

help:
	@echo "make              Exercices, documents et catalogue"
	@echo "make check        Tout compiler, modèles et tests inclus"
	@echo "make c chemin.typ Énoncé et corrigé, quel que soit le dossier"
	@echo "make w chemin.typ [C=true] [O=0]  Aperçu surveillé"
	@echo "make catalogue    Régénérer build/catalogue.json"
	@echo "make docs         Documentation Tidy"
