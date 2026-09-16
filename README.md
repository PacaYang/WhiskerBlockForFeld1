# WhiskerBlock for Fel d 1

Supporting data and analysis files for the Fel d 1 portion of the manuscript:

> **Development of high-affinity, single-domain protein binders for neutralizing household allergens**  
> bioRxiv (2025)  
> [https://doi.org/10.1101/2025.08.03.668213](https://doi.org/10.1101/2025.08.03.668213)

The manuscript describes the discovery and characterization of high-affinity single-domain protein binders (AVA) against major household allergens. This repository contains selected structural predictions, molecular-dynamics-derived data, umbrella-sampling results, size-exclusion chromatography (SEC) image analysis, and sequence analyses associated with Fel d 1 and the binder candidate denoted **C3** in the filenames.

## Repository contents

| Path | Description |
| --- | --- |
| `c3_af3/` | AlphaFold 3 prediction for the C3 binder, including the predicted structure (`.cif`) and full model output (`.json`). |
| `feld1_c3_af3/` | AlphaFold 3 prediction for the Fel d 1–C3 complex, including the predicted complex structure and full model output. |
| `feld1_MD/` | GROMACS distance-matrix output (`dm.xpm`) from the Fel d 1 molecular dynamics analysis. |
| `feld1_c3_MD/` | Selected GROMACS outputs for the Fel d 1–C3 complex: distance matrix, interaction energies, interface RMSD, and a coordinate snapshot. |
| `feld1_umbrella/` | GROMACS WHAM potential-of-mean-force profile and umbrella-window histogram for Fel d 1. |
| `feld1_c3_umbrella/` | GROMACS WHAM potential-of-mean-force profile and umbrella-window histogram for the Fel d 1–C3 complex. |
| `SEC_integral/` | Source images and a Python notebook used to identify contours and calculate pixel areas for SEC peak integration. |
| `proteinSeq_analysis/` | Binder sequence inputs, CDR3 and pairwise-similarity analysis, a similarity matrix, plotting scripts, and generated figures. |

## File formats

- `.cif`: predicted macromolecular structures from AlphaFold 3.
- `.json`: full AlphaFold 3 model output and confidence information.
- `.gro`: GROMACS coordinate file.
- `.xvg`: GROMACS numerical output with metadata, axis labels, and units in the header.
- `.xpm`: GROMACS matrix data.
- `.fasta` and `.csv`: protein sequences, sequence names, and pairwise similarity data.
- `.ipynb`: Jupyter notebooks for SEC integration and sequence analysis.
- `.r`: R script for the sequence-similarity chord diagram.
- `.png` and `.pdf`: source or generated figures.

## Using the analysis notebooks

Clone the repository and create a Python environment:

```bash
git clone https://github.com/PacaYang/WhiskerBlockForFeld1.git
cd WhiskerBlockForFeld1

python -m venv .venv
source .venv/bin/activate
python -m pip install --upgrade pip
python -m pip install jupyter numpy pandas biopython seaborn matplotlib opencv-python
```

On Windows PowerShell, activate the environment with:

```powershell
.venv\Scripts\Activate.ps1
```

The notebooks use relative paths, so launch Jupyter from the corresponding analysis directory.

### SEC peak integration

```bash
cd SEC_integral
jupyter lab integral.ipynb
```

The notebook reads `1_splited.png` and `2_splited.png`, thresholds each image, identifies external contours, and reports the number of pixels enclosed by each contour.

### Protein-sequence analysis

```bash
cd proteinSeq_analysis
jupyter lab alignment.ipynb
```

The notebook uses Biopython for pairwise sequence alignment and calculates normalized similarities for complete binder sequences and CDR3 regions. It also includes heat-map visualization code.

To regenerate the chord diagram from `similarity_matrix.csv`, install the required R packages and run:

```r
install.packages(c("circlize", "readr"))
```

```bash
Rscript circle2.r
```

The R script retains pairwise similarities greater than 0.7 and draws a chord diagram colored by sequence group.

## Working with the structural and simulation data

Predicted `.cif` structures can be opened in molecular-visualization software such as UCSF ChimeraX or PyMOL. The `.gro`, `.xvg`, and `.xpm` files are standard GROMACS formats.

For example, numerical data can be extracted from an XVG file while omitting its metadata lines:

```bash
grep -vE '^[#@]' feld1_c3_umbrella/profile.xvg > profile.tsv
```

The XVG headers record the GROMACS command, software version, units, and plot labels used to generate each dataset. The umbrella-sampling profiles were generated with `gmx wham`, while `energy.xvg` reports short-range Coulomb and Lennard-Jones interaction energies between Fel d 1 and C3.

## Scope and reproducibility

This repository is a focused collection of selected supporting data and analysis artifacts. It does **not** contain every input required to reproduce the molecular dynamics and umbrella-sampling calculations from the beginning; for example, complete topologies, parameter files, run-input files, and trajectories are not included.

The included notebooks preserve their original analysis logic and recorded outputs. Results may vary slightly with different software or dependency versions. The notebooks were last executed with Python 3.12, and the GROMACS file headers indicate versions 2023.3 and 2023.6-dev.

## Citation

If you use these data or analysis files, please cite the associated preprint:

```bibtex
@article{zhang2025allergenbinders,
  title   = {Development of high-affinity, single-domain protein binders for neutralizing household allergens},
  author  = {Zhang, David K. Y. and others},
  journal = {bioRxiv},
  year    = {2025},
  doi     = {10.1101/2025.08.03.668213},
  url     = {https://doi.org/10.1101/2025.08.03.668213}
}
```

## License

This repository does not currently include a separate license file. Please contact the repository owner before reusing or redistributing repository contents beyond what is permitted by applicable law and the manuscript's license.
