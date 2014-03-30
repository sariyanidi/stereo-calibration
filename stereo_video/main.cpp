#include "opencv2/highgui/highgui.hpp"
#include "opencv2/calib3d/calib3d.hpp"
#include "opencv2/imgproc/imgproc.hpp"
#include "opencv2/features2d/features2d.hpp"
#include <iostream>
#include <sstream>

class Camera;

cv::Mat getUndistortedRectified(const cv::Mat& D, const cv::Mat M, const cv::Mat R, const cv::Mat P, cv::Mat& src);
cv::Mat getUndistorted(const Camera& cam, cv::Mat& src);


/**
 * Camera class
 * Class where camera data is kept and handled
 */
class Camera
{
public:
    Camera( double fx, double fy, double cx, double cy, double k1, double k2, double p1, double p2, double k3 = 0 );

    // change intrinsic matrix scale to handle images of different sizes e.g. 320x240
    void setScale(double scale);

    // camera matrix
    cv::Mat M;

    // scaled camera matrix - needed for reduced image sizes etc
    cv::Mat SM;

    // distortion coefficients
    cv::Mat D;
};

class StereoRig
{
public:
    StereoRig(const Camera* _camL, const Camera* _camR, const cv::Mat& _R, const cv::Mat& _T, const cv::Size& _size);

    // left and right camera
    const Camera* const camL;
    const Camera* const camR;

    // get 3d data using camera coordinates and disparity value. See the book Learning OpenCV pg. 453
    double getDepth(double xc, double yc, double d);

    // rotation matrix bw cams
    cv::Mat R;

    // translation matrix bw cams
    cv::Mat T;

    // matrices needed by cv::stereoRectify function
    cv::Mat R1, R2, P1, P2, Q;
};

