import java.util.Arrays;
import java.util.Comparator;

public class Test {

    public static void main(String[] args) {

        Book[] books = {
                new Book(101,"Clean Code","Robert Martin"),
                new Book(102,"Java Basics","James Gosling"),
                new Book(103,"Data Structures","Mark Allen"),
                new Book(104,"Algorithms","Thomas Cormen"),
                new Book(105,"Operating Systems","Abraham Silberschatz")
        };

        LibrarySearch search = new LibrarySearch();

        System.out.println("Linear Search Result");
        Book linearResult =
                search.linearSearchByTitle(books,"Algorithms");
        showResult(linearResult);

        Book[] sortedBooks =
                Arrays.copyOf(books, books.length);

        Arrays.sort(sortedBooks,
                Comparator.comparing(Book::getTitle,
                        String.CASE_INSENSITIVE_ORDER));

        System.out.println();
        System.out.println("Books Sorted by Title");

        for(Book book : sortedBooks) {

            book.display();
        }

        System.out.println();
        System.out.println("Binary Search Result");
        Book binaryResult =
                search.binarySearchByTitle(sortedBooks,"Algorithms");
        showResult(binaryResult);
    }

    private static void showResult(Book book) {

        if(book != null) {

            book.display();
        }
        else {

            System.out.println("Book Not Found");
        }
    }
}
