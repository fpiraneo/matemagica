# Matemagica

**Libro di supporto per l’apprendimento della matematica nelle scuole medie**
*Ispirato al Piano di studio DECS, Canton Ticino, Svizzera*

---

## Colophon

*Matemagica* è un libro di testo di matematica pensato per gli allievi delle scuole medie del Canton Ticino (Svizzera), fascia d'età 11–14 anni, in conformità con il Piano di studio del DECS (Dipartimento dell'Educazione, della Cultura e dello Sport).

Il progetto nasce con una forte vocazione all'**accessibilità**: il testo è progettato per essere fruibile da tutti gli studenti, inclusi quelli con dislessia, discalculia e profili neurodivergenti (ADHD, Asperger).

### Dati tipografici

| Voce | Dettaglio |
|---|---|
| **Titolo** | Matemagica |
| **Sottotitolo** | Libro di matematica per le scuole medie |
| **Autore** | Francesco ed Emma Piraneo Giuliano |
| **Composizione e ottimizzazione** | Claude Sonnet |
| **Lingua** | Italiano |
| **Riferimento curricolare** | Ispirato al piano di studio DECS, Canton Ticino |
| **Fascia scolastica** | Scuola media, anni 1–4 (età 11–14) |
| **Formato** | A5, ottimizzato per stampa e lettura digitale (PDF) |
| **Composizione** | LuaLaTeX |
| **Font testo** | [Atkinson Hyperlegible](https://brailleinstitute.org/freefont) — Braille Institute |
| **Font matematica** | Latin Modern Math |
| **Versione corrente** | [vedi tag su GitHub] |

### Generazione del PDF

Il progetto richiede una distribuzione TeX moderna con LuaLaTeX.

```bash
# Doppio passaggio (necessario per riferimenti incrociati)
lualatex main.tex
lualatex main.tex
```

Il font **Atkinson Hyperlegible** deve essere installato nel sistema operativo prima della compilazione. È scaricabile gratuitamente da: https://brailleinstitute.org/freefont

### Struttura della repository

```
matemagica/
├── main.tex                  # File principale
├── preamble.tex              # Pacchetti, font, macro, colori
├── stili/
│   └── riquadri.tex          # Ambienti tcolorbox (definizione, regola, ecc.)
├── capitoli/                 # Un file .tex per capitolo
├── immagini/                 # Figure e schemi TikZ/PDF
├── LICENSE.txt               # Licenza d'uso (CC BY-NC-SA 4.0)
└── README.md                 # Questo file
```

---

## Licenza e Condizioni d'Uso

[![Licenza: CC BY-NC-SA 4.0](https://img.shields.io/badge/Licenza-CC%20BY--NC--SA%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by-nc-sa/4.0/deed.it)

Quest'opera è distribuita con licenza **Creative Commons Attribuzione – Non Commerciale – Condividi allo stesso modo 4.0 Internazionale (CC BY-NC-SA 4.0)**.

### ⚠️ Avvisi importanti

> **USO COMMERCIALE VIETATO.**
> È espressamente vietato qualsiasi uso commerciale di questo materiale, anche parziale: vendita, inclusione in prodotti a pagamento, monetizzazione tramite pubblicità o piattaforme in abbonamento.

> **ATTRIBUZIONE OBBLIGATORIA.**
> Qualsiasi utilizzo, riproduzione o adattamento — anche parziale — deve includere un riferimento esplicito e visibile a quest'opera e al suo autore, con link alla repository GitHub.

> **CONDIVIDI ALLO STESSO MODO.**
> Le opere derivate devono essere distribuite con la stessa licenza CC BY-NC-SA 4.0.

### Formula di attribuzione richiesta

```
Matemagica
di Francesco ed Emma Piraneo Giuliano.
Distribuito con licenza CC BY-NC-SA 4.0.
Fonte: https://github.com/fpiraneo/matemagica
```

Per il testo completo della licenza, vedi [`LICENSE.txt`](./LICENSE.txt).

---

## Disclaimer

- I contenuti sono stati redatti con cura ispirandosi al Piano di studio DECS, ma **non garantiscono completezza o aggiornamento** rispetto a versioni successive del curricolo ufficiale.
- Il materiale è fornito **"così com'è"**, senza garanzie di alcun tipo. L'autore declina ogni responsabilità per eventuali errori od omissioni.
- Questo progetto **non ha alcun endorsement ufficiale** da parte del DECS, del Canton Ticino o di qualsiasi istituzione scolastica.
- Il materiale **non sostituisce** l'insegnamento frontale di un docente qualificato.

---

## Contatti

Per segnalare errori, proporre correzioni o richiedere autorizzazioni speciali:
aprire una [Issue](https://github.com/fpiraneo/matemagica/issues) su GitHub.
