% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly excecuted under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 884.619820246672475 ; 885.130452157858826 ];

%-- Principal point:
cc = [ 335.461342469849228 ; 225.605601852535898 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ -0.271168345926695 ; 0.171248086620693 ; 0.000436448084702 ; 0.000333959090964 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 5.261230687550763 ; 4.870188455671498 ];

%-- Principal point uncertainty:
cc_error = [ 8.304973476335269 ; 8.141184590962791 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.034848858202766 ; 0.308238067868357 ; 0.001338627635398 ; 0.001872432724363 ; 0.000000000000000 ];

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
omc_1 = [ -1.533872e+00 ; -2.024811e+00 ; 8.357532e-01 ];
Tc_1  = [ 1.541607e+01 ; -1.117053e+02 ; 7.489542e+02 ];
omc_error_1 = [ 8.314754e-03 ; 7.187736e-03 ; 1.226578e-02 ];
Tc_error_1  = [ 7.046169e+00 ; 6.887338e+00 ; 4.315967e+00 ];

%-- Image #2:
omc_2 = [ -1.659796e+00 ; -2.085139e+00 ; 9.707546e-01 ];
Tc_2  = [ -2.284379e+01 ; -9.003266e+01 ; 7.255787e+02 ];
omc_error_2 = [ 8.919950e-03 ; 6.551996e-03 ; 1.277258e-02 ];
Tc_error_2  = [ 6.829377e+00 ; 6.662508e+00 ; 3.984879e+00 ];

%-- Image #3:
omc_3 = [ 2.128027e+00 ; 1.505692e+00 ; 6.798757e-01 ];
Tc_3  = [ -3.214579e+01 ; -6.182250e+01 ; 5.369012e+02 ];
omc_error_3 = [ 9.797096e-03 ; 5.422779e-03 ; 1.246853e-02 ];
Tc_error_3  = [ 5.070021e+00 ; 4.916966e+00 ; 3.588360e+00 ];

%-- Image #4:
omc_4 = [ -2.639448e+00 ; -1.489100e+00 ; -1.789792e-01 ];
Tc_4  = [ -1.040405e+02 ; -5.282128e+01 ; 6.798571e+02 ];
omc_error_4 = [ 1.115193e-02 ; 6.950464e-03 ; 1.785991e-02 ];
Tc_error_4  = [ 6.418781e+00 ; 6.265604e+00 ; 4.404533e+00 ];

%-- Image #5:
omc_5 = [ -1.963560e+00 ; -1.618822e+00 ; 7.360284e-01 ];
Tc_5  = [ -9.565723e+01 ; -5.908373e+01 ; 7.117349e+02 ];
omc_error_5 = [ 9.117943e-03 ; 5.862106e-03 ; 1.283118e-02 ];
Tc_error_5  = [ 6.720241e+00 ; 6.559677e+00 ; 3.908393e+00 ];

%-- Image #6:
omc_6 = [ 1.987283e+00 ; 2.094050e+00 ; -1.914450e-01 ];
Tc_6  = [ -3.809026e+01 ; -1.182156e+02 ; 7.265380e+02 ];
omc_error_6 = [ 7.483672e-03 ; 8.634520e-03 ; 1.535230e-02 ];
Tc_error_6  = [ 6.860077e+00 ; 6.663432e+00 ; 4.596032e+00 ];

%-- Image #7:
omc_7 = [ -1.629412e+00 ; -1.745210e+00 ; 8.429762e-01 ];
Tc_7  = [ 4.248801e+01 ; -1.087037e+02 ; 7.032138e+02 ];
omc_error_7 = [ 8.377922e-03 ; 6.569182e-03 ; 1.146043e-02 ];
Tc_error_7  = [ 6.625909e+00 ; 6.469491e+00 ; 4.019016e+00 ];

%-- Image #8:
omc_8 = [ -1.526885e+00 ; -2.071063e+00 ; 7.867229e-01 ];
Tc_8  = [ 2.324203e+00 ; -9.156885e+01 ; 7.551235e+02 ];
omc_error_8 = [ 7.917690e-03 ; 7.247063e-03 ; 1.231774e-02 ];
Tc_error_8  = [ 7.094821e+00 ; 6.935161e+00 ; 4.207152e+00 ];

%-- Image #9:
omc_9 = [ -2.246934e+00 ; -1.536284e+00 ; 9.405122e-01 ];
Tc_9  = [ -8.367266e+01 ; -3.327073e+01 ; 7.223399e+02 ];
omc_error_9 = [ 9.978955e-03 ; 4.569427e-03 ; 1.363398e-02 ];
Tc_error_9  = [ 6.811907e+00 ; 6.642549e+00 ; 3.860100e+00 ];

%-- Image #10:
omc_10 = [ 1.938151e+00 ; 1.492959e+00 ; 4.412334e-01 ];
Tc_10  = [ -1.124671e+01 ; -7.128751e+01 ; 5.786408e+02 ];
omc_error_10 = [ 9.273473e-03 ; 6.239881e-03 ; 1.157630e-02 ];
Tc_error_10  = [ 5.456607e+00 ; 5.301930e+00 ; 3.797908e+00 ];

