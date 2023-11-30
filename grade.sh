CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'
CORRECT_TESTS=0
FAILED_TESTS=0

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'
if [ -f "./student-submission/ListExamples.java" ]; 
    then 
        cp ./student-submission/ListExamples.java ./grading-area
        cp ./TestListExamples.java ./grading-area
        cp -r ./lib ./grading-area
        cd grading-area
        if ! javac -cp .:lib/hamcrest-core-1.3.jar:./lib/junit-4.13.2.jar *.java; then
            echo "Compilation error"
        else
            set +e
            java -cp .:lib/hamcrest-core-1.3.jar:./lib/junit-4.13.2.jar org.junit.runner.JUnitCore TestListExamples > ./result
            if grep -q "OK" ./result; then
                echo "Correct"
                CORRECT_TESTS+=1
            else
                grep
            fi
            TOTAL_TESTS=$((CORRECT_TESTS+FAILED_TESTS))
            GRADE=$(echo "scale=2; $CORRECT_TESTS/$TOTAL_TESTS" | bc) 
            # This will give you a decimal grade. The scale=2 sets the number of decimal places to 2.
            echo "Your grade is $GRADE"
        fi

else 
    echo "File does not exist or is in another directory"
fi
