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

.PHONY: all exercices feuilles concours catalogue check test f w wf ws clean help
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

# Compile aussi les modèles, afin qu’ils restent utilisables lors des évolutions de la bibliothèque.
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

f:
	@test -f "feuilles/$(F_SANS_PREFIXE).typ" || { echo "Feuille introuvable : $(F)"; exit 1; }
	$(MAKE) "build/feuilles/$(F_SANS_PREFIXE).pdf" "build/feuilles/$(F_SANS_PREFIXE)-corrige.pdf"

w:
	@test -f "exercices/$(E_SANS_PREFIXE).typ" || { echo "Exercice introuvable : $(E)"; exit 1; }
	@mkdir -p "build/exercices/$(E_SANS_PREFIXE)"
	$(TYPST) compile $(TYPST_FLAGS) --input "exercice=/exercices/$(E_SANS_PREFIXE).typ" --input "corrige=$(C)" templates/fiche.typ "build/exercices/$(E_SANS_PREFIXE)/apercu.pdf"
	@if [ "$(O)" = "1" ]; then $(O_PDF) "build/exercices/$(E_SANS_PREFIXE)/apercu.pdf"; fi
	$(TYPST) w $(TYPST_FLAGS) --input "exercice=/exercices/$(E_SANS_PREFIXE).typ" --input "corrige=$(C)" templates/fiche.typ "build/exercices/$(E_SANS_PREFIXE)/apercu.pdf"

wf:
	@test -f "feuilles/$(F_SANS_PREFIXE).typ" || { echo "Feuille introuvable : $(F)"; exit 1; }
	@mkdir -p "build/feuilles/$(dir $(F_SANS_PREFIXE))"
	$(TYPST) compile $(TYPST_FLAGS) --input "corrige=$(C)" "feuilles/$(F_SANS_PREFIXE).typ" "build/feuilles/$(F_SANS_PREFIXE)-apercu.pdf"
	@if [ "$(O)" = "1" ]; then $(O_PDF) "build/feuilles/$(F_SANS_PREFIXE)-apercu.pdf"; fi
	$(TYPST) w $(TYPST_FLAGS) --input "corrige=$(C)" "feuilles/$(F_SANS_PREFIXE).typ" "build/feuilles/$(F_SANS_PREFIXE)-apercu.pdf"

ws:
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
	@echo "make f F=feuilles/langages/td-kleene.typ"
	@echo "make w E=exercices/langage/ensembles-inevitables.typ [C=true] [O=0]"
	@echo "make wf F=langages [C=true] [O=0]"
	@echo "make ws S=22/centrale-2022-mp-informatique [C=true] [O=0]"
	@echo "make catalogue        Régénérer build/catalogue.json"
	@echo "make clean            Supprimer uniquement build/"
