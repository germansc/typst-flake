# Typst project Makefile
#
TYPST = typst
OUT_DIR = out

# Encuentro todos los .typ, asumiendo que van a ser compilados a .pdf
DOCS = $(wildcard *.typ)
PDF_FILES := $(addprefix out/,$(DOCS:.typ=.pdf))

.PHONY: all tutorial conference
default:all

# Individual targets
conference: out/conference.pdf
tutorial: out/tutorial.pdf

all: $(PDF_FILES)

# Generic compile rule
out/%.pdf: %.typ | $(OUT_DIR)
	@echo "> Compilando $< → $@"
	typst compile $< $@
	@echo ""

$(OUT_DIR):
	@echo "> Creando directorio de salida: $(OUT_DIR)/"
	mkdir -p $@
	@echo ""

clean:
	@echo "> Limpiando archivos generados..."
	rm -rf $(OUT_DIR)
	@echo ""

