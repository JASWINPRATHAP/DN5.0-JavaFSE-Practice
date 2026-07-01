public class EmployeeManager {

    private Employee[] employees;
    private int count;

    public EmployeeManager(int size) {

        employees = new Employee[size];
        count = 0;
    }

    public void addEmployee(Employee employee) {

        if(count < employees.length) {

            employees[count] = employee;
            count++;

            System.out.println("Employee Added");
        }
        else {

            System.out.println("Employee List Full");
        }
    }

    public Employee searchEmployee(int employeeId) {

        for(int i = 0; i < count; i++) {

            if(employees[i].getEmployeeId() == employeeId) {

                return employees[i];
            }
        }

        return null;
    }

    public void deleteEmployee(int employeeId) {

        for(int i = 0; i < count; i++) {

            if(employees[i].getEmployeeId() == employeeId) {

                for(int j = i; j < count - 1; j++) {

                    employees[j] = employees[j + 1];
                }

                employees[count - 1] = null;
                count--;

                System.out.println("Employee Deleted");
                return;
            }
        }

        System.out.println("Employee Not Found");
    }

    public void displayEmployees() {

        for(int i = 0; i < count; i++) {

            employees[i].display();
        }
    }
}
