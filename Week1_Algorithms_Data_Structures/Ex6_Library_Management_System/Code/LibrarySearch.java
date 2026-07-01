public class LibrarySearch {

    public Book linearSearchByTitle(Book[] books,
                                    String title) {

        for(Book book : books) {

            if(book.getTitle().equalsIgnoreCase(title)) {

                return book;
            }
        }

        return null;
    }

    public Book binarySearchByTitle(Book[] books,
                                    String title) {

        int low = 0;
        int high = books.length - 1;

        while(low <= high) {

            int mid = (low + high) / 2;
            int result = books[mid].getTitle()
                    .compareToIgnoreCase(title);

            if(result == 0) {

                return books[mid];
            }
            else if(result < 0) {

                low = mid + 1;
            }
            else {

                high = mid - 1;
            }
        }

        return null;
    }
}
