public class StudentView {

    public void displayStudentDetails(
            Student student) {

        System.out.println(
                "ID: " + student.getId());

        System.out.println(
                "Name: " + student.getName());

        System.out.println(
                "Grade: " + student.getGrade());

    }
}