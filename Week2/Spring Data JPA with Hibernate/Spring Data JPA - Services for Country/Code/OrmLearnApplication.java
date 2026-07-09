import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ApplicationContext;
import java.util.List;

@SpringBootApplication
public class OrmLearnApplication {
    private static final Logger LOGGER = LoggerFactory.getLogger(OrmLearnApplication.class);
    private static CountryService countryService;
    private static void getAllCountriesTest() {
        LOGGER.info("Start");
        try {
            Country country = countryService.findCountryByCode("IN");
            LOGGER.debug("Country:{}", country);
        } catch (CountryNotFoundException e) {
            LOGGER.error(e.getMessage());
        }
        LOGGER.info("End");
    }
    private static void testAddCountry() {
        LOGGER.info("Start");
        Country country = new Country();
        country.setCode("ZZ");
        country.setName("TestCountry");
        countryService.addCountry(country);
        try {
            Country addedCountry = countryService.findCountryByCode("ZZ");
            LOGGER.debug("Added Country:{}", addedCountry);
        } catch (CountryNotFoundException e) {
            LOGGER.error(e.getMessage());
        }
        LOGGER.info("End");
    }
    private static void testUpdateCountry() {
        LOGGER.info("Start");
        try {
            countryService.updateCountry("ZZ", "UpdatedTestCountry");
            Country updatedCountry = countryService.findCountryByCode("ZZ");
            LOGGER.debug("Updated Country:{}", updatedCountry);
        } catch (CountryNotFoundException e) {
            LOGGER.error(e.getMessage());
        }
        LOGGER.info("End");
    }
    private static void testDeleteCountry() {
        LOGGER.info("Start");
        countryService.deleteCountry("ZZ");
        try {
            countryService.findCountryByCode("ZZ");
        } catch (CountryNotFoundException e) {
            LOGGER.error("Country ZZ deleted successfully.");
        }
        LOGGER.info("End");
    }
    private static void testFindCountriesByName() {
        LOGGER.info("Start");
        List<Country> countries = countryService.findCountriesByName("uni");
        LOGGER.debug("Countries matching 'uni': {}", countries);
        LOGGER.info("End");
    }
    public static void main(String[] args) {
        ApplicationContext context = SpringApplication.run(OrmLearnApplication.class, args);
        countryService = context.getBean(CountryService.class);
        getAllCountriesTest();
        testAddCountry();
        testUpdateCountry();
        testFindCountriesByName();
        testDeleteCountry();
        LOGGER.info("Inside main");
    }
}
