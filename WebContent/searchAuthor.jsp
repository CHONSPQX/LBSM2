<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Search Book || LMS</title>
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
				<li><a href="book_status.jsp">Book Status</a></li>
				<li class="active"><a href="searchBook.jsp">Search Book</a></li>
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
		
			<p>Search Author</p>
			<form action="searchAuthor.jsp">
				<p>
					AuthorID:<input type="text" name="authorid">
				</p>
				<p>
					Name:<input type="text" name="name">
				</p>
				<p>
					Age:<input type="text" name="age">
				</p>
				<p>
					Country:<input type="text" name="country">
				</p>
				<input type="submit" value="Submit" name="submit">
			</form>

			
				<%
				String session_user = (String) session.getAttribute("user");
				try {
					if (session_user != null) {
						String submit = null;
						submit = request.getParameter("submit");
						if (submit != null)
						{
							Connection con = null;
							PreparedStatement pstSearchItem = null;
							ResultSet result=null;	
							try {
								Class.forName("com.mysql.jdbc.Driver");
								con = DriverManager.getConnection("jdbc:mysql://localhost:3306/test?useSSL=false", "root",
										"126459");
							} catch (ClassNotFoundException e) {
								out.println("<b>Driver Class not found Exception: </b>" + e.getMessage());

							} catch (SQLException e) {
								out.println("<b>SQL EXception:</b>" + e.getMessage());
							} 
							
							String authorid = request.getParameter("authorid");
							String name = request.getParameter("name");
							int age = Integer.valueOf(request.getParameter("age"));
							String country=request.getParameter("country");
							System.out.println(authorid + " " + name + " " + age + " "
									+ country);	
							String sqlSearchItem = "select * from test.author where AuthorID='"+authorid+"' and Name='"+name
									+"' and Age='"+age+"' and Country='"+country
									+"'";
							pstSearchItem = con.prepareStatement(sqlSearchItem);
							result=pstSearchItem.executeQuery();
							out.println(
									"<p>The Search Result</p>"+
									"<table width=\"100%\" border=\"1\" align=\"center\">"+
									"<tr bgcolor=\"#ffff00\">"+	
									"<th>AuthorID</th>"+
									"<th>Name</th>"+
									"<th>Age</th>"+
									"<th>Country</th>"+
									"</tr>"+
									"</table>");
							while(result.next())
							{
							%>	
								<tr>
									<td><%=result.getString("AuthorID")%></td>
									<td><%=result.getString("Name")%></td>
									<td><%=result.getInt("Age")%></td>
									<td><%=result.getString("Country")%></td>
								</tr>
							<% 
							}
							
							sqlSearchItem = "select * from test.book where AuthorID='"+authorid+"'";
							pstSearchItem = con.prepareStatement(sqlSearchItem);
							result=pstSearchItem.executeQuery();
							out.println(
									"<p>The Relative Books</p>"+
									"<table width=\"100%\" border=\"1\" align=\"center\">"+
									"<tr bgcolor=\"#66ff33\">"+	
									"<th>ISBN</th>"+
									"<th>Title</th>"+
									"<th>AuthorID</th>"+
									"<th>Publisher</th>"+
									"<th>PublishDate</th>"+
									"<th>Price</th>"+
									"</tr>"+
									"</table>");
							
							while(result.next())
							{
								%>
								
								<tr>
									<td><%=result.getString("ISBN")%></td>
									<td><%=result.getString("Title")%></td>
									<td><%=result.getString("AuthorID")%></td>
									<td><%=result.getString("Publisher")%></td>
									<td><%=result.getString("PublishDate")%></td>
									<td><%=result.getFloat("Price")%></td>
								</tr>
								<%
							}
							
						}
					} else
						response.sendRedirect("index.jsp");
				} catch (Exception e) {
					out.println(e.getMessage());
				}
			%>

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