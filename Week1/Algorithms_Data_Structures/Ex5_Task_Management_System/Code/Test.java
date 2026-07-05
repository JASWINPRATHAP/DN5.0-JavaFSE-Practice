public class Test {

    public static void main(String[] args) {

        TaskList taskList = new TaskList();

        taskList.addTask(
                new Task(101,"Design Login Page","Pending"));

        taskList.addTask(
                new Task(102,"Create Database","In Progress"));

        taskList.addTask(
                new Task(103,"Test Checkout","Completed"));

        System.out.println();
        System.out.println("Task List");
        taskList.displayTasks();

        System.out.println();
        System.out.println("Search Result");
        Task task = taskList.searchTask(102);

        if(task != null) {

            task.display();
        }
        else {

            System.out.println("Task Not Found");
        }

        System.out.println();
        taskList.deleteTask(101);

        System.out.println();
        System.out.println("Task List After Delete");
        taskList.displayTasks();
    }
}