int main(int argc, char *argv[])
{
    using namespace cv;

    Camera camL(884.619820246672475, 885.130452157858826,
                335.461342469849228, 225.605601852535898,
                -0.271168345926695, 0.171248086620693,
                0.000436448084702, 0.000333959090964);

    Camera camR(885.679500214111613, 885.587940988541959,
                308.631155554682550, 240.859136168840280,
                -0.272114096878774, -0.046570787534115,
                -0.001413873867930, 0.003539442941778);

    Mat R(3,3,CV_64FC1);
    Mat T(3,1,CV_64FC1);

    R.at<double>(0,0) = 0.9967;
    R.at<double>(0,1) = -0.0440;
    R.at<double>(0,2) = 0.0677;
    R.at<double>(1,0) = 0.0449;
    R.at<double>(1,1) = 0.9989;
    R.at<double>(1,2) = -0.0110;
    R.at<double>(2,0) = -0.0671;
    R.at<double>(2,1) = 0.0140;
    R.at<double>(2,2) = 0.9976;

    T.at<double>(0,0) = -143.8316;
    T.at<double>(1,0) = -5.6844;
    T.at<double>(2,0) = -1.3908;

    Mat frame, frame2;

    VideoCapture cap(0); // open the default camera
    VideoCapture cap2(1); // open the default camera

    if(!cap.isOpened())  // check if we succeeded
        return -1;

    double scale = 1.;
    camL.setScale(scale);
    camR.setScale(scale);

    cap.set(CV_CAP_PROP_FRAME_WIDTH, 640*scale);
    cap.set(CV_CAP_PROP_FRAME_HEIGHT, 480*scale);

    cap2.set(CV_CAP_PROP_FRAME_WIDTH, 640*scale);
    cap2.set(CV_CAP_PROP_FRAME_HEIGHT, 480*scale);

/**/


    StereoRig rig(&camL, &camR, R, T, cv::Size(640*scale,480*scale));

    /*
        for (uint j=0; j<rig.Q.rows; ++j)
        {
            for (uint i=0; i<rig.Q.cols; ++i)
                std::cout << rig.Q.at<double>(j,i) << "\t";
            std::cout << std::endl;
        }
    */

    while(1)
    {
        cv::Mat frameRaw, frame2Raw, frame, frame2;

        cap >> frameRaw; // get a new frame from camera
        cap2 >> frame2Raw;

        cv::cvtColor(frameRaw, frame, CV_RGB2GRAY);
        cv::cvtColor(frame2Raw, frame2, CV_RGB2GRAY);

        cv::Mat remappedLeft = getUndistortedRectified(camL.D, camL.SM, rig.R1, rig.P1, frame);
        cv::Mat remappedRight = getUndistortedRectified(camR.D, camR.SM, rig.R2, rig.P2, frame2);


        cv::imshow("sol", remappedLeft);
        cv::imshow("sag", remappedRight);
        cv::waitKey(10);
continue;
        double pad = 80*scale;

        remappedLeft = remappedLeft(cv::Rect(pad, pad/2., remappedLeft.cols-pad*2,remappedLeft.rows-pad*2));
        remappedRight = remappedRight(cv::Rect(pad, pad/2., remappedRight.cols-pad*2,remappedRight.rows-pad*2));

        // containers to keep features temporarily !
        std::vector<cv::KeyPoint> keyPointsLeft, keyPointsRight;
        cv::Mat descriptorsLeft, descriptorsRight;

        // SurfFeatureDetector performs slower than FastFeature detector, but its far better
        //cv::Ptr<FeatureDetector> detector = new FastFeatureDetector(100);
        cv::Ptr<FeatureDetector> detector = new SurfFeatureDetector(500);
        cv::Ptr<DescriptorExtractor> descriptorExtractor = new SurfDescriptorExtractor;

        cv::FlannBasedMatcher matcher;

        detector->detect(remappedLeft, keyPointsLeft);
        detector->detect(remappedRight, keyPointsRight);

        descriptorExtractor->compute(remappedLeft, keyPointsLeft, descriptorsLeft);
        descriptorExtractor->compute(remappedRight, keyPointsRight, descriptorsRight);

//        std::vector<cv::DMatch> matches;
        std::vector< std::vector<cv::DMatch> > matches;

        matcher.clear();
        matcher.knnMatch(descriptorsLeft, descriptorsRight, matches,2);
//        matcher.match(descriptorsLeft, descriptorsRight, matches);

        /*
        for (uint i=0; i<keyPointsLeft.size(); ++i)
            cv::circle(remappedLeft, keyPointsLeft[i].pt, 4, cv::Scalar::all(0), 1);

        for (uint i=0; i<keyPointsRight.size(); ++i)
            cv::circle(remappedRight, keyPointsRight[i].pt, 4, cv::Scalar::all(0), 1);
        */

        std::vector<cv::Point2f> pointsLeft, pointsRight;

        std::vector<double> disparities(matches.size(), 0.);
        std::vector<int> leftIdxs, rightIdxs;

        leftIdxs.reserve(matches.size());
        rightIdxs.reserve(matches.size());

        /*
        for (uint i=0; i<matches.size(); ++i)
        {
            if (matches[i][0].distance > 0.6*matches[i][1].distance)
                continue;

            cv::circle(remappedLeft, keyPointsLeft[matches[i][0].queryIdx].pt, 4, CV_RGB(255,255,255), 2);
            cv::circle(remappedRight, keyPointsRight[matches[i][0].trainIdx].pt, 4, cv::Scalar::all(255), 2);
        }
        */

        for (int i=0; i<matches.size(); i++) {
            leftIdxs.push_back(matches[i][0].queryIdx);
            rightIdxs.push_back(matches[i][0].trainIdx);
        }


        KeyPoint::convert(keyPointsLeft, pointsLeft, leftIdxs);
        KeyPoint::convert(keyPointsRight, pointsRight, rightIdxs);


        for( size_t i = 0; i < pointsLeft.size(); i++ )
            disparities[i] = pointsLeft[i].x-pointsRight[i].x;

        cv::Mat matPointsLeft(pointsLeft, true);
        cv::Mat matPointsRight(pointsRight, true);

        cv::Mat H12 = cv::findHomography(matPointsLeft, matPointsRight, CV_RANSAC,5);

        cv::Mat pointsLeftT;
        perspectiveTransform(Mat(pointsLeft), pointsLeftT, H12);

//        vector<char> matchesMask( matches.size(), 0 );
        vector< vector<char> > matchesMask(matches.size(), vector<char>(2,0));

        uint i_matched=0;
        for( size_t i1 = 0; i1 < pointsLeft.size(); i1++ )
        {
            if( norm(pointsRight[i1] - pointsLeftT.at<Point2f>((int)i1,0)) < 4 ) // inlier
            {
                matchesMask[i1][0] = 1;
                cv::circle(remappedLeft, keyPointsLeft[matches[i1][0].queryIdx].pt, 4, CV_RGB(0,0,0), 2);
                cv::circle(remappedLeft, keyPointsRight[matches[i1][0].trainIdx].pt, 4, CV_RGB(255,255,255), 2);
//                double disparity = pointsRight[i1].x-pointsLeft[i1].x;
//                depths[i1] = ;
            }
        }

        for ( int i = matches.size()-1; i >=0; i-- ) {
            if (12 < std::abs(keyPointsLeft[matches[i][0].queryIdx].pt.y-keyPointsRight[matches[i][0].trainIdx].pt.y)) {
//                keyPointsLeft.erase(keyPointsLeft.begin()+matches[i].queryIdx);
//                keyPointsRight.erase(keyPointsRight.begin()+matches[i].trainIdx);
                matchesMask[i][0] = 0;
            }
        }

        for ( int i = matches.size()-1; i >=0; i-- ) {
//            if (matches[i][0].distance > 0.9*matches[i][1].distance)
//                matchesMask[i][0] = 0;
        }

        i_matched = 0;

        for (uint i=0; i<matches.size(); ++i)
        {
            std::stringstream ss;
            cv::Point2f leftPt1(keyPointsLeft[matches[i][0].queryIdx].pt);
            cv::Point2f leftPt2(keyPointsRight[matches[i][0].trainIdx].pt);
            std::vector<cv::Point2f> gecici;
            gecici.push_back(leftPt1);

            if (matchesMask[i][0] == 1)
            {
                cv::Vec4d inputt(leftPt1.x, leftPt1.y, disparities[i], 1.0);
                cv::Mat x(4,1,CV_64FC1);
                x.at<double>(0,0) = leftPt1.x;
                x.at<double>(0,1) = leftPt1.y;
                x.at<double>(0,2) = disparities[i];
                x.at<double>(0,3) = 1.0;

                cv::Mat X(4, 1, CV_64FC1);
                X = rig.Q*x;
                X = X/X.at<double>(3,0);

                std::cout << "d: " << disparities[i] << "; " << X.at<double>(0,0) << " " << X.at<double>(1,0) << " " << X.at<double>(2,0) << " " << X.at<double>(3,0) << " =? " << rig.getDepth(leftPt1.x, leftPt1.y, disparities[i]) << std::endl;

                uint durBurda = 0;
                std::cout << i_matched++ << ": " <<disparities[i] << "(" <<  i << ")"<< std::endl;
                ss << disparities[i];
            }

            cv::putText(remappedLeft, ss.str(), leftPt1, cv::FONT_HERSHEY_SIMPLEX, 0.50, cv::Scalar::all(255),1);
        }

        cv::Mat outImg, outImg2;
        cv::drawMatches(remappedLeft, keyPointsLeft, remappedRight, keyPointsRight, matches, outImg, CV_RGB(0, 255, 0), CV_RGB(0, 0, 255), matchesMask,DrawMatchesFlags::NOT_DRAW_SINGLE_POINTS);
        cv::drawMatches(remappedLeft, keyPointsLeft, remappedRight, keyPointsRight, matches, outImg2, CV_RGB(0, 255, 0), CV_RGB(0, 0, 255));

        imshow("LEFT_RECT", remappedLeft);
        imshow("RIGHT_RECT", remappedRight);
        imshow("outImg", outImg);
        imshow("outImg2", outImg2);

//        for (uint j=0; j<H12.rows; ++j)
//        {
//            for (uint i=0; i<H12.cols; ++i)
//                std::cout << H12.at<double>(j,i) << "\t";
//            std::cout << std::endl;
//        }

        int c = 0xff & waitKey(10);
        if( (c & 255) == 27 || c == 'q' || c == 'Q' )
            break;

    }

    return 0;
}

