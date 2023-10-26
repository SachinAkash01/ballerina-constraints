//This file is an example for Ballerina constraint validation for
//Integer, String and Array types.

import ballerina/constraint;

@constraint:Int{
    minValue: 19,
    maxValue: 35
    //apart from these validations, Ballerina supports minValueExclusive: & maxValueExclusive:
    //constraints as well.
}
type Age int;
//Float & Number (decimal) Constraints also can be added as above.

type Student record {|
    @constraint:String{
        pattern: re`[0-9]{6}[A-Z|a-z]`
        //Other than this, Ballerina supports maxLength:, minLength:, and length:
        //constraints as well.
    }
    string id;
    string name;
    Age age;
    @constraint:Array{
        minLength: 1,
        maxLength: 10
        //apart from these validations, Array type supports length: constraint as well.
    }
    string[] subjects;
|};


public function main() returns error?{
    //student object created using `Student` record.
    Student student = {
        id: "200123v",
        name: "Sachin Akash",
        age: 21,
        subjects: ["Data Structures","OOP","OS"]
    };

    student = check constraint:validate(student); //To check whether the given data is valid.

    student.age = 36; //this will exceeds the maximum value for age variable.

    student = check constraint:validate(student); //this will print an error message indicating a validation fail for age variable.
}
