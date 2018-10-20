## Resubmission
This is a resubmission. In this version I have:

* Added a reference in the Description field. 

* Changed the example for function modelFit so that it can be executed in < 5 sec.

* Functions reinforced, modelFit_VS, reinforced_VS are computationally intensive. I tried some smaller toy
examples. However, it is just impossible for the example to be executed within 5 seconds. Hence, I wrapped 
these examples in donttest{}. I tested these examples using devtools::check(run_dont_test = TRUE), and works well. 

## Test environments 

* local OS X install, R 3.5.1
* win-builder (release and devel)

## R CMD check results

There were no ERRORs or WARNINGs. 

There was 1 NOTE:

* This is a new submission.

## Downstream dependencies

There are currently no downstream dependencies for this package. 