Camera::Camera(double fx, double fy, double cx, double cy, double k1, double k2, double p1, double p2, double k3)
{
    M = cv::Mat::zeros(3,3,CV_64FC1); // camera matrix
    D = cv::Mat::zeros(5,1,CV_64FC1); // distortion coeffs

    M.at<double>(0,0) = fx;
    M.at<double>(0,2) = cx;
    M.at<double>(1,1) = fy;
    M.at<double>(1,2) = cy;
    M.at<double>(2,2) = 1.;

    SM = M.clone(); // scaled matrix

    D.at<double>(0,0) = k1;
    D.at<double>(1,0) = k2;
    D.at<double>(2,0) = p1;
    D.at<double>(3,0) = p2;
    D.at<double>(4,0) = k3;
}

void Camera::setScale(double scale)
{
    SM.at<double>(0,0) = scale*M.at<double>(0,0);
    SM.at<double>(0,1) = scale*M.at<double>(0,1);
    SM.at<double>(0,2) = scale*M.at<double>(0,2);
    SM.at<double>(1,0) = scale*M.at<double>(1,0);
    SM.at<double>(1,1) = scale*M.at<double>(1,1);
    SM.at<double>(1,2) = scale*M.at<double>(1,2);
}

StereoRig::StereoRig(const Camera *_camL, const Camera *_camR, const cv::Mat &_R, const cv::Mat &_T, const cv::Size &_size)
    : camL(_camL), camR(_camR), R(_R), T(_T)
{
    cv::stereoRectify(camL->SM, camL->D, camR->SM, camR->D, _size, R, T, R1, R2, P1, P2, Q, 1.);
}

