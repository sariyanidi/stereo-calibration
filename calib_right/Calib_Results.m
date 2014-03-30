% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly excecuted under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 885.679500214111613 ; 885.587940988541959 ];

%-- Principal point:
cc = [ 308.631155554682550 ; 240.859136168840280 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ -0.272114096878774 ; -0.046570787534115 ; -0.001413873867930 ; 0.003539442941778 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 5.605499260190777 ; 5.072622192525745 ];

%-- Principal point uncertainty:
cc_error = [ 8.457029773993062 ; 7.762621290539267 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.033467260218819 ; 0.257072541835520 ; 0.001383360220402 ; 0.002012860075167 ; 0.000000000000000 ];

%-- Image size:
nx = 640;
ny = 480;


%-- Various other variables (may be ignored if you do not use the Matlab Calibration Toolbox):
%-- Those variables are used to control which intrinsic parameters should be optimized

n_ima = 21;						% Number of calibration images
est_fc = [ 1 ; 1 ];					% Estimation indicator of the two focal variables
est_aspect_ratio = 1;				% Estimation indicator of the aspect ratio fc(2)/fc(1)
center_optim = 1;					% Estimation indicator of the principal point
est_alpha = 0;						% Estimation indicator of the skew coefficient
est_dist = [ 1 ; 1 ; 1 ; 1 ; 0 ];	% Estimation indicator of the distortion coefficients


%-- Extrinsic parameters:
%-- The rotation (omc_kk) and the translation (Tc_kk) vectors for every calibration image and their uncertainties

%-- Image #1:
omc_1 = [ -1.438655e+00 ; -2.018737e+00 ; 8.779478e-01 ];
Tc_1  = [ -7.238916e+01 ; -1.253067e+02 ; 7.417735e+02 ];
omc_error_1 = [ 8.957293e-03 ; 7.288586e-03 ; 1.129825e-02 ];
Tc_error_1  = [ 7.101483e+00 ; 6.531504e+00 ; 4.378757e+00 ];

%-- Image #2:
omc_2 = [ -1.558112e+00 ; -2.087185e+00 ; 1.010329e+00 ];
Tc_2  = [ -1.129811e+02 ; -1.050045e+02 ; 7.215549e+02 ];
omc_error_2 = [ 9.534025e-03 ; 6.801005e-03 ; 1.193792e-02 ];
Tc_error_2  = [ 6.913476e+00 ; 6.390151e+00 ; 4.114320e+00 ];

%-- Image #3:
omc_3 = [ 2.154975e+00 ; 1.594134e+00 ; 6.402761e-01 ];
Tc_3  = [ -1.366290e+02 ; -7.508950e+01 ; 5.343215e+02 ];
omc_error_3 = [ 9.317619e-03 ; 5.823810e-03 ; 1.218886e-02 ];
Tc_error_3  = [ 5.141966e+00 ; 4.755741e+00 ; 3.804329e+00 ];

%-- Image #4:
omc_4 = [ -2.574765e+00 ; -1.521691e+00 ; -9.910216e-02 ];
Tc_4  = [ -1.987275e+02 ; -7.123476e+01 ; 6.815227e+02 ];
omc_error_4 = [ 1.156724e-02 ; 6.025817e-03 ; 1.856915e-02 ];
Tc_error_4  = [ 6.539496e+00 ; 6.064955e+00 ; 4.898050e+00 ];

%-- Image #5:
omc_5 = [ -1.879025e+00 ; -1.629114e+00 ; 7.967090e-01 ];
Tc_5  = [ -1.880050e+02 ; -7.732582e+01 ; 7.132296e+02 ];
omc_error_5 = [ 9.877203e-03 ; 6.144811e-03 ; 1.177763e-02 ];
Tc_error_5  = [ 6.871893e+00 ; 6.385675e+00 ; 4.235376e+00 ];

%-- Image #6:
omc_6 = [ 1.968735e+00 ; 2.185531e+00 ; -2.483632e-01 ];
Tc_6  = [ -1.271785e+02 ; -1.335641e+02 ; 7.240366e+02 ];
omc_error_6 = [ 6.072047e-03 ; 9.113868e-03 ; 1.640787e-02 ];
Tc_error_6  = [ 6.959854e+00 ; 6.372872e+00 ; 4.824559e+00 ];

%-- Image #7:
omc_7 = [ -1.540680e+00 ; -1.742676e+00 ; 8.952870e-01 ];
Tc_7  = [ -4.875645e+01 ; -1.205394e+02 ; 6.944038e+02 ];
omc_error_7 = [ 9.181997e-03 ; 6.809865e-03 ; 1.053657e-02 ];
Tc_error_7  = [ 6.648038e+00 ; 6.095182e+00 ; 4.022195e+00 ];

%-- Image #8:
omc_8 = [ -1.432804e+00 ; -2.065230e+00 ; 8.278124e-01 ];
Tc_8  = [ -8.612498e+01 ; -1.057910e+02 ; 7.489749e+02 ];
omc_error_8 = [ 8.578747e-03 ; 7.321061e-03 ; 1.144919e-02 ];
Tc_error_8  = [ 7.152983e+00 ; 6.600190e+00 ; 4.299861e+00 ];

%-- Image #9:
omc_9 = [ -2.158477e+00 ; -1.566054e+00 ; 1.006056e+00 ];
Tc_9  = [ -1.766317e+02 ; -5.102008e+01 ; 7.237242e+02 ];
omc_error_9 = [ 1.068333e-02 ; 4.935954e-03 ; 1.268451e-02 ];
Tc_error_9  = [ 6.951071e+00 ; 6.457715e+00 ; 4.188936e+00 ];

