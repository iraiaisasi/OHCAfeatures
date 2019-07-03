Code for computing OHCA rhythm classification features using an example ECG (e_ecg.mat).

This repository is structured in the following way:

- The main script (main.m) loads the RLS-filtered ECG (e_ecg.mat), calculates the reconstructed ECG and the detail coefficients based on the Stationary Wavelet Transform (SWT) (compute_SWT.m) and computes the OHCA features (computeFeatures.m).
- The features folder contains a .m file to each feature, which are called from computeFeatures.m.
- The SWT folder contains the functions needed to compute the Stationary Wavelet transform and is called from main.m.

If you use this code on your work please cite the following paper, thank you.

¨Automatic heart rhythm classification during manual chest compressions¨ IEEE Access 2020.



