public class Test {

    public static void main(String[] args) {

        Student student =
                new Student(
                        101,
                        "Jaswin",
                        "A");

        StudentView view =
                new StudentView();

        StudentController controller =
                new StudentController(
                        student,
                        view);

        controller.updateView();

        controller.setStudentName(
                "Prathap");

        controller.updateView();

    }
}