%-- Image #10:
omc_10 = [ 1.952114e+00 ; 1.583813e+00 ; 4.071645e-01 ];
Tc_10  = [ -1.127415e+02 ; -8.426464e+01 ; 5.749237e+02 ];
omc_error_10 = [ 8.529307e-03 ; 6.673770e-03 ; 1.158393e-02 ];
Tc_error_10  = [ 5.503433e+00 ; 5.069203e+00 ; 3.961870e+00 ];

%-- Image #11:
omc_11 = [ 2.273384e+00 ; 1.881756e+00 ; 2.285907e-01 ];
Tc_11  = [ -1.739764e+01 ; -1.294558e+01 ; 1.224502e+03 ];
omc_error_11 = [ 1.282443e-02 ; 9.264988e-03 ; 2.268044e-02 ];
Tc_error_11  = [ 1.170023e+01 ; 1.072063e+01 ; 8.334429e+00 ];

%-- Image #12:
omc_12 = [ -1.994827e+00 ; -1.814774e+00 ; 9.829609e-01 ];
Tc_12  = [ -2.291533e+01 ; -1.077365e+00 ; 9.802885e+02 ];
omc_error_12 = [ 9.504509e-03 ; 5.790036e-03 ; 1.276688e-02 ];
Tc_error_12  = [ 9.341702e+00 ; 8.583282e+00 ; 5.569682e+00 ];

%-- Image #13:
omc_13 = [ 1.545143e+00 ; 1.672635e+00 ; 4.011894e-01 ];
Tc_13  = [ -2.393924e+02 ; -1.534679e+02 ; 8.603919e+02 ];
omc_error_13 = [ 7.294163e-03 ; 8.288826e-03 ; 1.042232e-02 ];
Tc_error_13  = [ 8.352573e+00 ; 7.683239e+00 ; 6.313193e+00 ];

%-- Image #14:
omc_14 = [ -1.596105e+00 ; -2.113375e+00 ; 9.099966e-01 ];
Tc_14  = [ 3.582222e+01 ; -1.044969e+02 ; 1.068781e+03 ];
omc_error_14 = [ 8.875179e-03 ; 7.044435e-03 ; 1.272731e-02 ];
Tc_error_14  = [ 1.023757e+01 ; 9.357211e+00 ; 6.374778e+00 ];

%-- Image #15:
omc_15 = [ -1.617015e+00 ; -2.616168e+00 ; -2.023274e-02 ];
Tc_15  = [ -2.147623e+02 ; -2.002547e+02 ; 1.128291e+03 ];
omc_error_15 = [ 1.168934e-02 ; 1.570402e-02 ; 2.887878e-02 ];
Tc_error_15  = [ 1.086357e+01 ; 9.999496e+00 ; 7.681063e+00 ];

%-- Image #16:
omc_16 = [ -2.289101e+00 ; -1.813899e+00 ; 9.847655e-01 ];
Tc_16  = [ -2.388616e+02 ; -1.645647e+02 ; 1.202582e+03 ];
omc_error_16 = [ 1.168676e-02 ; 4.410849e-03 ; 1.512458e-02 ];
Tc_error_16  = [ 1.160498e+01 ; 1.071659e+01 ; 7.557470e+00 ];

%-- Image #17:
omc_17 = [ 1.330605e+00 ; 2.003148e+00 ; 6.043220e-01 ];
Tc_17  = [ -1.820533e+02 ; -1.564324e+02 ; 9.977017e+02 ];
omc_error_17 = [ 7.574478e-03 ; 8.823881e-03 ; 1.130210e-02 ];
Tc_error_17  = [ 9.611875e+00 ; 8.850730e+00 ; 6.902064e+00 ];

%-- Image #18:
omc_18 = [ 2.281404e+00 ; 1.090808e+00 ; -1.134839e+00 ];
Tc_18  = [ -1.389854e+02 ; 2.900193e+01 ; 9.008412e+02 ];
omc_error_18 = [ 7.358841e-03 ; 8.616213e-03 ; 1.243092e-02 ];
Tc_error_18  = [ 8.592561e+00 ; 7.941847e+00 ; 5.366713e+00 ];

%-- Image #19:
omc_19 = [ 1.961412e+00 ; 2.030040e+00 ; 4.941317e-02 ];
Tc_19  = [ -1.425018e+02 ; -7.127770e+01 ; 5.344356e+02 ];
omc_error_19 = [ 6.468173e-03 ; 7.268869e-03 ; 1.367684e-02 ];
Tc_error_19  = [ 5.132335e+00 ; 4.750064e+00 ; 3.597364e+00 ];

%-- Image #20:
omc_20 = [ 2.079308e+00 ; 2.204153e+00 ; -3.916758e-01 ];
Tc_20  = [ -1.608600e+02 ; -6.987016e+01 ; 5.565091e+02 ];
omc_error_20 = [ 5.452464e-03 ; 8.857004e-03 ; 1.498988e-02 ];
Tc_error_20  = [ 5.313541e+00 ; 4.981589e+00 ; 3.788073e+00 ];

%-- Image #21:
omc_21 = [ 2.053568e+00 ; 2.161296e+00 ; -3.870901e-01 ];
Tc_21  = [ -1.441193e+02 ; -8.820870e+01 ; 7.051824e+02 ];
omc_error_21 = [ 5.895688e-03 ; 8.887090e-03 ; 1.556136e-02 ];
Tc_error_21  = [ 6.744397e+00 ; 6.230961e+00 ; 4.599993e+00 ];

