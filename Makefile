# Typst Project | Makefile
#
TYPST = typst
OUT_DIR = out

# Encuentro todos los .typ, asumiendo que van a ser compilados a .pdf
DOCS = $(wildcard *.typ)
PDF_FILES := $(addprefix out/,$(DOCS:.typ=.pdf))

.PHONY: all tutorial conference
default:help

help: ## Muestra esta ayuda
	@echo "╔══════════════════════════════════════════════════════════════╗"
	@echo "║                    🚀 TYPST MAKEFILE 🚀                      ║"
	@echo "║        Entorno de desarrollo para documentos Typst           ║"
	@echo "╠══════════════════════════════════════════════════════════════╣"
	@echo "║  v1.0                                      2025 × germansc   ║"
	@echo "╚══════════════════════════════════════════════════════════════╝"
	@awk 'BEGIN {FS = ":.*##"; printf "Uso:\n  make \033[36m<target>\033[0m\n\nTARGETS:\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)
	@echo ""
	@echo -e "\033[33mEjemplo:\033[0m "
	@echo "  make conference"
	@echo ""

all: $(PDF_FILES) ## Compila todos los archivos *.typ

# Targets Individuales
conference: out/conference.pdf ## Compila el archivo conference.typ
tutorial: out/tutorial.pdf ## Compila el archivo tutorial.typ

# Generic compile rule
out/%.pdf: %.typ | $(OUT_DIR)
	@echo "> Compilando $< → $@"
	$(TYPST) compile $< $@
	@echo ""

$(OUT_DIR):
	@echo "> Creando directorio de salida: $(OUT_DIR)/"
	mkdir -p $@
	@echo ""

clean: ## Limpia los archivos generados
	@echo "> Limpiando archivos generados..."
	rm -rf $(OUT_DIR)
	@echo ""

