# Typst Project | Makefile
#
TYPST = typst
OUT_DIR = out

help: ## Shows this help
	@echo "╔══════════════════════════════════════════════════════════════╗"
	@echo "║                       TYPST MAKEFILE                         ║"
	@echo "╠══════════════════════════════════════════════════════════════╣"
	@echo "║  v1.0                                      2025 × germansc   ║"
	@echo "╚══════════════════════════════════════════════════════════════╝"
	@awk 'BEGIN {FS = ":.*##"; printf "Uso:\n  make \033[36m<target>\033[0m\n\nTARGETS:\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)
	@echo ""
	@echo "\033[33mExample:\033[0m"
	@echo "  make paper"
	@echo ""

# Gather all .typ files, assuming they will be compiled to x.pdf
DOCS = $(wildcard *.typ)
PDF_FILES := $(addprefix $(OUT_DIR)/,$(DOCS:.typ=.pdf))

.PHONY: all cheatsheet paper clean help
default: help

all: $(PDF_FILES)

cheatsheet: $(OUT_DIR)/cheatsheet.pdf ## Compiles the cheatsheet.pdf file
paper: $(OUT_DIR)/paper.pdf ## Compiles the paper.pdf file

$(OUT_DIR)/%.pdf: %.typ | $(OUT_DIR)
	@echo "Compiling $< -> $@"
	$(TYPST) compile $< $@

$(OUT_DIR):
	mkdir -p $@

clean:
	rm -rf $(OUT_DIR)
