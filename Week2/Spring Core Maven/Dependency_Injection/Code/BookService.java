public class BookService {
    private BookRepository bookRepository;
    public void setBookRepository(BookRepository bookRepository) {
        this.bookRepository = bookRepository;
    }
    public void executeServiceMethod() {
        System.out.println("BookService: executing task...");
        if (bookRepository != null) {
            bookRepository.executeRepositoryMethod();
        } else {
            System.out.println("Error: BookRepository dependency has not been injected!");
        }
    }
}
