import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ApplicationContext;

@SpringBootApplication
public class OrmLearnApplication {
    private static final Logger LOGGER = LoggerFactory.getLogger(OrmLearnApplication.class);
    private static EmployeeService employeeService;
    private static void testAddEmployeeJPA() {
        LOGGER.info("Start JPA");
        Employee emp = new Employee();
        emp.setName("JPA Employee");
        employeeService.addEmployeeJPA(emp);
        LOGGER.debug("Saved via Spring Data JPA: {}", emp);
        LOGGER.info("End JPA");
    }
    private static void testAddEmployeeHibernate() {
        LOGGER.info("Start Hibernate");
        Employee emp = new Employee();
        emp.setName("Hibernate Employee");
        Integer id = employeeService.addEmployeeHibernate(emp);
        LOGGER.debug("Saved via Hibernate. Generated ID: {}", id);
        LOGGER.info("End Hibernate");
    }
    public static void main(String[] args) {
        ApplicationContext context = SpringApplication.run(OrmLearnApplication.class, args);
        employeeService = context.getBean(EmployeeService.class);
        testAddEmployeeJPA();
        testAddEmployeeHibernate();
        LOGGER.info("Inside main");
    }
}
