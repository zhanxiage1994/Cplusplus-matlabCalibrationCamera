#ifndef CAMCALIBRATOR_H
#define CAMCALIBRATOR_H

#include"Head.h"

#include"camCalibMatlab.h"
#include<mclmcr.h>
#pragma comment(lib, "mclmcrrt.lib")
#pragma comment(lib, "camCalibMatlab.lib")

class CamCalibrator
{
public:
	CamCalibrator();
	~CamCalibrator() {};
	bool run();
private:
	double basis;
	double numImage;
};

CamCalibrator::CamCalibrator()
{
	basis = BASIS - 1;
	numImage = NUMIMAGE;
}

bool CamCalibrator::run()
{
	if (!camCalibMatlabInitialize())
	{
		return false;
	}
	cout<<endl;
	cout<<"Start matlab code!"<<endl;
	cout<<endl;
	mwArray _basis(1,1,mxDOUBLE_CLASS);
	mwArray _numImage(1,1,mxDOUBLE_CLASS);
	_basis.SetData(&basis,1);
	_numImage.SetData(&numImage,1);
	cameraCalibrator(_basis,_numImage);
    // terminate MCR  
    mclTerminateApplication(); 
	cout<<"Matlab create XML file!"<<endl;
	return true;
}
#endif