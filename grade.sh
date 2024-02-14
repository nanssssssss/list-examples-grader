CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
git clone $1 student-submission

rm -rf grading-area
mkdir grading-area

echo 'Finished cloning'

# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests

if [[ -f student-submission/ListExamples.java ]] 
then
	echo “file found”
    cp student-submission/ListExamples.java grading-area
    cp TestListExamples.java grading-area
    cp -r lib grading-area
else 
	echo “file not found”
    exit 1
fi 

cd grading-area 
javac -cp $CPATH *.java 

if [[ $? -ne 0 ]]
then 
    echo "The program failed to compile"
    exit 1
fi

java -cp $CPATH org.junit.runner.JUnitCore TestListExamples > junit-output.txt

TOTALTESTRUN=$(grep -Eo "Tests run: [0-9]+" junit-output.txt | grep -Eo "[0-9]+")

TOTALTESTFAIL=$(grep -Eo "Failures: [0-9]+" junit-output.txt | grep -Eo "[0-9]+")

TOTALSUCCESS=$((TOTALTESTRUN - TOTALTESTFAIL))

echo "Your grade is" $TOTALSUCCESS/$TOTALTESTRUN