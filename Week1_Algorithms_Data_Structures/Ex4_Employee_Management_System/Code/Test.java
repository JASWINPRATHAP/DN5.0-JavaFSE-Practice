public class Test {

    public static void main(String[] args) {

        EmployeeManager manager =
                new EmployeeManager(5);

        manager.addEmployee(
                new Employee(101,"Arun","Developer",45000));

        manager.addEmployee(
                new Employee(102,"Divya","Tester",38000));

        manager.addEmployee(
                new Employee(103,"Kiran","Manager",65000));

        System.out.println();
        System.out.println("Employee Records");
        manager.displayEmployees();

        System.out.println();
        System.out.println("Search Result");
        Employee employee =
                manager.searchEmployee(102);

        if(employee != null) {

            employee.display();
        }
        else {

            System.out.println("Employee Not Found");
        }

        System.out.println();
        manager.deleteEmployee(101);

        System.out.println();
        System.out.println("Employee Records After Delete");
        manager.displayEmployees();
    }
}
