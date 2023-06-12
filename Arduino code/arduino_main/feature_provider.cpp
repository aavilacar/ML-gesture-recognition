/* Copyright 2019 The TensorFlow Authors. All Rights Reserved.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
==============================================================================*/
#include "feature_provider.h"
#include "Arduino.h"

// Designing a 'sign' function like in MATLAB
static inline int8_t sign(float val) {
  if (val > 0) return 1;
  if (val < 0) return -1;
  return 0;
}

// Creating a function to find the Mean Absolute Value (MAV) of an array
float MeanAbsoluteValue(float* gest_ch, unsigned int wl, unsigned int len) {
  float sum = 0;
  
  for (int m = 0; m < len; m++) {     //Finding the sum of the absolute values of all of the entries of the array
    sum = sum + abs(gest_ch[m]);
  }
  
  float mav = sum/wl;    //Calculating the mean using only the length of the non-zero part of the sEMG signal (or 'wl')
  return mav;
}

// Creating a function to find the Zero Crossings (MAV) of a signal. To do this, 
// the function gets the sign of all of the points in the signal and counts the
// number of times the sign changes from the start to the end of the signal
unsigned int ZeroCrossings(float* gest_ch, unsigned int len) {
  int8_t previous = sign(gest_ch[0]);
  int8_t current;
  unsigned int counter = 0;
  
  for (int m = 1; m < len; m++) {
    current = sign(gest_ch[m]);
    if (previous != current) {
        counter = counter + 1;
    }
    previous = sign(gest_ch[m]);
  }
  
  unsigned int zc = counter;
  return zc;
}

// Creating a function to find the Slope Sign Changes (SSC) of a signal. To do 
// this, the function calculates the gradient at each point using the values of
// the two adjacent points (using central differences) and then gets the sign 
// of all of the gradient points in the signal. It then counts the number of 
// times the gradient sign changes from the start to the end of the signal
unsigned int SlopeSignChanges(float* gest_ch, unsigned int len) {
  float first_diff = gest_ch[1] - gest_ch[0];  //It is necessary to manually define the gradient at the first point as there is no point to the left for adequately calculating the gradient (using central differences)
  int8_t previous = sign(first_diff);
  float gradient;
  int8_t current;
  unsigned int counter = 0;
  
  for (int m = 1; m < len-1; m++) {
    gradient = (gest_ch[m+1] - gest_ch[m-1])/2;
    current = sign(gradient);
    if (previous != current) {
        counter = counter + 1;
    }
    previous = sign(gradient);
  }

  float final_diff = gest_ch[len-1] - gest_ch[len-2];  //It is necessary to manually define the gradient at the last point as there is no point to the right for adequately calculating the gradient (using central differences)
  current = sign(final_diff);
  if (previous != current) {
        counter = counter + 1;
  }
  
  unsigned int ssc = counter;
  return ssc;
}
