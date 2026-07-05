public class TaskList {

    private Node head;
    private Node tail;

    private class Node {

        Task task;
        Node next;

        Node(Task task) {

            this.task = task;
            this.next = null;
        }
    }

    public void addTask(Task task) {

        Node newNode = new Node(task);

        if(head == null) {

            head = newNode;
            tail = newNode;
        }
        else {

            tail.next = newNode;
            tail = newNode;
        }

        System.out.println("Task Added");
    }

    public Task searchTask(int taskId) {

        Node current = head;

        while(current != null) {

            if(current.task.getTaskId() == taskId) {

                return current.task;
            }

            current = current.next;
        }

        return null;
    }

    public void deleteTask(int taskId) {

        if(head == null) {

            System.out.println("Task Not Found");
            return;
        }

        if(head.task.getTaskId() == taskId) {

            head = head.next;

            if(head == null) {

                tail = null;
            }

            System.out.println("Task Deleted");
            return;
        }

        Node current = head;

        while(current.next != null) {

            if(current.next.task.getTaskId() == taskId) {

                if(current.next == tail) {

                    tail = current;
                }

                current.next = current.next.next;

                System.out.println("Task Deleted");
                return;
            }

            current = current.next;
        }

        System.out.println("Task Not Found");
    }

    public void displayTasks() {

        Node current = head;

        while(current != null) {

            current.task.display();
            current = current.next;
        }
    }
}
