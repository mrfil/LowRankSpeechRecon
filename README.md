# LowRankSpeechRecon

The package focus on the low-rank dynamic speech MRI reconstruction. Reference: https://pubmed.ncbi.nlm.nih.gov/36289572/

/PE_list: Random phase-slice encoding list with different FOV. Rmn: Reduction factor of m & n in the phase-slice encoding. zn: n slices. PD: Poisson-disc sampling

/Object: Robj4D: Regularization object. @sense4D: low-rank sense object. @lr-model:low-rank matrix. @MaskSep: Mask separation object for locally higher-rank reconstruction.

Note that: This package requires RecoIL package. Link:https://github.com/mrfil/RecoIL
It also requires mapVBVD package. Link:https://github.com/cm212/mapVBVD

Any questions please contact Riwei Jin: jriwei2@illinois.edu and Brad Sutton: bsutton@illinois.edu
