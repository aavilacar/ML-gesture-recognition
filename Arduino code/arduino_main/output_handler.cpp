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
#include "output_handler.h"
#include "Arduino.h"

const float thr = 0.8;

// Called by the main loop to produce some output based on the x and y values
// -->
void HandleOutput(tflite::ErrorReporter* error_reporter, float* y_val) {
  
  Serial.println();
  Serial.print("Predictions: Gesture 1-");
  Serial.println(y_val[0], 7);
  Serial.print("             Gesture 2-");
  Serial.println(y_val[1], 7);
  
  if (y_val[0] > thr) {
    Serial.println("Gesture 1 detected!");    
    digitalWrite(LEDB, LOW);
  } else if (y_val[1] > thr) {
    Serial.println("Gesture 2 detected!");
    digitalWrite(LEDR, LOW);
  }
  
  Serial.println();
  Serial.println("==============================");
  Serial.println();

  //Keep light on for 1 second, then turn it off
  delay(1000);
  if (y_val[0] > thr) {  
    digitalWrite(LEDB, HIGH);
  } else if (y_val[1] > thr) {
    digitalWrite(LEDR, HIGH);
  }
}
