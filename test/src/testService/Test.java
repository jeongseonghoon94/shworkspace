package testService;

public class Test {
	private String name;
	private String author;
	private int price;
	private String name2;
	
	public Test() {}
	public Test(String name, String author, int price, String name2) {
		super();
		this.name = name;
		this.author = author;
		this.price = price;
		this.name2 = name2;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getName2() {
		return name2;
	}
	public void setName2(String name2) {
		this.name2 = name2;
	}
	@Override
	public String toString() {
		return name + ", " + author+ ", " + price + "원, "+ name2;
	}
	
	

}
