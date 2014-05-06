require 'spec_helper'

describe "Library Object" do
  
  before :all do
    lib_arr= [
      Book.new("Javascript: The Good Parts", "Douglas Crockford", :development),
      Book.new("HTML: The Good Parts", "Douglas Crockford", :usability),
      Book.new("Ruby: The Good Parts", "Douglas Crockford", :development),
      Book.new("Css: The Good Parts", "Douglas Crockford", :design),
      Book.new("PHP: The Good Parts", "Douglas Crockford", :development),
    ]
    File.open "books.yml", "w" do |f|
      f.write YAML::dump lib_arr
    end
  end
  
  before :each do
    @lib = Library.new "books.yml"
  end

  describe "#new" do

    context "with no parameters" do
      it "has no book" do
        lib=Library.new
        lib.should have(0).books
      end
    end
    
    context "with a yaml file name parameter" do
      it "has five books" do
        @lib.should have(5).books
      end
    end
  end
  
  it "return all the books in given category" do
    @lib.get_books_in_category(:development).length.should == 3
  end
  
  it "accepts new books" do
    @lib.add_book( Book.new("Designin for the web", "Mark", :design))
    @lib.get_book("Designin for the web").should be_an_instance_of Book
  end
  
  it "saves the library" do
    books = @lib.books.map {|book| book.title }
    @lib.save "our_new_library.yml"
    lib2 = Library.new "our_new_library.yml"
    books2 = lib2.books.map { |book| book.title}
    books.should eql books2
    
  end
  
end