%-- Image #11:
omc_11 = [ 2.268449e+00 ; 1.794005e+00 ; 2.876266e-01 ];
Tc_11  = [ 4.270278e+01 ; 5.406059e+00 ; 1.236473e+03 ];
omc_error_11 = [ 1.147045e-02 ; 7.099613e-03 ; 1.839074e-02 ];
Tc_error_11  = [ 1.162158e+01 ; 1.136505e+01 ; 8.120735e+00 ];

%-- Image #12:
omc_12 = [ -2.090482e+00 ; -1.793136e+00 ; 9.259683e-01 ];
Tc_12  = [ 5.416142e+01 ; 1.358676e+01 ; 9.905437e+02 ];
omc_error_12 = [ 9.156466e-03 ; 6.111901e-03 ; 1.383950e-02 ];
Tc_error_12  = [ 9.292853e+00 ; 9.108073e+00 ; 5.408993e+00 ];

%-- Image #13:
omc_13 = [ 1.540487e+00 ; 1.584413e+00 ; 4.132309e-01 ];
Tc_13  = [ -1.602896e+02 ; -1.307716e+02 ; 8.570500e+02 ];
omc_error_13 = [ 7.737771e-03 ; 7.849573e-03 ; 1.074509e-02 ];
Tc_error_13  = [ 8.155670e+00 ; 7.943233e+00 ; 5.968923e+00 ];

%-- Image #14:
omc_14 = [ -1.695596e+00 ; -2.109226e+00 ; 8.661668e-01 ];
Tc_14  = [ 1.020426e+02 ; -9.109896e+01 ; 1.084493e+03 ];
omc_error_14 = [ 8.677028e-03 ; 7.225282e-03 ; 1.370472e-02 ];
Tc_error_14  = [ 1.020341e+01 ; 9.975029e+00 ; 6.348192e+00 ];

%-- Image #15:
omc_15 = [ 1.705920e+00 ; 2.626256e+00 ; 4.982414e-02 ];
Tc_15  = [ -1.566208e+02 ; -1.749638e+02 ; 1.126712e+03 ];
omc_error_15 = [ 1.504612e-02 ; 2.655643e-02 ; 4.356896e-02 ];
Tc_error_15  = [ 1.065281e+01 ; 1.041996e+01 ; 7.790645e+00 ];

%-- Image #16:
omc_16 = [ -2.389940e+00 ; -1.777415e+00 ; 9.294139e-01 ];
Tc_16  = [ -1.833693e+02 ; -1.365283e+02 ; 1.198676e+03 ];
omc_error_16 = [ 1.168444e-02 ; 4.353350e-03 ; 1.639720e-02 ];
Tc_error_16  = [ 1.138710e+01 ; 1.111417e+01 ; 7.327250e+00 ];

%-- Image #17:
omc_17 = [ 1.325200e+00 ; 1.914544e+00 ; 6.050964e-01 ];
Tc_17  = [ -1.123187e+02 ; -1.345556e+02 ; 9.974097e+02 ];
omc_error_17 = [ 7.586248e-03 ; 8.186180e-03 ; 1.147954e-02 ];
Tc_error_17  = [ 9.451944e+00 ; 9.211432e+00 ; 6.666983e+00 ];

%-- Image #18:
omc_18 = [ 2.325554e+00 ; 1.009361e+00 ; -1.071358e+00 ];
Tc_18  = [ -5.485707e+01 ; 4.755845e+01 ; 9.022632e+02 ];
omc_error_18 = [ 8.131578e-03 ; 7.668623e-03 ; 1.262064e-02 ];
Tc_error_18  = [ 8.480809e+00 ; 8.297008e+00 ; 5.114234e+00 ];

%-- Image #19:
omc_19 = [ 1.968409e+00 ; 1.938675e+00 ; 9.198121e-02 ];
Tc_19  = [ -3.798888e+01 ; -5.788465e+01 ; 5.363822e+02 ];
omc_error_19 = [ 8.149675e-03 ; 6.683916e-03 ; 1.331303e-02 ];
Tc_error_19  = [ 5.041520e+00 ; 4.914033e+00 ; 3.295012e+00 ];

%-- Image #20:
omc_20 = [ 2.108660e+00 ; 2.119099e+00 ; -3.300402e-01 ];
Tc_20  = [ -5.767498e+01 ; -5.543580e+01 ; 5.571563e+02 ];
omc_error_20 = [ 6.711905e-03 ; 7.462156e-03 ; 1.444486e-02 ];
Tc_error_20  = [ 5.231043e+00 ; 5.090892e+00 ; 3.401552e+00 ];

%-- Image #21:
omc_21 = [ 2.077115e+00 ; 2.069686e+00 ; -3.263086e-01 ];
Tc_21  = [ -5.206545e+01 ; -7.207858e+01 ; 7.066352e+02 ];
omc_error_21 = [ 7.296154e-03 ; 8.245089e-03 ; 1.531753e-02 ];
Tc_error_21  = [ 6.642762e+00 ; 6.465461e+00 ; 4.361214e+00 ];

