#!/usr/bin/env bash
# =============================================================
# build.sh
# Script di compilazione per il progetto Matemagica
# LuaLaTeX — doppio passaggio per riferimenti incrociati
#
# Uso:
#   ./build.sh          — compilazione completa
#   ./build.sh clean    — pulizia file temporanei
#   ./build.sh watch    — ricompila ad ogni salvataggio
# =============================================================

set -euo pipefail

# -------------------------------------------------------------
# PATH ESPLICITO — necessario quando lanciato da editor (Zed)
# che non eredita il PATH completo della shell interattiva
# -------------------------------------------------------------
export PATH="/Library/TeX/texbin:/usr/local/bin:/usr/bin:/bin:$PATH"

# -------------------------------------------------------------
# CONFIGURAZIONE
# -------------------------------------------------------------
MAIN="main"                   # Nome del file principale (senza .tex)
BUILD_DIR="build"             # Cartella output file temporanei
OUTPUT_DIR="."                # Dove mettere il PDF finale
LOGFILE="$BUILD_DIR/build.log"

# Colori per output terminale
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# -------------------------------------------------------------
# FUNZIONI
# -------------------------------------------------------------

log_info()    { echo -e "${BLUE}[INFO]${NC}  $1"; }
log_ok()      { echo -e "${GREEN}[OK]${NC}    $1"; }
log_warn()    { echo -e "${YELLOW}[WARN]${NC}  $1"; }
log_error()   { echo -e "${RED}[ERROR]${NC} $1"; }

# Verifica che lualatex sia installato
check_deps() {
    if ! command -v lualatex &> /dev/null; then
        log_error "lualatex non trovato nel PATH: $PATH"
        log_error "Installa TeX Live oppure aggiorna il PATH in build.sh"
        exit 1
    fi
    log_info "lualatex: $(which lualatex)"
}

# Crea la cartella build se non esiste
setup_build_dir() {
    mkdir -p "$BUILD_DIR"
}

# Compilazione singola LuaLaTeX
run_lualatex() {
    local pass=$1
    log_info "Passaggio $pass/2 — lualatex..."

    lualatex \
        --interaction=nonstopmode \
        --halt-on-error \
        --output-directory="$BUILD_DIR" \
        "$MAIN.tex" \
        >> "$LOGFILE" 2>&1

    local exit_code=$?
    if [ $exit_code -ne 0 ]; then
        log_error "Compilazione fallita al passaggio $pass."
        log_error "Log completo: $LOGFILE"
        echo ""
        echo -e "${RED}── Errori rilevati ───────────────────────────────${NC}"
        grep -E "^!" "$LOGFILE" | head -20 || true
        echo -e "${RED}── Ultime 20 righe del log ───────────────────────${NC}"
        tail -20 "$LOGFILE"
        echo -e "${RED}──────────────────────────────────────────────────${NC}"
        exit 1
    fi
}

# Compilazione completa (doppio passaggio)
build() {
    check_deps
    setup_build_dir

    # Pulisce il log precedente
    > "$LOGFILE"

    log_info "Compilazione di $MAIN.tex..."
    echo ""

    run_lualatex 1
    run_lualatex 2

    # Copia il PDF nella cartella output
    if [ -f "$BUILD_DIR/$MAIN.pdf" ]; then
        cp "$BUILD_DIR/$MAIN.pdf" "$OUTPUT_DIR/$MAIN.pdf"
        log_ok "PDF generato: $OUTPUT_DIR/$MAIN.pdf"
    else
        log_error "PDF non trovato dopo la compilazione."
        exit 1
    fi

    echo ""
    log_ok "Compilazione completata."
}

# Pulizia file temporanei
clean() {
    log_info "Pulizia file temporanei..."
    rm -rf "$BUILD_DIR"
    log_ok "Cartella $BUILD_DIR rimossa."
}

# Modalità watch — ricompila ad ogni modifica dei .tex
watch() {
    if ! command -v fswatch &> /dev/null; then
        log_warn "fswatch non trovato. Installa con: brew install fswatch"
        log_warn "Alternativa su Linux: sudo apt install inotify-tools"
        log_warn "Poi usa: while inotifywait -e modify \$(find . -name '*.tex'); do ./build.sh; done"
        exit 1
    fi

    log_info "Modalità watch attiva. Premi Ctrl+C per uscire."
    log_info "In ascolto su modifiche ai file .tex..."
    echo ""

    fswatch -o $(find . -name "*.tex") | while read num_events; do
        echo ""
        log_info "Modifica rilevata — ricompilazione..."
        build || true   # Continua anche in caso di errore
    done
}

# -------------------------------------------------------------
# MAIN
# -------------------------------------------------------------
case "${1:-build}" in
    build)  build  ;;
    clean)  clean  ;;
    watch)  watch  ;;
    *)
        echo "Uso: $0 [build|clean|watch]"
        exit 1
        ;;
esac