/**
 * Get depth from image coordinates and disparity data
 *
 * @param double xc - x coordinate on camera
 * @param double yc - y coordinate on camera
 * @param double d  - disparity obtained through stereo data
 * @return double depth - real world depth in mms
 */
double StereoRig::getDepth(double xc, double yc, double d)
{
    cv::Mat x(4,1,CV_64FC1); // camera coordinates
    x.at<double>(0,0) = xc;
    x.at<double>(0,1) = yc;
    x.at<double>(0,2) = d;
    x.at<double>(0,3) = 1.0;

    cv::Mat X(4, 1, CV_64FC1); // real world coordinates
    X = Q*x;                   // use Q matrix of the stereo rig
    X = X/X.at<double>(3,0);

    return X.at<double>(2,0);  // return depth
}

cv::Mat getUndistortedRectified(const cv::Mat& D, const cv::Mat M, const cv::Mat R, const cv::Mat P, cv::Mat& src)
{
    using namespace cv;

    cv::Size imageSize = src.size();
    Mat view = src.clone();
    Mat rview, map1, map2;

    initUndistortRectifyMap(M, D, R, P, imageSize, CV_16SC2, map1, map2);

    if(!view.data)
        return view;
    //    undistort( view, rview, cameraMatrix, distCoeffs, cameraMatrix );
    remap(view, rview, map1, map2, INTER_LINEAR, BORDER_CONSTANT);

    return rview;
}


cv::Mat getUndistorted(const Camera& cam, cv::Mat& src)
{
    using namespace cv;

    cv::Size imageSize = src.size();
    Mat view = src.clone();
    Mat rview, map1, map2;

    initUndistortRectifyMap(cam.SM, cam.D, Mat(),
                            getOptimalNewCameraMatrix(cam.SM, cam.D, imageSize, 1, imageSize, 0), imageSize, CV_16SC2, map1, map2);

    if(!view.data)
        return view;
    //    undistort( view, rview, cameraMatrix, distCoeffs, cameraMatrix );
    remap(view, rview, map1, map2, INTER_LINEAR, BORDER_CONSTANT);

    return rview;
}

/*
imageSize, CV_16SC2, map1, map2);


Mat view, rview, map1, map2;

initUndistortRectifyMap(cameraMatrix, distCoeffs, Mat(),
                        getOptimalNewCameraMatrix(cameraMatrix, distCoeffs, imageSize, 1, imageSize, 0),

for( int i = 0; i < (int)imageList.size(); i++ )
{
    view = imread(imageList[i], 1);
    if(!view.data)
        continue;
    //undistort( view, rview, cameraMatrix, distCoeffs, cameraMatrix );
    remap(view, rview, map1, map2, INTER_LINEAR);

    imshow("Image View", rview);
    int c = 0xff & waitKey();
    if( (c & 255) == 27 || c == 'q' || c == 'Q' )
        break;
}

return rview;
*/
