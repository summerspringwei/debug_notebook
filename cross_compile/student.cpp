#include <iostream>
#include <vector>

class Student {
public:
    Student(int id, const char* name, int age);
    void print();

private:
    int id;
    const char* name;
    int age;
    std::vector<int> friends;
};

Student::Student(int id, const char* name, int age) {
    this->id = id;
    this->name = name;
    this->age = age;
}

void Student::print(){
    if(name == NULL){
        printf("name is null\n");
        return;
    }
    printf("id: %d, name: %s, age: %d\n", id, name, age);
}

int main(){

    Student* s = new Student(1, "zhangsan", 20);
    s->print();
    delete s;

    return 0;
}