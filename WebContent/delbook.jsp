<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Delete Book || LMS</title>
<link href="css/bootstrap.css" rel="stylesheet">
</head>
<body>
	<div class="container">
		<a class="brand" href="#"></a>
		<h3>Library Management System</h3>
		<div class="tabbable tabs-below">
			<ul class="nav nav-pills">
				<li><a href="index.jsp">Home</a></li>
				<li><a href="issue_book.jsp">Issue Book</a></li>
				<li><a href="return_book.jsp">Return Book</a></li>
				<li><a href="addbook.jsp">Add New Book</a></li>
				<li class="active"><a href="delbook.jsp">Delete Book</a></li>
				<li><a href="updbook.jsp">Update Book</a></li>
				<li><a href="addauthor.jsp">Add Author</a></li>
				<li><a href="book_status.jsp">Book Status</a></li>
				<li><a href="listbook.jsp">Available Books</a></li>
				<li><button class="btn btn-primary"
						onclick="window.location.href='logout.jsp'">Logout</button></li>
			</ul>

			<ul class="nav nav-list">
				<li class="nav-header"></li>
				<li class="active"><a href="#"></a></li>
				<li><a href="#"></a></li>
			</ul>

		</div>
		<!--/.nav-collapse -->
	</div>
	<div class="container"></div>

	<div class="navbar navbar-inverse navbar-fixed-bottom">
		<div class="navbar-inner">
			<div class="container">
				<button type="button" class="btn btn-navbar" data-toggle="collapse"
					data-target=".nav-collapse">
					<span class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="active" href="#">Support@OnlinveInventory.com</a>
			</div>
		</div>
	</div>

	<!-- Wrap all page content here -->
	<div id="wrap">
		<div class="container">

			<p>Add Book</p>
			<%@page import="java.sql.*"%>
			<%
				String session_user = (String) session.getAttribute("user");
				try {
					if (session_user != null) {
						String submit = null;
						submit = request.getParameter("submit");
						if (submit != null) {
							String isbn = request.getParameter("isbn");
							String title = request.getParameter("title");
							String authorid = request.getParameter("authorid");
							String publisher = request.getParameter("publisher");
							String publishdate = request.getParameter("publishdate");
							float price = Float.valueOf(request.getParameter("price"));
							out.println(isbn + " " + title + " " + authorid + " " + publisher + " " + publishdate + " "
									+ price);

							Connection con = null;
							PreparedStatement pstDeleteItem = null;
							try {
								Class.forName("com.mysql.jdbc.Driver");
								con = DriverManager.getConnection("jdbc:mysql://localhost:3306/test?useSSL=false", "root",
										"126459");
								String sqlDeleteItem = "delete from test.book where ISBN='"+isbn+"' and Title='"+title
										+"' and AuthorID='"+authorid+"' and Publisher='"+publisher+
										"' and PublishDate='"+publishdate+"' and Price='"+price+"'";
								pstDeleteItem = con.prepareStatement(sqlDeleteItem);
								pstDeleteItem.executeUpdate();
								out.println("Success fully deleted");
							} catch (ClassNotFoundException e) {
								out.println("<b>Driver Class not found Exception: </b>" + e.getMessage());

							} catch (SQLException e) {
								out.println("<b>SQL EXception:</b>" + e.getMessage());
							} finally {
								try {
									if (con != null)
										con.close();
								} catch (SQLException e) {
									out.println("<br>Connection Closing Exception: </b>" + e.getMessage());

								}
							}
						}
					} else
						response.sendRedirect("delbook.jsp");
				} catch (Exception e) {
					out.println(e.getMessage());
				}
			%>

			<form action="delbook.jsp">
				<p>
					ISBN:<input type="text" name="isbn">
				</p>
				<p>
					Title:<input type="text" name="title">
				</p>
				<p>
					AuthorID:<input type="text" name="authorid">
				</p>
				<p>
					Publisher:<input type="text" name="publisher">
				</p>
				<p>
					PublishDate:<input type="text" name="publishdate">
				</p>
				<p>
					Price:<input type="text" name="price">
				</p>
				<input type="submit" value="Submit" name="submit">
			</form>


		</div>
		<!-- /container -->
	</div>
	<!-- /wrap -->

	<div id="footer">
		<div class="container">
			<p class="muted credit"></p>
		</div>
	</div>



</body>
</html>