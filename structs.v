module main

struct Users {
mut:
	id    int
	name  string
	email string
}

fn Users.new(id int, name string, email string) Users {
	return Users{
		id:    id
		name:  name
		email: email
	}
}

// =============Book=============
struct Books {
mut:
	id        int
	title     string
	author    string
	available bool
}

fn Books.new(id int, title string, author string) Books {
	return Books{
		id:        id
		title:     title
		author:    author
		available: true
	}
}

// =============Borrow=============
struct Borrows {
	user_id     int
	book_id     int
	borrow_date string
}

fn Borrows.new(user_id int, book_id int, borrow_date string) Borrows {
	return Borrows{
		user_id:     user_id
		book_id:     book_id
		borrow_date: borrow_date
	}
}

// =============Library=============
struct Library {
mut:
	books   []Books
	users   []Users
	borrows []Borrows
}

fn Library.new() Library {
	return Library{}
}

fn (mut lib Library) add_book(title string, author string) {
	id := lib.books.len + 1
	new_book := Books.new(id, title, author)
	/*new_book := Book{
		id:        lib.books.len + 1
		title:     title
		author:    author
		available: true
	}*/
	lib.books << new_book
}

fn (mut lib Library) add_user(name string, email string) {
	id := lib.users.len + 1
	new_user := Users.new(id, name, email)
	/*new_user := User{
		id:    lib.users.len + 1
		name:  name
		email: email
	}*/
	lib.users << new_user
}

fn (mut lib Library) borrow_book(user_id int, book_id int, borrow_date string) bool {
	if book_id <= lib.books.len && user_id <= lib.users.len {
		if lib.books[book_id - 1].available {
			lib.books[book_id - 1].available = false
			new_borrow := Borrows.new(user_id, book_id, borrow_date)
			/*new_borrow := Borrow{
				user_id:   user_id
				book_id:   book_id
				loan_date: borrow_date
			}*/
			lib.borrows << new_borrow
			return true
		}
	}
	// Si el libro ya está prestado o no existe
	return false
}

fn (mut lib Library) return_book(book_id int) bool {
	if book_id <= lib.books.len {
		// Buscar el libro prestado
		for i, borrow in lib.borrows {
			if borrow.book_id == book_id {
				lib.borrows.delete(i) // Eliminar el préstamo
				lib.books[book_id - 1].available = false // Marcar como disponible
				return true
			}
		}
	}
	// Si el libro no estaba prestado o no existe
	return false
}

fn (lib Library) list_books() {
	println('')
	println('======books======')
	for book in lib.books {
		println('book info: ${book}')
	}
}

fn (lib Library) list_users() {
	println('')
	println('======users======')
	for user in lib.users {
		println('user info ${user}')
	}
}

fn (lib Library) list_borrows() {
	for borrow in lib.borrows {
		println('borrow info ${borrow}')
	}
}

fn main() {
	mut lib := Library.new()
	lib.add_book('1984', 'George Orwell') // book_id 1
	lib.add_book('Dune', 'Frank Herbert') // book_id 2

	lib.add_user('bob', 'bob@example.com') // user_id 1
	lib.add_user('alice', 'alice@example.com') // user_id 2

	lib.list_books()
	lib.list_users()
	println('')
	println('======borrows======')
	lib.list_borrows()

	lib.borrow_book(1, 1, '2026-01-11')
	lib.borrow_book(1, 2, '2026-01-12')

	println('')
	println('======borrows after======')
	lib.list_borrows()

	lib.return_book(1)

	println('')
	println('======borrows after returns======')
	lib.list_borrows()
}
